package com.route.model;

import java.sql.Date;

public class RouteVO implements java.io.Serializable {
	private Integer routeno;
	private Integer tripno;
	private Integer spotno;
	private Integer actno;
	private Integer routeseq;
	private String days;
	
	public Integer getRouteseq() {
		return routeseq;
	}
	public void setRouteseq(Integer routeseq) {
		this.routeseq = routeseq;
	}
	public Integer getRouteno() {
		return routeno;
	}
	public void setRouteno(Integer routeno) {
		this.routeno = routeno;
	}
	public Integer getTripno() {
		return tripno;
	}
	public void setTripno(Integer tripno) {
		this.tripno = tripno;
	}
	public Integer getSpotno() {
		return spotno;
	}
	public void setSpotno(Integer spotno) {
		this.spotno = spotno;
	}
	public Integer getActno() {
		return actno;
	}
	public void setActno(Integer actno) {
		this.actno = actno;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
}
