package com.zianedu.lms.define.datasource;

public enum BookStatusType {
    //예약
    RESERVE(0),
    //판매중
    SALE(1),
    //품절
    SOLD_OUT(2),
    //절판
    PRINT_OUT(3);

    int bookStatusKey;

    BookStatusType(int bookStatusKey) {
        this.bookStatusKey = bookStatusKey;
    }
}
