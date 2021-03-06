package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.*;
import com.zianedu.lms.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductManageMapper {

    /** SELECT **/
    List<VideoListDTO> selectProductList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                       @Param("searchText") String searchText, @Param("searchType") String searchType,
                                         @Param("goodsTypeKey") int goodsTypeKey);

    int selectProductListCount(@Param("searchText") String searchText, @Param("searchType") String searchType,
                               @Param("goodsTypeKey") int goodsTypeKey);

    TGoodsVO selectTGoodsInfo(@Param("gKey") int gKey);

    List<TGoodsPriceOptionVO> selectTGoodsPriceOptionList(@Param("gKey") int gKey);

    TGoodsPriceOptionVO selectTGoodsPriceOptionSingle(@Param("gKey") int gKey);

    TGoodsPriceOptionVO selectTGoodsPriceOptionInfo(@Param("priceKey") int priceKey);

    List<TCategoryGoods> selectTCategoryGoodsList(@Param("gKey") int gKey);

    TLecVO selectTLecInfo(@Param("gKey") int gKey);

    List<TGoodTeacherLinkVO>selectTeacherListByTeacherLink(@Param("gKey") int gKey);

    List<TLinkKeyVO>selectTGoodsFromTLinkKeyRel(@Param("reqKey") int reqKey, @Param("resType") int resType);

    List<TLinkKeyVO>selectTExamMasterFromTLinkKeyRel(@Param("reqKey") int reqKey, @Param("resType") int resType);

    TLinkKeyVO selectTGoodsFromTLinkKeyRelSingle(@Param("reqKey") int reqKey, @Param("resType") int resType);

    TLinkKeyVO selectTExamMasterFromTLinkKeyRelSingle(@Param("reqKey") int reqKey, @Param("resType") int resType);

    List<TLecCurri>selectTLecCurriList(@Param("lecKey") int lecKey);

    TLecCurri selectTLecCurriInfo(@Param("curriKey") int curriKey);

    List<TLinkKeyVO>selectTLinkKeyList(@Param("reqKey") int reqKey);

    Integer selectTLecCurriLastPos(@Param("lecKey") int lecKey);

    List<TExamMasterVO>selectTExamList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                       @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectTExamListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<TGoodsVO>selectTGoodsListByType(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                       @Param("searchText") String searchText, @Param("searchType") String searchType,
                                         @Param("goodsTypeKey") int goodsTypeKey);

    int selectTGoodsListByTypeCount(@Param("searchText") String searchText, @Param("searchType") String searchType,
                                    @Param("goodsTypeKey") int goodsTypeKey);

    TBookVO selectBookInfo(@Param("gKey") int gKey);

    List<TResVO> selectTResList(@Param("gKey") int gKey);

    List<TResVO> selectTResListByTeacherKey(@Param("teacherKey") int teacherKey);

    TExamMasterVO selectTExamMasterInfo(@Param("examKey") int examKey);

    List<TBankSubjectExamLinkVO> selectTBankSubjectExamLinkList(@Param("examKey") int examKey);

    List<TExamQuestionBankSubjectVO> selectMockExamQuestionBankSubjectList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                               @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectMockExamQuestionBankSubjectListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<ProblemBankListDTO>selectTExamQuestionBankList(ProblemBankSearchVO problemBankSearchVO);

    int selectTExamQuestionBankListCount(ProblemBankSearchVO problemBankSearchVO);

    TExamQuestionBankVO selectTExamQuestionBankInfo(@Param("examQuestionBankKey") int examQuestionBankKey);

    TExamQuestionBankSubjectVO selectTExamQuestionBankSubjectDetailInfo(@Param("examQuestionBankSubjectKey") int examQuestionBankSubjectKey);

    List<ProblemBankSubjectDTO>selectTBankSubjectQuesLinkList(@Param("examQuesBankSubjectKey") int examQuesBankSubjectKey);

    Integer selectTBankSubjectQuesLinkLastPos(@Param("examQuesBankSubjectKey") int examQuesBankSubjectKey);

    List<String> selectTeacherNameListByVideoProduct(@Param("gKey") int gKey);

    List<FreeInjectDTO> selectVideoProductListByFreeLectureInject(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                                  @Param("searchType") String searchType, @Param("searchText") String searchText);

    List<TCpVO> selectTCpList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                              @Param("searchType") String searchType, @Param("searchText") String searchText);

    int selectTCpListCount(@Param("searchType") String searchType, @Param("searchText") String searchText);


    int selectVideoProductListCountByFreeLectureInject(@Param("searchType") String searchType, @Param("searchText") String searchText);

    /** INSERT **/
    int insertTGoods(TGoodsVO tGoodsVO);

    int insertTGoodsPriceOption(TGoodsPriceOptionVO tGoodsPriceOptionVO);

    void insertTCategoryGoods(TCategoryGoods tCategoryGoods);

    int insertTLec(TLecVO tLecVO);

    void insertTGoodsTeacherLink(TGoodTeacherLinkVO tGoodTeacherLinkVO);

    void insertTLinkKey(TLinkKeyVO tLinkKeyVO);

    Integer insertTLecCurri(TLecCurri tLecCurri);

    void insertTBook(TBookVO tBookVO);

    Integer insertTRes(TResVO tResVO);

    void insertTResAtTeacherSubject(TResVO tResVO);

    Integer insertTExamMaster(TExamMasterVO tExamMasterVO);

    void insertTExamQuestionBank(TExamQuestionBankVO tExamQuestionBankVO);

    void insertTBankSubjectQuesLink(@Param("examQuesBankSubjectKey") int examQuesBankSubjectKey, @Param("examQuesBankKey") int examQuesBankKey,
                                    @Param("pos") int pos);

    //void insertTExamQuestionBankSubject(@Param("name") String name, @Param("subjectCtgKey") int subjectCtgKey);

    void insertTExamQuestionBankSubject(TExamQuestionBankSubjectVO tExamQuestionBankSubjectVO);

    void insertTBankSubjectExamLink(TBankSubjectExamLinkVO tBankSubjectExamLinkVO);


    /** DELETE **/
    void deleteTCategoryGoods(@Param("gKey") int gKey);

    void deleteTLinkKey(@Param("reqKey") int reqKey);

    void deleteTLinkKeyByResType(@Param("reqKey") int reqKey, @Param("resType") int resType);

    void deleteTLinkKeyByLinkKey(@Param("linkKey") int linkKey);

    void deletePopupCategoryInfo(@Param("linkKey") int linkKey);

    void deleteTLinkKeyByResKey(@Param("resKey") int resKey);

    void deleteTGoodsTeacherLink(@Param("gTeacherKey") int gTeacherKey);

    void deleteTGoodsTeacherLinkByGkey(@Param("gKey") int gKey);

    void deleteTLecCurri(@Param("curriKey") int curriKey);

    void deleteTCategoryGoodsByCtgGKey(@Param("ctgGKey") int ctgGKey);

    void deleteTBankSubjectExamLink(@Param("bankSubjectExamLinkKey") int bankSubjectExamLinkKey);

    void deleteTBankSubjectQuesLink(@Param("bankSubjectQuesLinkKey") int bankSubjectQuesLinkKey);

    void deleteTGoodsPriceOption(@Param("gKey") int gKey);

    void deleteTRes(@Param("resKey") int resKey);

    /** UPDATE **/
    void updateTGoods(TGoodsVO tGoodsVO);

    void updateTGoodsPriceOption(TGoodsPriceOptionVO tGoodsPriceOptionVO);

    void updateTLec(TLecVO tLecVO);

    void updateTGoodsTeacherLink(TGoodTeacherLinkVO tGoodTeacherLinkVO);

    void updateTLinkKey(TLinkKeyVO tLinkKeyVO);

    void updateTLecCurri(TLecCurri tLecCurri);

    void updateTLecCurriPos(TLecCurri tLecCurri);

    void updateTBook(TBookVO tBookVO);

    void updateTExamMaster(TExamMasterVO tExamMasterVO);

    void updateTBankSubjectExamLink(TBankSubjectExamLinkVO tBankSubjectExamLinkVO);

    void updateTExamQuestionBank(TExamQuestionBankVO tExamQuestionBankVO);

    void updateTExamQuestionBankImage(@Param("examQuestionBankKey") int examQuestionBankKey, @Param("imageType") String imageType);

    void updateTBankSubjectQuesLinkPos(@Param("bankSubjectQuesLinkKey") int bankSubjectQuesLinkKey, @Param("pos") int pos);

    void updateTExamQuestionBankSubject(@Param("examQuestionBankSubjectKey") int examQuestionBankSubjectKey,
                                        @Param("name") String name, @Param("subjectCtgKey") int subjectCtgKey);

}
