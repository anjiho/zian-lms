package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * 상담내역 상태값 정의
 */
public enum CounselStatusType {

    RECEIPT(0, "접수"),
    PROCESS(1, "처리중"),
    SUCCESS(2, "완료")
    ;

    int counselStatusKey;

    String counselStatusStr;

    CounselStatusType(int counselStatusKey, String counselStatusStr) {
        this.counselStatusKey = counselStatusKey;
        this.counselStatusStr = counselStatusStr;
    }

    public static List<SelectboxDTO> getCounselStatusTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (CounselStatusType statusType : CounselStatusType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    statusType.counselStatusKey,
                    statusType.counselStatusStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }
}
