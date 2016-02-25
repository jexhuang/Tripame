package com.travel.model;

import java.sql.Date;

public class TravelVO implements java.io.Serializable {
	private Integer travelno;
	private String travelname;
	private Date travelbegin;
	private Date travelend;
	private String travelcontent;
	private Integer travellimit;
	private Date traveldeadline;
	private byte[] travelpic;
	private String travelstatus;
	private Integer travelprice;
	
	
	public Integer getTravelprice() {
		return travelprice;
	}

	public void setTravelprice(Integer travelprice) {
		this.travelprice = travelprice;
	}

	/**
	 * 套裝行程編號
	 * 
	 * @return Integer
	 */
	public Integer getTravelno() {
		return travelno;
	}

	public void setTravelno(Integer travelno) {
		this.travelno = travelno;
	}

	/**
	 * 行程名稱
	 * 
	 * @return String
	 */
	public String getTravelname() {
		return travelname;
	}

	public void setTravelname(String travelname) {
		this.travelname = travelname;
	}

	/**
	 * 行程開始日期
	 * 
	 * @return Date
	 */
	public Date getTravelbegin() {
		return travelbegin;
	}

	public void setTravelbegin(Date travelbegin) {
		this.travelbegin = travelbegin;
	}

	/**
	 * 行程結束日期
	 * 
	 * @return Date
	 */
	public Date getTravelend() {
		return travelend;
	}

	public void setTravelend(Date travelend) {
		this.travelend = travelend;
	}

	/**
	 * 行程簡介
	 * 
	 * @return String
	 */
	public String getTravelcontent() {
		return travelcontent;
	}

	public void setTravelcontent(String travelcontent) {
		this.travelcontent = travelcontent;
	}


	/**
	 * 限制報名人數
	 * 
	 * @return Integer
	 */
	public Integer getTravellimit() {
		return travellimit;
	}

	public void setTravellimit(Integer travellimit) {
		this.travellimit = travellimit;
	}

	/**
	 * 報名截止日期
	 * 
	 * @return Date
	 */
	public Date getTraveldeadline() {
		return traveldeadline;
	}

	public void setTraveldeadline(Date traveldeadline) {
		this.traveldeadline = traveldeadline;
	}

	/**
	 * 圖片
	 * 
	 * @return byte[]
	 */
	public byte[] getTravelpic() {
		return travelpic;
	}

	public void setTravelpic(byte[] travelpic) {
		this.travelpic = travelpic;
	}

	/**
	 * 上架狀態
	 * 
	 * @return String
	 */
	public String getTravelstatus() {
		return travelstatus;
	}

	public void setTravelstatus(String travelstatus) {
		this.travelstatus = travelstatus;
	}
}
