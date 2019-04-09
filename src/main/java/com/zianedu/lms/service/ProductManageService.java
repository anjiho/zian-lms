package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.dto.PagingSearchDTO;
import com.zianedu.lms.dto.VideoDetailInfoDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.vo.*;
import oracle.net.aso.g;
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
     * 동영상 목록 가져오기
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<VideoListDTO> getVideoList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        PagingSearchDTO searchDTO = new PagingSearchDTO(
                startNumber, listLimit, searchType, searchText
        );
        return productManageMapper.selectVideoList(startNumber, listLimit, searchText, searchType);
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
     * 상품기본정보 저장하기
     * @param tGoodsVO
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Integer saveGoodsInfo(TGoodsVO tGoodsVO) {
        if (tGoodsVO == null) return null;
        productManageMapper.insertTGoods(tGoodsVO);
        return tGoodsVO.getGKey();
    }

}
