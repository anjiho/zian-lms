package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.CounselType;
import com.zianedu.lms.define.datasource.MemberGradeType;
import com.zianedu.lms.define.datasource.SmsSendResultType;
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

import java.sql.SQLSyntaxErrorException;
import java.util.ArrayList;
import java.util.List;

@Service
public class MemberManageService {

    @Autowired
    private MemberManageMapper memberManageMapper;

    @Autowired
    private ProductManageMapper productManageMapper;

    @Autowired
    private DataManageService dataManageService;

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
        if (list.size() > 0) {
            for (CounselListDTO dto : list) {
                dto.setTypeName(CounselType.getCounselTypeStr(dto.getType()));
            }
        }
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

    /**
     * SMS 발송 리스트
     * @param sPage
     * @param listLimit
     * @param yyyyMM
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<SmsSendListDTO> getSmsSendList(int sPage, int listLimit, String yyyyMM, String searchType, String searchText) {
        if (sPage == 0 && "".equals(yyyyMM)) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        String tableName = "SC_LOG_" + yyyyMM;

        SmsSearchParamDTO paramDTO = new SmsSearchParamDTO(
                startNumber, listLimit, Util.isNullValue(tableName, ""), Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
                );
        List<SmsSendListDTO>list = new ArrayList<>();
        try {
            list = memberManageMapper.selectSmsSendLogList(paramDTO);
            if (list.size() > 0) {
                for (SmsSendListDTO smsSendListDTO : list) {
                    smsSendListDTO.setSendResultName(SmsSendResultType.getSmsSendResultStr(smsSendListDTO.getSendResult()));
                }
            }
        } catch (Exception e) {
            return null;
        }
        return list;
    }

    /**
     * SMS 발송 리스트 개수
     * @param yyyyMM
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getSmsSendListCount(String yyyyMM, String searchType, String searchText) {
        if ("".equals(yyyyMM)) return 0;

        int cnt = 0;
        String tableName = "SC_LOG_" + yyyyMM;
        SmsSearchParamDTO paramDTO = new SmsSearchParamDTO(
                Util.isNullValue(tableName, ""), Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
        try {
            cnt = memberManageMapper.selectSmsSendLogListCount(paramDTO);
        } catch (Exception e) {
            return 0;
        }
        return cnt;
    }

    /**
     * 강사 상세정보 가져오기
     * @param userKey
     * @return
     */
    @Transactional(readOnly = true)
    public TeacherDetailDTO getTeacherDetailInfo(int userKey) {
        if (userKey == 0) return null;

        TTeacherVO teacherVO = memberManageMapper.selectTTeacherInfo(userKey);
        List<TResVO>subjectGroupInfo = productManageMapper.selectTResListByTeacherKey(teacherVO.getTeacherKey());
        List<TLinkKeyVO>linkKeyList = memberManageMapper.selectTLinkKeyByTeacher(teacherVO.getTeacherKey());

        List<TeacherCategoryListDTO> teacherCategoryList = new ArrayList<>();
        List<List<TCategoryVO>> teacherCategoryInfo = new ArrayList<>();
        if (linkKeyList.size() > 0) {
            for (TLinkKeyVO tLinkKeyVO : linkKeyList) {
                List<TCategoryVO> tCategoryVOList = dataManageService.getSequentialCategoryList(tLinkKeyVO.getReqKey());
                //Collections.reverse(tCategoryVOList);
                teacherCategoryInfo.add(tCategoryVOList);

                TeacherCategoryListDTO dto = new TeacherCategoryListDTO();
                dto.setLinkKey(tLinkKeyVO.getLinkKey());
                dto.setTeacherCategoryInfo(tCategoryVOList);

                teacherCategoryList.add(dto);
            }
        }
        //teacherCategoryList.setTeacherCategoryInfo(teacherCategoryInfo);

        TeacherDetailDTO teacherDetailDTO = new TeacherDetailDTO(
                teacherVO,
                subjectGroupInfo,
                teacherCategoryList
        );
        return teacherDetailDTO;
    }

    /**
     * 강사 노출순서 리스트
     * @param academyKey
     * @return
     */
    @Transactional(readOnly = true)
    public List<TLinkKeyVO> getTeacherExposureNumberList(int academyKey) {
        if (academyKey == 0) return null;
        return memberManageMapper.selectNumberExposureTeacherList(academyKey);
    }

    /**
     * 상담내역 상세정보 가져오기
     * @param counselKey
     * @return
     */
    @Transactional(readOnly = true)
    public TCounselVO getCounselDetailInfo(int counselKey) {
        if (counselKey == 0) return null;
        return memberManageMapper.selectTCounselInfo(counselKey);
    }

    /**
     * 아이디 중복확인
     * @param userId
     * @return
     */
    @Transactional(readOnly = true)
    public boolean isUser(String userId) {
        if ("".equals(userId)) return false;
        int userCount = memberManageMapper.selectUserCountByUserId(userId);
        if (userCount > 0) {
            return false;
        }
        return true;
    }

