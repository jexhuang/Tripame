package com.trip.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;


public class TripService {
	private TripDAO_interface dao;

	public TripService() {
		dao = new TripDAO();
	}

	public Integer addTrip(Integer memno, String tripname, Double triplong, Double triplat,
			Timestamp tripbegin, Timestamp tripend) {

		TripVO tripVO = new TripVO();

		tripVO.setMemno(memno);
		tripVO.setTripname(tripname);
		tripVO.setTriplong(triplong);
		tripVO.setTriplat(triplat);
		tripVO.setTripbegin(tripbegin);
		tripVO.setTripend(tripend);
		Integer i = dao.insert(tripVO);

		return i;
	}

	public TripVO updateTrip(Integer tripno, Integer memno, String tripname,Double triplong,
			Double triplat, Timestamp tripbegin, Timestamp tripend) {

		TripVO tripVO = new TripVO();
		
		tripVO.setTripno(tripno);
		tripVO.setMemno(memno);
		tripVO.setTripname(tripname);
		tripVO.setTriplong(triplong);
		tripVO.setTriplat(triplat);
		tripVO.setTripbegin(tripbegin);
		tripVO.setTripend(tripend);
		dao.update(tripVO);

		return tripVO;
	}

	public List<TripVO> getAll() {
		return dao.getAll();
	}

	public TripVO getOneTrip(Integer tripno) {
		return dao.findByPrimaryKey(tripno);
	}

	public List<TripVO> getTripsByMemno(Integer tripno) {
		return dao.getTripsByMemno(tripno);
	}

	public void deleteTrip(Integer tripno) {
		dao.delete(tripno);
	}
}
