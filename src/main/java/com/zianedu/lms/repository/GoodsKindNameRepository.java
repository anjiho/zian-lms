package com.zianedu.lms.repository;

import com.zianedu.lms.dto.GoodsKindNameContain;

import java.util.List;

public interface GoodsKindNameRepository {

    void injectGoodsKindNameAny(List<?> goodKindNameAny);

    void injectGoodsKindNameContain(List<GoodsKindNameContain> goodsKindNameContains);
}
