package com.zianedu.lms.vo;

import lombok.Data;

import java.util.List;

@Data
public class TExamQuestionBankVO {

    private int examQuestionBankKey;

    private int cKey;

    private String dspDate;

    private String questionImage;

    private String commentaryImage;

    private String bookImage;

    private int answer;

    private String tag;

    private int divisionCtgKey;

    private int subjectCtgKey;

    private int stepCtgKey;//유형

    private int patternCtgKey;//패턴

    private int unitCtgKey;//단원

    private int examYear;//출제년도

    private int examLevel;//난이도

    private String subjectCode;//과목코드

    private String review;//총평

    private String commentaryUrl;//해설강의링크

    private String answer1Reason;

    private String answer2Reason;

    private String answer3Reason;

    private String answer4Reason;

    private String answer5Reason;

    private String questionImageUrl;

    private String commentaryImageUrl;

    private List<TCategoryVO>stepList;

    private List<TCategoryVO>patternList;

    private List<TCategoryVO>unitList;

    private int startNumber;

    private int listLimitNumber;

}
