package com.route.model;

import java.util.List;
import java.util.Set;

import com.activity.model.ActivityVO;
import com.spot.model.SpotVO;
import com.trip.model.TripVO;

public class RouteService {
	private RouteDAO_interface dao;

	public RouteService() {
		dao = new RouteDAO();
	}

	public RouteVO addRoute(Integer tripno, Integer spotno, Integer actno,
			Integer routeseq,String days) {

		RouteVO routeVO = new RouteVO();

		routeVO.setTripno(tripno);
		routeVO.setSpotno(spotno);
		routeVO.setActno(actno);
		routeVO.setRouteseq(routeseq);
		routeVO.setDays(days);
		dao.insert(routeVO);

		return routeVO;
	}

	public RouteVO updateRoute(Integer routeno, Integer tripno, Integer spotno,
			Integer actno, Integer routeseq,String days) {

		RouteVO routeVO = new RouteVO();

		routeVO.setRouteno(routeno);
		routeVO.setTripno(tripno);
		routeVO.setSpotno(spotno);
		routeVO.setActno(actno);
		routeVO.setRouteseq(routeseq);
		routeVO.setDays(days);
		dao.update(routeVO);
		
		return routeVO;
	}

	public List<RouteVO> getAll() {
		return dao.getAll();
	}

	public RouteVO getSpotno(Integer tripno) {
		return dao.findSpotno(tripno);
	}
	
	public List<RouteVO> findByForeignKey(Integer tripno, Integer days){
		return dao.findByForeignKey(tripno, days);
		
	}

	public List<TripVO> getTripsByTripno(Integer tripno) {
		return dao.getTripsByTripno(tripno);
	}
	public List<SpotVO> getSpotsByspotno(Integer spotno) {
		return dao.getSpotsByspotno(spotno);
	}
	
	public Integer getMaxDay(Integer tripno){
		return dao.getMaxDay(tripno);
		
	}
	public void deleteRoute(Integer tripno) {
		dao.delete(tripno);
	}
}
