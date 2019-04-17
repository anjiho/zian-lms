package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.CouponDcType;
import com.zianedu.lms.define.datasource.CouponIssueType;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.PopupCouponManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.RandomUtil;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Service
public class PopupCouponManageService {

    @Autowired
    private PopupCouponManageMapper popupCouponManageMapper;

    @Autowired
    private ProductManageMapper productManageMapper;

    @Autowired
    private DataManageService dataManageService;

    /**
     * 팝업 목록 리스트
     * @param sPage
     * @param listLimit
     * @return
     */
    @Transactional(readOnly = true)
    public List<PopupListDTO> getPopupList(int sPage, int listLimit) {
        if (sPage == 0) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        return popupCouponManageMapper.selectTPopupList(startNumber, listLimit);
    }

    /**
     * 팝업 목록 리스트 개수
     * @return
     */
    @Transactional(readOnly = true)
    public int getPopupListCount() {
        return popupCouponManageMapper.selectTPopupListCount();
    }

    /**
     * 팝업 목록 상세정보
     * @param popupKey
     * @return
     */
    @Transactional(readOnly = true)
    public PopupInfoDTO getPopupDetailInfo(int popupKey) {
        if (popupKey == 0) return null;
        PopupInfoDTO popupInfoDTO = new PopupInfoDTO(
                popupCouponManageMapper.selectTPopupInfo(popupKey),
                popupCouponManageMapper.selectTPopupLinkKey(popupKey)
        );
        return popupInfoDTO;
    }

    /**
     * 쿠폰 목록 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<CouponListDTO> getCouponList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        List<CouponListDTO> list = popupCouponManageMapper.selectTCouponMaterList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
        if (list.size() > 0) {
            for (CouponListDTO couponListDTO : list) {
                couponListDTO.setDcTypeName(CouponDcType.getCouponDcTypeStr(couponListDTO.getDcType()));
                couponListDTO.setIssueTypeName(CouponIssueType.getCouponIssueTypeStr(couponListDTO.getType()));
            }
        }
        return list;
    }

    /**
     * 쿠폰 목록 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getCouponListCount(String searchType, String searchText) {
        return popupCouponManageMapper.selectTCouponMaterListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
    }

    /**
     * 쿠폰 상세안의 카테고리 리스트
     * @param couponKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<List<TCategoryVO>> getCouponCategory(int couponKey) {
        List<TLinkKeyVO>tLinkKeyVOList = popupCouponManageMapper.selectTCouponLinkKey(couponKey);
        List<List<TCategoryVO>>couponCategoryList = new ArrayList<>();
        if (tLinkKeyVOList.size() > 0) {
            for (TLinkKeyVO tLinkKeyVO : tLinkKeyVOList) {
                List<TCategoryVO> tCategoryVOList = dataManageService.getSequentialCategoryListBy4DepthUnder(tLinkKeyVO.getReqKey());
                //Collections.reverse(tCategoryVOList);
                couponCategoryList.add(tCategoryVOList);
            }
        }
        return couponCategoryList;
    }

    /**
     * 쿠폰 상세정보 가져오기 (쿠폰 상세정보 + 쿠폰 적용 카테고리)
     * @param couponMasterKey
     * @return
     */
    @Transactional(readOnly = true)
    public CouponDetailDTO getCouponDetailInfo(int couponMasterKey) {
        if (couponMasterKey == 0) return null;
        TCouponMasterVO tCouponMasterVO = popupCouponManageMapper.selectTCouponMaterInfo(couponMasterKey);
        List<List<TCategoryVO>>categoryList = this.getCouponCategory(couponMasterKey);
        int issuedOfflineCouponCount = 0;

        if (tCouponMasterVO.getType() == 1) {
            //총 생성된 오프라인 쿠폰 개수 가져오기
            issuedOfflineCouponCount = popupCouponManageMapper.selectIssuedOfflineCouponCount(couponMasterKey);
        }
        CouponDetailDTO couponDetailDTO = new CouponDetailDTO(
            tCouponMasterVO, categoryList, issuedOfflineCouponCount
        );
        return couponDetailDTO;
    }

    /**
     * 쿠폰 상세 > 오프라인 쿠폰 목록 조회 리스트
     * @param couponMasterKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<OfflineCouponListDTO> getOfflineCouponList(int sPage, int listLimit, int couponMasterKey) {
        if (couponMasterKey == 0 && sPage == 0) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        return popupCouponManageMapper.selectOfflineCouponList(startNumber, listLimit, couponMasterKey);
    }

    /**
     * 쿠폰 상세 > 오프라인 쿠폰 목록 조회 리스트 개수
     * @param couponMasterKey
     * @return
     */
    @Transactional(readOnly = true)
    public int getOfflineCouponListCount(int couponMasterKey) {
        if (couponMasterKey == 0) return 0;
        return popupCouponManageMapper.selectOfflineCouponListCount(couponMasterKey);
    }

