package com.activity.model;

import java.sql.Date;
import java.util.*;

public interface ActivityDAO_interface 
{
	public void insert(ActivityVO activityVO);
	public void update(ActivityVO activityVO);
	public void delete(Integer actno);
	public ActivityVO findPrimaryKey(Integer actno);
	public List<ActivityVO> getAll();
	public List<ActivityVO> getAll(Map<String ,String[]> map);
}
