package com.spotboard.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class SpotboardService 
{
	private SpotboardDAO_interface dao = null;
	
	public SpotboardService()
	{
		dao = new SpotboardDAO();
	}
	
	public void insertSb(Integer spotno,Integer memno,String sbcontent,Timestamp sbtime)
	{
		SpotboardVO spotboardVO = new SpotboardVO();
		spotboardVO.setSpotno(spotno);
		spotboardVO.setMemno(memno);
		spotboardVO.setSbcontent(sbcontent);
		spotboardVO.setSbtime(sbtime);
		dao.insert(spotboardVO);
	}
	
	public void delete(Integer sbno)
	{
		dao.delete(sbno);
	}
	
	public List<SpotboardVO> getAll()
	{
		return dao.getAll();
	}

	public List<SpotboardVO> getAll(Map<String ,String[]> map)
	{
		return dao.getAll(map);
	}
}
