package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.CommentDTO;
import com.icia.memberBoard.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public void save(CommentDTO commentDTO) {
        commentRepository.save(commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {
        List<CommentDTO> commentDTOList = commentRepository.findAll(boardId);
        return commentDTOList;
    }

    public CommentDTO findById(Long id) {
        return commentRepository.findById(id);
    }
}
