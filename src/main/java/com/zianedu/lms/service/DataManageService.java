package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.TCategoryParentKeyType;
import com.zianedu.lms.dto.ResultDTO;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.mapper.UserMapper;
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
public class DataManageService {

    static final Logger logger = LoggerFactory.getLogger(DataManageService.class);

    @Autowired
    private DataManageMapper dataManageMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 카테고리 리스트 가져오기(key : parentKey)
     * @param categoryParentStr (분류관리 : CLASSFICATION(202), 과목관리 : SUBJECT(70))
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryVO> getTcategoryList(String categoryParentStr) {
        return dataManageMapper.selectTCategoryList(TCategoryParentKeyType.getParentKey(categoryParentStr));
    }

    /**
     * 배너관리 리스트 가져오기
     * @param ctgKey (selectboxService.getSubDomainList)
     * @return
     */
    @Transactional(readOnly = true)
    public List<ResultDTO> getBannerList(int ctgKey) {
        List<TCategoryVO> tCategoryVOList = dataManageMapper.selectBannerTitleList(ctgKey);
        List<ResultDTO> result = new ArrayList<>();

        for (TCategoryVO tCategoryVO : tCategoryVOList) {
            ResultDTO resultDTO = new ResultDTO();
            resultDTO.setResult(tCategoryVO);
            resultDTO.setResultList(
                dataManageMapper.selectTCategoryOtherInfoList(tCategoryVO.getCtgKey())
            );
            result.add(resultDTO);
        }
        return result;
    }

    /**
     * 배너 상세 정보 가져오기
     * @param ctgInfoKey
     * @return
     */
    @Transactional(readOnly = true)
    public TCategoryOtherInfoVO getBannerDetailInfo(int ctgInfoKey) {
        return dataManageMapper.selectTCategoryOtherInfo(ctgInfoKey);
    }

    /**
     * 사이드바 배너 리스트 가져오기
     * @param ctgKey(사이드바배너 : 4200)
     * @return
     */
    @Transactional(readOnly = true)
    public List<ResultDTO> getSideBarBannerList(int ctgKey) {
        List<TCategoryVO> tCategoryVOList = dataManageMapper.selectBannerTitleListByCtgKey(ctgKey, 0);
        List<ResultDTO> result = new ArrayList<>();

        for (TCategoryVO tCategoryVO : tCategoryVOList) {
            ResultDTO resultDTO = new ResultDTO();
            resultDTO.setResult(tCategoryVO);
            resultDTO.setResultList(
                    dataManageMapper.selectTCategoryOtherInfoList(tCategoryVO.getCtgKey())
            );
            result.add(resultDTO);
        }
        return result;
    }

    /**
     * 시험일정 리스트 가져오기
     * @return
     */
    @Transactional(readOnly = true)
    public List<TScheduleVO> getExamSchedule() {
        return dataManageMapper.selectTScheduleList();
    }

    /**
     * 시험일정 상세정보 가져오기
     * @param scheduleKey
     * @return
     */
    @Transactional(readOnly = true)
    public TScheduleVO getExamScheduleDetailInfo(int scheduleKey) {
        return dataManageMapper.selectTScheduleInfo(scheduleKey);
    }
    /**
     * 검색어 목록 가져오기
     * @param className
     * @return
     */
    @Transactional(readOnly = true)
    public List<TSearchKeywordVO> getSearchKeywordList(String className) {
        if ("".equals(className)) return null;
        return dataManageMapper.selectTSearchKeywordList(className.toLowerCase());
    }

    /**
     * 검색어 상세정보 가져오기
     * @param searchKeywordKey
     * @return
     */
    @Transactional(readOnly = true)
    public TSearchKeywordVO getSearchKeywordInfo(int searchKeywordKey) {
        if (searchKeywordKey == 0) return null;
        return dataManageMapper.selectTSearchKeywordInfo(searchKeywordKey);
    }

