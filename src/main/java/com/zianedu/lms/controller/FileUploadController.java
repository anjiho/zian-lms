package com.zianedu.lms.controller;

import com.google.gson.*;
import com.zianedu.lms.config.ConfigHolder;
import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.repository.ProductManageRepository;
import com.zianedu.lms.service.DataManageService;
import com.zianedu.lms.utils.FileUploadUtil;
import com.zianedu.lms.utils.GsonUtil;
import com.zianedu.lms.utils.JsonBuilder;
import com.zianedu.lms.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "file")
public class FileUploadController {

    @Autowired
    private DataManageService dataManageService;

    @Autowired
    private ProductManageRepository productManageRepository;

    /**
     * 배너관리 등록및 수정
     * @param request
     * @param ctgKey
     * @param value3
     * @param value4
     * @param value5
     * @param valueBit1
     * @return
     */
    @RequestMapping(value = "/bannerUpload", method = RequestMethod.POST)
    public @ResponseBody String bannerUpload(MultipartHttpServletRequest request, @RequestParam(value = "ctgKey") String ctgKey,
                                             @RequestParam(value = "value3") String value3, @RequestParam(value = "value4") String value4,
                                             @RequestParam(value = "value5") String value5, @RequestParam(value = "valueBit1") String valueBit1,
                                             @RequestParam(value = "ctgInfoKey") String ctgInfoKey, @RequestParam(value = "pos") String pos) {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, ConfigHolder.getFileUploadPath(), "BANNER");
        String filePath = null;
        if (uploadInfoMap.get("filePath")== null) {
            filePath = "";
        } else {
            filePath = uploadInfoMap.get("filePath").toString();
        }

        TCategoryOtherInfoVO tCategoryOtherInfoVO = new TCategoryOtherInfoVO(
                Integer.parseInt(ctgKey),
                //Util.isNullValue(String.valueOf(uploadInfoMap.get("filePath")), ""),
                filePath,
                value3,
                value4,
                value5,
                Integer.parseInt(valueBit1),
                Integer.parseInt(pos)

        );
        if (Integer.parseInt(ctgInfoKey) == 0) {
            dataManageService.saveBannerInfo(tCategoryOtherInfoVO);
        } else {
            tCategoryOtherInfoVO.setCtgInfoKey(Integer.parseInt(ctgInfoKey));
            if (uploadInfoMap.get("filePath") == null) tCategoryOtherInfoVO.setValue1("");
            dataManageService.modifyBannerDetailInfo(tCategoryOtherInfoVO);
        }
        return new JsonBuilder().add("result", ZianCoreManage.OK).build();
    }

    /**
     * 동영상 등록, 학원강의 등록
     * @param request
     * @param videoInfo
     * @param videoOptionInfo
     * @param videoCategoryInfo
     * @param videoLectureInfo
     * @param videoTeacherInfo
     * @param videoOtherInfo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/productUpload", method = RequestMethod.POST)
    public @ResponseBody String videoImgUpload(MultipartHttpServletRequest request, @RequestParam(value = "videoInfo") String videoInfo,
                                               @RequestParam(value = "videoOptionInfo") String videoOptionInfo,
                                               @RequestParam(value = "videoCategoryInfo") String videoCategoryInfo,
                                               @RequestParam(value = "videoLectureInfo") String videoLectureInfo,
                                               @RequestParam(value = "videoTeacherInfo") String videoTeacherInfo,
                                               @RequestParam(value = "videoOtherInfo") String videoOtherInfo) throws Exception {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, ConfigHolder.getFileUploadPath(), "VIDEO");

        String imageListFilePath = null;
        String imageViewFilePath = null;

        if (uploadInfoMap.get("imageListFilePath")== null) imageListFilePath = "";
        if (uploadInfoMap.get("imageViewFilePath")== null) imageViewFilePath = "";
        //동영상 기본정보 정보
        JsonObject videoInfoJson = GsonUtil.convertStringToJsonObj(videoInfo);
        Gson gson = new Gson();
        TGoodsVO tGoodsVO = gson.fromJson(videoInfoJson, TGoodsVO.class);

        //동영상 옵션 정보
        JsonArray videoOptionInfoJson = GsonUtil.convertStringToJsonArray(videoOptionInfo);
        List<TGoodsPriceOptionVO>tGoodsPriceOptionVOList = GsonUtil.getObjectFromJsonArray(videoOptionInfoJson, TGoodsPriceOptionVO.class);

        //동영상 카테코리 정보
        JsonArray videoCategoryInfoJson = GsonUtil.convertStringToJsonArray(videoCategoryInfo);
        List<TCategoryGoods>tCategoryVOList = GsonUtil.getObjectFromJsonArray(videoCategoryInfoJson, TCategoryGoods.class);

        //동영상 강좌 정보
        JsonObject videoLectureInfoJson = GsonUtil.convertStringToJsonObj(videoLectureInfo);
        Gson gson2 = new Gson();
        TLecVO tLecVO = gson2.fromJson(videoLectureInfoJson, TLecVO.class);

        //동영상 강사 정보
        JsonArray videoTeacherInfoJson = GsonUtil.convertStringToJsonArray(videoTeacherInfo);
        List<TGoodTeacherLinkVO>tGoodTeacherLinkVOS = GsonUtil.getObjectFromJsonArray(videoTeacherInfoJson, TGoodTeacherLinkVO.class);

        //전범위, 기출문제, 강의교재, 사은품 정보
        JsonArray videoOtherInfoJson = GsonUtil.convertStringToJsonArray(videoOtherInfo);
        List<TLinkKeyVO>tLinkKeyVOList = GsonUtil.getObjectFromJsonArray(videoOtherInfoJson, TLinkKeyVO.class);

        Integer gKey = productManageRepository.saveProductInfo(tGoodsVO, tGoodsPriceOptionVOList, tCategoryVOList,
                tLecVO, tGoodTeacherLinkVOS, tLinkKeyVOList, imageListFilePath, imageViewFilePath);


        return new JsonBuilder().add("result", gKey).build();
    }

    /**
     * 동영상 강의 입력에서 강의자료 파일 업로드
     * @param request
     * @return
     */
    @RequestMapping(value = "/videoDataFileUpload", method = RequestMethod.POST)
    public @ResponseBody String lectureCurriInfo(MultipartHttpServletRequest request) {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, ConfigHolder.getFileUploadPath(), "CURRI");
        return new JsonBuilder().add("result", uploadInfoMap.get("dataFilePath")).build();
    }

    /**
     * 도서 미리보기 파일업로드
     * @param request
     * @return
     */
    @RequestMapping(value = "/previewFileUpload", method = RequestMethod.POST)
    public @ResponseBody String previewFileUpload(MultipartHttpServletRequest request) {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, ConfigHolder.getFileUploadPath(), "PREVIEW");
        return new JsonBuilder().add("result", uploadInfoMap.get("previewFilePath")).build();
    }
}
