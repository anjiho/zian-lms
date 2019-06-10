package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.PromotionPmType;
import lombok.Data;

@Data
public class TPromotionVO {

    private int pmKey;

    private int gKey;

    private int pmType;

    private int examYear;

    private int limitDay;

    private int deviceLimitCount;
    //직렬 연결 코드
    private int affiliationCtgKey;

    private int classGroupCtgKey;

    private String pmTypeStr;

    public TPromotionVO(){}

    public TPromotionVO(int pmKey, int gKey, String pmTypeStr, int examYear, int limitDay,
                        int affiliationCtgKey, int classGroupCtgKey, int deviceLimitCount) {
        this.pmKey = pmKey;
        this.gKey = gKey;
        this.pmType = PromotionPmType.getPromotionPmTypeKey(pmTypeStr);
        this.examYear = examYear;
        this.limitDay = limitDay;
        this.deviceLimitCount = 0;
        this.affiliationCtgKey = affiliationCtgKey;
        this.classGroupCtgKey = classGroupCtgKey;
        this.deviceLimitCount = deviceLimitCount;
    }

}
