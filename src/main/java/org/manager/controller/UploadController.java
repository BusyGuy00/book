package org.manager.controller;



import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.manager.domain.ProductAttachDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@Controller
public class UploadController {
	//년/월.일 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
			
		return str.replace("-", File.separator);
	}
	//파일이 이미지 파일인지 체크하기
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			//이미지 파일인지 확인후 맞으면 true리턴
			return contentType.startsWith("image");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		}
	//화면에 보이게 설정 
		@GetMapping("/uploadForm")
		public void uploadForm() {
				
				log.info("upload form");
		}
		@PostMapping("/uploadFormAction")
		public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
			String uploadFolder = "C://upload";
			for(MultipartFile multipartfile : uploadFile) {
				//업로드 확인 하기 위한 로그 출력
				log.info("-------------------------------");
				log.info("파일 이름 : " + multipartfile.getOriginalFilename());
				log.info("파일 크기 : " + multipartfile.getSize());
				
				//원하는 위치에 파일 업로드 처리 
				File saveFile = new File(uploadFolder, multipartfile.getOriginalFilename());
					try {			//transferTo이 저장 하는 명령어
						multipartfile.transferTo(saveFile);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
		}
		@GetMapping("/uploadAjax")
		public void uploadAjax() {
			log.info("upload ajax");
		}
		@PostMapping("/uploadAjaxAction")
			//객체 타입으로 리턴이여서 제이슨 형식로 보여준다
		public ResponseEntity<List<ProductAttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
			//List 타입으로 변경후 추가 
			List<ProductAttachDTO> list = new ArrayList<ProductAttachDTO>();
			log.info("upload ajax post...........");
			String uploadFolder = "C://upload";
			//getFolder()를 통해 날짜를 가진 문자열로 바꿔서 저장이 된다.
			String uploadFolderPath = getFolder();
			//폴더 생성하기
			File uploadPath = new File(uploadFolder,uploadFolderPath);
			log.info("uploadPath : " + uploadPath);
			//생성된 폴더가 없으면 생성하라는 if문 
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
			for(MultipartFile multipartfile : uploadFile) {
				//List 타입으로 변경후 추가 
				ProductAttachDTO attachDTO = new ProductAttachDTO();
				//업로드 확인 하기 위한 로그 출력
				log.info("-------------------------------");
				log.info("파일 이름 : " + multipartfile.getOriginalFilename());
				log.info("파일 크기 : " + multipartfile.getSize());
				//lastIndexOf("\\"을 이용해 뒤에 있는 경로가 지워지고 저장된다.
				String uploadFileName = multipartfile.getOriginalFilename();
				uploadFileName = uploadFileName.substring(uploadFileName
						.lastIndexOf("\\")+1);
				//원하는 위치에 파일 업로드 처리 
				//File saveFile = new File(uploadFolder, multipartfile.getOriginalFilename());
				log.info("only file name : " + uploadFileName);
				//List 타입으로 변경후 추가 
				
				//파일 이름 필드에 할당
				//uuid 추가 하기 전에 file을 넣어 ㅈ자
				attachDTO.setFilename(uploadFileName);
				//중복방지 UUID사용하기
				//임의의 값ㅇ 생성 
				UUID uuid = UUID.randomUUID();
				uploadFileName = uuid.toString()+"_"+uploadFileName;
				//List 타입으로 변경후 추가 
				//uuid 필드에 할당
				//attachDTO.setUuid(uuid.toString());
				//List 타입으로 변경후 추가 
				//이미지 경로 필드에 할당 
				//attachDTO.setUploadPath(uploadFolder);
				File saveFile = new File(uploadPath, uploadFileName);
					try {
						multipartfile.transferTo(saveFile);
						//파일이 이미지 파일이라면 썸네일 이미지 생성하기
						if(checkImageType(saveFile)) {
							attachDTO.setImage(true);
							FileOutputStream thumbnail = new FileOutputStream(new File(
									uploadPath, "s_"+uploadFileName)); // 파일 생성하고 저장경로에 저장 그리고 s_를 붙인다
							Thumbnailator.createThumbnail(multipartfile.getInputStream(),
									thumbnail, 100,100);
							thumbnail.close();
						}
						//파일 이름 필드에 할당
						//attachDTO.setFileName(uploadFileName);
						//uuid 필드에 할당
						attachDTO.setUuid(uuid.toString());
						//이미지 경로 필드에 할당 
						attachDTO.setUploadpath(uploadFolderPath);
						//attachDTO.setUploadPath(uploadFolder+"\\"+ uploadFolderPath);
						list.add(attachDTO);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			return new ResponseEntity<List<ProductAttachDTO>>(list, HttpStatus.OK);
		}
		//썸네일 데이터 전송하기 
		//fileName을 전달받고 byte로 전송해준다
		@GetMapping("/display")
		@ResponseBody
		public ResponseEntity<byte[]> getFile(String filename){
			log.info("dddddddddddddddddddddddddddddddddd");
			log.info("여기에요 filename : " + filename);
			File file = new File("C:\\upload\\"+filename);
			ResponseEntity<byte[]> result = null;
			HttpHeaders header = new HttpHeaders();
			try {
				header.add("Content-Type", Files.probeContentType(file.toPath()));
				result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),
						header, HttpStatus.OK);	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return result;
		}
		//첨부파일 삭제 
		@PostMapping("/deleteFile")
		@ResponseBody
		public ResponseEntity<String> deleteFile(String fileName, String type){
			log.info("deleteFile : " + fileName);
			File file;
			try {
				file = new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
				file.delete();
				//이미지 파일 이라면 원본 이미지도 제거
				if(type.equals("image")) {
					String largeFileName = file.getAbsolutePath().replace("s_","");
					log.info("largeFileName : " + largeFileName);
					file = new File(largeFileName);
					file.delete();
				}
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return new ResponseEntity<String>("deleted" , HttpStatus.OK);
		}
}
