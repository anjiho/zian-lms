package com.zianedu.lms.controller;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.service.DataManageService;
import com.zianedu.lms.utils.FileUploadUtil;
import com.zianedu.lms.utils.JsonBuilder;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.Map;

@Controller
@RequestMapping(value = "file")
public class FileUploadController {

    //private static final String BANNER_FILE_UPLOAD_ROOT = "C:\\fileServer\\100\\main";
    //private static final String BANNER_FILE_UPLOAD_ROOT = "/Users/jihoan/Documents";
    private static final String BANNER_FILE_UPLOAD_ROOT = "C:\\Users\\won\\Documents\\ejwon";

    @Autowired
    private DataManageService dataManageService;

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
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, BANNER_FILE_UPLOAD_ROOT, "BANNER");
        TCategoryOtherInfoVO tCategoryOtherInfoVO = new TCategoryOtherInfoVO(
                Integer.parseInt(ctgKey),
                Util.isNullValue(String.valueOf(uploadInfoMap.get("filePath")), ""),
                value3,
                value4,
                value5,
                Integer.parseInt(valueBit1),
                Integer.parseInt(pos)

        );
        if ("".equals(ctgInfoKey)) {
            dataManageService.saveBannerInfo(tCategoryOtherInfoVO);
        } else {
            tCategoryOtherInfoVO.setCtgInfoKey(Integer.parseInt(ctgInfoKey));
            if (uploadInfoMap.get("filePath") == null) tCategoryOtherInfoVO.setValue1("");
            dataManageService.modifyBannerDetailInfo(tCategoryOtherInfoVO);
        }
        return new JsonBuilder().add("result", ZianCoreManage.OK).build();
    }
}
