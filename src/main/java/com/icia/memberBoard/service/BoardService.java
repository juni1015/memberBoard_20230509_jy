package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.BoardFileDTO;
import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.repository.BoardRepository;
import com.icia.memberBoard.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

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
        boardDTO.setBoardWriter(memberDTO.getMemberName());
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
}
