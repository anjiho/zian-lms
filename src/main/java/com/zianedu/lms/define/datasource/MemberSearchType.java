package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum MemberSearchType {

    NAME("name", "이름"),
    ID("id", "아이디"),
    CODE("code", "코드")
    ;

    String engStr;

    String korStr;

    MemberSearchType(String engStr, String korStr) {
        this.engStr = engStr;
        this.korStr = korStr;
    }

    public static List<SelectboxDTO> getMemberSearchTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (MemberSearchType memberSearchType : MemberSearchType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    memberSearchType.engStr.toString(),
                    memberSearchType.korStr.toString()
            );
            list.add(selectboxDTO);
        }
        return list;
    }

}
