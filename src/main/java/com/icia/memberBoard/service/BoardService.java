package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.BoardFileDTO;
import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.PageDTO;
import com.icia.memberBoard.repository.BoardRepository;
import com.icia.memberBoard.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;
    @Autowired
    private MemberRepository memberRepository;

    public void save(BoardDTO boardDTO, String loginEmail) throws IOException {
        // 로그인한 이메일로 memberDTO 가져오기
        MemberDTO memberDTO = memberRepository.findByEmail(loginEmail);
        System.out.println("memberDTO = " + memberDTO);
        // 가져온 memberDTO에서 boardDTO로 작성자와 memberId 셋팅
        boardDTO.setBoardWriter(memberDTO.getMemberEmail());
        boardDTO.setMemberId(memberDTO.getId());

        // 파일 유무에 따라 저장 방법 다르게 지정
        if (boardDTO.getBoardFile().get(0).isEmpty()) {
            boardDTO.setFileAttached(0);
            boardRepository.save(boardDTO);
        } else {
            boardDTO.setFileAttached(1);
            BoardDTO dto = boardRepository.save(boardDTO);
            System.out.println("dto = " + dto);
            for (MultipartFile boardFile: boardDTO.getBoardFile()) {
                String originalFileName = boardFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis() + "-" + originalFileName;
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setBoardId(dto.getId());
                boardFileDTO.setOriginalFileName(originalFileName);
                boardFileDTO.setStoredFileName(storedFileName);
                String savePath = "D:\\springframework_img\\" + storedFileName;
                boardFile.transferTo(new File(savePath));
                System.out.println("boardFileDTO = " + boardFileDTO);
                boardRepository.saveFile(boardFileDTO);
            }
        }
    }

    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }

    public List<BoardDTO> pagingList(int page) {
        int pageLimit = 3;
        int pagingStart = (page-1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        List<BoardDTO> boardDTOList = boardRepository.pagingList(pagingParams);
        return boardDTOList;
    }

    public PageDTO pagingParam(int page) {
        int pageLimit = 3;  // 한 페이지에 보여줄 글 갯수
        int blockLimit = 3; //하단에 보여줄 페이지 번호 갯수
        // 전체 글 갯수 조회
        int boardCount = boardRepository.boardCount();
        // 보여지는 전체 페이지 갯수 계산 (소수점 발생시 나머지 게시글이 표기될 페이지가 하나 더 필요하기 때문에 Math.ceil을 이용하여 올림처리해야 함
        int maxPage = (int)(Math.ceil((double)boardCount / pageLimit));
        // 시작 페이지 값 계산(1, 4, 7, 10 ~~)
        int startPage = (((int)(Math.ceil((double)page / blockLimit))) - 1) * blockLimit + 1;
        // 마지막 페이지 값 계산(3, 6, 9, 12 ~~)
        int endPage = startPage + blockLimit - 1;
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때 endPage 값을 maxPage 값과 같게 셋팅
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }

    public List<BoardDTO> searchList(int page, String type, String q) {
        int pageLimit = 3;  // 한 페이지에 보여줄 글 갯수
        int pagingStart = (page-1) * pageLimit;
        Map<String, Object> pagingParam = new HashMap<>();
        pagingParam.put("start", pagingStart);
        pagingParam.put("limit", pageLimit);
        pagingParam.put("q", q);
        pagingParam.put("type", type);
        List<BoardDTO> boardDTOList = boardRepository.searchList(pagingParam);
        return boardDTOList;
    }

    public PageDTO pagingSearchParam(int page, String type, String q) {
        int pageLimit = 3;  // 한 페이지에 보여줄 글 갯수
        int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수
        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("q", q);
        pagingParams.put("type", type);
        // 검색어에 해당하는 전체 글 갯수 조회
        int boardCount = boardRepository.boardSearchCount(pagingParams);
        // 검색어에 해당하는 전체 페이지 갯수 계산
        int maxPage = (int)(Math.ceil((double)boardCount / pageLimit));
        // 시작 페이지 값 계산(1, 4, 7, 10 ~~)
        int startPage = (((int)(Math.ceil((double)page / blockLimit))) - 1) * blockLimit + 1;
        // 마지막 페이지 값 계산(3, 6, 9, 12 ~~)
        int endPage = startPage + blockLimit - 1;
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때 endPage 값이 maxPage 값과 같게 셋팅
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;

    }

    public void hitsUp(Long id) {
        boardRepository.hitsUp(id);
    }

    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    public List<BoardFileDTO> findFile(Long id) {
        return boardRepository.findFile(id);
    }

    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }
}