    /**
     * 마지막 카테고리 값 기준 4뎁스 목록 카테고리 목록 가져오기
     * @param ctgKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryVO> getSequentialCategoryList(int ctgKey) {
        if (ctgKey == 0) return null;
        List<TCategoryVO>list = new ArrayList<>();
        int j = 0;
        for (int i=0; i<4; i++) {
            TCategoryVO tCategoryVO = new TCategoryVO();

            if (i == 0) tCategoryVO = dataManageMapper.selectTCategoryInfoByCtgKey(ctgKey);
            else tCategoryVO = dataManageMapper.selectTCategoryInfoByCtgKey(j);

            j = tCategoryVO.getParentKey();

            list.add(tCategoryVO);
            //Collections.reverse(list);
        }
        return list;
    }

    @Transactional(readOnly = true)
    public List<TCategoryVO> getSequentialCategoryListTwo(int ctgKey) {
        if (ctgKey == 0) return null;
        List<TCategoryVO>list = new ArrayList<>();
        int j = 0;
        for (int i=0; i<2; i++) {
            TCategoryVO tCategoryVO = new TCategoryVO();

            if (i == 0) tCategoryVO = dataManageMapper.selectTCategoryInfoByCtgKey(ctgKey);
            else tCategoryVO = dataManageMapper.selectTCategoryInfoByCtgKey(j);

            j = tCategoryVO.getParentKey();

            list.add(tCategoryVO);
        }
        return list;
    }

    /**
     * 4뎁스 이하의 카테고리 사용
     * @param ctgKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryVO> getSequentialCategoryListBy4DepthUnder(int ctgKey) {
        if (ctgKey == 0) return null;
        List<TCategoryVO>list = new ArrayList<>();
        TCategoryVO tCategoryVO = dataManageMapper.selectTCategoryInfoByCtgKey(ctgKey);

        if (tCategoryVO != null) {
            list.add(tCategoryVO);

            TCategoryVO tCategoryVO2 = dataManageMapper.selectTCategoryInfoByCtgKey(tCategoryVO.getParentKey());
            if (tCategoryVO2 != null) {
                list.add(tCategoryVO2);
                TCategoryVO tCategoryVO3 = dataManageMapper.selectTCategoryInfoByCtgKey(tCategoryVO2.getParentKey());

                if (tCategoryVO3 != null) {
                    if (tCategoryVO3.getCtgKey() > 1) {
                        list.add(tCategoryVO3);
                    }

                    if (tCategoryVO3.getParentKey() > 0) {
                        TCategoryVO tCategoryVO4 = dataManageMapper.selectTCategoryInfoByCtgKey(tCategoryVO3.getParentKey());
                        if (tCategoryVO4 != null) {
                            if (tCategoryVO4.getCtgKey() > 1) {
                                list.add(tCategoryVO4);
                            }
                        }
                    }
                }

            }
        }
        //Collections.reverse(list);
        return list;
    }

    /**
     * 모의고사 문제은행 문제 목록에서 단원 필드명 만들기
     * @param ctgKey
     * @return
     */
    public String getMakeUnitName(int ctgKey) {
        if (ctgKey == 0) return null;
        List<TCategoryVO>list = new ArrayList<>();
        int j = 0;
        for (int i=0; i<3; i++) {
            TCategoryVO tCategoryVO = new TCategoryVO();

            if (i == 0) tCategoryVO = dataManageMapper.selectTCategoryInfoByCtgKey(ctgKey);
            else tCategoryVO = dataManageMapper.selectTCategoryInfoByCtgKey(j);

            j = tCategoryVO.getParentKey();

            list.add(tCategoryVO);
        }
        String unitName = "";
        unitName = list.get(2).getName() + " > " + list.get(1).getName() + " > " + list.get(0).getName();
        return unitName;
    }

