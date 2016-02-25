package com.spotboard.model;

import java.util.List;
import java.util.Map;

public interface SpotboardDAO_interface 
{
	public void insert(SpotboardVO spotboardVO);
	public void delete(Integer sbno);
	public List<SpotboardVO> getAll();
	public List<SpotboardVO> getAll(Map<String ,String[]> map);
}
