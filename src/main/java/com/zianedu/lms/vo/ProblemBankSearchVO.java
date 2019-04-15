package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class ProblemBankSearchVO {
    //페이징 시작 넘버
    private int startPage;
    //출제구분
    private int divisionCtgKey = 0;
    //과목
    private int subjectCtgKey = 0;
    //유형
    private int stepCtgKey = 0;
    //패턴
    private int patternCtgKey = 0;
    //단원
    private int unitCtgKey = 0;
    //출제년도
    private String examYear = "";
    //과목코드
    private String subjectCode = "";

    private int startNumber;
    //리스트개수
    private int listLimitNumber;

}
