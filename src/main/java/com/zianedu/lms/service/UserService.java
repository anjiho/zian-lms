package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.DataSource;
import com.zianedu.lms.define.datasource.DataSourceType;
import com.zianedu.lms.mapper.TestMapper;
import com.zianedu.lms.mapper.UserMapper;
import com.zianedu.lms.utils.SecurityUtil;
import com.zianedu.lms.vo.TBbsVO;
import com.zianedu.lms.vo.TUserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ParameterizedPreparedStatementSetter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

}
