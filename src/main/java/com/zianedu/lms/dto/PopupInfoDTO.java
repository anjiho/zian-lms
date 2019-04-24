package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TLinkKeyVO;
import com.zianedu.lms.vo.TPopupVO;
import lombok.Data;

import java.util.List;

@Data
public class PopupInfoDTO {

    private TPopupVO result;

    private List<TLinkKeyVO> resultList;

    public PopupInfoDTO(){}

    public PopupInfoDTO(TPopupVO result, List<TLinkKeyVO>resultList) {
        this.result = result;
        this.resultList = resultList;
    }
}
