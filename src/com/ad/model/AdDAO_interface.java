package com.ad.model;

import java.util.*;
import java.sql.Date;

public interface AdDAO_interface {
	      public void insert(AdVO adVO);
          public void update(AdVO adVO);
          public void delete(Integer adno);
          public AdVO findByPrimaryKey(Integer adno);
	      public List<AdVO> getAll();
	      public Date getEndDate();
}
