package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.CounselType;
import com.zianedu.lms.define.datasource.MemberGradeType;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.TCounselVO;
import com.zianedu.lms.vo.TUserSecessionVO;
import com.zianedu.lms.vo.TUserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MemberManageService {

    @Autowired
    private MemberManageMapper memberManageMapper;

    /**
     * 회원 선택 리스트 ( 쿠폰 목록 > 운영자 발급 > 회원에게 쿠폰 발급 시 )
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<MemberSelectListDTO> getMemberSelectList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<MemberSelectListDTO> list = memberManageMapper.selectMemberListBySelect(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
        if (list.size() > 0) {
            for (MemberSelectListDTO selectListDTO : list) {
                selectListDTO.setAuthorityStr(MemberAuthorityType.getMemberAuthorityTypeStr(selectListDTO.getAuthority()));
            }
        }
        return list;
    }

    /**
     * 회원 선택 리스트 개수 ( 회원에게 쿠폰 발급 시 )
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getMemberSelectListCount(String searchType, String searchText) {
        return memberManageMapper.selectMemberListBySelectCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
    }

    /**
     * 회원관리 > 회원목록 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @param regStartDate
     * @param regEndDate
     * @param grade
     * @param affiliationCtgKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<MemberListDTO> getMemeberList(int sPage, int listLimit, String searchType, String searchText,
                                              String regStartDate, String regEndDate, int grade, int affiliationCtgKey) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<MemberListDTO> list = memberManageMapper.selectTUserList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(regStartDate, ""),
                Util.isNullValue(regEndDate, ""),
                grade,
                affiliationCtgKey
        );
        if (list.size() > 0) {
            for (MemberListDTO memberListDTO : list) {
                memberListDTO.setGradeName(MemberGradeType.getMemberGradeStr(memberListDTO.getGrade()));
                memberListDTO.setAuthorityName(MemberAuthorityType.getMemberAuthorityTypeStr(memberListDTO.getAuthority()));
            }
        }
        return list;
    }

    /**
     * 회원관리 > 회원목록 리스트 개수
     * @param searchType
     * @param searchText
     * @param regStartDate
     * @param regEndDate
     * @param grade
     * @param affiliationCtgKey
     * @return
     */
    @Transactional(readOnly = true)
    public int getMemeberListCount(String searchType, String searchText, String regStartDate, String regEndDate,
                                                   int grade, int affiliationCtgKey) {
        return memberManageMapper.selectTUserListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(regStartDate, ""),
                Util.isNullValue(regEndDate, ""),
                grade,
                affiliationCtgKey
        );
    }

    /**
     * 회원관리 > 회원탈퇴 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<TUserSecessionVO> getMemeberSecessionList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<TUserSecessionVO> list = memberManageMapper.selectTUserSecessionList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
        return list;
    }

    /**
     * 회원관리 > 회원탈퇴 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getMemeberSecessionListCount(String searchType, String searchText) {
        return memberManageMapper.selectTUserSecessionListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
    }

    /**
     * 회원관리 > 회원 상세 > 상담내역 리스트
     * @param userKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<UserConsultListDTO> getUserCounselList(int userKey) {
        if (userKey == 0) return null;

        List<UserConsultListDTO>list = memberManageMapper.selectTCounselList(userKey);
        if (list.size() > 0) {
            for (UserConsultListDTO consultListDTO : list) {
                consultListDTO.setConsultTypeName(CounselType.getCounselTypeStr(consultListDTO.getType()));
            }
        }
        return list;
    }

    /**
     * 회원관리 > 회원탈퇴 신청목록 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<TUserSecessionVO> getMemeberSecessionApplyList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<TUserSecessionVO> list = memberManageMapper.selectTUserSecessionApplyList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
        return list;
    }

    /**
     * 회원관리 > 회원탈퇴 신청목록 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getMemeberSecessionApplyListCount(String searchType, String searchText) {
        return memberManageMapper.selectTUserSecessionApplyListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
    }

    /**
     * 회원관리 > 회원목록 > 회원 상세정보
     * @param userKey
     * @return
     */
    @Transactional(readOnly = true)
    public ResultDTO getMemberDetailInfo(int userKey) {
        if (userKey == 0) return null;
        ResultDTO resultDTO = new ResultDTO();
        resultDTO.setResult(memberManageMapper.selectTUserInfo(userKey));
        resultDTO.setResultList(this.getUserCounselList(userKey));

        return resultDTO;
    }

    /**
     * 회원 추가
     * @param tUserVO
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveMember(TUserVO tUserVO) throws Exception {
        TUserVO userVO = new TUserVO(tUserVO);
        return memberManageMapper.insertTUSer(userVO);
    }

    /**
     * 상담내역 등록
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveCounselInfo(TCounselVO tCounselVO) {
        if (tCounselVO.getUserKey() == 0) return;
        TUserVO tUserVO = memberManageMapper.selectTUserInfo(tCounselVO.getUserKey());

        if (tUserVO != null) {
            tCounselVO.setTelephone(tUserVO.getTelephone());
            tCounselVO.setTelephoneMobile(tUserVO.getTelephoneMobile());

            if (tCounselVO.getStatus() == 0) {
                tCounselVO.setProcStartDate("");
                tCounselVO.setProcEndDate("");
            } else if (tCounselVO.getStatus() == 1) {
                tCounselVO.setProcStartDate(Util.returnNow());
                tCounselVO.setProcEndDate("");
            } else if (tCounselVO.getStatus() == 2) {
                tCounselVO.setProcStartDate("");
                tCounselVO.setProcEndDate(Util.returnNow());
            }
            TCounselVO counselVO = new TCounselVO(tCounselVO);
            memberManageMapper.insertTCounsel(counselVO);
        }
    }



}
