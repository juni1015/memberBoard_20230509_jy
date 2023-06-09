package com.icia.memberBoard.repository;

import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.MemberFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public MemberDTO save(MemberDTO memberDTO) {
        sql.insert("Member.save", memberDTO);
        return memberDTO;
    }

    public void saveProfile(MemberFileDTO memberFileDTO) {
        sql.insert("Member.saveProfile", memberFileDTO);
    }

    public MemberDTO findByEmail(String memberEmail) {
        return sql.selectOne("Member.findByEmail", memberEmail);
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login", memberDTO);
    }

    public List<MemberDTO> findAll() {
        return sql.selectList(("Member.findAll"));
    }

    public MemberDTO findById(Long id) {
        return sql.selectOne("Member.findById", id);
    }

    public MemberFileDTO findFile(Long memberId) {
        return sql.selectOne("Member.findFile", memberId);
    }

    public void update(MemberDTO memberDTO) {
        sql.update("Member.update", memberDTO);
    }

    public void delete(Long id) {
        sql.delete("Member.delete", id);
    }
}
