package com.zianedu.lms.service;

import com.zianedu.lms.config.ConfigHolder;
import com.zianedu.lms.define.datasource.ExamLevelType;
import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.define.datasource.PromotionPmType;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.mapper.PromotionManageMapper;
import com.zianedu.lms.utils.FileUtil;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.StringUtils;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class ProductManageService extends PagingSupport {

    protected static final Logger logger = LoggerFactory.getLogger(ProductManageService.class);

    @Autowired
    private ProductManageMapper productManageMapper;

    @Autowired
    private PromotionManageMapper promotionManageMapper;

    @Autowired
    private DataManageService dataManageService;

    /**
     * 제품 상세정보 가져오기(동영상, 학원강의)
     * @param gKey
     * @return
     */
    public ProductDetailInfoDTO getProductDetailInfo(int gKey, String goodsTypeStr) {
        if (gKey == 0) return null;

        TGoodsVO productInfo = this.getVideoBasicInfo(gKey);
        List<TGoodsPriceOptionVO>productOptionInfo = this.getVideoOptionList(gKey);
        List<List<TCategoryVO>>productCategoryInfo = this.getVideoCategoryList(gKey);
        TLecVO productLectureInfo = this.getVideoLecInfo(gKey);
        List<TGoodTeacherLinkVO> productTeacherInfo = this.getTeacherListByVideoInfo(gKey);

        List<TLecCurri> videoLectureCurriInfo = new ArrayList<>();
        if (GoodsType.getGoodsTypeKey(goodsTypeStr) == 1) {
            videoLectureCurriInfo = this.getLectureCurriList(productLectureInfo.getLecKey());
        }

        List<TLinkKeyVO>tLinkKeyVOList = productManageMapper.selectTLinkKeyList(gKey);
        List<List<TLinkKeyVO>>productOtherInfo = new ArrayList<>();
        if (tLinkKeyVOList.size() > 0) {
            for (TLinkKeyVO linkKeyVO : tLinkKeyVOList) {
                List<TLinkKeyVO>list = new ArrayList<>();
                list = this.getGoodsListFromTLinkKey(gKey, linkKeyVO.getResType());
                productOtherInfo.add(list);
            }
        }

        ProductDetailInfoDTO productDetailInfoDTO = new ProductDetailInfoDTO(
                productInfo,
                productOptionInfo,
                productCategoryInfo,
                productLectureInfo,
                productTeacherInfo,
                productOtherInfo,
                videoLectureCurriInfo

        );
        return productDetailInfoDTO;
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
     * 모의고사 상품 상세정보
     * @param gKey
     * @return
     */
    public ExamDetailInfoDTO getExamProductDetailInfo(int gKey) {
        TGoodsVO productInfo = this.getVideoBasicInfo(gKey);
        List<TGoodsPriceOptionVO>productOptionInfo = this.getVideoOptionList(gKey);
        List<List<TCategoryVO>>productCategoryInfo = this.getVideoCategoryList(gKey);
        List<TLinkKeyVO>productOtherInfo = this.getGoodsListFromTLinkKey(gKey, 0);

        ExamDetailInfoDTO examDetailInfoDTO = new ExamDetailInfoDTO(
                productInfo, productOptionInfo, productCategoryInfo, productOtherInfo
        );
        return examDetailInfoDTO;
    }

    /**
     * 제품 목록 가져오기
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @param goodsTypeStr(GoodsType 클래스 정의 / 동영상 : VIDEO, 학원 : ACADEMY, 책 : BOOK, 패키지 : PACKAGE)
     * @return
     */
    @Transactional(readOnly = true)
    public List<VideoListDTO> getProductList(int sPage, int listLimit, String searchType, String searchText, String goodsTypeStr) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        if (GoodsType.getGoodsTypeKey(goodsTypeStr) == 5) {
            if (PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 1
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 101
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 100
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 51
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 50) {
                return promotionManageMapper.selectPromotionProductList(
                        startNumber,
                        listLimit,
                        Util.isNullValue(searchText, ""),
                        Util.isNullValue(searchType.toLowerCase(), ""),
                        PromotionPmType.getPromotionPmTypeKey(goodsTypeStr)
                );
            }
        } else {
            List<VideoListDTO> videoListDTOList = productManageMapper.selectProductList(
                    startNumber,
                    listLimit,
                    Util.isNullValue(searchText, ""),
                    Util.isNullValue(searchType.toLowerCase(), ""),
                    GoodsType.getGoodsTypeKey(goodsTypeStr)
            );
            if (GoodsType.getGoodsTypeKey(goodsTypeStr) == 1) {
                for (VideoListDTO listDTO : videoListDTOList) {
                    int gKey = listDTO.getGKey();
                    List<String>teacherNameList = productManageMapper.selectTeacherNameListByVideoProduct(gKey);
                    String[] teacherNames = null;
                    String teacherName = "";
                    if (teacherNameList.size() > 0) {
                        teacherNames = StringUtils.arrayListToStringArray(teacherNameList);
                        teacherName = StringUtils.stringArrayToString(teacherNames, ",");
                    }

                    listDTO.setTeacherName(Util.isNullValue(teacherName, ""));
                }
            }
            return videoListDTOList;
        }
        return null;
    }

    /**
     * 제품 목록 개수
     * @param searchType
     * @param searchText
     * @param goodsTypeStr(GoodsType 클래스 정의 / 동영상 : VIDEO, 학원 : ACADEMY, 책 : BOOK, 패키지 : PACKAGE)
     * @return
     */
    @Transactional(readOnly = true)
    public Integer getProductListCount(String searchType, String searchText, String goodsTypeStr) {
        if (GoodsType.getGoodsTypeKey(goodsTypeStr) == 5) {
            if (PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 1
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 101
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 100
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 51
                    || PromotionPmType.getPromotionPmTypeKey(goodsTypeStr) == 50) {
                return promotionManageMapper.selectPromotionProductListCount(
                        Util.isNullValue(searchText, ""),
                        Util.isNullValue(searchType.toLowerCase(), ""),
                        PromotionPmType.getPromotionPmTypeKey(goodsTypeStr)
                );
            }
        } else {
            return productManageMapper.selectProductListCount(
                    Util.isNullValue(searchText, ""),
                    Util.isNullValue(searchType.toLowerCase(), ""),
                    GoodsType.getGoodsTypeKey(goodsTypeStr)
            );
        }
        return null;
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
                //Collections.reverse(tCategoryVOList);
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
     * 동영상의 강의교재, 사은품, 전범위모의고사, 기출문제 회차별 정보, 모의고사 정보, 포함된 온라인 강좌
     * @param gKey
     * @param resType {@link com.zianedu.lms.define.datasource.LinkKeyReqType} 정의 (4: 사은품, 5 : 강의교재), 모의고사 정보는 0
     *
     * @return
     */
    @Transactional(readOnly = true)
    public List<TLinkKeyVO>getGoodsListFromTLinkKey(int gKey, int resType) {
        if (gKey == 0) return null;
        List<TLinkKeyVO>list = new ArrayList<>();
        if (resType == 1 || resType == 4 || resType == 5) {
            list = productManageMapper.selectTGoodsFromTLinkKeyRel(gKey, resType);
        } else {
            list = productManageMapper.selectTExamMasterFromTLinkKeyRel(gKey, resType);
        }
        return list;
    }

    @Transactional(readOnly = true)
    public TLinkKeyVO getGoodsFromTLinkKey(int gKey, int resType) {
        TLinkKeyVO tLinkKeyVO = new TLinkKeyVO();
        if (resType == 1 || resType == 4 || resType == 5) {
            tLinkKeyVO = productManageMapper.selectTGoodsFromTLinkKeyRelSingle(gKey, resType);
        } else {
            tLinkKeyVO = productManageMapper.selectTExamMasterFromTLinkKeyRelSingle(gKey, resType);
        }
        return tLinkKeyVO;
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
     * 동영상 상세안의 강의 목록
     * @param curriKey
     * @return
     */
    @Transactional(readOnly = true)
    public TLecCurri getLectureCurriInfo(int curriKey) {
        if (curriKey == 0) return null;
        return productManageMapper.selectTLecCurriInfo(curriKey);
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
     * 모의고사 관리 > 모의고사 목록 > 상세화면 > 시험과목 추가버튼 > 모의고사 문제은행 - 과목선택리스트, 모의고사 문제은행 과목 목록 리스트
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
     * 모의고사 문제은행 - 과목선택리스트 개수, 모의고사 문제은행 과목 목록 리스트 개수
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

    /**
     * 모의고사 문제은행 문제 목록 리스트
     * @param searchVO
     * @return
     */
    @Transactional(readOnly = true)
    public List<ProblemBankListDTO> getProblemBankList(ProblemBankSearchVO searchVO) {
        int startNumber = PagingSupport.getPagingStartNumber(searchVO.getStartPage(), searchVO.getListLimitNumber());
        searchVO.setStartNumber(startNumber);

        List<ProblemBankListDTO>list = productManageMapper.selectTExamQuestionBankList(searchVO);

        if (list.size() == 0) return null;
        for (ProblemBankListDTO bankListDTO : list) {
            if (bankListDTO.getUnitCtgKey() > 0) {
                String unitName = dataManageService.getMakeUnitName(bankListDTO.getUnitCtgKey());
                bankListDTO.setUnitName(unitName);
            }
            bankListDTO.setLevelName(ExamLevelType.getExamLevelStr(bankListDTO.getExamLevel()));
        }
        return list;
    }

    /**
     * 모의고사 문제은행 문제 목록 리스트 개수
     * @param searchVO
     * @return
     */
    @Transactional(readOnly = true)
    public int getProblemBankListCount(ProblemBankSearchVO searchVO) {
        return productManageMapper.selectTExamQuestionBankListCount(searchVO);
    }

    /**
     * 모의고사 문제은행 문제 상세정보
     * @param examQuestionBankKey
     * @return
     */
    @Transactional(readOnly = true)
    public TExamQuestionBankVO getProblemBankDetailInfo(int examQuestionBankKey) {
        TExamQuestionBankVO questionBankVO = productManageMapper.selectTExamQuestionBankInfo(examQuestionBankKey);

        if (questionBankVO != null) {
            //정답 첫번째 문자 가져오기(3000 --> 3)
            String firstAnswer = Util.subStrStartEnd(String.valueOf(questionBankVO.getAnswer()), 0, 1);
            questionBankVO.setAnswer(Integer.parseInt(firstAnswer));
            //이미지 URL만들기
            questionBankVO.setCommentaryImageUrl(
                    FileUtil.concatPath(ConfigHolder.getFileDomainUrl(), questionBankVO.getCommentaryImage())
            );
            //이미지 URL만들기
            questionBankVO.setQuestionImageUrl(
                    FileUtil.concatPath(ConfigHolder.getFileDomainUrl(), questionBankVO.getQuestionImage())
            );
            //유형정보 가져오기
            if (questionBankVO.getStepCtgKey() > 0) {
                List<TCategoryVO>stepList = dataManageService.getSequentialCategoryList(questionBankVO.getStepCtgKey());
                questionBankVO.setStepList(stepList);
            }
            //패턴정보 가져오기
            if (questionBankVO.getPatternCtgKey() > 0) {
                List<TCategoryVO>patternList = dataManageService.getSequentialCategoryList(questionBankVO.getPatternCtgKey());
                questionBankVO.setPatternList(patternList);
            }
            //단원정보 가져오기
            if (questionBankVO.getUnitCtgKey() > 0) {
                List<TCategoryVO>unitList = dataManageService.getSequentialCategoryList(questionBankVO.getUnitCtgKey());
                questionBankVO.setUnitList(unitList);
            }
        }
        return questionBankVO;
    }

    /**
     * 모의고사 문제은행 과목 수정 상세화면
     * @param examQuesBankSubjectKey
     * @return
     */
    @Transactional(readOnly = true)
    public ProblemBankSubjectDetailDTO getProblemBankSubjectList(int examQuesBankSubjectKey) {
        if (examQuesBankSubjectKey == 0) return null;

        TExamQuestionBankSubjectVO subjectVO = productManageMapper.selectTExamQuestionBankSubjectDetailInfo(examQuesBankSubjectKey);
        List<ProblemBankSubjectDTO>list = productManageMapper.selectTBankSubjectQuesLinkList(examQuesBankSubjectKey);

        if (list.size() > 0) {
            for (ProblemBankSubjectDTO subjectDTO : list) {
                if (subjectDTO.getUnitCtgKey() > 0) {
                    String unitName = dataManageService.getMakeUnitName(subjectDTO.getUnitCtgKey());
                    subjectDTO.setUnitName(unitName);
                }
                if (!"".equals(subjectDTO.getQuestionImage())) {
                    subjectDTO.setQuestionImageUrl(
                            FileUtil.concatPath(ConfigHolder.getFileDomainUrl(), subjectDTO.getQuestionImage())
                    );
                }
                subjectDTO.setLevelName(ExamLevelType.getExamLevelStr(subjectDTO.getExamLevel()));
            }
        }
        ProblemBankSubjectDetailDTO subjectDetailDTO = new ProblemBankSubjectDetailDTO(
                subjectVO, list
        );
        return subjectDetailDTO;
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

        tGoodsVO.setImageList(Util.isNullValue(imageList, ""));
        tGoodsVO.setImageView(Util.isNullValue(imageView, ""));
        tGoodsVO.setIndate(Util.isNullValue(tGoodsVO.getIndate(), ""));
        tGoodsVO.setSellstartdate(Util.isNullValue(tGoodsVO.getSellstartdate(), ""));
        tGoodsVO.setDescription(Util.isNullValue(tGoodsVO.getDescription(), ""));

        if (tGoodsVO.getGKey() == 0) productManageMapper.insertTGoods(tGoodsVO);
        else productManageMapper.updateTGoods(tGoodsVO);

        return tGoodsVO.getGKey();
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public Integer updateGoodsInfo(TGoodsVO tGoodsVO, int gKey, String imageList, String imageView) {
        if (tGoodsVO == null) return null;

        tGoodsVO.setGKey(gKey);
        tGoodsVO.setImageList(Util.isNullValue(imageList, ""));
        tGoodsVO.setImageView(Util.isNullValue(imageView, ""));
        tGoodsVO.setIndate(Util.isNullValue(tGoodsVO.getIndate(), ""));
        tGoodsVO.setSellstartdate(Util.isNullValue(tGoodsVO.getSellstartdate(), ""));
        tGoodsVO.setDescription(Util.isNullValue(tGoodsVO.getDescription(), ""));

        if (tGoodsVO.getGKey() == 0) productManageMapper.insertTGoods(tGoodsVO);
        else productManageMapper.updateTGoods(tGoodsVO);

        return tGoodsVO.getGKey();
    }

    /**
     * 상품옵션정보 저장및 수정
     * @param tGoodsPriceOptionVOList
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultTGoodsPriceOption(List<TGoodsPriceOptionVO> tGoodsPriceOptionVOList, int gKey) {
        if (tGoodsPriceOptionVOList.size() == 0) return;

        productManageMapper.deleteTGoodsPriceOption(gKey);
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

        productManageMapper.deleteTCategoryGoods(gKey);
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
        tLecVO.setRegdate(Util.returnNowDateByYYMMDD());
        tLecVO.setStartdate(Util.isNullValue(tLecVO.getStartdate(), ""));

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

        productManageMapper.deleteTGoodsTeacherLinkByGkey(gKey);
        for (TGoodTeacherLinkVO teacherLinkVO : tGoodTeacherLinkVOList) {
            teacherLinkVO.setGKey(gKey);
            if (teacherLinkVO.getGTeacherKey() == 0) productManageMapper.insertTGoodsTeacherLink(teacherLinkVO);
            else productManageMapper.updateTGoodsTeacherLink(teacherLinkVO);
        }
    }

    /**
     * 동영상의 강의교재, 사은품, 전범위모의고사, 기출문제 회차별, 모의고사 정보, 포함된 온라인 강좌 저장
     * @param tLinkKeyVOList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultTLinkKink(List<TLinkKeyVO>tLinkKeyVOList, int gKey) {
        if (tLinkKeyVOList.size() == 0) return;

        productManageMapper.deleteTLinkKey(tLinkKeyVOList.get(0).getReqKey());
        for (TLinkKeyVO tLinkKeyVO : tLinkKeyVOList) {
            tLinkKeyVO.setReqKey(gKey);
            tLinkKeyVO.setGoodsName("");
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
        } else if ("TLINK".equals(menuType)) {  // 강의교재, 사은품, 전범위모의고사, 기출문제 회차별, 포함된 온라인 강좌
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
        if (lastPos == null) {
            lastPos = 0;
        } else {
            lastPos = lastPos + 1;
        }

        tLecCurri.setPos(lastPos);

        productManageMapper.insertTLecCurri(tLecCurri);
        return tLecCurri.getCurriKey();
    }

    /**
     * 동영상 강의 순서 변경
     * @param tLecCurriList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void changeNumberVideoLecture(List<TLecCurri> tLecCurriList) {
        if (tLecCurriList.size() == 0) return;
        for (TLecCurri tLecCurri : tLecCurriList) {
            productManageMapper.updateTLecCurriPos(tLecCurri);
        }
    }

    /**
     * 동영상 강의 수정
     * @param tLecCurri
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateTLecCurri(TLecCurri tLecCurri) {
        if (tLecCurri == null) return;
        productManageMapper.updateTLecCurri(tLecCurri);
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

   /**
     * 모의고사 상세 > 시험과목 목록 > 필수과목 여부 변경하기
     * @param tBankSubjectExamLinkVOS
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateRequireSubject(List<TBankSubjectExamLinkVO>tBankSubjectExamLinkVOS) {
        if (tBankSubjectExamLinkVOS.size() == 0)return;

        for (TBankSubjectExamLinkVO examLinkVO : tBankSubjectExamLinkVOS) {
            if (examLinkVO.getBankSubjectExamLinkKey() == 0) return;
            TBankSubjectExamLinkVO tBankSubjectExamLinkVO = new TBankSubjectExamLinkVO(
                    examLinkVO.getBankSubjectExamLinkKey(), examLinkVO.getRequired()
            );
            productManageMapper.updateTBankSubjectExamLink(tBankSubjectExamLinkVO);
        }
    }

    /**
     * 모의고사 문제은행 입력및 수정
     * @param tExamQuestionBankVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultProblemBank(TExamQuestionBankVO tExamQuestionBankVO) {
        if (tExamQuestionBankVO == null) return;
        if (tExamQuestionBankVO.getExamQuestionBankKey() == 0) {
            productManageMapper.insertTExamQuestionBank(tExamQuestionBankVO);
        } else {
            productManageMapper.updateTExamQuestionBank(tExamQuestionBankVO);
        }
    }

    /**
     * 모의고사 상세 > 시험과목 목록 > 과목삭제하기
     * @param bankSubjectExamLinkKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteExamSubject(int bankSubjectExamLinkKey) {
        if (bankSubjectExamLinkKey == 0)return;
        productManageMapper.deleteTBankSubjectExamLink(bankSubjectExamLinkKey);
    }

    /**
     * 모의고사 문제은행 문제 상세정보 > 이미지 삭제하기
     * @param examQuestionBankKey
     * @param imageType {QUESTION:questionImage, COMMENTARY:commentaryImage, BOOK:bookImage}
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteProblemBankImage(int examQuestionBankKey, String imageType) {
        if (examQuestionBankKey == 0 && "".equals(imageType)) return;
        productManageMapper.updateTExamQuestionBankImage(
                examQuestionBankKey, Util.isNullValue(imageType, "")
        );
    }

    /**
     * 모의고사 문제은행 과목 수정 > 문제 저장
     * @param examQuesBankSubjectKey
     * @param examQuesBankKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveProblemBankSubject(int examQuesBankSubjectKey, int examQuesBankKey) {
        if (examQuesBankSubjectKey == 0 && examQuesBankKey == 0) return;

        Integer lastPos = productManageMapper.selectTBankSubjectQuesLinkLastPos(examQuesBankSubjectKey);
        if (lastPos == null) lastPos = 0;

        productManageMapper.insertTBankSubjectQuesLink(examQuesBankSubjectKey, examQuesBankKey, lastPos);
    }

    /**
     * 모의고사 문제은행 과목 수정 목록 > "x"표시로 항목 삭제
     * @param bankSubjectQuesLinkKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteProblemBankSubjectList(int bankSubjectQuesLinkKey) {
        if (bankSubjectQuesLinkKey == 0) return;
        productManageMapper.deleteTBankSubjectQuesLink(bankSubjectQuesLinkKey);
    }

    /**
     * 모의고사 문제은행 과목 > 순서변경
     * @param list
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void changeNumberProblemBankSubjectList(List<ChangeNumberDTO>list) {
        if (list.size() == 0)return;
        for (ChangeNumberDTO numberDTO : list) {
            productManageMapper.updateTBankSubjectQuesLinkPos(
                    numberDTO.getKey(), numberDTO.getPos());
        }
    }

    /**
     * 모의고사 문제은행 과목 등록 > 상단 내용 등록및 수정
     * @param subjectName
     * @param subjectCtgKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void upsultProblemBankTitleInfo(int examQuestionBankSubjectKey, String subjectName, int subjectCtgKey) {
        if ("".equals(subjectName) && subjectCtgKey == 0) return;

        if (examQuestionBankSubjectKey == 0) {
            productManageMapper.insertTExamQuestionBankSubject(subjectName, subjectCtgKey);
        } else {
            productManageMapper.updateTExamQuestionBankSubject(examQuestionBankSubjectKey, subjectName, subjectCtgKey);
        }
    }

}
