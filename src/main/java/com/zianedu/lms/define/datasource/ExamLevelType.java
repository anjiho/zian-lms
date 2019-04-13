package com.zianedu.lms.define.datasource;

public enum ExamLevelType {

    HIGH(0, "상"),
    MIDDLE(1, "중"),
    LOW(2, "하");


    int examLevelKey;

    String examLevelStr;

    ExamLevelType(int examLevelKey, String examLevelStr) {
        this.examLevelKey = examLevelKey;
        this.examLevelStr = examLevelStr;
    }

    public static String getExamLevelStr(int examLevelKey) {
        for (ExamLevelType levelType : ExamLevelType.values()) {
            if (examLevelKey == levelType.examLevelKey) {
                return levelType.examLevelStr;
            }
        }
        return null;
    }
}
