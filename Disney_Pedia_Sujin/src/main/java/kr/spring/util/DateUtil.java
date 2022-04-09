package kr.spring.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import kr.spring.contents.vo.CalendarVO;

public class DateUtil {

	String year = "";
	String month = "";
	String date = "";
	String value = "";
	String db_startDate = "";
	String db_endDate = "";
	CalendarVO[] contents_data_arr = new CalendarVO[4];

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getDb_startDate() {
		return db_startDate;
	}

	public void setDb_startDate(String db_startDate) {
		this.db_startDate = db_startDate;
	}

	public CalendarVO[] getcontents_data_arr() {
		return contents_data_arr;
	}

	public void setcontents_data_arr(CalendarVO[] contents_data_arr) {
		this.contents_data_arr = contents_data_arr;
	}

	public Map<String, Object> today_info(DateUtil dateData) {
		Map<String, Object> today_Data = new HashMap<String, Object>();
		
		// 날짜 함수를 이용하기 위한 Calendar 클래스의 인스턴스 호출
		Calendar cal = Calendar.getInstance();
		
		// getter setter를 이용해서 지정된 연도와 월의 값이 있을 경우 캘린더 값을 초기 설정해준다
		cal.set(Integer.parseInt(dateData.getYear()), Integer.parseInt(dateData.getMonth()), 1);

		int startDay = cal.getMinimum(java.util.Calendar.DATE);
		int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
		int start = cal.get(java.util.Calendar.DAY_OF_WEEK);

		// 오늘 날짜에 해당하는 연도와 월 등의 정보를 알기 위한 호출
		Calendar todayCal = Calendar.getInstance();
		
		// 연도의 표시 형식 지정
		SimpleDateFormat ysdf = new SimpleDateFormat("yyyy");
		SimpleDateFormat msdf = new SimpleDateFormat("M");

		// 현재 연도를 위에 지정한 yyyy의 형식으로 int 타입 변수에 저장
		int today_year = Integer.parseInt(ysdf.format(todayCal.getTime()));
		int today_month = Integer.parseInt(msdf.format(todayCal.getTime()));

		// 지정한 연도와 달이 있을 경우
		int search_year = Integer.parseInt(dateData.getYear());
		int search_month = Integer.parseInt(dateData.getMonth()) + 1;

		int today = -1;
		// 지정한 연도와 달이 현재 연도와 달과 일치할 경우
		if (today_year == search_year && today_month == search_month) {
			SimpleDateFormat dsdf = new SimpleDateFormat("dd");
			today = Integer.parseInt(dsdf.format(todayCal.getTime()));
		}

		search_month = search_month - 1;

		Map<String, Integer> before_after_calendar = before_after_calendar(search_year, search_month);

		today_Data.put("start", start);
		today_Data.put("startDay", startDay);
		today_Data.put("endDay", endDay);
		today_Data.put("today", today);
		today_Data.put("search_year", search_year);
		today_Data.put("search_month", search_month + 1);
		today_Data.put("before_year", before_after_calendar.get("before_year"));
		today_Data.put("before_month", before_after_calendar.get("before_month"));
		today_Data.put("after_year", before_after_calendar.get("after_year"));
		today_Data.put("after_month", before_after_calendar.get("after_month"));

		// sql문 조건 설정을 위한 시작 날짜와 끝 날짜 값 설정
		this.db_startDate = String.valueOf(search_year) + "-" + String.valueOf(search_month + 1) + "-"
				+ String.valueOf(startDay);
		this.db_endDate = String.valueOf(search_year) + "-" + String.valueOf(search_month + 1) + "-"
				+ String.valueOf(endDay);
		
		// 인자값으로 사용하기 위해 Map에 넣어준다
		today_Data.put("db_startDate", db_startDate);
		today_Data.put("db_endDate", db_endDate);
		
		return today_Data;
	}

	private Map<String, Integer> before_after_calendar(int search_year, int search_month) {
		Map<String, Integer> before_after_data = new HashMap<String, Integer>();
		int before_year = search_year;
		int before_month = search_month - 1;
		int after_year = search_year;
		int after_month = search_month + 1;

		if (before_month < 0) {
			before_month = 11;
			before_year = search_year - 1;
		}

		if (after_month > 11) {
			after_month = 0;
			after_year = search_year + 1;
		}

		before_after_data.put("before_year", before_year);
		before_after_data.put("before_month", before_month);
		before_after_data.put("after_year", after_year);
		before_after_data.put("after_month", after_month);

		return before_after_data;
	}

	public DateUtil(String year, String month, String date, String value, CalendarVO[] contents_data_arr) {
		if ((month != null && month != "") && (date != null && date != "")) {
			this.year = year;
			this.month = month;
			this.date = date;
			this.value = value;
			this.contents_data_arr = contents_data_arr;
		}

	}

	public DateUtil() {
	}

}
