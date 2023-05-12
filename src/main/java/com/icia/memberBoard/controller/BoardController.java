package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.BoardFileDTO;
import com.icia.memberBoard.dto.CommentDTO;
import com.icia.memberBoard.dto.PageDTO;
import com.icia.memberBoard.service.BoardService;
import com.icia.memberBoard.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;
    @Autowired
    private CommentService commentService;

    @GetMapping("/save")
    public String saveForm() { return "boardPages/boardSave"; }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO, HttpSession session) throws IOException {
        // 세션에 들어있는 이메일 가져오기
        String loginEmail = (String) session.getAttribute("loginEmail");
        boardService.save(boardDTO, loginEmail);
        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public String findAll(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                            @RequestParam(value = "q", required = false, defaultValue = "") String q,
                            @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                            Model model) {
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;
        if (q.equals("")) {
            // 사용자가 요청한 페이지에 해당하는 글 목록 데이터
            boardDTOList = boardService.pagingList(page);
            // 하단에 보여줄 페이지 번호 목록 데이터
            pageDTO = boardService.pagingParam(page);
        } else {
            // 사용자가 입력한 검색타입과 검색어에 맞는 결과중 요청한 페이지에 해당하는 글 목록 데이터
            boardDTOList = boardService.searchList(page, type, q);
            // 사용자가 입력한 검색타입과 검색어에 맞는 결과에 따른 하단에 보여줄 페이지 번호 목록 데이터
            pageDTO = boardService.pagingSearchParam(page, type, q);
        }
        model.addAttribute("boardList", boardDTOList);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        return "boardPages/boardList";
    }

    @GetMapping("/detail")
    public String findById(@RequestParam("id") Long id,
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           @RequestParam(value = "q", required = false, defaultValue = "") String q,
                           @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                           Model model) {
        boardService.hitsUp(id);
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        if (boardDTO.getFileAttached() == 1) {
            List<BoardFileDTO> boardFileDTOList = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTOList);
        }
        List<CommentDTO> commentDTOList = commentService.findAll(id);
        if (commentDTOList.size() == 0) {
            model.addAttribute("commentList", null);
        } else {
            model.addAttribute("commentList", commentDTOList);
        }
        return "boardPages/boardDetail";
    }

    @GetMapping("/update")
    public String updateForm(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        if (boardDTO.getFileAttached() == 1) {
            List<BoardFileDTO> boardFileDTOList = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTOList);
        }
        return "boardPages/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO) {
        boardService.update(boardDTO);
        return "redirect:/board/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        boardService.delete(id);
        return "redirect:/board/list";
    }
}
