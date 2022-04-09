package kr.spring.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

public interface MemberMapper {
	// 사용자	
	@Select("SELECT dmember_seq.nextval FROM dual")
	public int selectMem_num();

	@Insert("INSERT INTO dmember (mem_num,id) VALUES (#{mem_num},#{id})")
	public void insertMember(MemberVO member); //회원가입(1)

	@Insert("INSERT INTO dmember_detail (mem_num,name,passwd) VALUES (#{mem_num},#{name},#{passwd})")
	public void insertMember_detail(MemberVO member); //회원가입(2)

	@Select("SELECT COUNT(*) FROM dmember where id=#{id}")
	public int checkId(String id); //아이디중복체크(1)
	
	@Select("SELECT m.mem_num,m.id,m.auth,d.passwd,d.photo,d.photo_name "
			+ "FROM dmember m LEFT OUTER JOIN dmember_detail d " + "ON m.mem_num=d.mem_num WHERE m.id=#{id}")
	public MemberVO selectCheckMember(String id); //아이디중복체크(2)

	@Select("SELECT * FROM dmember m JOIN dmember_detail d " + "ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num); //회원정보

	@Update("UPDATE dmember_detail SET name=#{name},introduction=#{introduction},modify_date=SYSDATE "
			+ "WHERE mem_num=#{mem_num}")
	public void updateMember(MemberVO member);

	@Update("UPDATE dmember_detail SET passwd=#{passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member);

	@Update("UPDATE dmember SET auth=0 WHERE mem_num=#{mem_num}")
	public void deleteMember(Integer mem_num);

	@Delete("DELETE FROM dmember_detail WHERE mem_num=#{mem_num}")
	public void deleteMember_detail(Integer mem_num);

	@Update("UPDATE dmember_detail SET photo=#{photo},photo_name=#{photo_name} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);

	// 유저 검색 (수진)
	public List<MemberVO> searchUsers(String name);
}
