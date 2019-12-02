package com.zianedu.lms.dto;

import com.zianedu.lms.vo.*;
import lombok.Data;

import java.util.List;

@Data
public class PromotionDetailDTO {

    private TGoodsVO productInfo;

    private List<TGoodsPriceOptionVO> productOptionInfo;

    private List<List<TCategoryVO>> productCategoryInfo;

    private TPromotionVO productPromotionInfo;

    private List<TLinkKeyVO> productOnlineLectureInfo;

    private List<TGoodTeacherLinkVO> productTeacherInfo;

    public PromotionDetailDTO(){}

    public PromotionDetailDTO(TGoodsVO productInfo, List<TGoodsPriceOptionVO> productOptionInfo, List<List<TCategoryVO>> productCategoryInfo,
                              TPromotionVO productPromotionInfo, List<TLinkKeyVO> productOnlineLectureInfo,List<TGoodTeacherLinkVO> productTeacherInfo) {
        this.productInfo = productInfo;
        this.productOptionInfo = productOptionInfo;
        this.productCategoryInfo = productCategoryInfo;
        this.productPromotionInfo = productPromotionInfo;
        this.productOnlineLectureInfo = productOnlineLectureInfo;
        this.productTeacherInfo=productTeacherInfo;
    }
}
