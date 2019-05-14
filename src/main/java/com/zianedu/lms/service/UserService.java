package com.zianedu.lms.service;

import com.zianedu.lms.mapper.UserMapper;
import com.zianedu.lms.utils.SecurityUtil;
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
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

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


}
