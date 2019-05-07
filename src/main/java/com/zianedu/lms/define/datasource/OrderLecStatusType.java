package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.OrderLecStatusName;

import java.util.ArrayList;
import java.util.List;

public enum OrderLecStatusType {

    WAIT(0, "대기중"),
    START(1, "시작"),
    PAUSE(2, "일시정지"),
    FINISH(3, "종강"),
    WAIT_RESTART(4, "재시작 대기")
    ;

    int orderLecStatusKey;

    String orderLecStatusStr;

    OrderLecStatusType(int orderLecStatusKey, String orderLecStatusStr) {
        this.orderLecStatusKey = orderLecStatusKey;
        this.orderLecStatusStr = orderLecStatusStr;
    }

    public static String getOrderLecStatusStr(int orderLecStatusKey) {
        for (OrderLecStatusType orderLecStatusType : OrderLecStatusType.values()) {
            if (orderLecStatusType.orderLecStatusKey == orderLecStatusKey) {
                return orderLecStatusType.orderLecStatusStr;
            }
        }
        return null;
    }

    public static List<OrderLecStatusName> getOrderLecStatusList() {
        List<OrderLecStatusName>list = new ArrayList<>();
        for (OrderLecStatusType orderLecStatusType : OrderLecStatusType.values()) {
            OrderLecStatusName orderLecStatusName = new OrderLecStatusName();
            orderLecStatusName.setOrderLecStatus(orderLecStatusType.orderLecStatusKey);
            orderLecStatusName.setOrderLecStatusName(orderLecStatusType.orderLecStatusStr);

            list.add(orderLecStatusName);
        }
        return list;
    }
}
