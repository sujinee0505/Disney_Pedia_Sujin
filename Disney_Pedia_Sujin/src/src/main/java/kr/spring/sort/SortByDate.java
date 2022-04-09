package kr.spring.sort;

import java.util.Comparator;
import java.util.Date;
import java.util.List;
import kr.spring.util.GetInfoUtil;
import kr.spring.contents.vo.ContentsVO;

public class SortByDate implements Comparator<ContentsVO> {

	@Override
	public int compare(ContentsVO o1, ContentsVO o2) {
		Date first = o1.getRelease_date();
		Date second = o2.getRelease_date();
		return second.compareTo(first);

	}
}
