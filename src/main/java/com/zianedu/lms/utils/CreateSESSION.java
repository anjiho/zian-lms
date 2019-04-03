package com.zianedu.lms.utils;

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

	public static TUserVO createSession(TUserVO tUserVO, HttpServletRequest request) {
		if (tUserVO.getUserKey() < 1L) return null;
		//세션 쓰래드에 세션 생성
		UserSession.set(tUserVO);
		request.setAttribute("userInfo", tUserVO);
		return tUserVO;
	}

}
