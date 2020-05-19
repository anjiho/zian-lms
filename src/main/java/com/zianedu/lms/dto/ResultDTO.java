package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import com.zianedu.lms.vo.TCategoryVO;
import lombok.Data;
import org.codehaus.jackson.annotate.JsonProperty;

import java.util.List;

@Data
public class ResultDTO {

    private Object result;

    private List<?> resultList;

    private Object resultTotalTime;

    private List<?> resultPauseRec;
}
