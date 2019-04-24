package com.zianedu.lms.repository;

import com.zianedu.lms.service.ProductManageService;
import com.zianedu.lms.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
public class ProductManageRepository {

    @Autowired
    private ProductManageService productManageService;

    /**
     * 동영상, 학원강의 저장하기
     * @param tGoodsVO
     * @param tGoodsPriceOptionVOList
     * @param tCategoryVOList
     * @param tLecVO
     * @param tGoodTeacherLinkVOS
     * @param tLinkKeyVOList
     * @param imageListFilePath
     * @param imageViewFilePath
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Integer saveProductInfo(TGoodsVO tGoodsVO,
                                 List<TGoodsPriceOptionVO> tGoodsPriceOptionVOList,
                                 List<TCategoryGoods>tCategoryVOList,
                                 TLecVO tLecVO,
                                 List<TGoodTeacherLinkVO>tGoodTeacherLinkVOS,
                                 List<TLinkKeyVO>tLinkKeyVOList,
                                 String imageListFilePath, String imageViewFilePath) {
        Integer gKey = productManageService.upsultGoodsInfo(tGoodsVO, imageListFilePath, imageViewFilePath);
        if (gKey != null || gKey > 0) {
            productManageService.upsultTGoodsPriceOption(tGoodsPriceOptionVOList, gKey);
            productManageService.upsultTCategoryGoods(tCategoryVOList, gKey);
            productManageService.upsultTLec(tLecVO, gKey);
            productManageService.upsultTGoodTeacherLink(tGoodTeacherLinkVOS, gKey);
            productManageService.upsultTLinkKink(tLinkKeyVOList, gKey);
        }
        return gKey;
    }

}
