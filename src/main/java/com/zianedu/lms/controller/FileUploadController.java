package com.zianedu.lms.controller;

import com.zianedu.lms.config.ConfigHolder;
import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.dto.VideoDetailInfoDTO;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.service.DataManageService;
import com.zianedu.lms.service.ProductManageService;
import com.zianedu.lms.utils.FileUploadUtil;
import com.zianedu.lms.utils.JsonBuilder;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import org.apache.http.HttpStatus;
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
        TCategoryOtherInfoVO tCategoryOtherInfoVO = new TCategoryOtherInfoVO(
                Integer.parseInt(ctgKey),
                Util.isNullValue(String.valueOf(uploadInfoMap.get("filePath")), ""),
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
    public @ResponseBody String videoImgUpload(MultipartHttpServletRequest request, @RequestBody VideoDetailInfoDTO videoDetailInfoDTO) {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, ConfigHolder.getFileUploadPath(), "VIDEO");

        return new JsonBuilder().add("result", ZianCoreManage.OK).build();
    }
}
