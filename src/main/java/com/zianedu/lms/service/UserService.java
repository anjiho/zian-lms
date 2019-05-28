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

    @Transactional(propagation = Propagation.REQUIRED)
    public void test() {
        String sql = "";
        List<TBbsVO> noticeList = testMapper.selectNotice();

        if (noticeList.size() > 0) {
            sql = "INSERT INTO T_NOTICE (IDX, TITLE, CONTENTS, NOTICE_TYPE, NOTICE_CATEGORY, CREATE_DATE, CREATE_USER_KEY) " +
                    "VALUES (T_NOTICE_SEQ.nextval, ?, ?, ?, ?, sysdate, ?)";
            jdbcTemplate.batchUpdate(
                    sql,
                    noticeList,
                    1000,
                    new ParameterizedPreparedStatementSetter<TBbsVO>() {
                        @Override
                        public void setValues(PreparedStatement ps, TBbsVO tBbsVO) throws SQLException {
                            ps.setString(1, tBbsVO.getTitle());
                            ps.setString(2, tBbsVO.getContents());
                            ps.setString(3, "ALL");
                            ps.setString(4, "");
                            ps.setInt(5, tBbsVO.getWriteUserKey());
                        }
                    });

        }
    }


    @DataSource(DataSourceType.ALGISA_ORACLE)
    public void test2() {
        String sql = "";

        //sql = "SELECT USER_ID, USER_PWD FROM TB_MA_MEMBER";

        List<HashMap<String, Object>> list = userMapper.selectAlgisaUser();
        //List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
        this.test3(list);

//        if (list.size() > 0) {
//            sql = "UPDATE T_USER SET USER_PWD = ? WHERE USER_ID= ?";
//            jdbcTemplate.batchUpdate(
//                    sql,
//                    list,
//                    1000,
//                    new ParameterizedPreparedStatementSetter<HashMap<String, Object>>() {
//                        @Override
//                        public void setValues(PreparedStatement ps, HashMap<String, Object>map) throws SQLException {
//                            ps.setString(1, SecurityUtil.encryptSHA256(String.valueOf(map.get("USER_PWD"))));
//                            ps.setString(2, String.valueOf(map.get("USER_ID")));
//                        }
//                    });
//
//
//        }

//        for (Map<String, Object> map : list) {
//            System.out.println(">>>>>>>>" + map.get("USER_ID"));
//            System.out.println(">>>>>>>>" + map.get("USER_PWD"));
//        }
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
