package com.rec.model;

import java.sql.Date;

public class RecVO  implements java.io.Serializable{
	private Integer recno;
	private Integer memno;
	private String recclass;
	private String recsort;
	private String reccon;
	private String rectown;
	private String recname;
	private String recphone;
	private String recaddress;
	private String reccontent;
	private byte[] recpic;
	private String recsite;
	private Double reclat;
	private Double reclong;
	private String recstatus;
	private String recmessage;
	
	public String getRecmessage() {
		return recmessage;
	}
	public void setRecmessage(String recmessage) {
		this.recmessage = recmessage;
	}
	public Integer getRecno() {
		return recno;
	}
	public void setRecno(Integer recno) {
		this.recno = recno;
	}
	public Integer getMemno() {
		return memno;
	}
	public void setMemno(Integer memno) {
		this.memno = memno;
	}
	public String getRecclass() {
		return recclass;
	}
	public void setRecclass(String recclass) {
		this.recclass = recclass;
	}
	public String getRecsort() {
		return recsort;
	}
	public void setRecsort(String recsort) {
		this.recsort = recsort;
	}
	public String getReccon() {
		return reccon;
	}
	public void setReccon(String reccon) {
		this.reccon = reccon;
	}
	public String getRectown() {
		return rectown;
	}
	public void setRectown(String rectown) {
		this.rectown = rectown;
	}
	public String getRecname() {
		return recname;
	}
	public void setRecname(String recname) {
		this.recname = recname;
	}
	public String getRecphone() {
		return recphone;
	}
	public void setRecphone(String recphone) {
		this.recphone = recphone;
	}
	public String getRecaddress() {
		return recaddress;
	}
	public void setRecaddress(String recaddress) {
		this.recaddress = recaddress;
	}
	public String getReccontent() {
		return reccontent;
	}
	public void setReccontent(String reccontent) {
		this.reccontent = reccontent;
	}
	public byte[] getRecpic() {
		return recpic;
	}
	public void setRecpic(byte[] recpic) {
		this.recpic = recpic;
	}
	public String getRecsite() {
		return recsite;
	}
	public void setRecsite(String recsite) {
		this.recsite = recsite;
	}
	public Double getReclat() {
		return reclat;
	}
	public void setReclat(Double reclat) {
		this.reclat = reclat;
	}
	public Double getReclong() {
		return reclong;
	}
	public void setReclong(Double reclong) {
		this.reclong = reclong;
	}
	public String getRecstatus() {
		return recstatus;
	}
	public void setRecstatus(String recstatus) {
		this.recstatus = recstatus;
	}
	
	
}
