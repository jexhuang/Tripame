package com.route.model;

import java.util.*;

import com.activity.model.ActivityVO;
import com.spot.model.SpotVO;
import com.trip.model.TripVO;


public interface RouteDAO_interface {

	public void insert(RouteVO routeVO);

	public void update(RouteVO routeVO);

	public void delete(Integer routeVO);

	public RouteVO findSpotno(Integer routeno);

	public List<RouteVO> getAll();
	
	public List<TripVO> getTripsByTripno(Integer tripno);

	public List<SpotVO> getSpotsByspotno(Integer spotno);
	
	public Integer getMaxDay(Integer tripno);

	List<RouteVO> findByForeignKey(Integer tripno, Integer days);
}
