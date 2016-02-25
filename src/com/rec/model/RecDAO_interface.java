package com.rec.model;

import java.util.*;

import com.emp.model.EmpVO;

public interface RecDAO_interface {
	      public void insert(RecVO recVO);
          public void update(RecVO recVO);
          public void delete(Integer recno);
          public RecVO findByPrimaryKey(Integer recno);
	      public List<RecVO> getAll();
}
