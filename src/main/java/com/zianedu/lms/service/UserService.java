package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.DataSource;
import com.zianedu.lms.define.datasource.DataSourceType;
import com.zianedu.lms.mapper.TestMapper;
import com.zianedu.lms.mapper.UserMapper;
import com.zianedu.lms.utils.DateUtils;
import com.zianedu.lms.utils.SecurityUtil;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.TBbsVO;
import com.zianedu.lms.vo.TUserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ParameterizedPreparedStatementSetter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.inject.Inject;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.net.URLDecoder;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private TestMapper testMapper;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Transactional(propagation = Propagation.REQUIRED)
    public void encryptUserPass() {
        String sql = "";
        List<TUserVO> userList = userMapper.getUserList();

        if (userList.size() > 0) {
            sql = "UPDATE T_USER SET PWD = ? WHERE USER_KEY= ?";
            jdbcTemplate.batchUpdate(
                    sql,
                    userList,
                    1000,
                    new ParameterizedPreparedStatementSetter<TUserVO>() {
                        @Override
                        public void setValues(PreparedStatement ps, TUserVO tUserVO) throws SQLException {
                            ps.setString(1, SecurityUtil.encryptSHA256(tUserVO.getPwd()));
                            ps.setInt(2, tUserVO.getUserKey());
                        }
                    });

        }
    }

    //게시판 -->  공지사항 테이블로 이동하기
    @Transactional(propagation = Propagation.REQUIRED)
    public void convertNoticeData() {
        String sql = "";
        List<TBbsVO> noticeList = testMapper.selectNotice();

        if (noticeList.size() > 0) {
            sql = "INSERT INTO T_NOTICE (IDX, TITLE, CONTENTS, BBS_MASTER_KEY, IS_HEAD, CREATE_DATE, CREATE_USER_KEY, NOTICE_FILE, BBS_KEY) " +
                    "VALUES (T_NOTICE_SEQ.nextval, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD hh24:mi:ss'), ?, ?, ?)";
            jdbcTemplate.batchUpdate(
                    sql,
                    noticeList,
                    1000,
                    new ParameterizedPreparedStatementSetter<TBbsVO>() {
                        @Override
                        public void setValues(PreparedStatement ps, TBbsVO tBbsVO) throws SQLException {
                            ps.setString(1, tBbsVO.getTitle());
                            ps.setString(2, tBbsVO.getContents());
                            ps.setInt(3, tBbsVO.getBbsMasterKey());
                            ps.setInt(4, tBbsVO.getIsNotice());
                            ps.setString(5, tBbsVO.getIndate());
                            ps.setInt(6, tBbsVO.getWriteUserKey());
                            ps.setString(7, tBbsVO.getFilename());
                            ps.setInt(8, tBbsVO.getBbsKey());
                        }
                    });

        }
    }


    @DataSource(DataSourceType.ALGISA_ORACLE)
    public void algisaPasswordUpdate() {
        List<HashMap<String, Object>> list = userMapper.selectAlgisaUser();
        this.test3(list);
    }

    public void test3(List<HashMap<String, Object>>list) {
        String sql = "";
        if (list.size() > 0) {
            sql = "UPDATE T_USER SET USER_PWD = ? WHERE USER_ID= ?";
            jdbcTemplate.batchUpdate(
                    sql,
                    list,
                    1000,
                    new ParameterizedPreparedStatementSetter<HashMap<String, Object>>() {
                        @Override
                        public void setValues(PreparedStatement ps, HashMap<String, Object>map) throws SQLException {
                            ps.setString(1, SecurityUtil.encryptSHA256(String.valueOf(map.get("USER_PWD"))));
                            ps.setString(2, String.valueOf(map.get("USER_ID")));
                        }
                    });


        }
    }

    @DataSource(DataSourceType.GW_ORACLE)
    public void eunjeong(String str) {
        testMapper.updateMyTable(10063, str);
    }

    @DataSource(DataSourceType.GW_ORACLE)
    public void jiho(String str) {
        testMapper.updateMyTable(10062, str);
    }

    public void daumEmailSend() throws Exception {
        String host = "smtp.daum.net";
        final String username = "anjo0070"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
        final String password = "c7684301-+"; //네이버 이메일 비밀번호를 입력해주세요.
        int port=465; //포트번호

        String recipient = "anjo0070@zianedu.com"; //받는 사람의 메일주소를 입력해주세요.
        String subject = "일일업무보고_" + Util.returnNowDateByYYMMDD2(); //메일 제목 입력해주세요.
        String body = "일일업무보고 파일 첨부하였습니다.\n" + "수고하세요"; //메일 내용 입력해주세요.
        InternetAddress[] toAddr = new InternetAddress[1];
        toAddr[0] = new InternetAddress ("anjo0070@naver.com", "피창근", "UTF-8");

        Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
        // SMTP 서버 정보 설정
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);
        //Session 생성
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            String un=username;
            String pw=password;
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(un, pw);
            }
        });

        session.setDebug(false); //for debug
        Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
        mimeMessage.setFrom(new InternetAddress("anjo0070@zianedu.com", "안지호", "UTF-8")); //발신자 셋팅 , 보내는 사람의 이메일주소
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient, "박태순", "UTF-8")); //수신자셋팅
        mimeMessage.setRecipients(Message.RecipientType.CC, toAddr);

        mimeMessage.setSubject(subject); //제목셋팅
        mimeMessage.setText(body); //내용셋팅

        // Create the message part
        BodyPart messageBodyPart = new MimeBodyPart();
        BodyPart messageBodyPart2 = new MimeBodyPart();
        messageBodyPart2.setText(body);

        Multipart multipart = new MimeMultipart();

        int today = DateUtils.getTodayDayOfWeek();
        String fileName = "";
        if (today == 2) {
            fileName = "C:/ftp/jihoan/월/일일업무일지(안지호).docx";
            //fileName = "/Users/jihoan/Downloads/일일업무일지(안지호).docx";
        } else if (today == 3) {
            fileName = "C:/ftp/jihoan/화/일일업무일지(안지호).docx";
        } else if (today == 4) {
            fileName = "C:/ftp/jihoan/수/일일업무일지(안지호).docx";
        } else if (today == 5) {
            fileName = "C:/ftp/jihoan/목/일일업무일지(안지호).docx";
        } else if (today == 6) {
            fileName = "C:/ftp/jihoan/금/일일업무일지(안지호).docx";
        }
