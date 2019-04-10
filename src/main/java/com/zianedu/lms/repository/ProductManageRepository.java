package com.zianedu.lms.repository;

import com.zianedu.lms.service.ProductManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductManageRepository {

    @Autowired
    private ProductManageService productManageService;


}
