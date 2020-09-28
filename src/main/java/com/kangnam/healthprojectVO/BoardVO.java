package com.kangnam.healthprojectVO;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component("boardvo")
public class BoardVO {
	private int seq;
	private String location;
    private int likes;
    private int bookmark;
    private String comments;
    private String caption;
    private String filepath;
    private MultipartFile file;
    private String id;
    
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBookmark() {
		return bookmark;
	}
	public void setBookmark(int bookmark) {
		this.bookmark = bookmark;
	}
	
	@Override
	public String toString() {
		return "BoardVO [seq=" + seq + ", location=" + location + ", likes=" + likes + ", bookmark=" + bookmark
				+ ", comments=" + comments + ", caption=" + caption + ", filepath=" + filepath + ", file=" + file
				+ ", id=" + id + "]";
	}
	
	
	
}
