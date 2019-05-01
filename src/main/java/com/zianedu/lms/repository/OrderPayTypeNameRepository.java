package com.zianedu.lms.repository;

import com.zianedu.lms.dto.OrderLecStatusNameContain;
import com.zianedu.lms.dto.OrderPayTypeNameContain;

import java.util.List;

public interface OrderPayTypeNameRepository {

    void injectOrderPayTypeNameAny(List<?> orderPayTypeNameAny);

    void injectOrderPayTypeNameContain(List<OrderPayTypeNameContain> orderPayTypeNameContains);
}
