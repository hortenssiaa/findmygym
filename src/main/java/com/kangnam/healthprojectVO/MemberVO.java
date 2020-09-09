package com.kangnam.healthprojectVO;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private String name;
	private String id;
	private String password;
	private String email;
	private String filepath;
	private MultipartFile file; // spring이 file을 받을때, MultipartFile 라는 type으로 받는다.
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
	
}
