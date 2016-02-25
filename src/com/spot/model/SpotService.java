package com.spot.model;

import java.util.*;
public class SpotService 
{
	private SpotDAO_interface dao = null;
	
	public SpotService()
	{
		dao = new SpotDAO();
	}
	
	public SpotVO insertSpot(Integer memno,String spotclass,String spotcon,String spottown,String spotname,
			String spotphone,String spotaddress, String spotcontent,String spotsite,String spotsort,Integer spotlook,
			Double spotlat,Double spotlong,String spotstatus,Integer spotstay,byte[] spotpic)
	{
		SpotVO spotVO = new SpotVO();
		spotVO.setMemno(memno);
		spotVO.setSpotclass(spotclass);
		spotVO.setSpotcon(spotcon);
		spotVO.setSpottown(spottown);
		spotVO.setSpotname(spotname);
		spotVO.setSpotphone(spotphone);
		spotVO.setSpotaddress(spotaddress);
		spotVO.setSpotcontent(spotcontent);
		spotVO.setSpotsite(spotsite);
		spotVO.setSpotsort(spotsort);
		spotVO.setSpotlook(spotlook);
		spotVO.setSpotlat(spotlat);
		spotVO.setSpotlong(spotlong);
		spotVO.setSpotstatus(spotstatus);
		spotVO.setSpotstay(spotstay);
		spotVO.setSpotpic(spotpic);
		dao.insert(spotVO);
		return spotVO;
	}
	
	public SpotVO updateSpot(Integer spotno,Integer memno,String spotclass,String spotcon,String spottown,String spotname,
			String spotphone,String spotaddress, String spotcontent,String spotsite,String spotsort,Integer spotlook,
			Double spotlat,Double spotlong,String spotstatus,Integer spotstay,byte[] spotpic)
	{
		SpotVO spotVO = new SpotVO();
		spotVO.setSpotno(spotno);
		spotVO.setMemno(memno);
		spotVO.setSpotclass(spotclass);
		spotVO.setSpotcon(spotcon);
		spotVO.setSpottown(spottown);
		spotVO.setSpotname(spotname);
		spotVO.setSpotphone(spotphone);
		spotVO.setSpotaddress(spotaddress);
		spotVO.setSpotcontent(spotcontent);
		spotVO.setSpotsite(spotsite);
		spotVO.setSpotsort(spotsort);
		spotVO.setSpotlook(spotlook);
		spotVO.setSpotlat(spotlat);
		spotVO.setSpotlong(spotlong);
		spotVO.setSpotstatus(spotstatus);
		spotVO.setSpotstay(spotstay);
		spotVO.setSpotpic(spotpic);
		dao.update(spotVO);
		return spotVO;
	}
	
	
	public SpotVO findSpot(Integer spotno)
	{
		SpotVO spotVO = dao.findPrimaryKey(spotno);		
		return spotVO;
	}
	
	public List<SpotVO> getAll()
	{
		return dao.getAll();
	}
	
	public List<SpotVO> getAll(Map<String ,String[]> map)
	{
		return dao.getAll(map);
	}
}
