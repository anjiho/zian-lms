package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.PopupListDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.vo.TPromotionVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PopupCouponManageMapper {

    /** SELECT **/
    List<PopupListDTO>selectTPopupList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber);

    int selectTPopupListCount();

    /** INSERT **/


    /** DELETE **/


    /** UPDATE **/


}
