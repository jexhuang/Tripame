package com.trajoin.model;

import java.util.List;
import java.util.Map;

public class TrajoinService {

	private TrajoinDAO_interface dao;

	public TrajoinService() {
		dao = new TrajoinDAO();
	}

	public TrajoinVO addTrajoin(Integer travelno,Integer memno) {

		TrajoinVO trajoinVO = new TrajoinVO();
		trajoinVO.setMemno(memno);
		trajoinVO.setTravelno(travelno);
		dao.insert(trajoinVO);
		return trajoinVO;
	}

	public TrajoinVO updateTrajoin(Integer travelno,Integer memno) {

		TrajoinVO trajoinVO = new TrajoinVO();

		trajoinVO.setTravelno(travelno);
		trajoinVO.setMemno(memno);
		dao.update(trajoinVO);

		return trajoinVO;
	}

	public void deleteTrajoin(Integer travelno) {
		dao.delete(travelno);
	}
	
	public void deleteByMem(Integer travelno,Integer memno){
		dao.deleteByMem(travelno, memno);
	}

	public List<TrajoinVO> getOneTrajoin(Integer travelno) {
		return dao.findByPrimaryKey(travelno);
	}

	public List<TrajoinVO> getAll() {
		return dao.getAll();
	}
	

}
