package kr.spring.contents.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.contents.vo.CalendarVO;
import kr.spring.util.DateUtil;

public interface CalendarMapper {

	// 캘린더 등록
	@Insert("INSERT INTO dcontents_cal (cal_num,custom_date,contents_num,contents_type,poster_path,mem_num) "
			+ "VALUES (dcontents_cal_seq_NEXTVAL(),#{custom_date},#{contents_num},#{contents_type},#{poster_path},#{mem_num})")
	public void insertCalendar(CalendarVO calendarVO);

	// 캘린더 수정
	@Update("UPDATE dcontents_cal SET custom_date=#{custom_date} WHERE contents_num = #{contents_num} AND contents_type = #{contents_type} AND mem_num = #{mem_num}")
	public void updateCalendar(CalendarVO calendarVO);

	// 캘린더 삭제
	@Delete("DELETE FROM dcontents_cal  WHERE contents_num = #{contents_num} AND contents_type = #{contents_type} AND mem_num = #{mem_num}")
	public void deleteCalendar(CalendarVO calendarVO);

	// 캘린더에 등록되는 컨텐츠 정보
	@Select("SELECT DATE_FORMAT(custom_date, '%Y-%m-%d') as custom_date, contents_num, contents_type, poster_path FROM dcontents_cal "
			+ "WHERE mem_num=#{mem_num} AND custom_date BETWEEN #{db_startDate} AND #{db_endDate} ")
	public ArrayList<CalendarVO> selectList(@Param("mem_num") Integer mem_num,
			@Param("db_startDate") String db_startDate, @Param("db_endDate") String db_endDate, DateUtil dateData);

	// 캘린더 기등록여부 확인
	@Select("SELECT DATE_FORMAT(custom_date, '%Y-%m-%d') as custom_date FROM dcontents_cal WHERE contents_num = #{contents_num} AND contents_type = #{contents_type} AND mem_num = #{mem_num}")
	public String checkDate(CalendarVO calendarVO);

	// 같은 날짜에 몇개의 캘린더가 등록되어 있는지 확인
	@Select("SELECT COUNT(*) FROM dcontents_cal WHERE mem_num=#{mem_num} AND custom_date =#{custom_date}")
	public int getCountCalendar(CalendarVO calendarVO);
}
