package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.GoodsKindName;
import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum GoodsKindType {

    BASIC(0, "기본설정"),
    VOD(100, "VOD"),
    MOBILE(101, "MOBILE"),
    VOD_MOBILE(102, "VOD + MOBILE"),
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

    public static String getGoodsKindName(int kind) {
        for (GoodsKindType goodsKindType : GoodsKindType.values()) {
            if (goodsKindType.kind == kind) {
                return goodsKindType.kindStr;
            }
        }
        return null;
    }

    public static List<GoodsKindName> getGoodsKindList() {
        List<GoodsKindName>list = new ArrayList<>();
        for (GoodsKindType goodsKindType : GoodsKindType.values()) {
            GoodsKindName goodsKindName = new GoodsKindName();
            goodsKindName.setGoodsKind(goodsKindType.kind);
            goodsKindName.setGoodsKindName(goodsKindType.kindStr);

            list.add(goodsKindName);
        }
        return list;
    }


}
