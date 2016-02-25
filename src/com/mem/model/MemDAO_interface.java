package com.mem.model;

import java.util.*;
import com.mem.model.MemVO;

public interface MemDAO_interface {
	      public void insert(MemVO memVO);
          public MemVO update(MemVO memVO);
          public void delete(Integer memno);
          public MemVO findByPrimaryKey(Integer memno);
	      public List<MemVO> getAll();
	      
}
