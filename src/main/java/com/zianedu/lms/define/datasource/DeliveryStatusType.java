package com.zianedu.lms.define.datasource;

public enum DeliveryStatusType {

    PREPARE(0, "준비중"),
    SHIPPING(1, "배송중"),
    SHIPPING_SUCCESS(2, "준비중"),
    VISITED(3, "방문수령"),
    VISITED_SUCCESS(4, "방문수령완료");

    int deliveryStatusKey;

    String deliveryStatusStr;

    DeliveryStatusType(int deliveryStatusKey, String deliveryStatusStr) {
        this.deliveryStatusKey = deliveryStatusKey;
        this.deliveryStatusStr = deliveryStatusStr;
    }

    public static String getDeliveryStatusName(int deliveryStatusKey) {
        for (DeliveryStatusType type : DeliveryStatusType.values()) {
            if (deliveryStatusKey == type.deliveryStatusKey) {
                return type.deliveryStatusStr;
            }
        }
        return null;
    }
}
