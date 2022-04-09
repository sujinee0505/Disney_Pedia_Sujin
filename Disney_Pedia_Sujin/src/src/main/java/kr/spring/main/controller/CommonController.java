package kr.spring.main.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CommonController {

	@RequestMapping("/common/imageUploader.do")
	@ResponseBody
	public Map<String,Object> uploadImage(MultipartFile upload,
			                              HttpSession session,
			                              HttpServletResponse response,
			                              HttpServletRequest request)
			                            		      throws Exception{
		//업로드할 폴더 경로
		String realFolder = 
		session.getServletContext().getRealPath("/resources/image_upload");
		
		//업로드할 파일 이름
		String org_filename = upload.getOriginalFilename();
		String str_filename = System.currentTimeMillis() + org_filename;
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		String filepath = realFolder + "\\" + user_num + "\\" + str_filename;
		
		File f = new File(filepath);
		if(!f.exists()) {
			f.mkdirs();
		}
		upload.transferTo(f);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uploaded",true);
		map.put("url",
		request.getContextPath()+"/resources/image_upload/"+user_num+"/"+str_filename);
		
		return map;
	}
}





