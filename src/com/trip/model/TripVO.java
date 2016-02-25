package com.trip.model;

import java.sql.Timestamp;


public class TripVO implements java.io.Serializable {
	private String tripname;
	private Integer tripno;
	private Integer memno;
	private Double triplong;
	private Double triplat;
	private Timestamp tripbegin;
	private Timestamp tripend;
	
	public String getTripname() {
		return tripname;
	}

	public void setTripname(String tripname) {
		this.tripname = tripname;
	}

	public Integer getTripno() {
		return tripno;
	}

	public void setTripno(Integer tripno) {
		this.tripno = tripno;
	}

	public Integer getMemno() {
		return memno;
	}

	public void setMemno(Integer memno) {
		this.memno = memno;
	}

	public Double getTriplong() {
		return triplong;
	}

	public void setTriplong(Double triplong) {
		this.triplong = triplong;
	}

	public Double getTriplat() {
		return triplat;
	}

	public void setTriplat(Double triplat) {
		this.triplat = triplat;
	}

	public Timestamp getTripbegin() {
		return tripbegin;
	}

	public void setTripbegin(Timestamp tripbegin) {
		this.tripbegin = tripbegin;
	}

	public Timestamp getTripend() {
		return tripend;
	}

	public void setTripend(Timestamp tripend) {
		this.tripend = tripend;
	}

}