//        else if (today == 7) {
//            fileName = "/Users/jihoan/Downloads/일일업무일지(안지호).docx";
//        }
        javax.activation.DataSource source = new FileDataSource(fileName);
        messageBodyPart.setDataHandler(new DataHandler(source));
        String name = "일일업무일지(안지호).docx";
        messageBodyPart.setFileName(MimeUtility.encodeText(name));
        multipart.addBodyPart(messageBodyPart2);
        multipart.addBodyPart(messageBodyPart);
        // Send the complete message parts
        mimeMessage.setContent(multipart);

        Transport.send(mimeMessage); //javax.mail.Transport.send() 이용

        this.pushEmail("anjo0080@gmail.com", fileName, recipient, toAddr[0].getAddress());
    }

    public void daumEmailSend2() throws Exception {
        String host = "smtp.daum.net";
        final String username = "huuc10"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
        final String password = "qwer779488!"; //네이버 이메일 비밀번호를 입력해주세요.
        int port=465; //포트번호

        String recipient = "anjo0070@naver.com"; //받는 사람의 메일주소를 입력해주세요.
        String subject = "일일업무보고_" + Util.returnNowDateByYYMMDD2(); //메일 제목 입력해주세요.
        String body = "일일업무보고 파일 첨부하였습니다.\n" + "수고하세요"; //메일 내용 입력해주세요.
        InternetAddress[] toAddr = new InternetAddress[1];
        toAddr[0] = new InternetAddress ("anjo0070@zianedu.com", "피창근", "UTF-8");

        Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
        // SMTP 서버 정보 설정
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);
        //Session 생성
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            String un=username;
            String pw=password;
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(un, pw);
            }
        });

        session.setDebug(false); //for debug
        Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
        mimeMessage.setFrom(new InternetAddress("ejwon@zianedu.com", "원은정", "UTF-8")); //발신자 셋팅 , 보내는 사람의 이메일주소
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient, "박태순", "UTF-8")); //수신자셋팅
        mimeMessage.setRecipients(Message.RecipientType.CC, toAddr);

        mimeMessage.setSubject(subject); //제목셋팅
        mimeMessage.setText(body); //내용셋팅

        // Create the message part
        BodyPart messageBodyPart = new MimeBodyPart();
        BodyPart messageBodyPart2 = new MimeBodyPart();
        messageBodyPart2.setText(body);

        Multipart multipart = new MimeMultipart();

        int today = DateUtils.getTodayDayOfWeek();
        String fileName = "";
        if (today == 2) {
            fileName = "C:/ftp/jihoan/월/일일업무일지(안지호).docx";
            //fileName = "/Users/jihoan/Downloads/일일업무일지(안지호).docx";
        } else if (today == 3) {
            fileName = "C:/ftp/jihoan/화/일일업무일지(안지호).docx";
        } else if (today == 4) {
            fileName = "C:/ftp/jihoan/수/일일업무일지(원은정).hwp";
            //fileName = "/Users/jihoan/Downloads/일일업무일지(원은정).hwp";
        } else if (today == 5) {
            fileName = "C:/ftp/jihoan/목/일일업무일지(안지호).docx";
        } else if (today == 6) {
            fileName = "C:/ftp/jihoan/금/일일업무일지(안지호).docx";
        }
