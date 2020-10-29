package com.kangnam.healthprojectVO;

public class WorkoutVO {
	String wo_name, wo_addr, wo_kind, wo_city, wo_town;
	String wo_lat, wo_lng, wo_admin;
	
	public String getWo_name() {
		return wo_name;
	}
	public void setWo_name(String wo_name) {
		this.wo_name = wo_name;
	}
	public String getWo_addr() {
		return wo_addr;
	}
	public void setWo_addr(String wo_addr) {
		this.wo_addr = wo_addr;
	}
	public String getWo_kind() {
		return wo_kind;
	}
	public void setWo_kind(String wo_kind) {
		this.wo_kind = wo_kind;
	}
	public String getWo_city() {
		return wo_city;
	}
	public void setWo_city(String wo_city) {
		this.wo_city = wo_city;
	}
	public String getWo_town() {
		return wo_town;
	}
	public void setWo_town(String wo_town) {
		this.wo_town = wo_town;
	}
	public String getWo_lat() {
		return wo_lat;
	}
	public void setWo_lat(String wo_lat) {
		this.wo_lat = wo_lat;
	}
	public String getWo_lng() {
		return wo_lng;
	}
	public void setWo_lng(String wo_lng) {
		this.wo_lng = wo_lng;
	}
	public String getWo_admin() {
		return wo_admin;
	}
	public void setWo_admin(String wo_admin) {
		this.wo_admin = wo_admin;
	}
	
	@Override
	public String toString() {
		return "WorkoutVO [wo_name=" + wo_name + ", wo_addr=" + wo_addr + ", wo_kind=" + wo_kind + ", wo_city="
				+ wo_city + ", wo_town=" + wo_town + ", wo_lat=" + wo_lat + ", wo_lng=" + wo_lng + ", wo_admin="
				+ wo_admin + "]";
	}
}
