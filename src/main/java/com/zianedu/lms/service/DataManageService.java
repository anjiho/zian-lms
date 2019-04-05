package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.TCategoryParentKeyType;
import com.zianedu.lms.define.datasource.TCategotyKeyType;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import com.zianedu.lms.vo.TCategoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DataManageService {

    @Autowired
    private DataManageMapper dataManageMapper;

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
     * 상단 대 배너 리스트 가져오기(key : ctgKey)
     * @param categoryStr (TCategoryKeyType ENUM 정의)
     * @return
     */
    @Transactional(readOnly = true)
    public List<TCategoryOtherInfoVO> getMainBannerList(String categoryStr) {
        return dataManageMapper.selectTCategoryOtherInfoList(TCategotyKeyType.getCtgKey(categoryStr));
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
        dataManageMapper.insertClassficationTCategoryInfo(ctgName, lastPosNum + 1);
        return dataManageMapper.selectTCategoryList(TCategoryParentKeyType.getParentKey(categoryTypeStr));
    }



}
