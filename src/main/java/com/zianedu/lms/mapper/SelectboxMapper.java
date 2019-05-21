package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.DeliveryVO;
import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TSiteVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SelectboxMapper {

    List<TSiteVO> selectSubDomainList();

    List<TCategoryVO> selectTCategoryByParentKey(@Param("parentKey") int parentKey);

    List<DeliveryVO> selectDeliveryCompanyList();

}
