package com.zianedu.lms.controller;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.mapper.DataManageMapper;
import com.zianedu.lms.service.DataManageService;
import com.zianedu.lms.utils.FileUploadUtil;
import com.zianedu.lms.utils.JsonBuilder;
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

    //private static final String FILE_UPLOAD_ROOT = "C:/imageFiles";
    private static final String FILE_UPLOAD_ROOT = "/Users/jihoan/Documents";

    private static final String INSERT = "INSERT";

    private static final String UPDATE = "UPDATE";

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
     * @param regType (등록 : INSERT, 수정 : UPDATE)
     * @return
     */
    @RequestMapping(value = "/bannerUpload/{regType}", method = RequestMethod.POST)
    public @ResponseBody String bannerUpload(MultipartHttpServletRequest request, @RequestParam(value = "ctgKey") String ctgKey,
                                             @RequestParam(value = "value3") String value3, @RequestParam(value = "value4") String value4,
                                             @RequestParam(value = "value5") String value5, @RequestParam(value = "valueBit1") String valueBit1,
                                             @PathVariable(value = "regType") String regType) {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUpload(request, FILE_UPLOAD_ROOT, "BANNER");
        if (uploadInfoMap.get("filePath") != null) {
            TCategoryOtherInfoVO tCategoryOtherInfoVO = new TCategoryOtherInfoVO(
                    Integer.parseInt(ctgKey),
                    String.valueOf(uploadInfoMap.get("filePath")),
                    value3,
                    value4,
                    value5,
                    Integer.parseInt(valueBit1)
            );
            if (INSERT.equals(regType)) {
                dataManageService.saveBannerInfo(tCategoryOtherInfoVO);
            } else if (UPDATE.equals(regType)) {
                dataManageService.modifyBannerDetailInfo(tCategoryOtherInfoVO);
            }

            return new JsonBuilder().add("result", ZianCoreManage.OK).build();
        }
        return new JsonBuilder().add("result", null).build();
    }
}
