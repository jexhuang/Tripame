package com.forumsrep.model;

import java.sql.Timestamp;
import java.util.List;

public class ForumsrepService {

	private ForumsrepDAO_interface dao;

	public ForumsrepService() {
		dao = new ForumsrepDAO();
	}

	public ForumsrepVO addForumsrep(Integer forno, Integer memno,String repcontent,Timestamp reptime
			) {
		
		
		ForumsrepVO forumsrepVO = new ForumsrepVO();

		forumsrepVO.setForno(forno);
		forumsrepVO.setMemno(memno);
		forumsrepVO.setRepcontent(repcontent);
		forumsrepVO.setReptime(reptime);
		dao.insert(forumsrepVO);

		return forumsrepVO;
	}

	public ForumsrepVO updateForumsrep(Integer repno, Integer forno, Integer memno,String repcontent,Timestamp reptime
			) {

		ForumsrepVO forumsrepVO = new ForumsrepVO();
		
		forumsrepVO.setRepno(repno);
		forumsrepVO.setForno(forno);
		forumsrepVO.setMemno(memno);
		forumsrepVO.setRepcontent(repcontent);
		forumsrepVO.setReptime(reptime);
		dao.update(forumsrepVO);

		return forumsrepVO;
	}

	public void deleteForumsrep(Integer forno) {
		dao.deleteByForno(forno);
	}

	public List<ForumsrepVO> getOneForumsrep(Integer forno) {
		return dao.findByPrimaryKey(forno);
	}

	public List<ForumsrepVO> getAll() {
		return dao.getAll();
	}
	public Integer getCount(Integer forno){
		return dao.getCount(forno);
	}
	 public Timestamp getLastTime(Integer forno){
		 return dao.getLastTime(forno);
	 }
	 public void deleteByRepno(Integer repno){
		 dao.deleteByRepno(repno);
	 }
	 public ForumsrepVO findByRepno(Integer repno){
		 return dao.findByRepno(repno);
	 }
}
