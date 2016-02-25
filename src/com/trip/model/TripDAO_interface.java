package com.trip.model;

import java.util.*;


public interface TripDAO_interface {

	public Integer insert(TripVO tripVO);

	public void update(TripVO tripVO);

	public void delete(Integer tripno);

	public TripVO findByPrimaryKey(Integer tripno);

	public List<TripVO> getAll();
	
	public List<TripVO> getTripsByMemno(Integer memno);

}
