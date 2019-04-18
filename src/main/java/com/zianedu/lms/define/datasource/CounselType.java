package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * 상담내역 Type 정의
 */
public enum CounselType {

    DELIVERY(0, "배송관련"),
    SIGNUP(1, "수강관련"),
    PAYMENT(2, "결제관련"),
    PAYDISMISS(3, "결제취소관련"),
    REFUND(4, "환불관련"),
    REMOTE(5, "원격상담관련"),
    ETC(9, "기타")
    ;

    int counselKey;

    String counselStr;

    CounselType(int counselKey, String counselStr) {
        this.counselKey = counselKey;
        this.counselStr = counselStr;
    }

    public static String getCounselTypeStr(int counselKey) {
        for (CounselType counselType : CounselType.values()) {
            if (counselKey == counselType.counselKey) {
                return counselType.counselStr;
            }
        }
        return null;
    }

    public static List<SelectboxDTO> getCounselTypeList() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (CounselType counselType : CounselType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    counselType.counselKey,
                    counselType.counselStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }


}