    /**
     * 회원 추가( 권한이 강사면 강사 테이블 추가 입력 )
     * @param tUserVO
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveMember(TUserVO tUserVO, TTeacherVO tTeacherVO) throws Exception {
        TUserVO userVO = new TUserVO(tUserVO);
        memberManageMapper.insertTUSer(userVO);
        if (userVO.getUserKey() > 0) {
            //강사면 강사 테이블 저장
            if (tUserVO.getAuthority() == 5) {
                TTeacherVO vo = new TTeacherVO(
                        userVO.getUserKey(), Util.isNullValue(tTeacherVO.getImageList(), ""), Util.isNullValue(tTeacherVO.getImageTeacherList(), ""),
                        Util.isNullValue(tTeacherVO.getImageTeacherView(), ""), Util.isNullValue(tTeacherVO.getGreeting(), ""),
                        Util.isNullValue(tTeacherVO.getHistory(), ""), Util.isNullValue(tTeacherVO.getBookWriting(), ""),
                        tTeacherVO.getOnlinelecCalculateRate(), tTeacherVO.getOfflinelecCalculateRate(), Util.isNullValue(tTeacherVO.getSampleVodFile(), "")
                );
                memberManageMapper.insertTTeacher(vo);
            }
        }
        return userVO.getUserKey();
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
     * SMS 발송하기
     * @param sendDTOList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void sendSms(List<SmsSendDTO>sendDTOList) {
        if (sendDTOList.size() > 0) {
            for (SmsSendDTO sendDTO : sendDTOList) {
                String userName = "";
                String userId = "";
                //발송자의 키가 있을 때
                if (sendDTO.getUserKey() > 0) {
                    //발송자의 정보 조회
                    TUserVO userVO = memberManageMapper.selectTUserInfo(sendDTO.getUserKey());
                    if (userVO != null) {
                        //발송자의 이름, 아이디 객체에 담기
                        userName = userVO.getName();
                        userId = userVO.getUserId();
                    }
                }
                //입력 객체 생성
                ScTranVO scTranVO = new ScTranVO(
                        Util.isNullValue(sendDTO.getReceiverPhoneNumber(), ""),
                        Util.isNullValue(sendDTO.getSendNumber(), ""),
                        Util.isNullValue(sendDTO.getMsg(), ""),
                        Util.isNullValue(String.valueOf(sendDTO.getUserKey()), ""),
                        Util.isNullValue(userName, ""),
                        Util.isNullValue(userId, "")
                );
                //SMS발송 테이블 입력
                memberManageMapper.insertScTran(scTranVO);
            }
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
        counselVO.setCounselKey(tCounselVO.getCounselKey());

        memberManageMapper.updateTCounsel(counselVO);
    }

    /**
     * 강사 노출순서 순서변경하기
     * @param tLinkKeyVOList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateTeacherExposurePos(List<TLinkKeyVO>tLinkKeyVOList) {
        if (tLinkKeyVOList.size() > 0) {
            for (TLinkKeyVO tLinkKeyVO : tLinkKeyVOList) {
                memberManageMapper.updateTLinkKeyPos(
                        tLinkKeyVO.getLinkKey(), tLinkKeyVO.getPos()
                );
            }
        }
    }

    /**
     * 회원탈퇴 승인
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void approveSecession(int secessionKey) {
        if (secessionKey == 0) return;
        memberManageMapper.updateTUserSecessionObtainDate(secessionKey);
    }

    /**
     * 회원탈퇴 취소
     * @param secessionKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void cancelSecession(int secessionKey) {
        if (secessionKey == 0) return;
        memberManageMapper.deleteTUserSecession(secessionKey);
    }

    /**
     * 회원정보 수정
     * @param tUserVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateUserInfo(TUserVO tUserVO) {
        if (tUserVO.getUserKey() == 0) return;
        memberManageMapper.updateTUser(tUserVO);
    }

    /**
     * 강사정보 수정
     * @param tTeacherVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateTeacherInfo(TTeacherVO tTeacherVO) {
        if (tTeacherVO.getTeacherKey() == 0) return;
        memberManageMapper.updateTTeacher(tTeacherVO);
    }

    /**
     * 과목그룹별 설명내용 저장
     * @param tResVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void insertTResAtTeacherSubject(TResVO tResVO) {
        productManageMapper.insertTResAtTeacherSubject(tResVO);
    }

    /**
     * 강사 카테고리 저장
     * @param tLinkKeyVO
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void insertTeacherCategory(TLinkKeyVO tLinkKeyVO) {
        productManageMapper.insertTLinkKey(tLinkKeyVO);
    }

    /**
     * 강사 카테고리 삭제
     * @param linkKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteTeacherCategory(int linkKey) {
        if (linkKey == 0) return;
        productManageMapper.deleteTLinkKeyByLinkKey(linkKey);
    }

}
