package com.zianedu.lms.vo;

import com.zianedu.lms.dto.CalculateInfoDTO;
import com.zianedu.lms.utils.StringUtils;
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

    public TCalculateDataVO(CalculateInfoDTO calculateInfoDTO) {
        this.calculateKey = calculateInfoDTO.getCalculateKey();
        this.indate = Util.returnNow();
        this.gKey = calculateInfoDTO.getGKey();
        this.type = calculateInfoDTO.getType();
        this.pmType = calculateInfoDTO.getPmType();
        this.kind = calculateInfoDTO.getKind();
        this.calcPrice = StringUtils.convertLastNumberZero(calculateInfoDTO.getCalcPrice());
        this.jCount = calculateInfoDTO.getJCount();
        this.payStatus = calculateInfoDTO.getPayStatus();
        this.calcCalculateRate = calculateInfoDTO.getCalcCalculateRate();
        this.gCalculateRate = calculateInfoDTO.getGCalculateRate();
        this.gTCalculateRate = calculateInfoDTO.getGTCalculateRate();
        this.tCalculateRate = calculateInfoDTO.getTCalculateRate();
        //this.jKey = jKey;
    }
}
