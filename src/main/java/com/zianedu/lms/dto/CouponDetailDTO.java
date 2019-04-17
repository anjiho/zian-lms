package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TCouponMasterVO;
import lombok.Data;

import java.util.List;

@Data
public class CouponDetailDTO {

    private TCouponMasterVO couponInfo;

    private List<List<TCategoryVO>> couponCategoryList;

    private int couponCount;

    public CouponDetailDTO() {}

    public CouponDetailDTO(TCouponMasterVO couponInfo, List<List<TCategoryVO>> couponCategoryList, int couponCount) {
        this.couponInfo = couponInfo;
        this.couponCategoryList = couponCategoryList;
        this.couponCount = couponCount;
    }
}
