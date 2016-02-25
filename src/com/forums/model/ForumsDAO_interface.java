package com.forums.model;

import java.util.List;

public interface ForumsDAO_interface {
	      public void insert(ForumsVO forumsVO);
          public void update(ForumsVO forumsVO);
          public void delete(Integer forno);
          public ForumsVO findByPrimaryKey(Integer forno);
	      public List<ForumsVO> getAll();
}