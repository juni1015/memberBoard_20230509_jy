package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.MemberFileDTO;
import com.icia.memberBoard.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @GetMapping("/save")
    public String saveForm() { return "memberPages/memberSave"; }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        System.out.println("memberDTO = " + memberDTO);
        memberService.save(memberDTO);
        return "memberPages/memberLogin";
    }

    @PostMapping("/email-check")
    public ResponseEntity emailCheck(@RequestParam("memberEmail") String memberEmail) {
        MemberDTO memberDTO = memberService.findByEmail(memberEmail);
        if(memberEmail.length() == 0){
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (memberDTO == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @GetMapping("/login")
    public String loginForm() { return "memberPages/memberLogin"; }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO, HttpSession session) {
        MemberDTO dto = memberService.login(memberDTO);
        if (dto != null) {
            session.setAttribute("loginEmail", memberDTO.getMemberEmail());
            return "memberPages/memberMyPage";
        } else {
            return "memberPages/memberLoginError";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션에 담긴 값 전체 삭제
        session.invalidate();
        // 특정 파라미터만 삭제
//        session.removeAttribute("loginEmail");
        return "redirect:/";
    }

    @GetMapping("/list")
    public String findAll(Model model) {
        List<MemberDTO> memberDTOList = memberService.findAll();
        model.addAttribute("memberList", memberDTOList);
        return "memberPages/memberList";
    }

    @GetMapping("/detail")
    public String detailForm(@RequestParam("id") Long id, Model model) {
        MemberDTO memberDTO = memberService.findById(id);
        model.addAttribute("memberDetail", memberDTO);
        if (memberDTO.getProfileAttached() == 1) {
            MemberFileDTO memberFileDTO = memberService.findFile(id);
            System.out.println("memberFileDTO = " + memberFileDTO);
            model.addAttribute("memberFile", memberFileDTO);
        }
        return "memberPages/memberDetail";
    }

    @GetMapping("/mypage")
    public String mypageForm() { return "memberPages/memberMyPage"; }
}
