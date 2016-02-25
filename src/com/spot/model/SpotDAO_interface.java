package com.spot.model;
import java.util.*;

public interface SpotDAO_interface 
{
	public void insert(SpotVO spotvo);
	public void update(SpotVO spotVO);
	public SpotVO findPrimaryKey(Integer spotno);
	public List<SpotVO> getAll();
	public List<SpotVO> getAll(Map<String ,String[]> map);
}
