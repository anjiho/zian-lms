package com.zianedu.lms.service;

import com.google.common.base.Strings;
import com.google.common.primitives.Ints;
import com.google.common.primitives.Longs;
import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.define.datasource.PromotionPmType;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.StatisManageMapper;
import com.zianedu.lms.repository.GoodsKindNameRepository;
import com.zianedu.lms.utils.StringUtils;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.utils.ZianUtils;
import com.zianedu.lms.vo.TCalculateOptionVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class StatisManageService {

    final static Logger logger = LoggerFactory.getLogger(StatisManageService.class);

    @Autowired
    private StatisManageMapper statisManageMapper;

    @Autowired
    private GoodsKindNameRepository goodsKindNameRepository;

    /**
     * 전체 결제 월별 통계
     * @param searchYear(YYYY)
     * @return
     * 차트 :  https://www.highcharts.com/demo/line-labels
     */
    @Transactional(readOnly = true)
    public StatisResultDTO getTotalStatisAtMonth(String searchYear) {
        if ("".equals(searchYear)) return null;

        List<Integer>totalResult = new ArrayList<>();
        List<Integer>videoResult = new ArrayList<>();
        List<Integer>academyResult = new ArrayList<>();
        List<Integer>bookResult = new ArrayList<>();

        List<StatisResultDTO> list = statisManageMapper.selectTotalStatisAtMonth(searchYear, GoodsType.getGoodsTypeKey("ALL"));
        List<StatisResultDTO> videoList = statisManageMapper.selectTotalStatisAtMonth(searchYear, GoodsType.getGoodsTypeKey("VIDEO"));
        List<StatisResultDTO> academyList = statisManageMapper.selectTotalStatisAtMonth(searchYear, GoodsType.getGoodsTypeKey("ACADEMY"));
        List<StatisResultDTO> bookList = statisManageMapper.selectTotalStatisAtMonth(searchYear, GoodsType.getGoodsTypeKey("BOOK"));

        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Integer totalPrice = Integer.parseInt(resultDTO.getPrice());
                totalResult.add(totalPrice);
            }
        }
        if (videoList.size() > 0) {
            for (StatisResultDTO resultDTO : videoList) {
                Integer videoPrice = Integer.parseInt(resultDTO.getPrice());
                videoResult.add(videoPrice);
            }
        }
        if (academyList.size() > 0) {
            for (StatisResultDTO resultDTO : academyList) {
                Integer academyPrice = Integer.parseInt(resultDTO.getPrice());
                academyResult.add(academyPrice);
            }
        }
        if (bookList.size() > 0) {
            for (StatisResultDTO resultDTO : bookList) {
                Integer bookPrice = Integer.parseInt(resultDTO.getPrice());
                bookResult.add(bookPrice);
            }
        }

        long[] totalPrices = Longs.toArray(totalResult);
        long[] videoPrices = Longs.toArray(videoResult);
        long[] academyPrices = Longs.toArray(academyResult);
        long[] bookPrices = Longs.toArray(bookResult);

        return new StatisResultDTO(totalPrices, videoPrices, academyPrices, bookPrices);
    }

    /**
     * 전체 결제 년도별 통계
     * @return
     * 차트 : https://www.highcharts.com/demo/line-basic
     */
    @Transactional(readOnly = true)
    public StatisResultDTO getTotalStatisAtYear() {
        List<StatisResultDTO> list = statisManageMapper.selectTotalStatisAtYear(GoodsType.getGoodsTypeKey("NEW"));
        List<StatisResultDTO> videoList = statisManageMapper.selectTotalStatisAtYear(GoodsType.getGoodsTypeKey(GoodsType.VIDEO.toString()));
        List<StatisResultDTO> academyList = statisManageMapper.selectTotalStatisAtYear(GoodsType.getGoodsTypeKey(GoodsType.ACADEMY.toString()));
        List<StatisResultDTO> bookList = statisManageMapper.selectTotalStatisAtYear(GoodsType.getGoodsTypeKey(GoodsType.BOOK.toString()));

        List<String>yearList = new ArrayList<>();
        List<Long>totalPriceList = new ArrayList<>();
        List<Long>videoPriceList = new ArrayList<>();
        List<Long>academyPriceList = new ArrayList<>();
        List<Long>bookPriceList = new ArrayList<>();

        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                String year = resultDTO.getDay();
                Long totalPrice = Long.parseLong(resultDTO.getPrice());

                yearList.add(year);
                totalPriceList.add(totalPrice);
            }
            for (StatisResultDTO resultDTO2 : videoList) {
                Long videoPrice = Long.parseLong(resultDTO2.getPrice());

                videoPriceList.add(videoPrice);
            }
            for (StatisResultDTO resultDTO3 : academyList) {
                Long academyPrice = Long.parseLong(resultDTO3.getPrice());

                academyPriceList.add(academyPrice);
            }
            for (StatisResultDTO resultDTO4 : bookList) {
                Long bookPrice = Long.parseLong(resultDTO4.getPrice());

                bookPriceList.add(bookPrice);
            }
        }
        String[] years = StringUtils.arrayListToStringArray(yearList);
        long[] totalPrices  = Longs.toArray(totalPriceList);
        long[] videoPrices = Longs.toArray(videoPriceList);
        long[] academyPrices = Longs.toArray(academyPriceList);
        long[] bookPrices = Longs.toArray(bookPriceList);

        return new StatisResultDTO(years, totalPrices, videoPrices, academyPrices, bookPrices);
    }

    /**
     * 전체 결제 일별 통계
     * @param yyyyMM
     * 차트 : https://www.highcharts.com/demo/line-basic
     */
    @Transactional(readOnly = true)
    public StatisResultDTO getTotalStatisAtDay(String yyyyMM) {
        if ("".equals(yyyyMM)) return null;

        List<StatisResultDTO> totalList = statisManageMapper.selectTotalStatisAtYearDay(yyyyMM, GoodsType.getGoodsTypeKey("NEW"));
        List<StatisResultDTO> videoList = statisManageMapper.selectTotalStatisAtYearDay(yyyyMM, GoodsType.getGoodsTypeKey(GoodsType.VIDEO.toString()));
        List<StatisResultDTO> academyList = statisManageMapper.selectTotalStatisAtYearDay(yyyyMM, GoodsType.getGoodsTypeKey(GoodsType.ACADEMY.toString()));
        List<StatisResultDTO> bookList = statisManageMapper.selectTotalStatisAtYearDay(yyyyMM, GoodsType.getGoodsTypeKey(GoodsType.BOOK.toString()));

        List<Long>totalPriceList = new ArrayList<>();
        List<Long>videoPriceList = new ArrayList<>();
        List<Long>academyPriceList = new ArrayList<>();
        List<Long>bookPriceList = new ArrayList<>();

        if (totalList.size() > 0) {
            for (StatisResultDTO resultDTO : totalList) {
                Long price = Long.parseLong(resultDTO.getPrice());
                totalPriceList.add(price);
            }
        }
        if (videoList.size() > 0) {
            for (StatisResultDTO resultDTO : videoList) {
                Long videoPrice = Long.parseLong(resultDTO.getPrice());
                videoPriceList.add(videoPrice);
            }
        }
        if (academyList.size() > 0) {
            for (StatisResultDTO resultDTO : academyList) {
                Long academyPrice = Long.parseLong(resultDTO.getPrice());
                academyPriceList.add(academyPrice);
            }
        }
        if (bookList.size() > 0) {
            for (StatisResultDTO resultDTO : bookList) {
                Long bookPrice = Long.parseLong(resultDTO.getPrice());
                bookPriceList.add(bookPrice);
            }
        }
        long[] totalPrices = Longs.toArray(totalPriceList);
        long[] videoPrices = Longs.toArray(videoPriceList);
        long[] academyPrices = Longs.toArray(academyPriceList);
        long[] bookPrices = Longs.toArray(bookPriceList);

        return new StatisResultDTO(totalPrices, videoPrices, academyPrices, bookPrices);
    }

    /**
     * 프로모션 월간 통계
     * @param searchYear
     * @return
     */
    @Transactional(readOnly = true)
    public PromotionStatisDTO selectPromotionStatisByMonth(String searchYear) {
        if ("".equals(searchYear)) return null;

        List<Integer>packageResult = new ArrayList<>();
        List<Integer>yearMemberResult = new ArrayList<>();
        List<Integer>zianPassResult = new ArrayList<>();

        List<StatisResultDTO> packageList = statisManageMapper.selectPackageStatisByMonth(searchYear, PromotionPmType.PACKAGE.getPromotionPmKey());
        List<StatisResultDTO> yearMemberList = statisManageMapper.selectPackageStatisByMonth(searchYear, PromotionPmType.YEAR_MEMBER.getPromotionPmKey());
        List<StatisResultDTO> zianPassList = statisManageMapper.selectPackageStatisByMonth(searchYear, PromotionPmType.ZIAN_PASS.getPromotionPmKey());

        String[] monthList = Util.returnYYYY_MM(searchYear);
        if (packageList.size() > 0) {
            for (int i=0; i<monthList.length; i++) {
                int packagePrice = 0;
                for (StatisResultDTO resultDTO : packageList) {
                    if (resultDTO.getDay().equals(monthList[i])) {
                        packagePrice = Integer.parseInt(resultDTO.getPrice());
                        break;
                    }
                }
                packageResult.add(packagePrice);
            }
        }
        if (yearMemberList.size() > 0) {
            for (int i=0; i<monthList.length; i++) {
                int yearMemberPrice = 0;
                for (StatisResultDTO resultDTO : yearMemberList) {
                    if (resultDTO.getDay().equals(monthList[i])) {
                        yearMemberPrice = Integer.parseInt(resultDTO.getPrice());
                        break;
                    }
                }
                yearMemberResult.add(yearMemberPrice);
            }
        }
        if (zianPassList.size() > 0) {
            for (int i=0; i<monthList.length; i++) {
                int zianPassPrice = 0;
                for (StatisResultDTO resultDTO : zianPassList) {
                    if (resultDTO.getDay().equals(monthList[i])) {
                        zianPassPrice = Integer.parseInt(resultDTO.getPrice());
                        break;
                    }
                }
                zianPassResult.add(zianPassPrice);
            }
        }
        long[] packagePrices = Longs.toArray(packageResult);
        long[] yearMemberPrices = Longs.toArray(yearMemberResult);
        long[] zianPassPrices = Longs.toArray(zianPassResult);

        return new PromotionStatisDTO(packagePrices, yearMemberPrices, zianPassPrices);
    }

    /**
     * 프로모션 년간 통계
     * @return
     */
    @Transactional(readOnly = true)
    public PromotionStatisDTO selectPromotionStatisByYear() {
        List<StatisResultDTO> packageList = statisManageMapper.selectPackageStatisByYear(PromotionPmType.PACKAGE.getPromotionPmKey());
        List<StatisResultDTO> yearMemberList = statisManageMapper.selectPackageStatisByYear(PromotionPmType.YEAR_MEMBER.getPromotionPmKey());
        List<StatisResultDTO> zianPassList = statisManageMapper.selectPackageStatisByYear(PromotionPmType.ZIAN_PASS.getPromotionPmKey());

        List<String>yearList = new ArrayList<>();
        List<Long>packagePriceList = new ArrayList<>();
        List<Long>yearMemberPriceList = new ArrayList<>();
        List<Long>zianPassPriceList = new ArrayList<>();

        if (packageList.size() > 0) {
            for (StatisResultDTO resultDTO : packageList) {
                String year = resultDTO.getDay();
                Long packagePrice = Long.parseLong(resultDTO.getPrice());

                yearList.add(year);
                packagePriceList.add(packagePrice);
            }
            for (StatisResultDTO resultDTO2 : yearMemberList) {
                Long yearMemberPrice = Long.parseLong(resultDTO2.getPrice());

                yearMemberPriceList.add(yearMemberPrice);
            }
            for (StatisResultDTO resultDTO3 : zianPassList) {
                Long zianPassPrice = Long.parseLong(resultDTO3.getPrice());

                zianPassPriceList.add(zianPassPrice);
            }
        }
        String[] years = StringUtils.arrayListToStringArray(yearList);
        long[] packagePrices = Longs.toArray(packagePriceList);
        long[] yearMemberPrices = Longs.toArray(yearMemberPriceList);
        long[] zianPassPrices = Longs.toArray(zianPassPriceList);

        return new PromotionStatisDTO(years, packagePrices, yearMemberPrices, zianPassPrices);
    }

    /**
     * 프로모션 일별 통계
     * @param yyyyMM
     * @return
     */
    @Transactional(readOnly = true)
    public PromotionStatisDTO selectPromotionStatisByDay(String yyyyMM) {
        if ("".equals(yyyyMM)) return null;

        List<StatisResultDTO> packageList = statisManageMapper.selectPackageStatisByDay(yyyyMM, PromotionPmType.PACKAGE.getPromotionPmKey());
        List<StatisResultDTO> yearMemberList = statisManageMapper.selectPackageStatisByDay(yyyyMM, PromotionPmType.YEAR_MEMBER.getPromotionPmKey());
        List<StatisResultDTO> zianPassList = statisManageMapper.selectPackageStatisByDay(yyyyMM, PromotionPmType.ZIAN_PASS.getPromotionPmKey());

        List<Long>packagePriceList = new ArrayList<>();
        List<Long>yearMemberPriceList = new ArrayList<>();
        List<Long>zianPassPriceList = new ArrayList<>();

        if (packageList.size() > 0) {
            for (StatisResultDTO resultDTO : packageList) {
                Long packagePrice = Long.parseLong(resultDTO.getPrice());
                packagePriceList.add(packagePrice);
            }
        }
        if (yearMemberList.size() > 0) {
            for (StatisResultDTO resultDTO : yearMemberList) {
                Long yearMemberPrice = Long.parseLong(resultDTO.getPrice());
                yearMemberPriceList.add(yearMemberPrice);
            }
        }
        if (zianPassList.size() > 0) {
            for (StatisResultDTO resultDTO : zianPassList) {
                Long zianPassPrice = Long.parseLong(resultDTO.getPrice());
                zianPassPriceList.add(zianPassPrice);
            }
        }
        long[] packagePrices = Longs.toArray(packagePriceList);
        long[] yearMemberPrices = Longs.toArray(yearMemberPriceList);
        long[] zianPassPrices = Longs.toArray(zianPassPriceList);

        return new PromotionStatisDTO(packagePrices, yearMemberPrices, zianPassPrices);
    }

    /**
     * 월간 회원가입 통계
     * @param searchYear
     * @return
     */
    @Transactional(readOnly = true)
    public MemberStatisDTO selectMemberRegStatisByMonth(String searchYear) {
        if ("".equals(searchYear)) return null;

        List<Integer>memberRegResult = new ArrayList<>();

        List<StatisResultDTO> list = statisManageMapper.selectMemberRegStatisByMonth(searchYear);
        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Integer userCount = resultDTO.getUserCount();
                memberRegResult.add(userCount);
            }
        }
        long[] userCounts = Longs.toArray(memberRegResult);

        return new MemberStatisDTO(userCounts);
    }

    /**
     * 년간 회원가입 통계
     * @return
     */
    @Transactional(readOnly = true)
    public MemberStatisDTO selectMemberRegStatisByYear() {
        List<String>yearList = new ArrayList<>();
        List<Integer>memberRegResult = new ArrayList<>();

        List<StatisResultDTO> list = statisManageMapper.selectMemberRegStatisByYear();

        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                String year = resultDTO.getDay();
                Integer userCount = resultDTO.getUserCount();

                yearList.add(year);
                memberRegResult.add(userCount);
            }
        }
        String[] years = StringUtils.arrayListToStringArray(yearList);
        long[] userCounts = Longs.toArray(memberRegResult);

        return new MemberStatisDTO(years, userCounts);
    }

    /**
     * 일간 회원 통계
     * @param yyyyMM
     * @return
     */
    @Transactional(readOnly = true)
    public MemberStatisDTO selectMemberRegStatisByDay(String yyyyMM) {
        if ("".equals(yyyyMM)) return null;

        List<Integer>memberRegResult = new ArrayList<>();

        List<StatisResultDTO> list = statisManageMapper.selectMemberRegStatisByDay(yyyyMM);
        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Integer userCount = resultDTO.getUserCount();
                memberRegResult.add(userCount);
            }
        }
        long[] userCounts = Longs.toArray(memberRegResult);

        return new MemberStatisDTO(userCounts);
    }

    /**
     * 월별 정산내역(강사)
     * @param teacherKey
     * @param searchMonth
     * @return
     */
    @Transactional(readOnly = true)
    public TeacherCalculateResultDTO getTeacherCalculateByMonth(int teacherKey, String searchMonth) {
        if (teacherKey == 0 && "".equals(searchMonth)) return null;

        List<TeacherCalculateDTO> videoCalculateResult = statisManageMapper.selectTeacherStatisByMonth(
                teacherKey,
                GoodsType.getGoodsTypeKey(GoodsType.VIDEO.toString()),
                Util.isNullValue(searchMonth, "")
        );
        //상품 구분명 주입하기
        if (videoCalculateResult != null && videoCalculateResult.size() > 0) {
            goodsKindNameRepository.injectGoodsKindNameAny(videoCalculateResult);
        }

        List<TeacherCalculateDTO> academyCalculateResult = statisManageMapper.selectTeacherStatisByMonth(
                teacherKey,
                GoodsType.getGoodsTypeKey(GoodsType.ACADEMY.toString()),
                Util.isNullValue(searchMonth, "")
        );
        //상품 구분명 주입하기
        if (academyCalculateResult != null && academyCalculateResult.size() > 0) {
            goodsKindNameRepository.injectGoodsKindNameAny(academyCalculateResult);
        }

        List<TeacherCalculateDTO> packageCalculateResult = statisManageMapper.selectTeacherStatisByMonth(
                teacherKey,
                GoodsType.getGoodsTypeKey(GoodsType.PACKAGE.toString()),
                Util.isNullValue(searchMonth, "")
        );
        //상품 구분명 주입하기
        if (packageCalculateResult != null && packageCalculateResult.size() > 0) {
            goodsKindNameRepository.injectGoodsKindNameAny(packageCalculateResult);
        }
        //옵션 정보 가져오기
        List<TCalculateOptionVO>calculateOptionList = statisManageMapper.selectTCalculateOptionList(teacherKey, searchMonth);

        return new TeacherCalculateResultDTO(videoCalculateResult, academyCalculateResult, packageCalculateResult, calculateOptionList);
    }

    /**
     * 기간별 정산내역(강사)
     * @param teacherKey
     * @param searchStartDate
     * @param searchEndDate
     * @return
     */
    @Transactional(readOnly = true)
    public TeacherCalculateResultDTO getTeacherCalculateBySection(int teacherKey, String searchStartDate, String searchEndDate) {
        if (teacherKey == 0 && "".equals(searchStartDate) && "".equals(searchEndDate)) return null;

        List<TeacherCalculateDTO> videoCalculateResult = statisManageMapper.selectTeacherStatisBySection(
                teacherKey,
                GoodsType.getGoodsTypeKey(GoodsType.VIDEO.toString()),
                Util.isNullValue(searchStartDate, ""),
                Util.isNullValue(searchEndDate, "")
        );
        //상품 구분명 주입하기
        if (videoCalculateResult != null && videoCalculateResult.size() > 0) {
            goodsKindNameRepository.injectGoodsKindNameAny(videoCalculateResult);
        }

        List<TeacherCalculateDTO> academyCalculateResult = statisManageMapper.selectTeacherStatisBySection(
                teacherKey,
                GoodsType.getGoodsTypeKey(GoodsType.ACADEMY.toString()),
                Util.isNullValue(searchStartDate, ""),
                Util.isNullValue(searchEndDate, "")
        );
        //상품 구분명 주입하기
        if (academyCalculateResult != null && academyCalculateResult.size() > 0) {
            goodsKindNameRepository.injectGoodsKindNameAny(academyCalculateResult);
        }

        List<TeacherCalculateDTO> packageCalculateResult = statisManageMapper.selectTeacherStatisBySection(
                teacherKey,
                GoodsType.getGoodsTypeKey(GoodsType.PACKAGE.toString()),
                Util.isNullValue(searchStartDate, ""),
                Util.isNullValue(searchEndDate, "")
        );
        //상품 구분명 주입하기
        if (packageCalculateResult != null && packageCalculateResult.size() > 0) {
            goodsKindNameRepository.injectGoodsKindNameAny(packageCalculateResult);
        }
        return new TeacherCalculateResultDTO(videoCalculateResult, academyCalculateResult, packageCalculateResult, null);
    }

    /**
     * 강사 매출 그래프 ( 월별 )
     * @param teacherKey
     * @param searchYear
     * @return
     */
    @Transactional(readOnly = true)
    public StatisResultDTO getTeacherStatisGraphByMonth(int teacherKey, String searchYear) {
        if (teacherKey == 0 && "".equals(searchYear)) return null;

        List<Integer>priceResult = new ArrayList<>();
        List<StatisResultDTO>list = statisManageMapper.selectTeacherStatisGraphByMonth(teacherKey, searchYear);

        if (list.size() > 0) {
            for (StatisResultDTO resultDTO : list) {
                Integer price = Integer.parseInt(resultDTO.getPrice());
                priceResult.add(price);
            }
        }
        long[] prices = Longs.toArray(priceResult);

        return new StatisResultDTO(prices);
    }

    /**
     * 교수 > 정산내역 > 옵션추가
     * @param teacherKey
     * @param targetDate
     * @param title
     * @param price
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveTeacherCalculateOptionInfo(int teacherKey, String targetDate, String title, int price) {
        if (teacherKey == 0 && "".equals(targetDate) && "".equals(title)) return;
        TCalculateOptionVO tCalculateOptionVO = new TCalculateOptionVO(
                teacherKey, targetDate, title, price
        );
        statisManageMapper.insertTCalculateOption(tCalculateOptionVO);
    }

}
