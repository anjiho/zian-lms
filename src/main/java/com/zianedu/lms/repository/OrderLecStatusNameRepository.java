package com.zianedu.lms.repository;

import com.zianedu.lms.dto.GoodsKindNameContain;
import com.zianedu.lms.dto.OrderLecStatusName;
import com.zianedu.lms.dto.OrderLecStatusNameContain;

import java.util.List;

public interface OrderLecStatusNameRepository {

    void injectOrderLecStatusNameAny(List<?> orderLecStatusNameAny);

    void injectOrderLecStatusNameContain(List<OrderLecStatusNameContain> orderLecStatusNameContains);
}
