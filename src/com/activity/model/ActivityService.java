package com.activity.model;

import java.sql.*;
import java.util.List;
import java.util.Map;

public class ActivityService 
{
	private ActivityDAO_interface dao = null;
	
	public ActivityService()
	{
		dao = new ActivityDAO();
	}
	
	public ActivityVO insertAct(String actcon,String acttown,String actname,String actphone,
			String actaddress,String actcontent,String actsite,String actorg,Date actbegin,
			Date actend,Integer acthours,Double actlat,Double actlong,Integer actprice,
			String actstatus,Integer actstay,byte[] actpic)
	{
		ActivityVO activityVO = new ActivityVO();
		activityVO.setActcon(actcon);
		activityVO.setActtown(acttown);
		activityVO.setActname(actname);
		activityVO.setActphone(actphone);
		activityVO.setActaddress(actaddress);
		activityVO.setActcontent(actcontent);
		activityVO.setActsite(actsite);
		activityVO.setActorg(actorg);
		activityVO.setActbegin(actbegin);
		activityVO.setActend(actend);
		activityVO.setActhours(acthours);
		activityVO.setActlat(actlat);
		activityVO.setActlong(actlong);
		activityVO.setActprice(actprice);
		activityVO.setActstatus(actstatus);
		activityVO.setActstay(actstay);
		activityVO.setActpic(actpic);
		dao.insert(activityVO);
		return activityVO;
	}
	
	public ActivityVO updateAct(Integer actno,String actcon,String acttown,String actname,String actphone,
			String actaddress,String actcontent,String actsite,String actorg,Date actbegin,
			Date actend,Integer acthours,Double actlat,Double actlong,Integer actprice,
			String actstatus,Integer actstay,byte[] actpic)
	{
		ActivityVO activityVO = new ActivityVO();
		activityVO.setActno(actno);
		activityVO.setActcon(actcon);
		activityVO.setActtown(acttown);
		activityVO.setActname(actname);
		activityVO.setActphone(actphone);
		activityVO.setActaddress(actaddress);
		activityVO.setActcontent(actcontent);
		activityVO.setActsite(actsite);
		activityVO.setActorg(actorg);
		activityVO.setActbegin(actbegin);
		activityVO.setActend(actend);
		activityVO.setActhours(acthours);
		activityVO.setActlat(actlat);
		activityVO.setActlong(actlong);
		activityVO.setActprice(actprice);
		activityVO.setActstatus(actstatus);
		activityVO.setActstay(actstay);
		activityVO.setActpic(actpic);
		dao.update(activityVO);
		return activityVO;
	} 
	
	public void deleteAct(Integer actno)
	{
		dao.delete(actno);
	}
	
	public ActivityVO findAct(Integer actno)
	{
		return dao.findPrimaryKey(actno);
	}
	
	public List<ActivityVO> getAll()
	{
		return dao.getAll();
	}
	
	public List<ActivityVO> getAll(Map<String ,String[]> map)
	{
		return dao.getAll(map);
	}
}