    /**
     * 쿠폰 상세 > 쿠폰 소시자 조회 리스트
     * @param sPage
     * @param listLimit
     * @param couponMasterKey
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<OfflineCouponListDTO> getOfflineCouponUserList(int sPage, int listLimit, int couponMasterKey,
                                                               String searchType, String searchText) {
        if (couponMasterKey == 0 && sPage == 0) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        return popupCouponManageMapper.selectOfflineCouponUserList(
                startNumber,
                listLimit,
                couponMasterKey,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
    }

    /**
     * 쿠폰 상세 > 쿠폰 소시자 조회 리스트 개수
     * @param couponMasterKey
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getOfflineCouponListUserCount(int couponMasterKey, String searchType, String searchText) {
        if (couponMasterKey == 0) return 0;
        return popupCouponManageMapper.selectOfflineCouponUserListCount(
                couponMasterKey,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
    }

    /**
     * 팝업 정보, 카테고리 정보 저장하기
     * @param tPopupVO
     * @param ctgKeyList
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Integer savePopupInfo(TPopupVO tPopupVO, List<Integer>ctgKeyList) {
        Integer popupKey = popupCouponManageMapper.insertTPopupInfo(tPopupVO);
        if (popupKey != null) {
            for (Integer ctgKey : ctgKeyList) {
                TLinkKeyVO tLinkKeyVO = new TLinkKeyVO();
                tLinkKeyVO.setReqKey(ctgKey);
                tLinkKeyVO.setResKey(popupKey);
                tLinkKeyVO.setReqType(100);
                tLinkKeyVO.setResType(300);
                tLinkKeyVO.setValueBit(0);

                productManageMapper.insertTLinkKey(tLinkKeyVO);
            }
        }
        return popupKey;
    }

    /**
     * 팝업 정보 수정
     * @param tPopupVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updatePopupInfo(TPopupVO tPopupVO) {
        popupCouponManageMapper.updateTPopupInfo(tPopupVO);
    }

    /**
     * 팝업 정보 > 카테고리 목록 추가
     * @param popupKey
     * @param ctgKeyList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updatePopupCategoryInfo(int popupKey, List<Integer>ctgKeyList) {
        if (ctgKeyList.size() == 0) return;
        for (Integer ctgKey : ctgKeyList) {
            TLinkKeyVO tLinkKeyVO = new TLinkKeyVO();
            tLinkKeyVO.setReqKey(ctgKey);
            tLinkKeyVO.setResKey(popupKey);
            tLinkKeyVO.setReqType(100);
            tLinkKeyVO.setResType(300);
            tLinkKeyVO.setValueBit(0);

            productManageMapper.insertTLinkKey(tLinkKeyVO);
        }
    }

    /**
     * 쿠폰 상세정보 > 쿠폰 적용 카테고리 추가
     * @param couponMasterKey
     * @param ctgKeyList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateCouponCategoryInfo(int couponMasterKey, List<Integer>ctgKeyList) {
        if (ctgKeyList.size() == 0) return;
        for (Integer ctgKey : ctgKeyList) {
            TLinkKeyVO tLinkKeyVO = new TLinkKeyVO();
            tLinkKeyVO.setReqKey(ctgKey);
            tLinkKeyVO.setResKey(couponMasterKey);
            tLinkKeyVO.setReqType(100);
            tLinkKeyVO.setResType(400);
            tLinkKeyVO.setValueBit(0);
            productManageMapper.insertTLinkKey(tLinkKeyVO);
        }
    }

    /**
     * 팝업 상세 > 노출 상태 값 변경
     * @param popupKey
     * @param isShow
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void changePopupViewStatus(int popupKey, int isShow) {
        if (popupKey == 0) return;
        popupCouponManageMapper.updateTPopupIsShow(popupKey, isShow);
    }

    /**
     * 쿠폰 기본 정보 수정하기
     * @param tCouponMasterVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateCouponMasterInfo(TCouponMasterVO tCouponMasterVO) {
        popupCouponManageMapper.updateTCouponMaster(tCouponMasterVO);
    }

    /**
     * 쿠폰 정보 저장하기
     * @param tCouponMasterVO
     * @param categoryCtgKeyList(카테고리 키 값 리스트)
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveCouponInfo(TCouponMasterVO tCouponMasterVO, List<Integer>categoryCtgKeyList) {
        popupCouponManageMapper.insertTCouponMaster(tCouponMasterVO);
        if (tCouponMasterVO.getCouponMasterKey() != null) {
            if (categoryCtgKeyList.size() > 0) {
                for (Integer ctgKey : categoryCtgKeyList) {
                    TLinkKeyVO tLinkKeyVO = new TLinkKeyVO();
                    tLinkKeyVO.setReqKey(ctgKey);
                    tLinkKeyVO.setResKey(tCouponMasterVO.getCouponMasterKey());
                    tLinkKeyVO.setReqType(100);
                    tLinkKeyVO.setResType(400);
                    tLinkKeyVO.setPos(0);
                    tLinkKeyVO.setValueBit(0);

                    productManageMapper.insertTLinkKey(tLinkKeyVO);
                }
            }
        }
        return tCouponMasterVO.getCouponMasterKey();
    }

    /**
     * 오프라인 쿠폰 발급하기
     * @param couponMasterKey
     * @param userKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void issueCouponToUser(int couponMasterKey, int userKey) {
        if (couponMasterKey == 0 && userKey == 0) return;
        TCouponIssueVO couponIssueVO = new TCouponIssueVO(couponMasterKey, userKey);
        popupCouponManageMapper.insertTCouponIssue(couponIssueVO);
    }

    /**
     * 쿠폰 상세정보 > 오프라인쿠폰 생성
     * @param couponMasterKey
     * @param produceCount
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void produceOfflineCoupon(int couponMasterKey, int produceCount) {
        if (couponMasterKey == 0 && produceCount == 0) return;
        for (int i=0; i<produceCount; i++) {
            String offlineCouponCode = RandomUtil.getRandomAlphaNumber(16);
            TCouponOfflineVO couponOfflineVO = new TCouponOfflineVO(couponMasterKey, offlineCouponCode);
            popupCouponManageMapper.insertTCouponOffline(couponOfflineVO);
        }
    }

}
