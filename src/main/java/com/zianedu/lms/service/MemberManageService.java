package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.CounselType;
import com.zianedu.lms.define.datasource.MemberGradeType;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MemberManageService {

    @Autowired
    private MemberManageMapper memberManageMapper;

    @Autowired
    private ProductManageMapper productManageMapper;

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
     * 회원관리 > 상담내역 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<CounselListDTO> getCounselList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        List<CounselListDTO> list = memberManageMapper.selectTCounselListByPaging(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
        return list;
    }

    /**
     * 회원관리 > 상담내역 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getCounselListCount(String searchType, String searchText) {
        return memberManageMapper.selectTCounselListByPagingCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, "")
        );
    }

    /**
     * 강사목록 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @param regStartDate
     * @param regEndDate
     * @return
     */
    @Transactional(readOnly = true)
    public List<MemberListDTO> getTeacherList(int sPage, int listLimit, String searchType, String searchText,
                                              String regStartDate, String regEndDate) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<MemberListDTO> list = memberManageMapper.selectTeacherList(
                startNumber,
                listLimit,
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(regStartDate, ""),
                Util.isNullValue(regEndDate, "")
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
     * 강사목록 리스트 개수
     * @param searchType
     * @param searchText
     * @param regStartDate
     * @param regEndDate
     * @return
     */
    @Transactional(readOnly = true)
    public int getTeacherListCount(String searchType, String searchText, String regStartDate, String regEndDate) {
        return memberManageMapper.selectTeacherListCount(
                Util.isNullValue(searchText, ""),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(regStartDate, ""),
                Util.isNullValue(regEndDate, "")
        );
    }

    @Transactional(readOnly = true)
    public ResultDTO getTeacherDetailInfo(int userKey) {
        if (userKey == 0) return null;

        TTeacherVO teacherVO = memberManageMapper.selectTTeacherInfo(userKey);
        List<TResVO>list = productManageMapper.selectTResListByTeacherKey(teacherVO.getTeacherKey());

        return null;
    }

    /**
     * 회원 추가( 권한이 강사면 강사 테이블 추가 입력 )
     * @param tUserVO
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveMember(TUserVO tUserVO) throws Exception {
        TUserVO userVO = new TUserVO(tUserVO);
        Integer userKey = memberManageMapper.insertTUSer(userVO);
        if (userKey != null) {
            //강사면 강사 테이블 저장
            if (tUserVO.getAuthority() == 5) {
                memberManageMapper.insertTTeacher(userKey);
            }
        }
        return userKey;
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

    /**
     * 상담내역 수정하기
     * @param tCounselVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateCounselInfo(TCounselVO tCounselVO) {
        if (tCounselVO.getCounselKey() == 0) return;

        if (tCounselVO.getStatus() == 1) {
            tCounselVO.setProcStartDate(Util.returnNow());
            tCounselVO.setProcEndDate("");
        } else if (tCounselVO.getStatus() == 2) {
            tCounselVO.setProcStartDate("");
            tCounselVO.setProcEndDate(Util.returnNow());
        }

        TCounselVO counselVO = new TCounselVO(tCounselVO);
        memberManageMapper.updateTCounsel(counselVO);
    }




}
