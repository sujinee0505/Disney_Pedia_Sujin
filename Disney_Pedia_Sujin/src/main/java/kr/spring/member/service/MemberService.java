package kr.spring.member.service;

import java.util.List;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	
	public int checkId(String id);
	
	public void insertMember(MemberVO member);

	public MemberVO selectCheckMember(String id);

	public MemberVO selectMember(Integer mem_num);

	public void updateMember(MemberVO member);

	public void updatePassword(MemberVO member);

	public void deleteMember(Integer mem_num);

	public void updateProfile(MemberVO member);

	// 유저 검색 (수진)
	public List<MemberVO> searchUsers(String name);
}
