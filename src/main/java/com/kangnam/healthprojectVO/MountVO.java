package com.kangnam.healthprojectVO;

public class MountVO {
	String mt_name, mt_addr, mt_tel, mt_city, mt_town, mt_lat, mt_lng;
	String mt_park, mt_baby, mt_pet;
	
	public String getMt_name() {
		return mt_name;
	}
	public void setMt_name(String mt_name) {
		this.mt_name = mt_name;
	}
	public String getMt_addr() {
		return mt_addr;
	}
	public void setMt_addr(String mt_addr) {
		this.mt_addr = mt_addr;
	}
	public String getMt_tel() {
		return mt_tel;
	}
	public void setMt_tel(String mt_tel) {
		this.mt_tel = mt_tel;
	}
	public String getMt_city() {
		return mt_city;
	}
	public void setMt_city(String mt_city) {
		this.mt_city = mt_city;
	}
	public String getMt_town() {
		return mt_town;
	}
	public void setMt_town(String mt_town) {
		this.mt_town = mt_town;
	}
	public String getMt_lat() {
		return mt_lat;
	}
	public void setMt_lat(String mt_lat) {
		this.mt_lat = mt_lat;
	}
	public String getMt_lng() {
		return mt_lng;
	}
	public void setMt_lng(String mt_lng) {
		this.mt_lng = mt_lng;
	}
	public String getMt_park() {
		return mt_park;
	}
	public void setMt_park(String mt_park) {
		this.mt_park = mt_park;
	}
	public String getMt_baby() {
		return mt_baby;
	}
	public void setMt_baby(String mt_baby) {
		this.mt_baby = mt_baby;
	}
	public String getMt_pet() {
		return mt_pet;
	}
	public void setMt_pet(String mt_pet) {
		this.mt_pet = mt_pet;
	}
	
	@Override
	public String toString() {
		return "MountVO [mt_name=" + mt_name + ", mt_addr=" + mt_addr + ", mt_tel=" + mt_tel + ", mt_city=" + mt_city
				+ ", mt_town=" + mt_town + ", mt_lat=" + mt_lat + ", mt_lng=" + mt_lng + ", mt_park=" + mt_park
				+ ", mt_baby=" + mt_baby + ", mt_pet=" + mt_pet + "]";
	}
	
}
