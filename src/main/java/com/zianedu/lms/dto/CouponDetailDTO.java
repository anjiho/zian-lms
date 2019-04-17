package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TCouponMasterVO;
import lombok.Data;

import java.util.List;

@Data
public class CouponDetailDTO {

    private TCouponMasterVO couponInfo;

    private List<List<TCategoryVO>> couponCategoryList;

    public CouponDetailDTO() {}

    public CouponDetailDTO(TCouponMasterVO couponInfo, List<List<TCategoryVO>> couponCategoryList) {
        this.couponInfo = couponInfo;
        this.couponCategoryList = couponCategoryList;
    }
}
