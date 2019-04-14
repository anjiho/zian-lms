package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TExamQuestionBankSubjectVO;
import lombok.Data;

import java.util.List;

@Data
public class ProblemBankSubjectDetailDTO {

    private TExamQuestionBankSubjectVO resultInfo;

    private List<ProblemBankSubjectDTO> resultList;

    public ProblemBankSubjectDetailDTO(){}

    public ProblemBankSubjectDetailDTO(TExamQuestionBankSubjectVO resultInfo, List<ProblemBankSubjectDTO> resultList) {
        this.resultInfo = resultInfo;
        this.resultList = resultList;
    }

}
