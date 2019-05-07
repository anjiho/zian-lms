package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TOrderLecVO {

    private int jLecKey;

    private int jGKey;

    private String indate;

    private int status;

    private String startDt;

    private int limitDay;

    private String pauseStartDt;

    private int pauseCnt;

    private int pauseDay;

    private int pauseTotalDay;

    private float multiple;

    private int maxReadCount;

    public TOrderLecVO() {}

    public TOrderLecVO(int jGKey, int status, String startDt, int limitDay, float multiple) {
        this.jGKey = jGKey;
        this.indate = Util.returnNow();
        this.status = status;
        this.startDt = startDt + " 00:00:00";
        this.limitDay = limitDay;
        this.pauseStartDt = "";
        this.pauseCnt = 0;
        this.pauseDay = 0;
        this.pauseTotalDay = 0;
        this.multiple = multiple;
        this.maxReadCount = 0;
    }
}
