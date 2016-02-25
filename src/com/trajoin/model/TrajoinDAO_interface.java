package com.trajoin.model;

import java.util.*;

public interface TrajoinDAO_interface {
	public void insert(TrajoinVO trajoinVO);

	public void update(TrajoinVO trajoinVO);

	public void delete(Integer travelno);

	public List<TrajoinVO> findByPrimaryKey(Integer travelno);

	public List<TrajoinVO> getAll();
	
	public void deleteByMem(Integer travelno,Integer memno);


}