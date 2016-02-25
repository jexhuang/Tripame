package com.forumsrep.model;

import java.sql.Timestamp;
import java.util.*;

public interface ForumsrepDAO_interface {
	public void insert(ForumsrepVO forumsrepVO);
    public void update(ForumsrepVO forumsrepVO);
    public void deleteByForno(Integer forno);
    public List<ForumsrepVO> findByPrimaryKey(Integer forno);
    public List<ForumsrepVO> getAll();
    public Integer getCount(Integer forno);
    public Timestamp getLastTime(Integer forno);
    public void deleteByRepno(Integer repno);
    public ForumsrepVO findByRepno(Integer repno);
}
