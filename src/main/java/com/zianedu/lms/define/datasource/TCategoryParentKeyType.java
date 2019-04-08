package com.zianedu.lms.define.datasource;

/**
 * T_CATEGORY PARENT_KEY 타입 정의
 */
public enum TCategoryParentKeyType {
    //분류관리
    CLASSFICATION(202),
    //과목관리
    SUBJECT(70);

    int parentKey;

    TCategoryParentKeyType(int parentKey) {
        this.parentKey = parentKey;
    }

    public static int getParentKey(String categoryType) {
        for (TCategoryParentKeyType tCategoryParentKeyType : TCategoryParentKeyType.values()) {
            if (categoryType.equals(tCategoryParentKeyType.toString())) {
                return tCategoryParentKeyType.parentKey;
            }
        }
        return 0;
    }

    public int getParentKey() {
        return this.parentKey;
    }


}
