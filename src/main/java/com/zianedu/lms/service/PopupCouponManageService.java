package com.zianedu.lms.service;

import com.zianedu.lms.dto.PopupListDTO;
import com.zianedu.lms.mapper.PopupCouponManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PopupCouponManageService {

    @Autowired
    private PopupCouponManageMapper popupCouponManageMapper;

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


}
