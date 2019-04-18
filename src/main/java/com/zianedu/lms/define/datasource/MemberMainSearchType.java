package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum MemberMainSearchType {

    NAME("name", "이름"),
    ID("id", "아이디"),
    TELEPHONE("telephone", "전화번호"),
    MOBILE("mobile", "휴대전화번호"),
    CODE("code", "코드")
    ;

    String engStr;

    String korStr;

    MemberMainSearchType(String engStr, String korStr) {
        this.engStr = engStr;
        this.korStr = korStr;
    }

    public static List<SelectboxDTO> getMemberMainSearchTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (MemberMainSearchType memberSearchType : MemberMainSearchType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    memberSearchType.engStr.toString(),
                    memberSearchType.korStr.toString()
            );
            list.add(selectboxDTO);
        }
        return list;
    }

}
