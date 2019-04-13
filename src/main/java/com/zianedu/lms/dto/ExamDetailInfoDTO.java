package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TGoodsPriceOptionVO;
import com.zianedu.lms.vo.TGoodsVO;
import com.zianedu.lms.vo.TLinkKeyVO;
import lombok.Data;

import java.util.List;

@Data
public class ExamDetailInfoDTO {

    //기본정보
    private TGoodsVO productInfo;
    //옵션정보
    private List<TGoodsPriceOptionVO> productOptionInfo;
    //카테고리 목록
    private List<List<TCategoryVO>> productCategoryInfo;
    //모의고사 정보
    private List<TLinkKeyVO> productOtherInfo;

    public ExamDetailInfoDTO() {}

    public ExamDetailInfoDTO(TGoodsVO productInfo, List<TGoodsPriceOptionVO> productOptionInfo,
                             List<List<TCategoryVO>> productCategoryInfo, List<TLinkKeyVO> productOtherInfo) {
        this.productInfo = productInfo;
        this.productOptionInfo = productOptionInfo;
        this.productCategoryInfo = productCategoryInfo;
        this.productOtherInfo = productOtherInfo;
    }
}
