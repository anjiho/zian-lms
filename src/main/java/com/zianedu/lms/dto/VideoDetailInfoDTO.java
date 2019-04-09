package com.zianedu.lms.dto;

import com.zianedu.lms.vo.*;
import lombok.Data;

import java.util.List;

@Data
public class VideoDetailInfoDTO {

    private TGoodsVO videoInfo;

    private List<TGoodsPriceOptionVO> videoOptionInfo;

    private List<List<TCategoryVO>> videoCategoryInfo;

    private TLecVO videoLectureInfo;

    private List<TGoodTeacherLinkVO> videoTeacherInfo;

    private List<TLinkKeyVO> videoOtherInfo;

    private List<TLecCurri> videoLectureCurriInfo;

    public VideoDetailInfoDTO(){}

    public VideoDetailInfoDTO(TGoodsVO videoInfo, List<TGoodsPriceOptionVO>videoOptionInfo,
                              List<List<TCategoryVO>>videoCategoryInfo, TLecVO videoLectureInfo,
                              List<TGoodTeacherLinkVO> videoTeacherInfo, List<TLinkKeyVO> videoOtherInfo,
                              List<TLecCurri> videoLectureCurriInfo) {
        this.videoInfo = videoInfo;
        this.videoOptionInfo = videoOptionInfo;
        this.videoCategoryInfo = videoCategoryInfo;
        this.videoLectureInfo = videoLectureInfo;
        this.videoTeacherInfo = videoTeacherInfo;
        this.videoOtherInfo = videoOtherInfo;
        this.videoLectureCurriInfo = videoLectureCurriInfo;
    }
}
