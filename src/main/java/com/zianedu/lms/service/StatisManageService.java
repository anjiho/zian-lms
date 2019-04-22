package com.zianedu.lms.service;

import com.google.common.primitives.Ints;
import com.zianedu.lms.dto.StatisResultDTO;
import com.zianedu.lms.mapper.StatisManageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class StatisManageService {

    @Autowired
    private StatisManageMapper statisManageMapper;

    /**
     * 월별 통계
     * @param searchYear
     * @return
     */
    @Transactional(readOnly = true)
    public int[] getTotalStatisAtMonth(String searchYear) {
        if ("".equals(searchYear)) return null;
        List<Integer>result = new ArrayList<>();
        List<StatisResultDTO> list = statisManageMapper.selectTotalStatisAtMonth(searchYear);
        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Integer price = Integer.parseInt(resultDTO.getPrice());
                result.add(price);
            }
        }
        int[] arr = Ints.toArray(result);
        return arr;
    }

    @Transactional(readOnly = true)
    public int[] getTotalStatisAtYear() {
        List<Integer>result = new ArrayList<>();
        List<StatisResultDTO> list = statisManageMapper.selectTotalStatisAtYear();
        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Integer price = Integer.parseInt(resultDTO.getPrice());
                result.add(price);
            }
        }
        int[] arr = Ints.toArray(result);
        return arr;
    }


}
