package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.*;
import com.zianedu.lms.dto.SelectboxDTO;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.mapper.SelectboxMapper;
import com.zianedu.lms.vo.SearchKeywordDomainVO;
import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TGoodTeacherLinkVO;
import com.zianedu.lms.vo.TSiteVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class SelectboxService {

    @Autowired
    private SelectboxMapper selectboxMapper;

    @Autowired
    private DataManageMapper dataManageMapper;

    /**
     * 서브도메인 목록 가져오기
     * @return
     */
    @Transactional(readOnly = true)
    public List<TSiteVO> getSubDomainList() {
        return selectboxMapper.selectSubDomainList();
    }

    /**
     * 검색어 도메인 목록 가져오기
     * @return
     */
    public List<SearchKeywordDomainVO> getSearchKeywordDomainList() {
        return SearchKeywordType.getSearchKeywordDomainList();
    }

    /**
     * 카테고리 트리구조의 셀렉트박스 가져오기
     * @param ctgKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryVO> getCategoryList(int ctgKey) {
        if (ctgKey == 0) return null;
        return selectboxMapper.selectTCategoryByParentKey(ctgKey);
    }

    /**
     * 동영상 검색에서 검색종류 가져오기
     * @return
     */
    public List<SelectboxDTO> getVideoSearchTypeList() {
        return VideoSearchType.getVideoSeaerchTypeList();
    }

    /**
     * 옵션명 선택하는 셀렉트박스 가져오기
     * @return
     */
    public List<SelectboxDTO> getVideoOptionTypeList() {
        return GoodsKindType.getGoodsOptionKindSelectbox();
    }

    /**
     * 강조표시 셀렉트박스 가져오기
     * @return
     */
    public List<SelectboxDTO> getEmphasisList() {
        return EmphasisType.getEmphasisSelectbox();
    }

    /**
     * 동영상 목록 강좌정보안의 (급수(4309), 과목(70), 유형(202)) 셀렉트박스
     * @param ctgKey ({@link TCategoryParentKeyType} 클래스에 정의
     * @return
     */
    @Transactional(readOnly = true)
    public List<SelectboxDTO> getSelectboxListForCtgKey(int ctgKey) {
        List<SelectboxDTO>selectboxDTOList = new ArrayList<>();
        List<TCategoryVO>list = dataManageMapper.selectTCategoryList(ctgKey);
        for (TCategoryVO tCategoryVO : list) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    tCategoryVO.getCtgKey(), tCategoryVO.getName()
            );
            selectboxDTOList.add(selectboxDTO);
        }
        return selectboxDTOList;
    }

    /**
     * 동영상 목록 강좌정보안의 진행상태 셀렉트박스
     * @return
     */
    public List<SelectboxDTO>getLectureStatusSelectbox() {
        return LectureStatusType.getLectureStatusSelectbox();
    }

    /**
     * 강좌수, 강좌시간 셀렉트박스
     * @return
     */
    public List<Integer>getLectureCountSelectbox() {
        int startNum = ZianCoreManage.LECTURE_COUNT_START_END[0];
        int endNum = ZianCoreManage.LECTURE_COUNT_START_END[1];
        List<Integer>list = new ArrayList<>();
        for (int i = startNum; i <= endNum; i++) {
            list.add(i);
        }
        return list;
    }

    /**
     * 수강일수 셀렉트박스
     * @return
     */
    public List<Integer>getClassRegistraionDaySelectbox() {
        int startNum = ZianCoreManage.CLASS_REGISTRATION_START_END[0];
        int endNum = ZianCoreManage.CLASS_REGISTRATION_START_END[1];
        List<Integer>list = new ArrayList<>();
        for (int i = startNum; i <= endNum; i++) {
            list.add(i);
        }
        return list;
    }

    /**
     * 시험대비년도 셀렉트박스
     * @return
     */
    public List<Integer>getExamPrepareSelectbox() {
        int startNum = ZianCoreManage.EXAM_PREPARE_YEAR[0];
        int endNum = ZianCoreManage.EXAM_PREPARE_YEAR[1];
        List<Integer>list = new ArrayList<>();
        for (int i = startNum; i <= endNum; i++) {
            list.add(i);
        }
        return list;
    }

    /**
     * 선생님 전체 목록 셀렉트박스
     * @return
     */
    @Transactional(readOnly = true)
    public List<TGoodTeacherLinkVO>selectTeacherSelectbox() {
        return dataManageMapper.selectTeacherList();
    }

    /**
     * 모의고사 검색시 검색 종류 셀렉트박스
     * @return
     */
    public List<SelectboxDTO>selectExamSearchSelectbox() {
        return ExamSearhType.getExamSearchTypeList();
    }

    /**
     * 모의고사 문제은행 문제 목록 > "유형" 셀렉트박스
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryVO>selectTypeSelectbox() {
        return dataManageMapper.selectTypeList(4397, 4399, 4400);
    }

    /**
     * 모의고사 문제은행 문제 목록 > "패턴" 셀렉트박스
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryVO>selectPatternSelectbox() {
        return dataManageMapper.selectTypeList(4406, 4407, 4408);
    }

    /**
     * 모의고사 문제은행 문제 목록 > "단원" > 대단원 선택 셀렉트박스
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryVO>selectUnitSelectbox() {
        return dataManageMapper.selectUnitList();
    }

    /**
     * 모의고사 문제은행 문제 > 난이도 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectExamLevelSelectbox() {
        return ExamLevelType.getExamLevelStrSelectbox();
    }

    /**
     * 쿠폰 목록 > 할인설정 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectCouponDiscountSelectbox() {
        return CouponDcType.getCouponDcTypeSelectbox();
    }

    /**
     * 쿠폰 목록 > 지급방식 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectCouponIssueSelectbox() {
        return CouponIssueType.getCouponIssueTypeSelectbox();
    }

    /**
     * 쿠폰 목록 > 사용기간 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectCouponPeriodTypeSelectbox() {
        return CouponPeriodType.getCouponPeriodTypeSelectbox();
    }

    /**
     * 쿠폰 목록 > 사용가능 디바이스 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectDeviceTypeSelectbox() {
        return DeviceType.getDeviceTypeSelectbox();
    }

    /**
     * 쿠폰 > 회원 검색 시 조건 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectMemberSearchTypeSelectbox() {
        return MemberSearchType.getMemberSearchTypeList();
    }

    /**
     * 회원 목록 > 회원등급 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectMemberGradeTypeSelectbox() {
        return MemberGradeType.getMemberGradeTypeList();
    }

    /**
     * 회원 목록 > 검색어 조건 셀렉트 박스
     * @return
     */
    public List<SelectboxDTO>selectMemberMainSearchTypeSelectbox() {
        return MemberMainSearchType.getMemberMainSearchTypeList();
    }

}
