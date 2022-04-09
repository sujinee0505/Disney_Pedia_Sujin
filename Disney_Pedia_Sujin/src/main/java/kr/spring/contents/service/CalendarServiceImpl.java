package kr.spring.contents.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.contents.dao.CalendarMapper;
import kr.spring.contents.vo.CalendarVO;
import kr.spring.util.DateUtil;

@Service
public class CalendarServiceImpl implements CalendarService {
	@Autowired
	private CalendarMapper calendarMapper;

	// 캘린더 등록
	@Override
	public void insertCalendar(CalendarVO calendarVO) {
		calendarMapper.insertCalendar(calendarVO);
	}

	// 캘린더 수정
	@Override
	public void updateCalendar(CalendarVO calendarVO) {
		calendarMapper.updateCalendar(calendarVO);
	}

	// 캘린더 삭제
	@Override
	public void deleteCalendar(CalendarVO calendarVO) {
		calendarMapper.deleteCalendar(calendarVO);
	}

	// 캘린더에 등록되는 컨텐츠 정보
	@Override
	public ArrayList<CalendarVO> selectList(int mem_num, String db_startDate, String db_endDate, DateUtil dateData) {
		return calendarMapper.selectList(mem_num, db_startDate, db_endDate, dateData);
	}

	// 캘린더 기등록여부 확인
	@Override
	public String checkDate(CalendarVO calendarVO) {
		return calendarMapper.checkDate(calendarVO);
	}

	// 같은 날짜에 몇개의 캘린더가 등록되어 있는지 확인
	@Override
	public int getCountCalendar(CalendarVO calendarVO) {
		return calendarMapper.getCountCalendar(calendarVO);
	}

}
