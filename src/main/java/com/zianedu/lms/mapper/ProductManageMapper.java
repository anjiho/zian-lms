package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.PagingSearchDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TScheduleVO;
import com.zianedu.lms.vo.TSearchKeywordVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductManageMapper {

    /** SELECT **/
    List<VideoListDTO> selectVideoList(PagingSearchDTO pagingSearchDTO);


    /** INSERT **/


    /** DELETE **/


    /** UPDATE **/

}
