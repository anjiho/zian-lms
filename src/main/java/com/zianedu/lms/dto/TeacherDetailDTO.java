package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TResVO;
import com.zianedu.lms.vo.TTeacherVO;
import lombok.Data;

import java.util.List;

@Data
public class TeacherDetailDTO {

    TTeacherVO teacherInfo;

    List<TResVO> subjectGroupInfo;

    List<List<TCategoryVO>> teacherCategoryInfo;

    public TeacherDetailDTO(){}

    public TeacherDetailDTO(TTeacherVO teacherInfo, List<TResVO> subjectGroupInfo, List<List<TCategoryVO>> teacherCategoryInfo) {
        this.teacherInfo = teacherInfo;
        this.subjectGroupInfo = subjectGroupInfo;
        this.teacherCategoryInfo = teacherCategoryInfo;
    }
}
