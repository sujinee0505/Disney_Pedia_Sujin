package kr.spring.contents.vo;

import java.util.Date;
import java.util.List;

public class ContentsVO {
	private int contents_num; // 컨텐츠 id
	private String contents_type; // 컨텐츠 유형(movie, tv)
	private String title; // 컨텐츠 제목
	private String overview; // 컨텐츠 줄거리
	private String poster_path; // 컨텐츠 포스터 사진
	private Date release_date; // 컨텐츠 공개일
	private float vote_average; // 컨텐츠 평점
	private float popularity; // 인기도
	private String genre; // 컨텐츠 장르(String 타입으로 변환시켜 저장)
	private String runtime; // 컨텐츠 런타임
	private List<Integer> genres; // 컨텐츠 장르(int 타입 그대로 List객체에 저장)
	private int count;
	private Double star; // 평점

	public int getContents_num() {
		return contents_num;
	}

	public void setContents_num(int contents_num) {
		this.contents_num = contents_num;
	}

	public String getContents_type() {
		return contents_type;
	}

	public void setContents_type(String contents_type) {
		this.contents_type = contents_type;
	}

	public float getPopularity() {
		return popularity;
	}

	public void setPopularity(float popularity) {
		this.popularity = popularity;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOverview() {
		return overview;
	}

	public void setOverview(String overview) {
		this.overview = overview;
	}

	public String getPoster_path() {
		return poster_path;
	}

	public void setPoster_path(String poster_path) {
		this.poster_path = "https://image.tmdb.org/t/p/original/" + poster_path;

	}

	public Date getRelease_date() {
		return release_date;
	}

	public void setRelease_date(Date release_date) {
		this.release_date = release_date;
	}

	public float getVote_average() {
		return vote_average;
	}

	public void setVote_average(float vote_average) {
		this.vote_average = vote_average;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getRuntime() {
		return runtime;
	}

	public void setRuntime(String runtime) {
		// 영화일 경우 러닝 타임을 숫자 형태의 값을 시간 형태로 변환
		if (!runtime.contains("시즌")) {
			int run_time = Integer.parseInt(runtime);
			int hours = 0;
			int minutes = 0;
			if (run_time < 60) {
				minutes = run_time;
				this.runtime = minutes + "분";
			} else if (run_time % 60 == 0) {
				hours = run_time % 60;
				this.runtime = hours + "시간";
			} else {
				hours = run_time / 60;
				minutes = run_time % 60;
				this.runtime = hours + "시간 " + minutes + "분";
			}
		} else {
			this.runtime = runtime;
		}
	}

	public List<Integer> getGenres() {
		return genres;
	}

	public void setGenres(List<Integer> genres) {
		this.genres = genres;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Double getStar() {
		return star;
	}

	public void setStar(Double star) {
		this.star = star;
	}



}
