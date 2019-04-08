package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;
import com.zianedu.lms.dto.VideoListDTO;

import java.util.ArrayList;
import java.util.List;

public enum VideoSearchType {

    TITLE("title", "제목"),
    CODE("code", "코드");

    String engStr;

    String korStr;

    VideoSearchType(String engStr, String korStr) {
        this.engStr = engStr;
        this.korStr = korStr;
    }

    public static List<SelectboxDTO> getVideoSeaerchTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (VideoSearchType videoSearchType : VideoSearchType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    videoSearchType.engStr.toString(),
                    videoSearchType.korStr.toString()
            );
            list.add(selectboxDTO);
        }
        return list;
    }
}
