package com.zianedu.lms.utils;

import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;

import java.util.Date;

public class DateUtils {

    public final static DateTimeZone UTC_TIME_ZONE = DateTimeZone.UTC;
    public final static DateTimeZone KOR_TIME_ZONE = DateTimeZone.UTC;
    public final static String DF_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";
    public final static String DF_YMD_PATTERN = "yyyy-MM-dd";

    /**
     * 데이트 객체를 패턴에 따라 문자로 변환한다.
     *
     * @param date 데이트 객체.
     * @param pattern 문자열 패턴
     * @return 패턴화 문자.
     */
    public static String dateToStr(Date date, String pattern, DateTimeZone timeZone){
        if(date == null){
            return null;
        }
        DateTime dt = new DateTime(date, timeZone);
        return dt.toString(pattern);
    }

    /**
     * 현재 시각의 데이트 객체를 반환한다.
     * @return
     */
    public static Date now() {
        DateTime dateTime = new DateTime();
        return dateTime.toDate();
    }

    public static String nowToStrUTC() {
        DateTime dt = new DateTime(now(), UTC_TIME_ZONE);
        return dt.toString(DF_TIME_PATTERN);
    }

    public static String nowToStrUTCNoHms(String pattern) {
        DateTime dt = new DateTime(now(), UTC_TIME_ZONE);
        return dt.toString(pattern + " 00:00:00");
    }

    public static void main(String[] args) {
        System.out.println(nowToStrUTC());
        //System.out.println(dateToStr(d));
    }
}
