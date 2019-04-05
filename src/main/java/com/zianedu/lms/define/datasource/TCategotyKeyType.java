package com.zianedu.lms.define.datasource;

/**
 * T_CATEGORY CTG_KEY 타입 정의
 */
public enum TCategotyKeyType {
    //상단 대 배너
    MAIN_BANNER(786);

    int ctgKey;

    TCategotyKeyType(int ctgKey) {
        this.ctgKey = ctgKey;
    }

    public static int getCtgKey(String categoryType) {
        for (TCategotyKeyType tCategotyKeyType : TCategotyKeyType.values()) {
            if (categoryType.equals(tCategotyKeyType.toString())) {
                return tCategotyKeyType.ctgKey;
            }
        }
        return 0;
    }

    public int getCthKey() {
        return this.ctgKey;
    }
}
