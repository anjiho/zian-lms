package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum EmphasisType {

    NONE(0, "없음"),
    BEST(1, "BEST"),
    NEW(2, "NEW");

    int emphasis;

    String emphasisStr;

    EmphasisType(int emphasis, String emphasisStr) {
        this.emphasis = emphasis;
        this.emphasisStr = emphasisStr;
    }

    public static List<SelectboxDTO> getEmphasisSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (EmphasisType emphasisType : EmphasisType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    emphasisType.emphasis,
                    emphasisType.emphasisStr
            );
        list.add(selectboxDTO);
        }
        return list;
    }
}
