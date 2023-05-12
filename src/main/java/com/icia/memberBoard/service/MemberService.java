package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.MemberFileDTO;
import com.icia.memberBoard.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    public void save(MemberDTO memberDTO) throws IOException {
        if (memberDTO.getMemberProfile().isEmpty()) {
            System.out.println("파일없음");
            memberDTO.setProfileAttached(0);
            memberRepository.save(memberDTO);
        } else {
            System.out.println("파일있음");
            memberDTO.setProfileAttached(1);
            MemberDTO dto = memberRepository.save(memberDTO);
            // 원본 파일명
            String originalFileName = dto.getMemberProfile().getOriginalFilename();
            // 서버용 파일명 만들기
            String storeFileName = System.currentTimeMillis() + "-" + originalFileName;
            // 저장할 MemberFileDTO 셋팅
            MemberFileDTO memberFileDTO = new MemberFileDTO();
            memberFileDTO.setMemberId(dto.getId());
            memberFileDTO.setOriginalFileName(originalFileName);
            memberFileDTO.setStoredFileName(storeFileName);
            // 로컬에 파일을 저장할 경로 설정 (저장할 폴더 + 저장할 이름)
            String savePath = "D:\\springframework_img\\" + storeFileName;
            // 저장처리
            dto.getMemberProfile().transferTo(new File(savePath));
            memberRepository.saveProfile(memberFileDTO);
        }
    }

    public MemberDTO findByEmail(String memberEmail) {
        return memberRepository.findByEmail(memberEmail);
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return memberRepository.login(memberDTO);
    }

    public List<MemberDTO> findAll() {
        return memberRepository.findAll();
    }

    public MemberDTO findById(Long id) {
        return memberRepository.findById(id);
    }

    public MemberFileDTO findFile(Long id) {
        return memberRepository.findFile(id);
    }

    public void update(MemberDTO memberDTO) {
        memberRepository.update(memberDTO);
    }

    public void delete(Long id) {
        memberRepository.delete(id);
    }
}
