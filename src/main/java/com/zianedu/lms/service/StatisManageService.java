package com.zianedu.lms.service;

import com.google.common.base.Strings;
import com.google.common.primitives.Ints;
import com.google.common.primitives.Longs;
import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.dto.StatisResultDTO;
import com.zianedu.lms.mapper.StatisManageMapper;
import com.zianedu.lms.utils.StringUtils;
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
     * 전체 결제 월별 통계
     * @param searchYear(YYYY)
     * @return
     * 차트 :  https://www.highcharts.com/demo/line-labels
     */
    @Transactional(readOnly = true)
    public int[] getTotalStatisAtMonth(String searchYear, String goodsTypeStr) {
        if ("".equals(searchYear)) return null;

        List<Integer>result = new ArrayList<>();
        List<StatisResultDTO> list = statisManageMapper.selectTotalStatisAtMonth(searchYear, GoodsType.getGoodsTypeKey(goodsTypeStr));
        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Integer price = Integer.parseInt(resultDTO.getPrice());
                result.add(price);
            }
        }
        int[] arr = Ints.toArray(result);
        return arr;
    }

    /**
     * 전체 결제 년도별 통계
     * @return
     * 차트 : https://www.highcharts.com/demo/line-basic
     */
    @Transactional(readOnly = true)
    public StatisResultDTO getTotalStatisAtYear(String goodsTypeStr) {
        List<StatisResultDTO> list = statisManageMapper.selectTotalStatisAtYear(GoodsType.getGoodsTypeKey(goodsTypeStr));
        List<String>yearList = new ArrayList<>();
        List<Long>priceList = new ArrayList<>();

        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                String year = resultDTO.getDay();
                Long price = Long.parseLong(resultDTO.getPrice());

                yearList.add(year);
                priceList.add(price);
            }
        }
        String[] years = StringUtils.arrayListToStringArray(yearList);
        long[] prices  = Longs.toArray(priceList);

        return new StatisResultDTO(years, prices);
    }

    /**
     * 전체 결제 일별 통계
     * @param yyyyMM
     * 차트 : https://www.highcharts.com/demo/line-basic
     */
    @Transactional(readOnly = true)
    public StatisResultDTO getTotalStatisAtDay(String yyyyMM, String goodsTypeStr) {
        if ("".equals(yyyyMM)) return null;

        List<StatisResultDTO> list = statisManageMapper.selectTotalStatisAtYearDay(yyyyMM, GoodsType.getGoodsTypeKey(goodsTypeStr));
        List<Long>priceList = new ArrayList<>();

        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Long price = Long.parseLong(resultDTO.getPrice());
                priceList.add(price);
            }
        }
        long[] prices = Longs.toArray(priceList);
        return new StatisResultDTO(prices);
    }

}
