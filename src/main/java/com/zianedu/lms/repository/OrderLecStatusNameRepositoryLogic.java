package com.zianedu.lms.repository;

import com.zianedu.lms.define.datasource.OrderLecStatusType;
import com.zianedu.lms.dto.OrderLecStatusName;
import com.zianedu.lms.dto.OrderLecStatusNameContain;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Component
public class OrderLecStatusNameRepositoryLogic implements OrderLecStatusNameRepository {

    @Override
    public void injectOrderLecStatusNameAny(List<?> orderLecStatusNameAny) {
        if (orderLecStatusNameAny == null || orderLecStatusNameAny.size() == 0) return;

        List<OrderLecStatusNameContain> contains = orderLecStatusNameAny
                .stream()
                .filter(Objects::nonNull)
                .filter(any->any instanceof OrderLecStatusName)
                .map(any->(OrderLecStatusNameContain)any)
                .collect(Collectors.toList());

        this.injectOrderLecStatusNameContain(contains);
    }

    @Override
    public void injectOrderLecStatusNameContain(List<OrderLecStatusNameContain> orderLecStatusNameContains) {
        if (orderLecStatusNameContains == null || orderLecStatusNameContains.size() == 0) return;

        List<OrderLecStatusNameContain> injectable = orderLecStatusNameContains
                .stream()
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        List<Integer>orderLecStatus = injectable
                .stream()
                .map(OrderLecStatusNameContain::orderLecStatusKey)
                .distinct()
                .collect(Collectors.toList());

        if (orderLecStatus == null || orderLecStatus.size() == 0) return;

        List<OrderLecStatusName> orderLecStatusNameList = OrderLecStatusType.getOrderLecStatusList();
        for (OrderLecStatusNameContain contain : injectable) {
            for (OrderLecStatusName orderLecStatusName : orderLecStatusNameList) {
                if (contain.orderLecStatusKey() != null && contain.orderLecStatusKey() == orderLecStatusName.getOrderLecStatus()) {
                    contain.addOrderLecStatusName(orderLecStatusName);
                }
            }
        }
    }
}
