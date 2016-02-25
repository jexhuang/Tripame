package com.forums.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class ForumsService {

	private ForumsDAO_interface dao;

	public ForumsService() {
		dao = new ForumsDAO();
	}

	public ForumsVO addForums(Integer memno, String forclass, String fortheme,
			String forcontent, Timestamp fortime) {
		
		ForumsVO forumsVO = new ForumsVO();

		forumsVO.setMemno(memno);
		forumsVO.setForclass(forclass);
		forumsVO.setFortheme(fortheme);
		forumsVO.setForcontent(forcontent);
		forumsVO.setFortime(fortime);
		dao.insert(forumsVO);

		return forumsVO;
	}

	public ForumsVO updateForums(Integer forno, Integer memno, String forclass, 
			String fortheme,String forcontent, Timestamp fortime) {

		ForumsVO forumsVO = new ForumsVO();
		
		forumsVO.setForno(forno);
		forumsVO.setMemno(memno);
		forumsVO.setForclass(forclass);
		forumsVO.setFortheme(fortheme);
		forumsVO.setForcontent(forcontent);
		forumsVO.setFortime(fortime);
		dao.update(forumsVO);

		return forumsVO;
	}

	public void deleteForums(Integer forno) {
		dao.delete(forno);
	}

	public ForumsVO getOneForums(Integer forno) {
		return dao.findByPrimaryKey(forno);
	}

	public List<ForumsVO> getAll() {
		return dao.getAll();
	}
}
