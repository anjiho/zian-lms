package com.zianedu.lms.session;

import com.zianedu.lms.vo.TUserVO;

/**
 * <PRE>
 *     1. 내용 : 세션관리
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 03
 * </PRE>
 */
public class UserSession {

    private static ThreadLocal<TUserVO> local = new ThreadLocal<>();

    public static void set(TUserVO tUserVO) {
        local.set(tUserVO);
    }

    public static TUserVO get() {
        return local.get();
    }

    public static int getAuthority() {
        return local.get().getAuthority();
    }

    public static int getUserKey() {
        return local.get().getUserKey();
    }

    public static int getTeacherKey() {
        return local.get().getTeacherKey();
    }
}
