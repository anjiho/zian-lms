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

    private int stepCtgKey;

    private int patternCtgKey;

    private int unitCtgKey;

    private int examYear;

    private int examLevel;

    private String subjectCode;

    private String review;

    private String commentaryUrl;

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
