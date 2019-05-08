package com.zianedu.lms.repository;

import com.zianedu.lms.dto.CalculateInfoDTO;

import java.util.List;

public interface TeacherCalculateRepository {

    void calculateTeacherSaleGoodsAny(String yyyymmdd, int teacherKey) throws Exception;

    //List<> calculateTeacherSaleGoodsContain(List<>)
}
