package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TBankSubjectExamLinkVO;
import com.zianedu.lms.vo.TExamMasterVO;
import lombok.Data;

import java.util.List;

@Data
public class MokExamInfoDTO {

    private TExamMasterVO mokExamInfo;

    private List<TBankSubjectExamLinkVO> examSubjectInfo;

    public MokExamInfoDTO(){}

    public MokExamInfoDTO(TExamMasterVO mokExamInfo, List<TBankSubjectExamLinkVO> examSubjectInfo) {
        this.mokExamInfo = mokExamInfo;
        this.examSubjectInfo = examSubjectInfo;
    }
}
