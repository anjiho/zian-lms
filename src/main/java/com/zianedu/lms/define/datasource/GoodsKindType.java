package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum GoodsKindType {

    BASIC(0, "기본설정"),
    VOD(100, "VOD"),
    MOBILE(101, "Mobile"),
    VOD_MOBILE(102, "VOD + Mobile"),
    CATEGORY_SEARCH(119, "카테고리 참조"),
    DIRECT_INSERT(120, "직접입력");

    int kind;

    String kindStr;

    GoodsKindType(int kind, String kindStr) {
        this.kind = kind;
        this.kindStr = kindStr;
    }

    public static List<SelectboxDTO> getGoodsOptionKindSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (GoodsKindType kindType : GoodsKindType.values()) {
            if (kindType.kind == 100 || kindType.kind == 101 || kindType.kind == 102) {
                SelectboxDTO selectboxDTO = new SelectboxDTO(
                        kindType.kind, kindType.kindStr.toString()
                );
                list.add(selectboxDTO);
            }
        }
        return list;
    }
}
