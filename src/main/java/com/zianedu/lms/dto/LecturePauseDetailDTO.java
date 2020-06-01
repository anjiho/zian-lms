package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TOrderDeliveryVO;
import com.zianedu.lms.vo.TUserVO;
import lombok.Data;

import java.util.List;

@Data
public class LecturePauseDetailDTO {

    private List<LecturePauseRecDTO> pauseRec;

    private LecturePauseRecDTO lecturePauseDetail;


    public LecturePauseDetailDTO(){}

    public LecturePauseDetailDTO(List<LecturePauseRecDTO> pauseRec, LecturePauseRecDTO lecturePauseDetail) {
        this.pauseRec = pauseRec;
        this.lecturePauseDetail = lecturePauseDetail;
    }
}
