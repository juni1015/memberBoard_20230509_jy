package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.CommentDTO;
import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.service.CommentService;
import com.icia.memberBoard.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;
    @Autowired
    private MemberService memberService;

    @PostMapping("/save")
    public ResponseEntity save(@ModelAttribute CommentDTO commentDTO, HttpSession session) {
        // 세션에 들어있는 이메일 가져오기
        String loginEmail = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByEmail(loginEmail);
        commentDTO.setMemberId(memberDTO.getId());
        commentService.save(commentDTO);
        List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

//    @GetMapping("/update")
//    public String updateForm(@RequestParam("id") Long id, Model model) {
//        CommentDTO commentDTO = commentService.findById(id);
//        model.addAttribute("comment", commentDTO);
//        return "/boardPages/commentUpate";
//    }
}
