package com.zianedu.lms.repository;

import com.zianedu.lms.dto.CalculateInfoDTO;

import java.util.List;

public interface TeacherCalculateRepository {

    void calculateTeacherSaleGoodsAny(String yyyymmdd) throws Exception;

    //List<> calculateTeacherSaleGoodsContain(List<>)
}
