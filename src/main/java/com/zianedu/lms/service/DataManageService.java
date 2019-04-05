package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.TCategoryParentKeyType;
import com.zianedu.lms.define.datasource.TCategoryKeyType;
import com.zianedu.lms.dto.ResultDTO;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import com.zianedu.lms.vo.TCategoryVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class DataManageService {

    static final Logger logger = LoggerFactory.getLogger(DataManageService.class);

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
            dataManageMapper.updateTCategoryOtherInfo(vo);
        }
    }



}
