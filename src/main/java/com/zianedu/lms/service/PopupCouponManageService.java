package com.zianedu.lms.service;

import com.zianedu.lms.dto.PopupInfoDTO;
import com.zianedu.lms.dto.PopupListDTO;
import com.zianedu.lms.mapper.PopupCouponManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.vo.TLinkKeyVO;
import com.zianedu.lms.vo.TPopupVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PopupCouponManageService {

    @Autowired
    private PopupCouponManageMapper popupCouponManageMapper;

    @Autowired
    private ProductManageMapper productManageMapper;

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
     * 팝업 상세 > 노출 상태 값 변경
     * @param popupKey
     * @param isShow
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void changePopupViewStatus(int popupKey, int isShow) {
        if (popupKey == 0) return;
        popupCouponManageMapper.updateTPopupIsShow(popupKey, isShow);
    }

}
