package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class OrderDetailProductListDTO {

    private int jGKey;

    private int type;

    private String name;

    private int kind;

    private int cnt;

    private int sellPrice;

    private String productTypeName;

    private String productOptionName;
}
