package kr.spring.sort;

import java.util.Comparator;
import java.util.Date;
import java.util.List;
import kr.spring.util.GetInfoUtil;
import kr.spring.contents.vo.ContentsVO;

public class SortByVote implements Comparator<ContentsVO> {

	@Override
	public int compare(ContentsVO o1, ContentsVO o2) {

		float first = o1.getVote_average();
		float second = o2.getVote_average();
		if (first < second) {
			return 1;
		} else if (first > second) {
			return -1;
		} else {
			return 0;
		}

	}

}
