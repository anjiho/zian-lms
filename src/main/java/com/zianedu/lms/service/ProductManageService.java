package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.*;
import oracle.net.aso.g;
import org.apache.poi.ss.formula.functions.T;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductManageService extends PagingSupport {

    protected static final Logger logger = LoggerFactory.getLogger(ProductManageService.class);

    @Autowired
    private ProductManageMapper productManageMapper;

    @Autowired
    private DataManageService dataManageService;

    /**
     * 동영상 상세정보 가져오기
     * @param gKey
     * @return
     */
    public VideoDetailInfoDTO getVideoDetailInfo(int gKey) {
        if (gKey == 0) return null;

        TGoodsVO videoInfo = this.getVideoBasicInfo(gKey);
        List<TGoodsPriceOptionVO>videoOptionInfo = this.getVideoOptionList(gKey);
        List<List<TCategoryVO>>videoCategoryInfo = this.getVideoCategoryList(gKey);
        TLecVO videoLectureInfo = this.getVideoLecInfo(gKey);
        List<TGoodTeacherLinkVO> videoTeacherInfo = this.getTeacherListByVideoInfo(gKey);
        List<TLecCurri> videoLectureCurriInfo = this.getLectureCurriList(videoLectureInfo.getLecKey());

        List<TLinkKeyVO>tLinkKeyVOList = productManageMapper.selectTLinkKeyList(gKey);
        List<TLinkKeyVO>videoOtherInfo = new ArrayList<>();
        if (tLinkKeyVOList.size() > 0) {
            for (TLinkKeyVO linkKeyVO : tLinkKeyVOList) {
                videoOtherInfo = this.getGoodsListFromTLinkKey(gKey, linkKeyVO.getResType());
            }
        }

        VideoDetailInfoDTO videoDetailInfoDTO = new VideoDetailInfoDTO(
                videoInfo,
                videoOptionInfo,
                videoCategoryInfo,
                videoLectureInfo,
                videoTeacherInfo,
                videoOtherInfo,
                videoLectureCurriInfo

        );
        return videoDetailInfoDTO;
    }

    /**
     * 도서정보 저장및 수정
     * @param goodsInfo
     * @param tGoodsPriceOptionVOList
     * @param tCategoryVOList
     * @param tBookVO
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Integer saveBook(TGoodsVO goodsInfo, List<TGoodsPriceOptionVO> tGoodsPriceOptionVOList,
                            List<TCategoryGoods>tCategoryVOList, TBookVO tBookVO) {
        Integer gKey = this.upsultGoodsInfo(goodsInfo, goodsInfo.getImageList(), goodsInfo.getImageView());
        if (gKey != null || gKey > 0) {
            this.upsultTGoodsPriceOption(tGoodsPriceOptionVOList, gKey);
            this.upsultTCategoryGoods(tCategoryVOList, gKey);
            this.upsultBookInfo(tBookVO, gKey);
        }
        return gKey;
    }

    /**
     * 도서 상세정보 가져오기
     * @param gKey
     * @return
     */
    public BookDetailInfoDTO getBookDetailInfo(int gKey) {
        TGoodsVO productInfo = this.getVideoBasicInfo(gKey);
        List<TGoodsPriceOptionVO>productOptionInfo = this.getVideoOptionList(gKey);
        List<List<TCategoryVO>>productCategoryInfo = this.getVideoCategoryList(gKey);
        TBookVO bookInfo = productManageMapper.selectBookInfo(gKey);
        List<TResVO> previewInfo = productManageMapper.selectTResList(gKey);

        return new BookDetailInfoDTO(
            productInfo, productOptionInfo, productCategoryInfo, bookInfo, previewInfo
        );
    }

    /**
     * 제품 목록 가져오기
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @param goodsTypeStr(GoodsType 클래스 정의 / 동영상 : VIDEO, 학원 : ACADEMY, 책 : BOOK)
     * @return
     */
    @Transactional(readOnly = true)
    public List<VideoListDTO> getProductList(int sPage, int listLimit, String searchType, String searchText, String goodsTypeStr) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        return productManageMapper.selectProductList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType.toLowerCase(), ""),
                GoodsType.getGoodsTypeKey(goodsTypeStr)
        );
    }

    /**
     * 제품 목록 개수
     * @param searchType
     * @param searchText
     * @param goodsTypeStr(GoodsType 클래스 정의 / 동영상 : VIDEO, 학원 : ACADEMY, 책 : BOOK)
     * @return
     */
    @Transactional(readOnly = true)
    public Integer getProductListCount(String searchType, String searchText, String goodsTypeStr) {
        return productManageMapper.selectProductListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType.toLowerCase(), ""),
                GoodsType.getGoodsTypeKey(goodsTypeStr)
        );
    }

    /**
     * 동영상 상세 제일 처음 기본정보 가져오기
     * @param gkey
     * @return
     */
    @Transactional(readOnly = true)
    public TGoodsVO getVideoBasicInfo(int gkey) {
        if (gkey == 0) return null;
        return productManageMapper.selectTGoodsInfo(gkey);
    }

    /**
     * 동영상 옵션정보 리스트
     * @param gKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<TGoodsPriceOptionVO> getVideoOptionList(int gKey) {
        if (gKey == 0) return null;
        return productManageMapper.selectTGoodsPriceOptionList(gKey);
    }

    /**
     * 동영상 상세정보의 카테고리 목록 가져오기
     * @param gKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<List<TCategoryVO>> getVideoCategoryList(int gKey) {
        if (gKey == 0) return null;
        List<TCategoryGoods>categoryGoodsList = productManageMapper.selectTCategoryGoodsList(gKey);
        List<List<TCategoryVO>>videoCategoryList = new ArrayList<>();
        if (categoryGoodsList.size() > 0) {
            for (TCategoryGoods tCategoryGoods : categoryGoodsList) {
                List<TCategoryVO> tCategoryVOList = dataManageService.getSequentialCategoryList(tCategoryGoods.getCtgKey());
                videoCategoryList.add(tCategoryVOList);
            }
        }
        return videoCategoryList;
    }

    /**
     * 동영상 상세정보의 강좌 정보
     * @param gKey
     * @return
     */
    @Transactional(readOnly = true)
    public TLecVO getVideoLecInfo(int gKey) {
        if (gKey == 0) return null;
        return productManageMapper.selectTLecInfo(gKey);
    }

    /**
     * 동영상 상세정보의 강사 정보
     * @param gKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<TGoodTeacherLinkVO>getTeacherListByVideoInfo(int gKey) {
        if (gKey == 0) return null;
        return productManageMapper.selectTeacherListByTeacherLink(gKey);
    }

    /**
     * 동영상의 강의교재, 사은품, 전범위모의고사, 기출문제 회차별 정보
     * @param gKey
     * @param resType {@link com.zianedu.lms.define.datasource.LinkKeyReqType} 정의 (4: 사은품, 5 : 강의교재)
     *
     * @return
     */
    @Transactional(readOnly = true)
    public List<TLinkKeyVO>getGoodsListFromTLinkKey(int gKey, int resType) {
        if (gKey == 0) return null;
        List<TLinkKeyVO>list = new ArrayList<>();
        if (resType == 4 || resType == 5) {
            list = productManageMapper.selectTGoodsFromTLinkKeyRel(gKey, resType);
        } else {
            list = productManageMapper.selectTExamMasterFromTLinkKeyRel(gKey, resType);
        }
        return list;
    }

    /**
     * 동영상 상세안의 강의 목록
     * @param lecKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<TLecCurri>getLectureCurriList(int lecKey) {
        if (lecKey == 0) return null;
        return productManageMapper.selectTLecCurriList(lecKey);
    }

    /**
     * 모의고사 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<TExamMasterVO>getMockExamList(int sPage, int listLimit, String searchType, String searchText) {
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        return productManageMapper.selectTExamList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType.toLowerCase(), "")
        );
    }

    /**
     * 모의고사 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getMockExamListCount(String searchType, String searchText) {
        return productManageMapper.selectTExamListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType.toLowerCase(), "")
        );
    }

    /**
     * 모의고사 상세정보
     * @param examKey
     * @return
     */
    @Transactional(readOnly = true)
    public MokExamInfoDTO getMockExamInfo(int examKey) {
        if (examKey == 0) return null;
        return new MokExamInfoDTO(
                productManageMapper.selectTExamMasterInfo(examKey),
                productManageMapper.selectTBankSubjectExamLinkList(examKey)
        );
    }

    /**
     * 모의고사 문제은행 - 과목선택리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<TExamQuestionBankSubjectVO> getMockExamQuestionBankSubjectList(int sPage, int listLimit,
                                                                               String searchType, String searchText) {
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        return productManageMapper.selectMockExamQuestionBankSubjectList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType.toLowerCase(), "")
        );
    }

    /**
     * 모의고사 문제은행 - 과목선택리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getMockExamQuestionBankSubjectListCount(String searchType, String searchText) {
        return productManageMapper.selectMockExamQuestionBankSubjectListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType.toLowerCase(), "")
        );
    }

//    /**
//     * 상품종류 리스트
//     * @param sPage
//     * @param listLimit
//     * @param searchType
//     * @param searchText
//     * @param goodsTypeStr(GoodsType 클래스 정의 / 동영상 : VIDEO, 책 : BOOK)
//     * @return
//     */
//    @Transactional(readOnly = true)
//    public List<TGoodsVO>getGoodList(int sPage, int listLimit, String searchType, String searchText, String goodsTypeStr) {
//        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
//        return productManageMapper.selectTGoodsListByType(
//                startNumber,
//                listLimit,
//                Util.isNullValue(searchType, ""),
//                Util.isNullValue(searchText, ""),
//                GoodsType.getGoodsTypeKey(goodsTypeStr)
//        );
//    }
//
//    /**
//     * 상품종류 리스트 개수
//     * @param searchType
//     * @param searchText
//     * @param goodsTypeStr
//     * @return
//     */
//    @Transactional(readOnly = true)
//    public int getGoodListCount(String searchType, String searchText, String goodsTypeStr) {
//        return productManageMapper.selectTGoodsListByTypeCount(
//                Util.isNullValue(searchType, ""),
//                Util.isNullValue(searchText, ""),
//                GoodsType.getGoodsTypeKey(goodsTypeStr)
//        );
//    }

    /**
     * 상품기본정보 저장및 수정
     * @param tGoodsVO
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Integer upsultGoodsInfo(TGoodsVO tGoodsVO, String imageList, String imageView) {
        if (tGoodsVO == null) return null;

        tGoodsVO.setImageList(imageList);
        tGoodsVO.setImageView(imageView);

        if (tGoodsVO.getGKey() == 0) productManageMapper.insertTGoods(tGoodsVO);
        else productManageMapper.updateTGoods(tGoodsVO);

        return tGoodsVO.getGKey() + 1;
    }

    /**
     * 상품옵션정보 저장및 수정
     * @param tGoodsPriceOptionVOList
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultTGoodsPriceOption(List<TGoodsPriceOptionVO> tGoodsPriceOptionVOList, int gKey) {
        if (tGoodsPriceOptionVOList.size() == 0) return;

        for (TGoodsPriceOptionVO optionVO : tGoodsPriceOptionVOList) {
            optionVO.setGKey(gKey);
            if (optionVO.getPriceKey() == 0) {
                productManageMapper.insertTGoodsPriceOption(optionVO);
            } else {
                productManageMapper.updateTGoodsPriceOption(optionVO);
            }
        }
    }

    /**
     * 동영상 카테고리 삭제 후 저장하기
     * @param tCategoryGoodsList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultTCategoryGoods(List<TCategoryGoods>tCategoryGoodsList, int gKey) {
        if (tCategoryGoodsList.size() == 0) return;

        //productManageMapper.deleteTCategoryGoods(tCategoryGoodsList.get(0).getGKey());
        for (TCategoryGoods categoryGoods : tCategoryGoodsList) {
            categoryGoods.setGKey(gKey);
            categoryGoods.setPos(0);
            productManageMapper.insertTCategoryGoods(categoryGoods);
        }
    }

    /**
     * 동영상 강좌정보 저장및 수정
     * @param tLecVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultTLec(TLecVO tLecVO, int gKey) {
        if (tLecVO == null) return;

        tLecVO.setGKey(gKey);
        if (tLecVO.getLecKey() == 0) productManageMapper.insertTLec(tLecVO);
        else productManageMapper.updateTLec(tLecVO);
    }

    /**
     * 동영상 강사목록 저장및 수정
     * @param tGoodTeacherLinkVOList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultTGoodTeacherLink(List<TGoodTeacherLinkVO> tGoodTeacherLinkVOList, int gKey) {
        if (tGoodTeacherLinkVOList.size() == 0) return;

        for (TGoodTeacherLinkVO teacherLinkVO : tGoodTeacherLinkVOList) {
            teacherLinkVO.setGKey(gKey);
            if (teacherLinkVO.getGTeacherKey() == 0) productManageMapper.insertTGoodsTeacherLink(teacherLinkVO);
            else productManageMapper.updateTGoodsTeacherLink(teacherLinkVO);
        }
    }

    /**
     * 동영상의 강의교재, 사은품, 전범위모의고사, 기출문제 회차별 저장
     * @param tLinkKeyVOList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultTLinkKink(List<TLinkKeyVO>tLinkKeyVOList, int gKey) {
        if (tLinkKeyVOList.size() == 0) return;

        productManageMapper.deleteTLinkKey(tLinkKeyVOList.get(0).getReqKey());
        for (TLinkKeyVO tLinkKeyVO : tLinkKeyVOList) {
            tLinkKeyVO.setReqKey(gKey);
            productManageMapper.insertTLinkKey(tLinkKeyVO);
        }
    }

    /**
     * 강의교재 주교재, 부교재 설정하기
     * @param linkKey
     * @param valueBit
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateLectureBookStatus(int linkKey, int valueBit) {
        if (linkKey == 0) return;
        TLinkKeyVO tLinkKeyVO = new TLinkKeyVO(linkKey, valueBit);
        productManageMapper.updateTLinkKey(tLinkKeyVO);
    }

    /**
     * x표시가 있는 항목 삭제하기
     * @param key
     * @param menuType
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteVideoOtherInfo(int key, String menuType) {
        if (key == 0 && "".equals(menuType)) return;

        if ("TEACHER".equals(menuType)) {   //강사목록
            productManageMapper.deleteTGoodsTeacherLink(key);
        } else if ("CATE_GOODS".equals(menuType)) { //카테고리목록
            productManageMapper.deleteTCategoryGoodsByCtgGKey(key);
        } else if ("TLINK".equals(menuType)) {  // 강의교재, 사은품, 전범위모의고사, 기출문제 회차별
            productManageMapper.deleteTLinkKeyByLinkKey(key);
        } else if ("CURRI".equals(menuType)) {  // 강의목록
            productManageMapper.deleteTLecCurri(key);
        }
    }

    /**
     * 동영상 강의 저장
     * @param tLecCurri
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Integer saveVideoLectureInfo(TLecCurri tLecCurri) {
        if (tLecCurri == null) return 0;

        Integer lastPos = productManageMapper.selectTLecCurriLastPos(tLecCurri.getLecKey());
        if (lastPos == null) lastPos = 0;

        tLecCurri.setPos(lastPos);
        productManageMapper.insertTLecCurri(tLecCurri);
        return tLecCurri.getCurriKey() + 1;
    }

    /**
     * 동영상 강의 순서 변경
     * @param tLecCurriList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void changeNumberVideoLecture(List<TLecCurri> tLecCurriList) {
        if (tLecCurriList.size() == 0) return;
        for (TLecCurri tLecCurri : tLecCurriList) {
            productManageMapper.updateTLecCurri(tLecCurri);
        }
    }

    /**
     * T_BOOK 저장및 수정
     * @param tBookVO
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultBookInfo(TBookVO tBookVO, int gKey) {
        if (tBookVO == null) return;

        if (tBookVO.getBookKey() == 0) {
            tBookVO.setGKey(gKey);
            productManageMapper.insertTBook(tBookVO);
        } else {
            productManageMapper.updateTBook(tBookVO);
        }

    }

    /**
     * 미리보기 이미지 저장
     * @param tResVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveBookPreviewInfo(TResVO tResVO) {
        if (tResVO == null)return;
        productManageMapper.insertTRes(tResVO);
    }

    /**
     * 모의고사 상세정보 저장및 수정
     * @param tExamMasterVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultMokExamInfo(TExamMasterVO tExamMasterVO) {
        if (tExamMasterVO == null) return;

        if (tExamMasterVO.getExamKey() == 0) productManageMapper.insertTExamMaster(tExamMasterVO);
        else productManageMapper.updateTExamMaster(tExamMasterVO);
    }

}
