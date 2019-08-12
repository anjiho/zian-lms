package com.zianedu.lms.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ZianUtils {

    public static List<String> getMonthList() {
        List<String> monthList = new ArrayList<>();

        for (int i=1; i<13; i++) {
            String month = String.valueOf(i);
            if (i < 10) {
                month = "0" + String.valueOf(i);
            }
            monthList.add(month);
        }
        return monthList;
    }

    /**
     * T_ORDER.j_id 값 만들기
     * @return
     */
    public static String getJId() {
        String jId = "";
        String yyyyMM = Util.getYearMonth();
        String[] splitHHmm = Util.split(Util.returnHourMinute(), ":");
        String hhmm = splitHHmm[0] + splitHHmm[1];
        String ranNumber = RandomUtil.getRandomNumber(6);

        jId = yyyyMM + "-" + hhmm + "-" + ranNumber;
        return jId;
    }

    public static boolean isHoliday() throws Exception {
        String today = Util.plusDate(Util.returnNow(), 0);
        String[] holiday = {"2019-08-15", "2019-09-12", "2019-09-13", "2019-10-03", "2019-10-09", "2019-12-25"};

        if (Arrays.asList(holiday).contains(today)) {
            return true;
        }
        return false;
    }
    public static void main(String[] args) throws Exception {
        System.out.println(isHoliday());
    }
}
