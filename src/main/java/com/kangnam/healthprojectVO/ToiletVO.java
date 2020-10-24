package com.kangnam.healthprojectVO;

public class ToiletVO {
	String pt_city, pt_kind, pt_name, pt_addr1, pt_addr2;
	String pt_m_handi1, pt_m_handi2, pt_f_handi;
	String pt_tel, pt_time, pt_lat, pt_lng;
	
	public String getPt_city() {
		return pt_city;
	}
	
	public void setPt_city(String pt_city) {
		this.pt_city = pt_city;
	}
	
	public String getPt_kind() {
		return pt_kind;
	}
	
	public void setPt_kind(String pt_kind) {
		this.pt_kind = pt_kind;
	}
	
	public String getPt_name() {
		return pt_name;
	}
	
	public void setPt_name(String pt_name) {
		this.pt_name = pt_name;
	}
	
	public String getPt_addr1() {
		return pt_addr1;
	}
	
	public void setPt_addr1(String pt_addr1) {
		this.pt_addr1 = pt_addr1;
	}
	
	public String getPt_addr2() {
		return pt_addr2;
	}
	
	public void setPt_addr2(String pt_addr2) {
		this.pt_addr2 = pt_addr2;
	}
	
	public String getPt_m_handi1() {
		return pt_m_handi1;
	}
	
	public void setPt_m_handi1(String pt_m_handi1) {
		this.pt_m_handi1 = pt_m_handi1;
	}
	
	public String getPt_m_handi2() {
		return pt_m_handi2;
	}
	
	public void setPt_m_handi2(String pt_m_handi2) {
		this.pt_m_handi2 = pt_m_handi2;
	}
	
	public String getPt_f_handi() {
		return pt_f_handi;
	}
	
	public void setPt_f_handi(String pt_f_handi) {
		this.pt_f_handi = pt_f_handi;
	}
	
	public String getPt_tel() {
		return pt_tel;
	}
	
	public void setPt_tel(String pt_tel) {
		this.pt_tel = pt_tel;
	}
	
	public String getPt_time() {
		return pt_time;
	}
	
	public void setPt_time(String pt_time) {
		this.pt_time = pt_time;
	}
	
	public String getPt_lat() {
		return pt_lat;
	}
	
	public void setPt_lat(String pt_lat) {
		this.pt_lat = pt_lat;
	}
	
	public String getPt_lng() {
		return pt_lng;
	}
	
	public void setPt_lng(String pt_lng) {
		this.pt_lng = pt_lng;
	}

	@Override
	public String toString() {
		return "ToiletVO [pt_city=" + pt_city + ", pt_kind=" + pt_kind + ", pt_name=" + pt_name + ", pt_addr1="
				+ pt_addr1 + ", pt_addr2=" + pt_addr2 + ", pt_m_handi1=" + pt_m_handi1 + ", pt_m_handi2=" + pt_m_handi2
				+ ", pt_f_handi=" + pt_f_handi + ", pt_tel=" + pt_tel + ", pt_time=" + pt_time + ", pt_lat=" + pt_lat
				+ ", pt_lng=" + pt_lng + "]";
	}

	
}
