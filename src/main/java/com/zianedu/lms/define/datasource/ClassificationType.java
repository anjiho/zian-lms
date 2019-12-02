package com.zianedu.lms.define.datasource;

public enum ClassificationType {
    //이론
    THEORY(203, "이론"),
    //단과
    SHORT_SUBJECT(204, "단과"),
    //문제풀이a
    COMMENTARY(205, "문제풀이"),
    //패키지
    PACKAGE(206, "패키지"),
    //단과특강
    SPEACIAL_S_SUBJECT(207, "단과특강"),
    //종합반
    COMBINED_CLASS(767, "종합반"),
    //아침특강
    MORNING_CLASS(774, "아침특강"),
    //필기대비
    H_WRITING_CONTRAST(4172, "필기대비"),
    //실기대비
    PRACTICAL_CONTRAST(4173, "실기대비"),
    //모의고사
    MOK_TEST(4266, "모의고사"),;

    int classificationTypeKey;

    String classificationTypeStr;

    ClassificationType(int classificationTypeKey, String classificationTypeStr) {
        this.classificationTypeKey = classificationTypeKey;
        this.classificationTypeStr = classificationTypeStr;
    }

    public static Integer getClassificationTypeKey(String classificationTypeStr) {
        for (ClassificationType classificationType : ClassificationType.values()) {
            if (classificationTypeStr.equals(classificationType.toString())) {
                return classificationType.classificationTypeKey;
            }
        }
        return 0;
    }

    public static String getClassificationTypeStr(int classificationTypeKey) {
        for (ClassificationType classificationType : ClassificationType.values()) {
            if (classificationTypeKey == classificationType.classificationTypeKey) {
                return classificationType.classificationTypeStr;
            }
        }
        return null;
    }


}
