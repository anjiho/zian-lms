package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * 회원등급 정의
 */
public enum MemberGradeType {

    BRONZE(0, "브론즈"),
    SILVER(1, "실버"),
    GOLD(2, "골드"),
    ZIAN_PASS(100, "지안패스"),
    YEAR(101, "연간회원")
    ;

    int gradeKey;

    String gradeStr;

    MemberGradeType(int gradeKey, String gradeStr) {
        this.gradeKey = gradeKey;
        this.gradeStr = gradeStr;
    }

    public static List<SelectboxDTO> getMemberGradeTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (MemberGradeType memberGradeType : MemberGradeType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    memberGradeType.gradeKey,
                    memberGradeType.gradeStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }
}
