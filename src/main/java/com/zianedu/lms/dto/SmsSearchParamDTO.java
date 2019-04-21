package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class SmsSearchParamDTO {

    private int startNumber;

    private int listLimitNumber;

    private String tableName;

    private String searchType;

    private String searchText;

    public SmsSearchParamDTO(){}

    public SmsSearchParamDTO(int startNumber, int listLimitNumber, String tableName, String searchType, String searchText) {
        this.startNumber = startNumber;
        this.listLimitNumber = listLimitNumber;
        this.tableName = tableName;
        this.searchType = searchType;
        this.searchText = searchText;
    }

    public SmsSearchParamDTO(String tableName, String searchType, String searchText) {
        this.tableName = tableName;
        this.searchType = searchType;
        this.searchText = searchText;
    }
}
