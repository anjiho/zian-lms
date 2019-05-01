package com.zianedu.lms.repository;

import com.zianedu.lms.define.datasource.OrderPayType;
import com.zianedu.lms.dto.OrderPayTypeName;
import com.zianedu.lms.dto.OrderPayTypeNameContain;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 주문 타입 한글명 주입하기(T_ORDER.PAY_TYPE)
 */
@Component
public class OrderPayTypeNameRepositoryLogic implements OrderPayTypeNameRepository {

    @Override
    public void injectOrderPayTypeNameAny(List<?> orderPayTypeNameAny) {
        if (orderPayTypeNameAny == null || orderPayTypeNameAny.size() == 0) return;

        List<OrderPayTypeNameContain> contains = orderPayTypeNameAny
                .stream()
                .filter(Objects::nonNull)
                .filter(any->any instanceof OrderPayTypeNameContain)
                .map(any->(OrderPayTypeNameContain)any)
                .collect(Collectors.toList());

        this.injectOrderPayTypeNameContain(contains);
    }

    @Override
    public void injectOrderPayTypeNameContain(List<OrderPayTypeNameContain> orderPayTypeNameContains) {
        if (orderPayTypeNameContains == null || orderPayTypeNameContains.size() == 0)return;

        List<OrderPayTypeNameContain> injectable = orderPayTypeNameContains
                .stream()
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        List<Integer>orderPayTypes = injectable
                .stream()
                .map(OrderPayTypeNameContain::orderPayType)
                .distinct()
                .collect(Collectors.toList());

        if (orderPayTypes == null || orderPayTypes.size() == 0) return;

        List<OrderPayTypeName> orderPayTypeNameList = OrderPayType.getOrderPayTypeList();
        for (OrderPayTypeNameContain contain : injectable) {
            for (OrderPayTypeName orderPayTypeName : orderPayTypeNameList) {
                if (contain.orderPayType() != null && contain.orderPayType() == orderPayTypeName.getOrderPayType()) {
                    contain.addOrderPayTypeName(orderPayTypeName);
                }
            }
        }
    }
}
