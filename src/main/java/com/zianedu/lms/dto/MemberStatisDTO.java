package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class MemberStatisDTO {

    private String[] years;

    private long[] userCounts;

    public MemberStatisDTO(){}

    public MemberStatisDTO(long[] userCounts) {
        this.userCounts = userCounts;
    }

    public MemberStatisDTO(String[] years, long[] userCounts) {
        this.years = years;
        this.userCounts = userCounts;
    }
}
