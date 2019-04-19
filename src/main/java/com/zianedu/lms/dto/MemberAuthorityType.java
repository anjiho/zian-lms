package com.zianedu.lms.dto;

/**
 * 회원권한 정의
 */
public enum MemberAuthorityType {
    ADMIN(0, "관리자"),
    TEACHER(5, "강사"),
    USER(10, "회원"),
    DISMISS(19, "방문객");

    int memberAuthorityKey;

    String memberAuthorityStr;

    MemberAuthorityType(int memberAuthorityKey, String memberAuthorityStr) {
        this.memberAuthorityKey = memberAuthorityKey;
        this.memberAuthorityStr = memberAuthorityStr;
    }

    public static String getMemberAuthorityTypeStr(int memberAuthorityKey) {
        for (MemberAuthorityType authorityType : MemberAuthorityType.values()) {
            if (memberAuthorityKey == authorityType.memberAuthorityKey) {
                return authorityType.memberAuthorityStr;
            }
        }
        return null;
    }
}
