package com.travel.model;

import java.util.List;

public class TravelService {

	private TravelDAO_interface dao;

	public TravelService() {
		dao = new TravelDAO();
	}

	public TravelVO addTravel(String Travelname,java.sql.Date Travelbegin,java.sql.Date Travelend,
			String Travelcontent,Integer Travellimit,java.sql.Date Traveldeadline,
			byte[] Travelpic,String Travelstatus,Integer Travelprice) {

		TravelVO travelVO = new TravelVO();

		travelVO.setTravelname(Travelname);
		travelVO.setTravelbegin(Travelbegin);
		travelVO.setTravelend(Travelend);
		travelVO.setTravelcontent(Travelcontent);
		travelVO.setTravellimit(Travellimit);
		travelVO.setTraveldeadline(Traveldeadline);
		travelVO.setTravelpic(Travelpic);
		travelVO.setTravelstatus(Travelstatus);
		travelVO.setTravelprice(Travelprice);
		dao.insert(travelVO);

		return travelVO;
	}

	public TravelVO updateTravel(Integer Travelno,String Travelname,java.sql.Date Travelbegin,java.sql.Date Travelend,
			String Travelcontent,Integer Travellimit,java.sql.Date Traveldeadline,
			byte[] Travelpic,String Travelstatus,Integer Travelprice) {

		TravelVO travelVO = new TravelVO();
		
		travelVO.setTravelno(Travelno);
		travelVO.setTravelname(Travelname);
		travelVO.setTravelbegin(Travelbegin);
		travelVO.setTravelend(Travelend);
		travelVO.setTravelcontent(Travelcontent);
		travelVO.setTravellimit(Travellimit);
		travelVO.setTraveldeadline(Traveldeadline);
		travelVO.setTravelpic(Travelpic);
		travelVO.setTravelstatus(Travelstatus);
		travelVO.setTravelprice(Travelprice);
		dao.update(travelVO);
		return travelVO;
	}

	public void deleteTravel(Integer travelno) {
		dao.delete(travelno);
	}

	public TravelVO getOneTravel(Integer travelno) {
		return dao.findByPrimaryKey(travelno);
	}

	public List<TravelVO> getAll() {
		return dao.getAll();
	}
}
