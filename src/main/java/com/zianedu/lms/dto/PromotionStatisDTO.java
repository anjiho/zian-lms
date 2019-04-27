package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class PromotionStatisDTO {

    private String[] years;

    private long[] packagePrices;

    private long[] yearMemberPrices;

    private long[] zianPassPrices;

    public PromotionStatisDTO(){}

    public PromotionStatisDTO(String[] years, long[] packagePrices, long[] yearMemberPrices, long[] zianPassPrices) {
        this.years = years;
        this.packagePrices = packagePrices;
        this.yearMemberPrices = yearMemberPrices;
        this.zianPassPrices = zianPassPrices;
    }

    public PromotionStatisDTO(long[] packagePrices, long[] yearMemberPrices, long[] zianPassPrices) {
        this.packagePrices = packagePrices;
        this.yearMemberPrices = yearMemberPrices;
        this.zianPassPrices = zianPassPrices;
    }
}
