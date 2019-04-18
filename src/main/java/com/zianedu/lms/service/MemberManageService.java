package com.zianedu.lms.service;

import com.zianedu.lms.dto.MemberAuthorityType;
import com.zianedu.lms.dto.MemberSelectListDTO;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
                selectListDTO.setAuthorityStr(MemberAuthorityType.getMemberAuthoriTypeStr(selectListDTO.getAuthority()));
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

}
