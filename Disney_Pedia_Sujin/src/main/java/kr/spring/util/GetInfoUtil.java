package kr.spring.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import kr.spring.contents.vo.ContentsVO;
import kr.spring.contents.vo.CreditsVO;

public class GetInfoUtil {

	// TMDB API KEY
	private final String KEY = "d4bdd7b053d3ab0a1ed909424e2bb707";
	// API를 통해 추출한 json형태의 결과값을 저장할 변수 result
	private String result = "";

	// 페이지 단위로 데이터를 제공하기 때문에 총 페이지 수를 알기 위한 메소드
	public int getPages(String type) {
		int page = 0;

		try {
			// 데이터를 받아오기 위한 API 호출 URL, type (영화인지 시리즈인지에 따라 결과 값이 달라짐)
			URL url = new URL("https://api.themoviedb.org/3/discover/" + type + "?api_key=" + KEY
					+ "&with_watch_providers=337&watch_region=KR&language=ko");

			// URL 객체를 통해서 url을 연결한 후 API가 제공하는 원본데이터를 가져와서 버퍼에 저장
			BufferedReader bf;

			/*
			 * BufferedReader는 속성에 Reader 클래스가 와야하는데, URL에서 제공되는 메소드인 openStream() 사용하기 위해
			 * InputStreamReader를 속성으로 사용. 한글이 깨지는 경우가 있어서 UTF-8을 추가.
			 */
			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

			// 읽어온 Buffer 데이터를 readLine() 메소드를 사용해서 한줄씩 읽어 result변수에 저장
			result = bf.readLine();

			/*
			 * 현재까지는 result에 저장되어 있는 값은 String타입이므로 json타입으로 인식하도록 바꾸기 위해서 JSON 관련 라이브러리를 사용
			 * JSONParser를 사용해서 String 값을 json 객체로 만들어준다.
			 */
			JSONParser jsonParser = new JSONParser();

			// 만들어진 JSON 객체는 JSONObject 사용해서 저장
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);

			// 만들어진 JSONObject에서 key가 total_pages인 value를 추출하기 위해서 get() 사용
			String pages = jsonObject.get("total_pages").toString();

			page = Integer.parseInt(pages);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	// 컨텐츠 리스트 추출
	public List<ContentsVO> getInfoList(String type) {
		int pages = getPages(type);

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String date = "0001-01-01";

		List<ContentsVO> infoList = null;
		List<Integer> genreList = null;
		try {

			infoList = new ArrayList<ContentsVO>();

			// 페이지 마다 루프를 돌며 값 추출 및 저장
			for (int i = 1; i <= pages; i++) {
				String apiURL = "https://api.themoviedb.org/3/discover/" + type + "?api_key=" + KEY
						+ "&with_watch_providers=337&watch_region=KR&language=ko&page=" + i;
				URL url = new URL(apiURL);

				BufferedReader bf;

				bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

				result = bf.readLine();

				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
				JSONArray list = (JSONArray) jsonObject.get("results");

				for (int j = 0; j < list.size(); j++) {
					genreList = new ArrayList<Integer>();
					ContentsVO vo = new ContentsVO();
					JSONObject contents = (JSONObject) list.get(j);

					vo.setContents_num(Integer.parseInt(String.valueOf(contents.get("id"))));
					vo.setContents_type(type);
					vo.setOverview(contents.get("overview").toString());
					vo.setVote_average(Float.parseFloat(String.valueOf(contents.get("vote_average"))));
					vo.setPopularity(Float.parseFloat(String.valueOf(contents.get("popularity"))));
					// 컨텐츠 타입(영화/시리즈)에 따라서 파싱 방법 다르게 설정
					if (type.equals("movie")) {
						// 시리즈일 경우 release_date를 key로 데이터 파싱
						if (contents.get("release_date") == null || contents.get("release_date").equals("")) {
							vo.setRelease_date(dateFormat.parse(date));
						} else {
							Date release_date = dateFormat.parse((String) contents.get("release_date"));
							vo.setRelease_date(release_date);
						}
						vo.setTitle(contents.get("title").toString());
					} else if (type.equals("tv")) {
						// 시리즈일 경우 first_air_date를 key로 데이터 파싱
						if (contents.get("first_air_date") == null || contents.get("first_air_date").equals("")) {
							vo.setRelease_date(dateFormat.parse(date));
						} else {
							Date first_air_date = dateFormat.parse((String) contents.get("first_air_date"));
							vo.setRelease_date(first_air_date);
						}
						// 시리즈일 경우 title이 아닌 name을 key로 데이터 파싱
						vo.setTitle(contents.get("name").toString());
					}
					if (contents.get("poster_path") == null || contents.get("poster_path").toString().equals("")) {
						vo.setPoster_path("");
					} else {
						vo.setPoster_path(contents.get("poster_path").toString());
					}

					// 장르 id를 List<integer> 형태로 저장 → 장르 비교를 위한 작업
					JSONArray genre_list = (JSONArray) contents.get("genre_ids");
					for (int k = 0; k < genre_list.size(); k++) {
						genreList.add(Integer.parseInt(String.valueOf(genre_list.get(k))));
					}
					vo.setGenres(genreList);
					infoList.add(vo);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return infoList;
	}

	// 컨텐츠 상세정보 추출 (해당 컨텐츠 id로 검색)
	public ContentsVO getInfoDetail(String contents_type, int id) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		ContentsVO contents = new ContentsVO();
		String genres = "";
		List<Integer> genreList = null;
		try {

			String apiURL = "https://api.themoviedb.org/3/" + contents_type + "/" + id + "?api_key=" + KEY
					+ "&language=ko-KR";
			URL url = new URL(apiURL);

			BufferedReader bf;

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

			result = bf.readLine();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);

			contents.setContents_num(Integer.parseInt(String.valueOf(jsonObject.get("id"))));
			contents.setContents_type(contents_type);
			contents.setOverview(jsonObject.get("overview").toString());
			contents.setVote_average(Float.parseFloat(String.valueOf(jsonObject.get("vote_average"))));
			contents.setPoster_path(jsonObject.get("poster_path").toString());
			if (contents_type.equals("movie")) {
				Date release_date = dateFormat.parse((String) jsonObject.get("release_date"));
				contents.setRelease_date(release_date);
				contents.setTitle(jsonObject.get("title").toString());
				contents.setRuntime(jsonObject.get("runtime").toString());

			} else if (contents_type.equals("tv")) {
				Date first_air_date = dateFormat.parse((String) jsonObject.get("first_air_date"));
				contents.setRelease_date(first_air_date);
				contents.setTitle(jsonObject.get("name").toString());
				// 시리즈일 경우 러닝 타임이 아니라 시즌과 에피소드 개수로 표현
				contents.setRuntime("시즌 : " + jsonObject.get("number_of_seasons").toString() + "개</br>총 에피소드 : "
						+ jsonObject.get("number_of_episodes").toString() + "개");
			}

			genreList = new ArrayList<Integer>();
			JSONArray genre_list = (JSONArray) jsonObject.get("genres");
			for (int i = 0; i < genre_list.size(); i++) {
				JSONObject genre = (JSONObject) genre_list.get(i);
				// List<Integer> 형태로 저장 → 저장 형태 :  [1, 3, 15]
				genreList.add(Integer.parseInt(String.valueOf(genre.get("id"))));
				// String 타입으로 저장 → 저장 형태 : 드라마 / 멜로
				if (i == 0) {
					genres += genre.get("name");
				} else {
					genres += "/" + genre.get("name");
				}
			}
			contents.setGenres(genreList);
			contents.setGenre(genres);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return contents;
	}

	// 갤러리에 이미지 출력
	public List<String> getImages(String type, int id) {
		// 이미지 주소를 String타입으로 List에 저장
		List<String> image_list = null;
		try {
			image_list = new ArrayList<String>();

			String apiURL = "https://api.themoviedb.org/3/" + type + "/" + id + "/images?api_key=" + KEY;

			URL url = new URL(apiURL);

			BufferedReader bf;

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

			result = bf.readLine();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONArray list = (JSONArray) jsonObject.get("backdrops");

			for (int j = 0; j < list.size(); j++) {
				String file_path = new String();
				JSONObject images = (JSONObject) list.get(j);
				file_path = images.get("file_path").toString();
				image_list.add(file_path);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return image_list;
	}

	// 감독 및 배우 추출
	public List<CreditsVO> getCredits(String type, int id, String kind) {
		// 데이터를 파싱해서 VO객체에 저장한 뒤 List에 저장
		List<CreditsVO> creditList = null;
		try {
			creditList = new ArrayList<CreditsVO>();
			String apiURL = "https://api.themoviedb.org/3/" + type + "/" + id + "/credits?api_key=" + KEY;
			URL url = new URL(apiURL);

			BufferedReader bf;

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

			result = bf.readLine();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONArray list = (JSONArray) jsonObject.get(kind);

			// 배우 목록	
			if (kind.equals("cast")) {
				for (int i = 0; i < list.size(); i++) {
					JSONObject credits = (JSONObject) list.get(i);
					CreditsVO vo = new CreditsVO();
					if (credits.get("known_for_department").equals("Acting")) {
						vo.setName(credits.get("name").toString());
						if (credits.get("profile_path") == null) {
							vo.setProfile_path("");
						} else {
							vo.setProfile_path(credits.get("profile_path").toString());
						}
						creditList.add(vo);
					}
				}
				// 감독 목록
			} else if (kind.equals("crew")) {
				for (int i = 0; i < list.size(); i++) {
					JSONObject credits = (JSONObject) list.get(i);
					CreditsVO vo = new CreditsVO();
					if (credits.get("known_for_department").equals("Directing")) {
						vo.setName(credits.get("name").toString());
						if (credits.get("profile_path") == null) {
							vo.setProfile_path("");
						} else {
							vo.setProfile_path(credits.get("profile_path").toString());
						}
						creditList.add(vo);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return creditList;
	}
}