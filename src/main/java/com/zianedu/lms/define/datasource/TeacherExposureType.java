package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * 강사순서관리 종류 정의
 */
public enum TeacherExposureType {

    GAERI_VOD(1086, "계리직 동영상"),
    GAERI_ACA(1080, "계리직 학원"),
    TECH_VOD(829, "기술직 동영상"),
    TECH_ACA(823, "기술직 학원"),
    ADMIN_VOD(794, "행정직 동영상"),
    ADMIN_ACA(788, "행정직 학원")
    ;

    int academyKey;

    String academyStr;

    TeacherExposureType(int academyKey, String academyStr) {
        this.academyKey = academyKey;
        this.academyStr = academyStr;
    }

    public static List<SelectboxDTO> getAcademyTypeSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (TeacherExposureType exposureType : TeacherExposureType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    exposureType.academyKey,
                    exposureType.academyStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }
}
