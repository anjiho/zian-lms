package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TUserVO;
import lombok.Data;

import java.util.List;

@Data
public class OrderDetailDTO {

    private OrderDetailInfoDTO payInfo;

    private List<OrderDetailProductListDTO> orderProductList;

    private TUserVO orderUserInfo;

    private TUserVO deliveryUserInfo;

    public OrderDetailDTO(){}

    public OrderDetailDTO(OrderDetailInfoDTO payInfo, List<OrderDetailProductListDTO> orderProductList,
                          TUserVO orderUserInfo, TUserVO deliveryUserInfo) {
        this.payInfo = payInfo;
        this.orderProductList = orderProductList;
        this.orderUserInfo = orderUserInfo;
        this.deliveryUserInfo = deliveryUserInfo;
    }
}
