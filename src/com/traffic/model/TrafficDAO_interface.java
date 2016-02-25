package com.traffic.model;

import java.util.*;

public interface TrafficDAO_interface {
	      public void insert(TrafficVO trafficVO);
          public void update(TrafficVO trafficVO);
          public void delete(Integer trafficVO);
          public TrafficVO findByPrimaryKey(Integer trafficVO);
	      public List<TrafficVO> getAll();
	      public List<TrafficVO> getAll(Map<String,String[]> map);
}