    /**
     * 카테고리 저장하기
     * @param categoryTypeStr (분류관리 : CLASSFICATION(202), 과목관리 : SUBJECT(70))
     * @param ctgName
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public List<TCategoryVO> saveClassficationInfo(String categoryTypeStr, String ctgName) {
        if ("".equals(ctgName)) return null;
        int lastPosNum = dataManageMapper.selectTCategoryLastPosNumber(TCategoryParentKeyType.getParentKey(categoryTypeStr));
        dataManageMapper.insertTCategoryInfo(
                TCategoryParentKeyType.getParentKey(categoryTypeStr), ctgName, lastPosNum + 1);
        return dataManageMapper.selectTCategoryList(TCategoryParentKeyType.getParentKey(categoryTypeStr));
    }

    /**
     * 배너정보 저장하기
     * @param tCategoryOtherInfoVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveBannerInfo(TCategoryOtherInfoVO tCategoryOtherInfoVO) {
        if (tCategoryOtherInfoVO == null) return;

        Integer lastPosNum= dataManageMapper.selectTCategoryOtherInfoLastPosNumber(tCategoryOtherInfoVO.getCtgKey());

        if (lastPosNum == null) {
            tCategoryOtherInfoVO.setPos(0);
        } else {
            tCategoryOtherInfoVO.setPos(lastPosNum + 1);
        }
        tCategoryOtherInfoVO.setType(1);
        tCategoryOtherInfoVO.setValue2("");
        tCategoryOtherInfoVO.setValueLong1(0);
        tCategoryOtherInfoVO.setValueLong2(0);

        dataManageMapper.insertTCategoryOtherInfo(tCategoryOtherInfoVO);
    }

    /**
     *
     * @param ctgKey 배너 카테고리 키
     * @param subjectCtgKey 과목 카테고리 카
     * @param teacherKey 강사 키
     * @param isNew 새창여부 (0 : OFF, 1: ON)
     * @param url (새창 URL)
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveTeacherBannerInfo(int ctgKey, int subjectCtgKey, int teacherKey, int isNew, String url) {
        TCategoryOtherInfoVO otherInfoVO = new TCategoryOtherInfoVO();
        Integer lastPosNum= dataManageMapper.selectTCategoryOtherInfoLastPosNumber(ctgKey);

        TUserVO userVO = userMapper.selectTeacherInfo(teacherKey);
        TCategoryVO subjectInfo = dataManageMapper.selectTCategoryInfoByCtgKey(subjectCtgKey);

        String teacherName = userVO.getName();
        String subjectName = subjectInfo.getName();
        String teacherBannerTitle = "[" + subjectName + "]" + teacherName;

        otherInfoVO.setCtgKey(ctgKey);
        otherInfoVO.setType(1);
        otherInfoVO.setValue1("");
        otherInfoVO.setValue2("");
        otherInfoVO.setValue3("");
        otherInfoVO.setValue4(Util.isNullValue(url, ""));
        otherInfoVO.setValue5(teacherBannerTitle);
        otherInfoVO.setValueLong1(subjectCtgKey);
        otherInfoVO.setValueLong2(teacherKey);
        otherInfoVO.setValueBit1(isNew);

        if (lastPosNum == null) {
            otherInfoVO.setPos(0);
        } else {
            otherInfoVO.setPos(lastPosNum + 1);
        }
        dataManageMapper.insertTCategoryOtherInfo(otherInfoVO);
        return otherInfoVO.getCtgInfoKey();
    }

    /**
     * 시험일정 등록하기
     * @param title
     * @param startDate
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveExamSchedule(String title, String startDate) {
        if ("".equals(title) && "".equals(startDate)) return;
        TScheduleVO tScheduleVO = new TScheduleVO(title, startDate);
        dataManageMapper.insertTSchedule(tScheduleVO);
    }

    /**
     * 검색어 저장하기
     * @param className
     * @param keyword
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveSearchKeyword(String className, String keyword) {
        if ("".equals(keyword) && "".equals(className)) return;
        TSearchKeywordVO tSearchKeywordVO = new TSearchKeywordVO(
                className.toLowerCase(),
                keyword,
                dataManageMapper.selectTSearchKeywordLastPosNumber(className.toLowerCase())
        );
        dataManageMapper.insertTSearchKeyword(tSearchKeywordVO);
    }

    /**
     * 배너관리 삭제하기
     * @param ctgInfoKey
     * @param ctgKey
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public List<ResultDTO> deleteBannerInfo(int ctgInfoKey, int ctgKey) {
        dataManageMapper.deleteTCategoryOtherInfo(ctgInfoKey);
        return this.getBannerList(ctgKey);
    }

    /**
     * 시험일정 삭제하기
     * @param scheduleKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteExamSchedule(int scheduleKey) {
        if (scheduleKey == 0) return;
        dataManageMapper.deleteTSchedule(scheduleKey);
    }

    /**
     * 검색어 삭제하기
     * @param searchKeywordKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteSearchkeyword(int searchKeywordKey) {
        if (searchKeywordKey == 0) return;
        dataManageMapper.deleteTSearchKeyword(searchKeywordKey);
    }

    /**
     * 분류관리, 과목관리 삭제
     * @param ctgKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteClassSubject(int ctgKey) {
        if (ctgKey == 0) return;
        dataManageMapper.deleteTCategory(ctgKey);
    }

    /**
     * 배너정보 수정하기
     * @param otherInfoVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyBannerDetailInfo(TCategoryOtherInfoVO otherInfoVO) {
        dataManageMapper.updateTCategoryOtherInfo(otherInfoVO);
    }

    /**
     * 배너 순서 변경
     * @param list
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void changeBannerPosition(List<TCategoryOtherInfoVO>list) {
        if (list.size() == 0) return;
        for (TCategoryOtherInfoVO vo : list) {
            dataManageMapper.changeBannerPosition(vo);
        }
    }

    /**
     * 시험일정 수정하기
     * @param tScheduleVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyExamSchedule(TScheduleVO tScheduleVO) {
        if (tScheduleVO.getScheduleKey() == 0) return;
        dataManageMapper.updateTSchedule(tScheduleVO);
    }

    /**
     * 검색어 수정하기
     * @param searchKeywordKey
     * @param keyword
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifySearchKeyword(int searchKeywordKey, String keyword) {
        if (searchKeywordKey == 0) return;
        dataManageMapper.updateTSearchKeyword(searchKeywordKey, keyword);
    }

    /**
     * 교수진 배너 수정하기
     * @param ctgInfoKey
     * @param subjectCtgKey
     * @param teacherKey
     * @param isNew
     * @param url
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int modifyTeacherBannerInfo(int ctgInfoKey, int subjectCtgKey, int teacherKey, int isNew, String url) {
        TCategoryOtherInfoVO otherInfoVO = new TCategoryOtherInfoVO();

        TUserVO userVO = userMapper.selectTeacherInfo(teacherKey);
        TCategoryVO subjectInfo = dataManageMapper.selectTCategoryInfoByCtgKey(subjectCtgKey);

        String teacherName = userVO.getName();
        String subjectName = subjectInfo.getName();
        String teacherBannerTitle = "[" + subjectName + "]" + teacherName;

        otherInfoVO.setCtgInfoKey(ctgInfoKey);
        otherInfoVO.setValue4(Util.isNullValue(url, ""));
        otherInfoVO.setValue5(teacherBannerTitle);
        otherInfoVO.setValueLong1(subjectCtgKey);
        otherInfoVO.setValueLong2(teacherKey);
        otherInfoVO.setValueBit1(isNew);

        dataManageMapper.updateTCategoryOtherInfoFromTeacherBanner(otherInfoVO);
        return otherInfoVO.getCtgInfoKey();
    }

}
