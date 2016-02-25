package com.activity.model;

import java.io.Serializable;
import java.sql.Date;

public class ActivityVO implements Serializable
{
	private Integer actno;
	private String actcon;
	private String acttown;
	private String actname;
	private String actphone;
	private String actaddress;
	private String actcontent;
	private byte[] actpic;
	private String actsite;
	private String actorg;
	private Date actbegin;
	private Date actend;
	private Integer acthours;
	private Double actlat;
	private Double actlong;
	private Integer actprice;
	private String actstatus;
	private Integer actstay;
	public Integer getActno() {
		return actno;
	}
	public void setActno(Integer actno) {
		this.actno = actno;
	}
	public String getActcon() {
		return actcon;
	}
	public void setActcon(String actcon) {
		this.actcon = actcon;
	}
	public String getActtown() {
		return acttown;
	}
	public void setActtown(String acttown) {
		this.acttown = acttown;
	}
	public String getActname() {
		return actname;
	}
	public void setActname(String actname) {
		this.actname = actname;
	}
	public String getActphone() {
		return actphone;
	}
	public void setActphone(String actphone) {
		this.actphone = actphone;
	}
	public String getActaddress() {
		return actaddress;
	}
	public void setActaddress(String actaddress) {
		this.actaddress = actaddress;
	}
	public String getActcontent() {
		return actcontent;
	}
	public void setActcontent(String actcontent) {
		this.actcontent = actcontent;
	}
	public byte[] getActpic() {
		return actpic;
	}
	public void setActpic(byte[] actpic) {
		this.actpic = actpic;
	}
	public String getActsite() {
		return actsite;
	}
	public void setActsite(String actsite) {
		this.actsite = actsite;
	}
	public String getActorg() {
		return actorg;
	}
	public void setActorg(String actorg) {
		this.actorg = actorg;
	}
	public Date getActbegin() {
		return actbegin;
	}
	public void setActbegin(Date actbegin) {
		this.actbegin = actbegin;
	}
	public Date getActend() {
		return actend;
	}
	public void setActend(Date actend) {
		this.actend = actend;
	}
	public Integer getActhours() {
		return acthours;
	}
	public void setActhours(Integer acthours) {
		this.acthours = acthours;
	}
	public Double getActlat() {
		return actlat;
	}
	public void setActlat(Double actlat) {
		this.actlat = actlat;
	}
	public Double getActlong() {
		return actlong;
	}
	public void setActlong(Double actlong) {
		this.actlong = actlong;
	}
	public Integer getActprice() {
		return actprice;
	}
	public void setActprice(Integer actprice) {
		this.actprice = actprice;
	}
	public String getActstatus() {
		return actstatus;
	}
	public void setActstatus(String actstatus) {
		this.actstatus = actstatus;
	}
	public Integer getActstay() {
		return actstay;
	}
	public void setActstay(Integer actstay) {
		this.actstay = actstay;
	}
}
