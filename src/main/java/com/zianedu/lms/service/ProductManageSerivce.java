package com.zianedu.lms.service;

import com.zianedu.lms.dto.PagingSearchDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductManageSerivce extends PagingSupport {

    @Autowired
    private ProductManageMapper productManageMapper;

    @Transactional(readOnly = true)
    public List<VideoListDTO> getVideoList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;
        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        PagingSearchDTO searchDTO = new PagingSearchDTO(
                startNumber, listLimit, searchType, searchType
        );
        return productManageMapper.selectVideoList(searchDTO);
    }
}
