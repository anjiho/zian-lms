package com.zianedu.lms.service;

import com.zianedu.lms.dto.QnaListDTO;
import com.zianedu.lms.mapper.BoardManageMapper;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.TUserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BoardManageService extends PagingSupport {

    protected final static Logger logger = LoggerFactory.getLogger(BoardManageService.class);

    @Autowired
    private BoardManageMapper boardManageMapper;

    @Autowired
    private MemberManageMapper memberManageMapper;

    /**
     * QNA 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     * @throws Exception
     */
    @Transactional(readOnly = true)
    public List<QnaListDTO> selectQnaList(int sPage, int listLimit, String searchType, String searchText) throws Exception {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<QnaListDTO> list = boardManageMapper.selectQnAList(startNumber, listLimit, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, ""));
        if (list.size() > 0) {
            String standardDate = Util.plusDate(Util.returnNow(), -10);
            for (QnaListDTO dto : list) {
                int diffDayCnt = Util.getDiffDayCount(Util.convertDateFormat3(standardDate), Util.convertDateFormat3(dto.getIndate()));

                if (diffDayCnt >= 0 && diffDayCnt <= 10) dto.setNew(true);
                else dto.setNew(false);

                TUserVO userVO = memberManageMapper.selectTUserInfo(dto.getWriteUserKey());
                if (userVO != null) {
                    dto.setUserId(userVO.getUserId());
                    dto.setUserName(userVO.getName());
                }
            }
        }
        return list;
    }

    /**
     * QNA 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int selectQnaListCount(String searchType, String searchText) {
        return boardManageMapper.selectQnAListCount(Util.isNullValue(searchType, ""), Util.isNullValue(searchText, ""));
    }


}
