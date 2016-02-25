package com.spotboard.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class SpotboardVO implements Serializable
{
	private Integer sbno;
	private Integer spotno;
	private Integer memno;
	private String sbcontent;
	private Timestamp sbtime;
	public Integer getSbno() {
		return sbno;
	}
	public void setSbno(Integer sbno) {
		this.sbno = sbno;
	}
	public Integer getSpotno() {
		return spotno;
	}
	public void setSpotno(Integer spotno) {
		this.spotno = spotno;
	}
	public Integer getMemno() {
		return memno;
	}
	public void setMemno(Integer memno) {
		this.memno = memno;
	}
	public String getSbcontent() {
		return sbcontent;
	}
	public void setSbcontent(String sbcontent) {
		this.sbcontent = sbcontent;
	}
	public Timestamp getSbtime() {
		return sbtime;
	}
	public void setSbtime(Timestamp sbtime) {
		this.sbtime = sbtime;
	}
}
