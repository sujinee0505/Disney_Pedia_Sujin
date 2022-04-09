package kr.spring.contents.service;

import java.util.ArrayList;

import kr.spring.contents.vo.CalendarVO;
import kr.spring.util.DateUtil;

public interface CalendarService {

	// 캘린더 등록
	public void insertCalendar(CalendarVO calendarVO);

	// 캘린더 수정
	public void updateCalendar(CalendarVO calendarVO);

	// 캘린더 삭제
	public void deleteCalendar(CalendarVO calendarVO);

	// 캘린더에 등록되는 컨텐츠 정보
	public ArrayList<CalendarVO> selectList(int mem_num, String db_startDate, String db_endDate, DateUtil dateData);

	// 캘린더 기등록여부 확인
	public String checkDate(CalendarVO calendarVO);

	// 같은 날짜에 몇개의 캘린더가 등록되어 있는지 확인
	public int getCountCalendar(CalendarVO calendarVO);
}
