package com.zianedu.lms.controller;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.zianedu.lms.config.ConfigHolder;
import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.dto.VideoDetailInfoDTO;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.service.DataManageService;
import com.zianedu.lms.service.ProductManageService;
import com.zianedu.lms.utils.FileUploadUtil;
import com.zianedu.lms.utils.GsonUtil;
import com.zianedu.lms.utils.JsonBuilder;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import com.zianedu.lms.vo.TGoodsVO;
import org.apache.http.HttpStatus;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "file")
public class FileUploadController {

    @Autowired
    private DataManageService dataManageService;

    @Autowired
    private ProductManageService productManageService;

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
        if (uploadInfoMap.get("filePath")== null) filePath = "";

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

    @RequestMapping(value = "/videoImgUpload", method = RequestMethod.POST)
    public @ResponseBody String videoImgUpload(MultipartHttpServletRequest request, @RequestParam(value = "videoInfo") String videoInfo) throws Exception {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, ConfigHolder.getFileUploadPath(), "VIDEO");

        String imageList = uploadInfoMap.get("imageListFilePath").toString();
        String imageView = uploadInfoMap.get("imageViewFilePath").toString();

        JsonObject object = GsonUtil.conertStringToJsonObj(videoInfo);
        Gson gson = new Gson();
        TGoodsVO tGoodsVO = gson.fromJson(object, TGoodsVO.class);

        productManageService.upsultGoodsInfo(tGoodsVO, imageList, imageView);

        return new JsonBuilder().add("result", ZianCoreManage.OK).build();
    }
}
