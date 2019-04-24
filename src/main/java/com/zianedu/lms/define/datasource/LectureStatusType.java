package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * T_LEC.STATUS 값 정의
 */
public enum LectureStatusType {

    READY(0, "준비중"),
    PROCEED(1, "진행중"),
    COMPLETE(2, "완강"),
    CLOSE(3, "폐강")
    ;

    int lectureStatus;

    String lectureStatusStr;

    LectureStatusType(int lectureStatus, String lectureStatusStr) {
        this.lectureStatus = lectureStatus;
        this.lectureStatusStr = lectureStatusStr;
    }

    public static List<SelectboxDTO>getLectureStatusSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (LectureStatusType lectureStatusType : LectureStatusType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    lectureStatusType.lectureStatus,
                    lectureStatusType.lectureStatusStr.toString()
            );
            list.add(selectboxDTO);
        }
        return list;
    }
}
