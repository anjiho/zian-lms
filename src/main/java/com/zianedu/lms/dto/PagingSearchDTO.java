package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class PagingSearchDTO {

    private int startNumber;

    private int listLimitNumber;

    private String searchType;

    private String searchText;

    public PagingSearchDTO() {}

    public PagingSearchDTO(int startNumber, int listLimitNumber, String searchType, String searchText) {
        this.startNumber = startNumber;
        this.listLimitNumber = listLimitNumber;
        this.searchType = searchText;
        this.searchText = searchText;
    }
}
