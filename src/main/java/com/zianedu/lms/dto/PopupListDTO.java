package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class PopupListDTO {

    private int popupKey;

    private String name;

    private String type = "레이어";

    private int width;

    private int height;

    private int left;

    private int top;

    private String startDate;

    private String endDate;

    private int isShow;
}
