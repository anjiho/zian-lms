package com.zianedu.lms.service;

import com.zianedu.lms.dto.GoodsReviewDTO;
import com.zianedu.lms.dto.QnaDetailInfoDTO;
import com.zianedu.lms.dto.QnaListDTO;
import com.zianedu.lms.mapper.BoardManageMapper;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.TBbsCommentVO;
import com.zianedu.lms.vo.TBbsDataVO;
import com.zianedu.lms.vo.TUserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
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
     * @param bbsMasterKey ( 10025 : QNA )
     * @param teacherKey
     * @param searchType
     * @param searchText
     * @return
     * @throws Exception
     */
    @Transactional(readOnly = true)
    public List<QnaListDTO> selectBbsList(int sPage, int listLimit, int bbsMasterKey, int teacherKey, String searchType, String searchText) throws Exception {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<QnaListDTO> list = boardManageMapper.selectQnAList(startNumber, listLimit, bbsMasterKey, teacherKey, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, ""));
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
     * @param bbsMasterKey
     * @param teacherKey
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int selectBbsListCount(int bbsMasterKey, int teacherKey, String searchType, String searchText) {
        return boardManageMapper.selectQnAListCount(bbsMasterKey, teacherKey, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, ""));
    }

    /**
     * QNA 상세
     * @param bbsKey
     * @return
     */
    @Transactional(readOnly = true)
    public QnaDetailInfoDTO getBbsDetailInfo(int bbsKey) {
        QnaDetailInfoDTO qnaDetailInfo = new QnaDetailInfoDTO(
            boardManageMapper.selectQnaDetailInfo(bbsKey),
            boardManageMapper.selectQnaCommentList(bbsKey)
        );
        return qnaDetailInfo;
    }

    /**
     * 리뷰 리스트
     * @param sPage
     * @param listLimit
     * @param gKey
     * @param teacherKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<GoodsReviewDTO> getGoodsReviewList(int sPage, int listLimit, int gKey, int teacherKey) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<GoodsReviewDTO>reviewList = boardManageMapper.selectGoodsReviewList(startNumber, listLimit, gKey, teacherKey);
        return reviewList;
    }

    /**
     * 리뷰 리스트 개수
     * @param gKey
     * @param teacherKey
     * @return
     */
    @Transactional(readOnly = true)
    public int getGoodsReviewListCount(int gKey, int teacherKey) {
        return boardManageMapper.selectGoodsReviewListCount(gKey, teacherKey);
    }

    /**
     * QNA 답글 쓰기
     * @param bbsKey
     * @param title
     * @param teacherKey
     * @param ctgKey
     * @param contents
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveQnaReply(int bbsKey, String title, int teacherKey, int ctgKey, String contents) {
        if (bbsKey == 0) return;
        TBbsDataVO bbsDataVO = new TBbsDataVO(
                10025, bbsKey, title, teacherKey, ctgKey, contents
        );
        boardManageMapper.insertTBbsData(bbsDataVO);
    }

    /**
     * QNA 댓글 쓰기
     * @param bbsKey
     * @param commentContents
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveQnaComment(int bbsKey, String commentContents) {
        if (bbsKey == 0) return;
        TBbsCommentVO commentVO = new TBbsCommentVO(bbsKey, commentContents);
        boardManageMapper.insertTBbsComment(commentVO);
    }

    /**
     * QNA 수정하기
     * @param bbsKey
     * @param title
     * @param contents
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateQna(int bbsKey, String title, String contents) {
        if (bbsKey == 0) return;
        boardManageMapper.updateTBbsData(bbsKey, Util.isNullValue(title, ""), Util.isNullValue(contents, ""));
    }

    /**
     * 댓글 수정하기
     * @param bbsCommentKey
     * @param commentContents
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateQnaComment(int bbsCommentKey, String commentContents) {
        if (bbsCommentKey == 0) return;
        boardManageMapper.updateTBbsComment(bbsCommentKey, Util.isNullValue(commentContents, ""));
    }

    /**
     * 댓글 삭제하기
     * @param bbsCommentKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteQnaComment(int bbsCommentKey) {
        if (bbsCommentKey == 0) return;
        boardManageMapper.deleteTBbsComment(bbsCommentKey);
    }

    /**
     * QNA 본글 삭제하기
     * @param bbsKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteQna(int bbsKey) {
        if (bbsKey == 0) return;
        boardManageMapper.deleteTBbsData(bbsKey);
    }

}
