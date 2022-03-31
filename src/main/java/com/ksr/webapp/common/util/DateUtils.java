package com.ksr.webapp.common.util;

import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtils {
	/**
	 * 특정일이 rday를 더해서 리턴
	 *
	 * @param yyyyMMdd 특정일
	 * @param rday     주어진 일자
	 * @return 더한 날짜
	 */
	public static String getRelativeDate(String yyyyMMdd, int rday) {
		return getRelativeDate(yyyyMMdd, "yyyyMMdd", rday);
	}

	/**
	 * 특정일이 rday를 더해서 리턴
	 *
	 * @param yyyyMMdd
	 * @param type
	 * @param rday
	 * @return
	 */
	public static String getRelativeDate(String yyyyMMdd, String type, int rday) {
		if (yyyyMMdd == null)
			return null;
		if (yyyyMMdd.length() < 8)
			return ""; // 최소 8 자리
		String time = "";

		TimeZone kst = TimeZone.getTimeZone("JST");
		TimeZone.setDefault(kst);
		Calendar cal = Calendar.getInstance(kst); // 현재
		int yyyy = Integer.parseInt(yyyyMMdd.substring(0, 4));
		int mm = Integer.parseInt(yyyyMMdd.substring(4, 6));
		int dd = Integer.parseInt(yyyyMMdd.substring(6, 8));
		cal.set(yyyy, mm - 1, dd); // 카렌더를 주어진 date 로 세팅하고
		cal.add(Calendar.DATE, rday); // 그 날짜에서 주어진 rday 만큼 더한다.
		time = new SimpleDateFormat(type).format(cal.getTime());

		return time;
	}

	/**
	 * 특정일이 rmonth를 더해서 리턴
	 *
	 * @param yyyyMMdd
	 * @param type
	 * @param rmonth
	 * @return
	 */
	public static String getRelativeMonth(String yyyyMMdd, String type, int rmonth) {
		if (yyyyMMdd == null)
			return null;
		if (yyyyMMdd.length() < 8)
			return ""; // 최소 8 자리
		String time = "";

		TimeZone kst = TimeZone.getTimeZone("JST");
		TimeZone.setDefault(kst);
		Calendar cal = Calendar.getInstance(kst); // 현재
		int yyyy = Integer.parseInt(yyyyMMdd.substring(0, 4));
		int mm = Integer.parseInt(yyyyMMdd.substring(4, 6));
		int dd = Integer.parseInt(yyyyMMdd.substring(6, 8));
		cal.set(yyyy, mm - 1, dd); // 카렌더를 주어진 date 로 세팅하고
		cal.add(Calendar.MONTH, rmonth); // 그 날짜에서 주어진 rmonth 만큼 더한다.
		time = new SimpleDateFormat(type).format(cal.getTime());

		return time;
	}

	/**
	 * milisecond -> day로 변환
	 *
	 * @param mil
	 * @param type
	 * @return
	 */
	public static String getDate(long mil, String type) {
		return (new SimpleDateFormat(type)).format(new Date(mil));
	}

	/**
	 * 오늘 날짜를 다양한 형태로 리턴한다. 예) getToday("yyyyMMdd"); getToday("yyyyMMddHHmmss");
	 * getToday("yyyy-MM-dd HH:mm:ss"); getToday("yyyy-MM-dd"); getToday("HHmm");
	 *
	 * @param type 날짜형태
	 * @return
	 */
	public static String getToday(String type) {
		if (type == null)
			return null;

		String s = new SimpleDateFormat(type).format(new Date());
		return s;
	}

	/**
	 * @param type 날짜형태
	 * @return
	 */
	public static String getDate(String type, int daydiff) {
		if (type == null)
			return null;
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, daydiff);
		String s = new SimpleDateFormat(type).format(cal.getTime());
		return s;
	}

	/**
	 * @return
	 */
	public static String getLastDate(int year,  int month) {
        Calendar now = Calendar.getInstance(); // 현재 날짜를 받아옴
        now.set(year, month, 1);
        Date stDate = now.getTime();
        int end = now.getActualMaximum(Calendar.DAY_OF_MONTH);    //해당월의 마지막 날짜
		String realMonth = String.valueOf(month).length() > 1 ? String.valueOf(month) : "0" + String.valueOf(month);
		String date = String.valueOf(year) + "-" + realMonth + "-" + String.valueOf(end);

		return date;
	}

	/**
	 * 오늘 날짜를 yyyyMMddHHmmss 형태로 리턴
	 *
	 * @return
	 */
	public static String getToday() {
		return getToday("yyyyMMddHHmmss");
	}

	public static String getTodayTimeSec() {
		return getToday("yyyy-MM-dd HH:mm:ss");
	}

	public static String getTodayTime() {
		return getToday("yyyy-MM-dd HH:mm");
	}

	public static String getTodayDate() {
		return getToday("yyyy-MM-dd");
	}

	/**
	 * 오늘의 요일을 계산한다.
	 *
	 * @return String yyyyMMdd
	 */
	public static String getDayOfWeek() {
		return getDayOfWeek(getToday("yyyyMMdd"));
	}

	/**
	 * 해당날짜의 요일을 계산한다. (년월일(6자리)을 지정하는데 지정되지 않으면 default 값을 사용한다. 2000.2)
	 * <p>
	 * 예) getDayOfWeek("2000") -> 토 (2000/1/1) getDayOfWeek("200002") -> 화
	 * (2000/2/1) getDayOfWeek("20000225") -> 금 (2000/2/25)
	 *
	 * @param yyyyMMdd 요일을 구할 날짜
	 * @return String 요일
	 */
	public static String getDayOfWeek(String yyyyMMdd) {
		if (yyyyMMdd == null)
			return null;
		int yyyy = 0, MM = 1, dd = 1, day_of_week; // default
		String days[] = { "일", "월", "화", "수", "목", "금", "토" };

		yyyy = Integer.parseInt(yyyyMMdd.substring(0, 4));
		MM = Integer.parseInt(yyyyMMdd.substring(4, 6));
		dd = Integer.parseInt(yyyyMMdd.substring(6, 8));

		Calendar cal = Calendar.getInstance();
		cal.set(yyyy, MM - 1, dd);
		day_of_week = cal.get(Calendar.DAY_OF_WEEK);
		// 1(일),2(월),3(화),4(수),5(목),6(금),7(토)
		return days[day_of_week - 1];
	}

	/**
	 * 날짜를 입력하면 요일을 나타내준다. - 1(일),2(월),3(화),4(수),5(목),6(금),7(토)
	 *
	 * @param yyyyMMdd
	 * @return
	 */
	public static int getWeekNumber(String yyyyMMdd) {
		if (yyyyMMdd == null)
			return -1;

		int yyyy = 0, MM = 1, dd = 1, day_of_week; // default

		yyyy = Integer.parseInt(yyyyMMdd.substring(0, 4));
		MM = Integer.parseInt(yyyyMMdd.substring(4, 6));
		dd = Integer.parseInt(yyyyMMdd.substring(6, 8));

		Calendar cal = Calendar.getInstance();
		cal.set(yyyy, MM - 1, dd);
		day_of_week = cal.get(Calendar.DAY_OF_WEEK); // 1(일),2(월),3(화),4(수),5(목),6(금),7(토)

		return day_of_week;
	}

	public static String format(Date date, String pattern) {
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, new Locale("ko", "KOREA"));
		return formatter.format(date);
	}

	/**
	 * 시간을 스트링으로 받어서 type 형태로 리턴한다.
	 * <p>
	 * 예) formatTime("1200","HH:mm") -> "12:00" formatTime("1200","HH:mm:ss") ->
	 * "12:00:00" formatTime("120003","HH:mm") -> "12:00" formatTime("120003","HH:mm
	 * ss") -> "12:00 03"
	 *
	 * @param timeString 시간
	 * @param type       시간형태
	 * @return 시간을 스트링으로 받어서 type 형태로 리턴
	 */
	public static String formatTime(String timeString, String type) {
		if (timeString == null || type == null)
			return null;

		String result = "";
		int hour = 0, min = 0, sec = 0, length = timeString.length();

		hour = Integer.parseInt(timeString.substring(0, 2));
		if (length > 2)
			min = Integer.parseInt(timeString.substring(2, 4));
		if (length > 4)
			sec = Integer.parseInt(timeString.substring(4, 6));
		Calendar cal = Calendar.getInstance();
		cal.set(0, 0, 0, hour, min, sec);
		result = (new SimpleDateFormat(type)).format(cal.getTime());

		return result;
	}

	/**
	 * 날짜(+시간)을 스트링으로 받어서 type 형태로 리턴한다.
	 * <p>
	 * 예) formatDate("19991201","yyy/MM/dd") -> "1999/12/01"
	 * formatDate("19991201","yyyy-MM-dd") -> "1999-12-01"
	 * formatDate("1999120112","yyyy-MM-dd HH") -> "1999-12-01 12"
	 * formatDate("199912011200","yyyy-MM-dd HH:mm ss") -> "1999-12-01 12:00 00"
	 * formatDate("19991231115959","yyyy-MM-dd-HH-mm-ss") -> "1999-12-31-11-59-59"
	 *
	 * @param dateString 날짜
	 * @param type       날짜형태
	 * @return 날짜(+ 시간)을 스트링으로 받어서 type 형태로 리턴
	 * @throws Exception
	 */
	public static String formatDate(String dateString, String type) {
		String result = "";
		if (dateString == null || type == null)
			result = "";

		try {
			int year = 0, month = 0, day = 0, hour = 0, min = 0, sec = 0, length = dateString.length();
			year = Integer.parseInt(dateString.substring(0, 4));
			month = Integer.parseInt(dateString.substring(4, 6));
			day = Integer.parseInt(dateString.substring(6, 8));
			if (length > 8) {
				hour = Integer.parseInt(dateString.substring(8, 10));
				min = Integer.parseInt(dateString.substring(10, 12));
				sec = Integer.parseInt(dateString.substring(12, 14));
			}

			Calendar cal = Calendar.getInstance();
			cal.set(year, month - 1, day, hour, min, sec);
			result = (new SimpleDateFormat(type)).format(cal.getTime());
		} catch (Exception e) {
		}

		return result;
	}

	/**
	 * 두 시간의 차이를 분으로 계산한다.
	 * <p>
	 * 예) getMinuteDiff("20000302","20000303") --> 3600
	 * getMinuteDiff("2000030210","2000030211") --> 60
	 * getMinuteDiff("200003021020","200003021021") --> 1
	 * getMinuteDiff("20000302102000","20000302102130") --> 1 처음 파라메터가 작은 날짜인데 만약 더
	 * 큰날짜를 처음으로 주면 음수를리턴.
	 *
	 * @param s_start 첫번째 시간
	 * @param s_end   두번째 시간
	 * @return 두 시간의 차이를 분으로 계산
	 */
	public static int getMinuteDiff(String s_start, String s_end) {
		long l_start, l_end, l_gap;
		int i_start_year = 0, i_start_month = 1, i_start_day = 1, i_start_hour = 0, i_start_min = 0, i_start_sec = 0;
		int i_end_year = 0, i_end_month = 1, i_end_day = 1, i_end_hour = 0, i_end_min = 0, i_end_sec = 0;

		i_start_year = Integer.parseInt(s_start.substring(0, 4));
		i_start_month = Integer.parseInt(s_start.substring(4, 6));
		// month는 Calendar에서 0 base으로 작동하므로 1 을 빼준다.
		i_start_day = Integer.parseInt(s_start.substring(6, 8));
		i_start_hour = Integer.parseInt(s_start.substring(8, 10));
		i_start_min = Integer.parseInt(s_start.substring(10, 12));
		i_start_sec = Integer.parseInt(s_start.substring(12, 14));

		i_end_year = Integer.parseInt(s_end.substring(0, 4));
		i_end_month = Integer.parseInt(s_end.substring(4, 6));
		// month는 Calendar에서0 base으로 작동하므로 1 을 빼준다.
		i_end_day = Integer.parseInt(s_end.substring(6, 8));
		i_end_hour = Integer.parseInt(s_end.substring(8, 10));
		i_end_min = Integer.parseInt(s_end.substring(10, 12));
		i_end_sec = Integer.parseInt(s_end.substring(12, 14));

		Calendar cal = Calendar.getInstance();
		cal.set(i_start_year, i_start_month - 1, i_start_day, i_start_hour, i_start_min, i_start_sec);
		l_start = cal.getTime().getTime();
		cal.set(i_end_year, i_end_month - 1, i_end_day, i_end_hour, i_end_min, i_end_sec);
		l_end = cal.getTime().getTime();
		l_gap = l_end - l_start;
		return (int) (l_gap / (1000 * 60));
	}

	/**
	 * 두 시간의 차이를 계산한다.
	 * <p>
	 * 예) getMinuteDiff("20000302","20000303") --> 3600
	 * getMinuteDiff("2000030210","2000030211") --> 60
	 * getMinuteDiff("200003021020","200003021021") --> 1
	 * getMinuteDiff("20000302102000","20000302102130") --> 1 처음 파라메터가 작은 날짜인데 만약 더
	 * 큰날짜를 처음으로 주면 음수를리턴.
	 *
	 * @param s_start 첫번째 시간
	 * @param s_end   두번째 시간
	 * @return 두 시간의 차이를 분으로 계산
	 */
	public static long getTimeDiff(String type, String s_start, String s_end) {
		long l_start, l_end, l_gap;
		int i_start_year = 0, i_start_month = 1, i_start_day = 1, i_start_hour = 0, i_start_min = 0, i_start_sec = 0;
		int i_end_year = 0, i_end_month = 1, i_end_day = 1, i_end_hour = 0, i_end_min = 0, i_end_sec = 0;

		i_start_year = Integer.parseInt(s_start.substring(0, 4));
		i_start_month = Integer.parseInt(s_start.substring(4, 6));
		// month는 Calendar에서 0 base으로 작동하므로 1 을 빼준다.
		i_start_day = Integer.parseInt(s_start.substring(6, 8));
		try {
			i_start_hour = Integer.parseInt(s_start.substring(8, 10));
			i_start_min = Integer.parseInt(s_start.substring(10, 12));
			i_start_sec = Integer.parseInt(s_start.substring(12, 14));
		} catch (Exception e) {
		}

		i_end_year = Integer.parseInt(s_end.substring(0, 4));
		i_end_month = Integer.parseInt(s_end.substring(4, 6));
		// month는 Calendar에서0 base으로 작동하므로 1 을 빼준다.
		i_end_day = Integer.parseInt(s_end.substring(6, 8));
		try {
			i_end_hour = Integer.parseInt(s_end.substring(8, 10));
			i_end_min = Integer.parseInt(s_end.substring(10, 12));
			i_end_sec = Integer.parseInt(s_end.substring(12, 14));
		} catch (Exception e) {
		}

		Calendar cal = Calendar.getInstance();
		cal.set(i_start_year, i_start_month - 1, i_start_day, i_start_hour, i_start_min, i_start_sec);
		l_start = cal.getTime().getTime();
		cal.set(i_end_year, i_end_month - 1, i_end_day, i_end_hour, i_end_min, i_end_sec);
		l_end = cal.getTime().getTime();
		l_gap = l_end - l_start;
		long lDiff = 0;
		if ("s".equals(type)) { // 초단위
			lDiff = l_gap / 1000;
		} else if ("h".equals(type)) { // 시간단위
			lDiff = l_gap / (1000 * 60 * 60);
		} else if ("d".equals(type)) { // 일단위
			lDiff = l_gap / (1000 * 60 * 60 * 24);
		} else { // "m" 분단위
			lDiff = l_gap / (1000 * 60);
		}
		return lDiff;
	}

	/**
	 * 날짜(yyyyMMdd)에 addNumber만큼의 (년/월/일/주/시/분)을 더해서 리턴
	 *
	 * @param yyyyMMdd
	 * @param type      - 리턴 날짜 형식
	 * @param gubun     - year, month, date, week, hour, minute 중 하나
	 * @param addNumber
	 * @return
	 */
	public static String getDateAdd(String yyyyMMdd, String type, String gubun, int addNumber) {
		String result = "";

		if (yyyyMMdd == null)
			return null;
		if (type == null)
			return null;

		int year = 0, month = 0, day = 0, length = yyyyMMdd.length();
		if (length != 8)
			return null;

		Calendar cal = Calendar.getInstance();

		year = Integer.parseInt(yyyyMMdd.substring(0, 4));
		month = Integer.parseInt(yyyyMMdd.substring(4, 6)) - 1;
		day = Integer.parseInt(yyyyMMdd.substring(6, 8));

		cal.set(year, month, day);
		if (gubun == "year")
			cal.add(Calendar.YEAR, addNumber);
		if (gubun == "month")
			cal.add(Calendar.MONTH, addNumber);
		if (gubun == "date")
			cal.add(Calendar.DATE, addNumber);
		if (gubun == "week")
			cal.add(Calendar.WEEK_OF_MONTH, addNumber);
		if (gubun == "hour")
			cal.add(Calendar.HOUR_OF_DAY, addNumber);
		if (gubun == "minute")
			cal.add(Calendar.MINUTE, addNumber);
		result = (new SimpleDateFormat(type)).format(cal.getTime());

		cal = null;
		return result;
	}

	/**
	 * yyyyMMdd(또는 yyyy-MM-dd)가 유효한 날짜인 확인
	 *
	 * @param yyyyMMdd
	 * @return
	 */
	public static boolean isValidDate(String yyyyMMdd) {

		boolean bResult = false;
		if (yyyyMMdd == null)
			return false;

		yyyyMMdd = yyyyMMdd.replaceAll("-", "").replaceAll(" ", "").substring(0, 8);
		if (yyyyMMdd.length() != 8)
			return false;

		try {
			int yyyy = Integer.parseInt(yyyyMMdd.substring(0, 4));
			int mm = Integer.parseInt(yyyyMMdd.substring(4, 6));
			int dd = Integer.parseInt(yyyyMMdd.substring(6, 8));

			int eday[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
			if (yyyy % 4 == 0 && yyyy % 100 != 0) {
				eday[1] = 29;
			} else if (yyyy % 400 == 0) {
				eday[1] = 29;
			}

			bResult = yyyy >= 0;
			if (mm < 1 || mm > 12) {
				bResult = false;
			}
			if (dd < 1 || dd > eday[mm - 1]) {
				bResult = false;
			}

		} catch (Exception e) {
			bResult = false;
		}
		return bResult;
	}

	public static List<String> getYearList(int prev, int next) {
		List<String> yearList = new ArrayList<>();

		String currentYear = getToday("yyyy");
		Integer currentYearInt = Integer.parseInt(currentYear);

		for (int i = currentYearInt - prev; i < currentYearInt + next; i++) {
			yearList.add(String.valueOf(i));
		}

		return yearList;
	}
}