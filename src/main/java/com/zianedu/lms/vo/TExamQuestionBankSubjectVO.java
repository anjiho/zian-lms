package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TExamQuestionBankSubjectVO {

    private int examQuestionBankSubjectKey;

    private int cKey;

    private int subjectCtgKey;

    private String name;

    private String ctgName;
    
    private int questionNumber;
}
