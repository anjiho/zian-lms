package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class StatisResultDTO {

    private String day;

    private String price;

    private String[] years;

    private long[] prices;

    private long[] totalPrices;

    private long[] videoPrices;

    private long[] academyPrices;

    private long[] bookPrices;

    public StatisResultDTO(){}

    public StatisResultDTO(String[] years, long[] prices) {
        this.years = years;
        this.prices = prices;
    }

    public StatisResultDTO(long[] prices) {
        this.prices = prices;
    }

    public StatisResultDTO(long[] totalPrices, long[] videoPrices, long[] academyPrices, long[] bookPrices) {
        this.totalPrices = totalPrices;
        this.videoPrices = videoPrices;
        this.academyPrices = academyPrices;
        this.bookPrices = bookPrices;
    }
}
