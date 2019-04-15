package com.zianedu.lms.define.datasource;

/**
 * T_CATEGORY PARENT_KEY 타입 정의
 */
public enum TCategoryParentKeyType {
    //분류
    CLASSFICATION(202),
    //과목
    SUBJECT(70),
    //급수
    RATE(4309),
    //유형
    TYPE(202),
    //분류(모의고사)
    EXAM_TYPE(133),
    //단원
    UNIT_TYPE(4405),
    //출제구분
    DIVISION_TYPE(4390),
    //직렬
    AFFILIATION_TYPE(133)
    ;

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
