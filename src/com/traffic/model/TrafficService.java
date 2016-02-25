package com.traffic.model;

import java.util.List;
import java.util.Map;

public class TrafficService {

	private TrafficDAO_interface dao;

	public TrafficService() {
		dao = new TrafficDAO();
	}

	public TrafficVO addTraffic(String traclass, String traname,String traphone,String tracon,
			String traaddress, String trasite) {

		TrafficVO trafficVO = new TrafficVO();

		trafficVO.setTraclass(traclass);
		trafficVO.setTraname(traname);
		trafficVO.setTraphone(traphone);
		trafficVO.setTracon(tracon);
		trafficVO.setTraaddress(traaddress);
		trafficVO.setTrasite(trasite);
		dao.insert(trafficVO);

		return trafficVO;
	}

	public TrafficVO updateTraffic(Integer trano, String traclass, String traname,String traphone,String tracon,
			String traaddress, String trasite) {

		TrafficVO trafficVO = new TrafficVO();
		
		trafficVO.setTrano(trano);
		trafficVO.setTraclass(traclass);
		trafficVO.setTraname(traname);
		trafficVO.setTraphone(traphone);
		trafficVO.setTracon(tracon);
		trafficVO.setTraaddress(traaddress);
		trafficVO.setTrasite(trasite);
		dao.update(trafficVO);

		return trafficVO;
	}

	public void deleteTraffic(Integer trano) {
		dao.delete(trano);
	}

	public TrafficVO getOneTraffic(Integer trano) {
		return dao.findByPrimaryKey(trano);
	}

	public List<TrafficVO> getAll() {
		return dao.getAll();
	}
	
	public List<TrafficVO> getAll(Map<String,String[]> map)
	{
		return dao.getAll(map);
	}
}
