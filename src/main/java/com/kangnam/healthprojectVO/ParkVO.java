package com.kangnam.healthprojectVO;

public class ParkVO {
	String pk_city, pk_name, pk_kind, pk_addr;
	String pk_lat, pk_lng, pk_tel;
	String etc1, etc2, etc3, etc4;
	
	public String getPk_city() {
		return pk_city;
	}
	public void setPk_city(String pk_city) {
		this.pk_city = pk_city;
	}
	public String getPk_name() {
		return pk_name;
	}
	public void setPk_name(String pk_name) {
		this.pk_name = pk_name;
	}
	public String getPk_kind() {
		return pk_kind;
	}
	public void setPk_kind(String pk_kind) {
		this.pk_kind = pk_kind;
	}
	public String getPk_addr() {
		return pk_addr;
	}
	public void setPk_addr(String pk_addr) {
		this.pk_addr = pk_addr;
	}
	public String getPk_lat() {
		return pk_lat;
	}
	public void setPk_lat(String pk_lat) {
		this.pk_lat = pk_lat;
	}
	public String getPk_lng() {
		return pk_lng;
	}
	public void setPk_lng(String pk_lng) {
		this.pk_lng = pk_lng;
	}
	public String getPk_tel() {
		return pk_tel;
	}
	public void setPk_tel(String pk_tel) {
		this.pk_tel = pk_tel;
	}
	
	public String getEtc1() {
		return etc1;
	}
	public void setEtc1(String etc1) {
		this.etc1 = etc1;
	}
	public String getEtc2() {
		return etc2;
	}
	public void setEtc2(String etc2) {
		this.etc2 = etc2;
	}
	public String getEtc3() {
		return etc3;
	}
	public void setEtc3(String etc3) {
		this.etc3 = etc3;
	}
	public String getEtc4() {
		return etc4;
	}
	public void setEtc4(String etc4) {
		this.etc4 = etc4;
	}
	
	@Override
	public String toString() {
		return "ParkVO [pk_city=" + pk_city + ", pk_name=" + pk_name + ", pk_kind=" + pk_kind + ", pk_addr=" + pk_addr
				+ ", pk_lat=" + pk_lat + ", pk_lng=" + pk_lng + ", pk_tel=" + pk_tel + ", etc1=" + etc1 + ", etc2="
				+ etc2 + ", etc3=" + etc3 + ", etc4=" + etc4 + "]";
	}
	
}
