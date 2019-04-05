package com.zianedu.lms.define.datasource;

/**
 * T_CATEGORY CTG_KEY 타입 정의
 */
public enum TCategoryKeyType {
    //상단 대 배너(행정직 학원)
    ADMIN_TOP_MAIN_BANNER(786),
    //상단 소 배너(행정직 학원)
    ADMIN_TOP_SUB_BANNER(787),
    //상단 대 배너(행정직 동영상)
    ADMIN_VIDEO_BANNER(792),
    //
    ;


    int ctgKey;

    TCategoryKeyType(int ctgKey) {
        this.ctgKey = ctgKey;
    }

    public static int getCtgKey(String categoryType) {
        for (TCategoryKeyType tCategoryKeyType : TCategoryKeyType.values()) {
            if (categoryType.equals(tCategoryKeyType.toString())) {
                return tCategoryKeyType.ctgKey;
            }
        }
        return 0;
    }

    public int getCthKey() {
        return this.ctgKey;
    }
}
