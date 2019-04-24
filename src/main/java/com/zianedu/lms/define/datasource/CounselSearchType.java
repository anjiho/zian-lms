package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum CounselSearchType {

    NUMBER("name", "상담번호"),
    MEMBER_ID("id", "회원아이디"),
    MEMBER_NAME("name", "회원이름")
    ;

    String engStr;

    String korStr;

    CounselSearchType(String engStr, String korStr) {
        this.engStr = engStr;
        this.korStr = korStr;
    }

    public static List<SelectboxDTO> getCounselSearchTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (CounselSearchType counselSearchType : CounselSearchType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    counselSearchType.engStr,
                    counselSearchType.korStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }

}
