package com.traffic.model;

import java.sql.Date;

public class TrafficVO  implements java.io.Serializable{
	private Integer trano;
	private String traclass;
	private String traname;
	private String traphone;
	private String tracon;
	private String traaddress;
	private String trasite;
	
	public Integer getTrano() {
		return trano;
	}
	public void setTrano(Integer trano) {
		this.trano = trano;
	}
	public String getTraclass() {
		return traclass;
	}
	public void setTraclass(String traclass) {
		this.traclass = traclass;
	}
	public String getTraname() {
		return traname;
	}
	public void setTraname(String traname) {
		this.traname = traname;
	}
	public String getTraphone() {
		return traphone;
	}
	public void setTraphone(String traphone) {
		this.traphone = traphone;
	}
	public String getTracon() {
		return tracon;
	}
	public void setTracon(String tracon) {
		this.tracon = tracon;
	}
	public String getTraaddress() {
		return traaddress;
	}
	public void setTraaddress(String traaddress) {
		this.traaddress = traaddress;
	}
	public String getTrasite() {
		return trasite;
	}
	public void setTrasite(String trasite) {
		this.trasite = trasite;
	}


}
