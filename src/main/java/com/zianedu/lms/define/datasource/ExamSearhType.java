package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum ExamSearhType {

    EXAM_NAME("name", "시험명"),
    EXAM_CODE("code", "코드");

    String engStr;

    String korStr;

    ExamSearhType(String engStr, String korStr) {
        this.engStr = engStr;
        this.korStr = korStr;
    }

    public static List<SelectboxDTO> getExamSearchTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (ExamSearhType examSearhType : ExamSearhType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    examSearhType.engStr.toString(),
                    examSearhType.korStr.toString()
            );
            list.add(selectboxDTO);
        }
        return list;
    }
}
