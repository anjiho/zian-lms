package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class MemberSelectListDTO {

    private int userKey;

    private String userId;

    private String name;

    private String telephoneMobile;

    private int authority;

    private String authorityStr;
}
