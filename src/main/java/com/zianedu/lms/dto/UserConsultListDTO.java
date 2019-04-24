package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class UserConsultListDTO {

    private int counselKey;

    private int type;

    private String consultTypeName;

    private String indate;

    private String procStartDate;

    private String procEndDate;

}
