package com.ad.model;

import java.sql.Date;

public class AdVO  implements java.io.Serializable{
	private Integer adno;
	private Integer memno;
	private String adclass;
	private String adsort;
	private String adcon;
	private String adtown;
	private String adname;
	private String adphone;
	private String adaddress;
	private String adcontent;
	private byte[] adpic;
	private String adsite;
	private Double adlat;
	private Double adlong;
	private String adstatus;
	private Date adbegin;
	private Date adend;
	private String admessage;
	
	
	public String getAdmessage() {
		return admessage;
	}
	public void setAdmessage(String admessage) {
		this.admessage = admessage;
	}
	public Integer getAdno() {
		return adno;
	}
	public void setAdno(Integer adno) {
		this.adno = adno;
	}
	public Integer getMemno() {
		return memno;
	}
	public void setMemno(Integer memno) {
		this.memno = memno;
	}
	public String getAdclass() {
		return adclass;
	}
	public void setAdclass(String adclass) {
		this.adclass = adclass;
	}
	public String getAdsort() {
		return adsort;
	}
	public void setAdsort(String adsort) {
		this.adsort = adsort;
	}
	public String getAdcon() {
		return adcon;
	}
	public void setAdcon(String adcon) {
		this.adcon = adcon;
	}
	public String getAdtown() {
		return adtown;
	}
	public void setAdtown(String adtown) {
		this.adtown = adtown;
	}
	public String getAdname() {
		return adname;
	}
	public void setAdname(String adname) {
		this.adname = adname;
	}
	public String getAdphone() {
		return adphone;
	}
	public void setAdphone(String adphone) {
		this.adphone = adphone;
	}
	public String getAdaddress() {
		return adaddress;
	}
	public void setAdaddress(String adaddress) {
		this.adaddress = adaddress;
	}
	public String getAdcontent() {
		return adcontent;
	}
	public void setAdcontent(String adcontent) {
		this.adcontent = adcontent;
	}
	public byte[] getAdpic() {
		return adpic;
	}
	public void setAdpic(byte[] adpic) {
		this.adpic = adpic;
	}
	public String getAdsite() {
		return adsite;
	}
	public void setAdsite(String adsite) {
		this.adsite = adsite;
	}
	public Double getAdlat() {
		return adlat;
	}
	public void setAdlat(Double adlat) {
		this.adlat = adlat;
	}
	public Double getAdlong() {
		return adlong;
	}
	public void setAdlong(Double adlong) {
		this.adlong = adlong;
	}
	public String getAdstatus() {
		return adstatus;
	}
	public void setAdstatus(String adstatus) {
		this.adstatus = adstatus;
	}
	public Date getAdbegin() {
		return adbegin;
	}
	public void setAdbegin(Date adbegin) {
		this.adbegin = adbegin;
	}
	public Date getAdend() {
		return adend;
	}
	public void setAdend(Date adend) {
		this.adend = adend;
	}
	
	
}
