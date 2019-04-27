package com.zianedu.lms.utils;

import java.util.ArrayList;
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

    public static void main(String[] args) {
        System.out.println(getMonthList());
    }
}
