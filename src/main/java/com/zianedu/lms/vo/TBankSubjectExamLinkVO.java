package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import lombok.Data;

@Data
public class TBankSubjectExamLinkVO {

    private int bankSubjectExamLinkKey;

    private int cKey;

    private int examKey;

    private int examQuestionBankSubjectKey;

    private int required;

    private String name;

    private String ctgName;

    private int questionNumber;

    public TBankSubjectExamLinkVO(){}

    public TBankSubjectExamLinkVO(int bankSubjectExamLinkKey, int required) {
        this.bankSubjectExamLinkKey = bankSubjectExamLinkKey;
        this.required = required;
    }

    public TBankSubjectExamLinkVO(int examKey, int examQuestionBankSubjectKey, int required) {
        this.cKey = ZianCoreManage.ZIAN_COMPANY_CODE;
        this.examKey = examKey;
        this.examQuestionBankSubjectKey = examQuestionBankSubjectKey;
        this.required = required;
    }
}
