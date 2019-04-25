package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class StatisResultDTO {

    private String day;

    private String price;

    private String[] years;

    private long[] prices;

    public StatisResultDTO(){}

    public StatisResultDTO(String[] years, long[] prices) {
        this.years = years;
        this.prices = prices;
    }

    public StatisResultDTO(long[] prices) {
        this.prices = prices;
    }
}
