package com.icia.memberBoard.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
    private int page;   // 현재
    private int maxPage;    // 전체
    private int startPage;  // 보여지는 시작 페이지
    private int endPage;    // 보여지는 마지막 페이지
}
