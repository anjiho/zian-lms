package com.zianedu.lms.define.datasource;

import org.apache.http.HttpStatus;

/**
 * 지안에듀 핵심 코드 값 관리 클래스
 */
public class ZianCoreManage {
    //지안에듀 회사코드
    public static final int ZIAN_COMPANY_CODE = 100;
    //강좌수 시작, 종료 값
    public static final int[] LECTURE_COUNT_START_END = {0, 200};
    //수강일수 시작, 종료 값
    public static final int[] CLASS_REGISTRATION_START_END = {0, 500};

    public static final int[] EXAM_PREPARE_YEAR = {2010, 2022};

    public static final int OK = HttpStatus.SC_OK;
}
