package com.zianedu.lms.dto;

import com.zianedu.lms.define.datasource.TLectureStatusType;
import lombok.Data;

@Data
public class VideoListDTO {

    private int gKey;

    private String goodsName;

    private String indate;

    private int isShow;

    private int isSell;

    private int isFree;

    private String teacherName;

    private int status;

    private String statusStr;

    VideoListDTO() {
        this.gKey = getGKey();
        this.goodsName = getGoodsName();
        this.isShow = getIsShow();
        this.isSell = getIsSell();
        this.isFree = getIsFree();
        this.teacherName = getTeacherName();
        this.status = getStatus();
        this.statusStr = TLectureStatusType.getStatusStr(getStatus());
    }
}
