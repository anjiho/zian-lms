package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TCategoryVO;
import lombok.Data;

import java.util.List;

@Data
public class TeacherCategoryListDTO {

    private int linkKey;

    List<TCategoryVO> teacherCategoryInfo;
}
