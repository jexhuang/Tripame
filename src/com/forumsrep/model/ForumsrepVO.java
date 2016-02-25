package com.forumsrep.model;

import java.sql.Date;
import java.sql.Timestamp;

public class ForumsrepVO implements java.io.Serializable {
	private Integer repno;
	private Integer forno;
	private Integer memno;
	private String repcontent;
	private Timestamp reptime;
	public Integer getRepno() {
		return repno;
	}
	public void setRepno(Integer repno) {
		this.repno = repno;
	}
	public Integer getForno() {
		return forno;
	}
	public void setForno(Integer forno) {
		this.forno = forno;
	}
	public Integer getMemno() {
		return memno;
	}
	public void setMemno(Integer memno) {
		this.memno = memno;
	}
	public String getRepcontent() {
		return repcontent;
	}
	public void setRepcontent(String repcontent) {
		this.repcontent = repcontent;
	}
	public Timestamp getReptime() {
		return reptime;
	}
	public void setReptime(Timestamp reptime) {
		this.reptime = reptime;
	}

}
