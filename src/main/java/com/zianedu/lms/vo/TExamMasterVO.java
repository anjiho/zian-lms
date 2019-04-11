package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TExamMasterVO {

    private int examKey;

    private int cKey;

    private String name;

    private String indate;

    private int classCtgKey;

    private int selectSubjectCount;

    private String acceptStartDate;

    private String acceptEndDate;

    private String onlineStartDate;

    private String onlineEndDate;

    private int onlineTime;

    private String offlineDate;

    private String offlineTimePeriod;

    private String offlineTimePlace;

    private int answerCount;

    private int questionCount;

    private String printQuestionFile;

    private String printCommentaryFile;

    private int isShowStaticTotalRank;

    private int isShowStaticTotalAvg;

    private int isShowFiles;

    private int classGroupCtgKey;

    private int examYear;

    private int unitCtgKey = 0;

    private int divisionCtgKey;

    private int refKey;

    private int isRealFree;

    private int isGichul;

}
