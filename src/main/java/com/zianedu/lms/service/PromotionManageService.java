package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.PromotionPmType;
import com.zianedu.lms.dto.PromotionDetailDTO;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.mapper.PromotionManageMapper;
import com.zianedu.lms.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class PromotionManageService {

    @Autowired
    private PromotionManageMapper promotionManageMapper;

    @Autowired
    private ProductManageMapper productManageMapper;

    @Autowired
    private ProductManageService productManageService;

    /**
     * 패키지 목록 상세정보
     * @param gKey
     * @return
     */
    @Transactional(readOnly = true)
    public PromotionDetailDTO getPackageDetailInfo(int gKey) {
        if (gKey == 0) return null;

        TGoodsVO productInfo = productManageService.getVideoBasicInfo(gKey);
        List<TGoodsPriceOptionVO> productOptionInfo = productManageService.getVideoOptionList(gKey);
        List<List<TCategoryVO>>productCategoryInfo = productManageService.getVideoCategoryList(gKey);
        TPromotionVO productPromotionInfo = promotionManageMapper.selectTPromotion(gKey);

        List<TLinkKeyVO>tLinkKeyVOList = productManageMapper.selectTLinkKeyList(gKey);
        List<TLinkKeyVO>productOnlineLectureInfo = new ArrayList<>();
        if (tLinkKeyVOList.size() > 0) {
            for (TLinkKeyVO linkKeyVO : tLinkKeyVOList) {
                productOnlineLectureInfo = productManageService.getGoodsListFromTLinkKey(gKey, linkKeyVO.getResType());
            }
        }

        PromotionDetailDTO promotionDetailDTO = new PromotionDetailDTO(
                productInfo,
                productOptionInfo,
                productCategoryInfo,
                productPromotionInfo,
                productOnlineLectureInfo
        );
        return promotionDetailDTO;
    }

    /**
     * 패키지 등록하기(
     * @param productInfo
     * @param productOptionInfo
     * @param productCategoryInfo
     * @param productPromotionInfo (지안패스 페이지, 연간회원제 페이지 등록시 입력화면이 없다 )
     * @param productOnlineLectureInfo
     */
    public void savePackage(TGoodsVO productInfo, List<TGoodsPriceOptionVO>productOptionInfo, List<TCategoryGoods>productCategoryInfo,
                            TPromotionVO productPromotionInfo, List<TLinkKeyVO>productOnlineLectureInfo) {
        //상품 기본정보 입력
        Integer gKey = productManageService.upsultGoodsInfo(productInfo, productInfo.getImageList(), productInfo.getImageView());
        if (gKey != null || gKey > 0) {
            //카테고리 목록 입력
            productManageService.upsultTGoodsPriceOption(productOptionInfo, gKey);
            //옵션정보
            if (productOptionInfo != null) productManageService.upsultTCategoryGoods(productCategoryInfo, gKey);
            //연간회원제 페이지, 지안패스 페이지는 입력화면이 없어서 예외처리
            if (PromotionPmType.getPromotionPmTypeKey(productPromotionInfo.getPmTypeStr()) == 51
                || PromotionPmType.getPromotionPmTypeKey(productPromotionInfo.getPmTypeStr()) == 101) {
                this.upsultPromotionInfo(
                        0, gKey, productPromotionInfo.getPmTypeStr(), 0, 0, 0, 0);
            } else {
                //패키지, 연간회원제, 지안패스
                this.upsultPromotionInfo(
                        productPromotionInfo.getPmKey(),
                        gKey,
                        productPromotionInfo.getPmTypeStr(),
                        productPromotionInfo.getExamYear(),
                        productPromotionInfo.getLimitDay(),
                        productPromotionInfo.getAffiliationCtgKey(),
                        productPromotionInfo.getClassGroupCtgKey()
                );
            }
            //온라인강좌, 프리패스 입력
            productManageService.upsultTLinkKink(productOnlineLectureInfo, gKey);
        }
    }

    /**
     * 프로모션 정보 저장및 수정
     * @param pmKey
     * @param gKey
     * @param pmTypeStr
     * @param examYear
     * @param limitDay
     * @param affiliationCtgKey
     * @param classGroupCtgKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultPromotionInfo(int pmKey, int gKey, String pmTypeStr, int examYear,
                                    int limitDay, int affiliationCtgKey, int classGroupCtgKey) {
        TPromotionVO promotionVO = new TPromotionVO(
                pmKey, gKey, pmTypeStr, examYear, limitDay, affiliationCtgKey, classGroupCtgKey
        );
        if (promotionVO.getPmKey() == 0) {
            promotionManageMapper.insertTPromotion(promotionVO);
        } else {
            promotionManageMapper.updateTPromotion(promotionVO);
        }
    }

}
