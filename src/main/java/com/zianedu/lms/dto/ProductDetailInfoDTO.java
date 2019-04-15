package com.zianedu.lms.dto;

import com.zianedu.lms.vo.*;
import lombok.Data;

import java.util.List;

@Data
public class ProductDetailInfoDTO {

    private TGoodsVO productInfo;

    private List<TGoodsPriceOptionVO> productOptionInfo;

    private List<List<TCategoryVO>> productCategoryInfo;

    private TLecVO productLectureInfo;

    private List<TGoodTeacherLinkVO> productTeacherInfo;

    private List<TLinkKeyVO> productOtherInfo;

    private List<TLecCurri> videoLectureCurriInfo;

    public ProductDetailInfoDTO(){}

    public ProductDetailInfoDTO(TGoodsVO productInfo, List<TGoodsPriceOptionVO>productOptionInfo,
                                List<List<TCategoryVO>>productCategoryInfo, TLecVO productLectureInfo,
                                List<TGoodTeacherLinkVO> productTeacherInfo, List<TLinkKeyVO> productOtherInfo,
                                List<TLecCurri> videoLectureCurriInfo) {
        this.productInfo = productInfo;
        this.productOptionInfo = productOptionInfo;
        this.productCategoryInfo = productCategoryInfo;
        this.productLectureInfo = productLectureInfo;
        this.productTeacherInfo = productTeacherInfo;
        this.productOtherInfo = productOtherInfo;
        this.videoLectureCurriInfo = videoLectureCurriInfo;
    }
}
