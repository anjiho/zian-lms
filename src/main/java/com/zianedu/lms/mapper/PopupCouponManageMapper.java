package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.PopupListDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.vo.TLinkKeyVO;
import com.zianedu.lms.vo.TPopupVO;
import com.zianedu.lms.vo.TPromotionVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PopupCouponManageMapper {

    /** SELECT **/
    List<PopupListDTO>selectTPopupList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber);

    int selectTPopupListCount();

    List<TLinkKeyVO>selectTPopupLinkKey(@Param("popupKey") int popupKey);

    TPopupVO selectTPopupInfo(@Param("popupKey") int popupKey);

    /** INSERT **/
    Integer insertTPopupInfo(TPopupVO tPopupVO);

    /** DELETE **/


    /** UPDATE **/
    void updateTPopupInfo(TPopupVO tPopupVO);

    void updateTPopupIsShow(@Param("popupKey") int popupKey, @Param("isShow") int isShow);

}
