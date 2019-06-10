package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TOrderDeliveryVO;
import com.zianedu.lms.vo.TUserVO;
import lombok.Data;

import java.util.List;

@Data
public class OrderDetailDTO {

    private OrderDetailInfoDTO payInfo;

    private List<OrderDetailProductListDTO> orderProductList;

    private TUserVO orderUserInfo;

    private TUserVO deliveryUserInfo;

    private TOrderDeliveryVO deliveryInfo;

    private DeliveryAddressDTO deliveryAddressInfo;

    public OrderDetailDTO(){}

    public OrderDetailDTO(OrderDetailInfoDTO payInfo, List<OrderDetailProductListDTO> orderProductList,
                          TUserVO orderUserInfo, TUserVO deliveryUserInfo, TOrderDeliveryVO deliveryInfo,
                          DeliveryAddressDTO deliveryAddressInfo) {
        this.payInfo = payInfo;
        this.orderProductList = orderProductList;
        this.orderUserInfo = orderUserInfo;
        this.deliveryUserInfo = deliveryUserInfo;
        this.deliveryInfo = deliveryInfo;
        this.deliveryAddressInfo = deliveryAddressInfo;
    }
}
