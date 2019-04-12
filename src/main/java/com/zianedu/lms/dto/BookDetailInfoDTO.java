package com.zianedu.lms.dto;

import com.zianedu.lms.vo.*;
import lombok.Data;

import java.util.List;

@Data
public class BookDetailInfoDTO {
    //기본정보
    private TGoodsVO productInfo;
    //옵션정보
    private List<TGoodsPriceOptionVO> productOptionInfo;
    //카테고리 목록
    private List<List<TCategoryVO>> productCategoryInfo;
    //도서 정보
    private TBookVO bookInfo;
    //미리보기 정보
    private List<TResVO> previewInfo;

    public BookDetailInfoDTO(){}

    public BookDetailInfoDTO(TGoodsVO productInfo, List<TGoodsPriceOptionVO> productOptionInfo,
                             List<List<TCategoryVO>> productCategoryInfo, TBookVO bookInfo, List<TResVO> previewInfo) {
        this.productInfo = productInfo;
        this.productOptionInfo = productOptionInfo;
        this.productCategoryInfo = productCategoryInfo;
        this.bookInfo = bookInfo;
        this.previewInfo = previewInfo;
    }
}
