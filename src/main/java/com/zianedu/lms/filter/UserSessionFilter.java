package com.zianedu.lms.filter;

import com.zianedu.lms.service.LoginService;
import com.zianedu.lms.session.UserSession;
import com.zianedu.lms.vo.TUserVO;
import org.springframework.web.filter.DelegatingFilterProxy;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class UserSessionFilter extends DelegatingFilterProxy {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
        try {
            HttpServletRequest req = ((HttpServletRequest)request);
            LoginService loginService = findWebApplicationContext().getBean(LoginService.class);

            TUserVO tUserVO = (TUserVO) req.getSession().getAttribute("user_info");
            if (tUserVO != null) {
                if (UserSession.get() == null) {
                    TUserVO vo = loginService.getUserInfoByUserKey(tUserVO.getUserKey());
                    UserSession.set(new TUserVO(vo.getUserKey(), vo.getName(), vo.getAuthority(), vo.getTeacherKey()));
                    logger.info("userSession >>>>>>>>>>>>>>> " + vo);
                }
            }
            chain.doFilter(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
