package com.forums.model;
import java.sql.Timestamp;
public class ForumsVO  implements java.io.Serializable{
	private Integer forno;
	private Integer memno;
	private String forclass;
	private String fortheme;
	private String forcontent;
	private Timestamp fortime;
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
	public String getForclass() {
		return forclass;
	}
	public void setForclass(String forclass) {
		this.forclass = forclass;
	}
	public String getFortheme() {
		return fortheme;
	}
	public void setFortheme(String fortheme) {
		this.fortheme = fortheme;
	}
	public String getForcontent() {
		return forcontent;
	}
	public void setForcontent(String forcontent) {
		this.forcontent = forcontent;
	}
	public Timestamp getFortime() {
		return fortime;
	}
	public void setFortime(Timestamp fortime) {
		this.fortime = fortime;
	}
	
	}
