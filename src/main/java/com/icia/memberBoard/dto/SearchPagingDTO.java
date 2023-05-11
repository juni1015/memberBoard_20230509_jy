package com.icia.memberBoard.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchPagingDTO {
    private Long id;
    private int page;
    private String q;
    private String type;
}
