package com.zianedu.lms.utils;

import com.zianedu.lms.service.LoginService;
import com.zianedu.lms.session.UserSession;
import com.zianedu.lms.vo.TUserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class CreateSESSION {

	final static Logger logger = LoggerFactory.getLogger(CreateSESSION.class);

	public static TUserVO createSession(HttpServletRequest request) throws Exception {
		Long userKey = Long.parseLong(request.getParameter("userKey"));
		String userName = new String(request.getParameter("userName").getBytes("ISO-8859-1"), "UTF-8");
		String authority = request.getParameter("authority");

		logger.info(">>>>>>>>>>>>>>" + authority);

		TUserVO tUserVO = new TUserVO(userKey, userName, Integer.parseInt(authority));
		UserSession.set(tUserVO);
		request.setAttribute("userInfo", tUserVO);

		return tUserVO;
	}

}
