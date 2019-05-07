package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TCalculateDataVO {

    private Long calculateDataKey;

    private Long calculateKey;

    private String indate;

    private int gKey;

    private int type;

    private int pmType;

    private int kind;

    private int calcPrice;

    private int jCount;

    private int payStatus;

    private int calcCalculateRate;

    private int gCalculateRate;

    private int gTCalculateRate;

    private int tCalculateRate;

    private int jKey;

    public TCalculateDataVO(){}

    public TCalculateDataVO(Long calculateKey, int gKey, int type, int pmType, int kind, int calcPrice,
                            int jCount, int payStatus, int calcCalculateRate, int gCalculateRate, int gTCalculateRate,
                            int tCalculateRate, int jKey) {
        this.calculateKey = calculateKey;
        this.indate = Util.returnNow();
        this.gKey = gKey;
        this.type = type;
        this.pmType = pmType;
        this.kind = kind;
        this.calcPrice = calcPrice;
        this.jCount = jCount;
        this.payStatus = payStatus;
        this.calcCalculateRate = calcCalculateRate;
        this.gCalculateRate = gCalculateRate;
        this.gTCalculateRate = gTCalculateRate;
        this.tCalculateRate = tCalculateRate;
        this.jKey = jKey;
    }
}