//        else if (today == 7) {
//            fileName = "/Users/jihoan/Downloads/일일업무일지(안지호).docx";
//        }
        javax.activation.DataSource source = new FileDataSource(fileName);
        messageBodyPart.setDataHandler(new DataHandler(source));
        String name = "일일업무일지(원은정).hwp";
        messageBodyPart.setFileName(MimeUtility.encodeText(name));
        multipart.addBodyPart(messageBodyPart2);
        multipart.addBodyPart(messageBodyPart);
        // Send the complete message parts
        mimeMessage.setContent(multipart);

        Transport.send(mimeMessage); //javax.mail.Transport.send() 이용

        //this.pushEmail("anjo0080@gmail.com", fileName, recipient, toAddr[0].getAddress());
    }

    public void pushEmail(String email, String fileName, String recipientTo, String recipientCC) throws Exception {
        String host = "smtp.daum.net";
        final String username = "anjo0070"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
        final String password = "c7684301-+"; //네이버 이메일 비밀번호를 입력해주세요.
        int port=465; //포트번호

        String recipient = email; //받는 사람의 메일주소를 입력해주세요.
        String subject = Util.returnNowDateByYYMMDD2() + "_일일업무보고발송결과"; //메일 제목 입력해주세요.
        String body = "파일명 : " + fileName + "\n" + "수신자 : " + recipientTo + "\n" + "참조자 : " + recipientCC; //메일 내용 입력해주세요.

        Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
        // SMTP 서버 정보 설정
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);
        //Session 생성
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            String un=username;
            String pw=password;
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(un, pw);
            }
        });

        session.setDebug(false); //for debug
        Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
        mimeMessage.setFrom(new InternetAddress("anjo0070@zianedu.com")); //발신자 셋팅 , 보내는 사람의 이메일주소
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅

        mimeMessage.setSubject(subject); //제목셋팅
        mimeMessage.setText(body); //내용셋팅

        Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
    }
}
