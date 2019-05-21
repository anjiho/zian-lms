package com.zianedu.lms.dto;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class DeliveryAddressDTO {

    private int jKey;

    private String deliveryNane;

    private String deliveryTelephone;

    private String deliveryTelephoneMobile;

    private String deliveryEmail;

    private String deliveryZipcode;

    private String deliveryAddress;

    private String deliveryAddressRoad;

    private String deliveryAddressAdd;

    public DeliveryAddressDTO(){}

    public DeliveryAddressDTO(int jKey, String deliveryName, String deliveryTelephone, String deliveryTelephoneMobile,
                              String deliveryEmail, String deliveryZipcode, String deliveryAddress, String deliveryAddressRoad,
                              String deliveryAddressAdd) {
        this.jKey = jKey;
        this.deliveryNane = Util.isNullValue(deliveryName, "");
        this.deliveryTelephone = Util.isNullValue(deliveryTelephone, "");
        this.deliveryTelephoneMobile = Util.isNullValue(deliveryTelephoneMobile, "");
        this.deliveryEmail = Util.isNullValue(deliveryEmail, "");
        this.deliveryZipcode = Util.isNullValue(deliveryZipcode, "");
        this.deliveryAddress = Util.isNullValue(deliveryAddress, "");
        this.deliveryAddressRoad = Util.isNullValue(deliveryAddressRoad, "");
        this.deliveryAddressAdd = Util.isNullValue(deliveryAddressAdd, "");
    }

}
