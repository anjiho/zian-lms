package com.zianedu.lms.repository;

import com.zianedu.lms.define.datasource.GoodsKindType;
import com.zianedu.lms.dto.GoodsKindName;
import com.zianedu.lms.dto.GoodsKindNameContain;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Repository
public class GoodsKindNameRepositoryLogic implements GoodsKindNameRepository {

    @Override
    public void injectGoodsKindNameAny(List<?> goodKindNameAny) {
        if (goodKindNameAny == null || goodKindNameAny.size() == 0) return;

        List<GoodsKindNameContain> contains = goodKindNameAny
                .stream()
                .filter(Objects::nonNull)
                .filter(any->any instanceof GoodsKindNameContain)
                .map(any->(GoodsKindNameContain)any)
                .collect(Collectors.toList());

        this.injectGoodsKindNameContain(contains);
    }

    @Override
    public void injectGoodsKindNameContain(List<GoodsKindNameContain> goodsKindNameContains) {
        if (goodsKindNameContains == null || goodsKindNameContains.size() == 0) return;

        List<GoodsKindNameContain> injectable = goodsKindNameContains
                .stream()
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        List<Integer> goodsKinds = injectable
                .stream()
                .map(GoodsKindNameContain::goodsKind)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

        if (goodsKinds == null || goodsKinds.size() == 0) return;

        List<GoodsKindName> kindNameList = GoodsKindType.getGoodsKindList();
        for (GoodsKindNameContain contain : injectable) {
            for (GoodsKindName kindName : kindNameList) {
                if (contain.goodsKind() != null && contain.goodsKind() == kindName.getGoodsKind()) {
                    contain.addGoodsKindName(kindName);
                }
            }
        }
    }
}
