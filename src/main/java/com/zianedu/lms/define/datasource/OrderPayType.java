package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.OrderPayTypeName;
import org.aspectj.weaver.ast.Or;

import java.util.ArrayList;
import java.util.List;

public enum OrderPayType {

    CARD(0, "신용카드"),
    LIVE_BANK(1, "실사간 계좌이체"),
    DEPOSIT_BANK(19, "무통장입금"),
    FREE(20, "무료"),
    CASH(21, "현금"),
    CASH_CARD(22, "현금+신용카드"),
    ONLINE(23, "온라인")
    ;

    int orderPayTypeKey;

    String orderPayTypeStr;

    OrderPayType(int orderPayTypeKey, String orderPayTypeStr) {
        this.orderPayTypeKey = orderPayTypeKey;
        this.orderPayTypeStr = orderPayTypeStr;
    }

    public static String getOrderPayTypeStr(int orderPayTypeKey) {
        for (OrderPayType orderPayType : OrderPayType.values()) {
            if (orderPayTypeKey == orderPayType.orderPayTypeKey) {
                return orderPayType.orderPayTypeStr;
            }
        }
        return null;
    }

    public static List<OrderPayTypeName> getOrderPayTypeList() {
        List<OrderPayTypeName>list = new ArrayList<>();
        for (OrderPayType orderPayType : OrderPayType.values()) {
            OrderPayTypeName orderPayTypeName = new OrderPayTypeName();
            orderPayTypeName.setOrderPayType(orderPayType.orderPayTypeKey);
            orderPayTypeName.setOrderPayTypeName(orderPayType.orderPayTypeStr);

            list.add(orderPayTypeName);
        }
        return list;
    }
}
