package com.spot.model;

import hibernate.util.HibernateUtil;

import java.util.*;
import java.io.*;
import java.nio.file.Files;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;

import com.activity.model.ActivityVO;

public class SpotDAO implements SpotDAO_interface
{
	private static final String GET_ALL = "from SpotVO order by spotno desc";
	public void insert(SpotVO spotVO)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(spotVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	public void update(SpotVO spotVO)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(spotVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	public void delete(Integer spotno)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();

			SpotVO spotVO = new SpotVO();
			spotVO.setSpotno(spotno);
			session.delete(spotVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	public SpotVO findPrimaryKey(Integer spotno)
	{
		SpotVO spotVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			spotVO = (SpotVO) session.get(SpotVO.class, spotno);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return spotVO;
	}
	
	public List<SpotVO> getAll()
	{
		List<SpotVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	
	@Override
	public List<SpotVO> getAll(Map<String, String[]> map) 
	{
		List<SpotVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from SpotVO "+getContition(map));
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

		return list;
	}
	
	private String getContition(Map<String, String[]> map) 
	{
		Set<String> keys = map.keySet();
		StringBuffer Contition = new StringBuffer();
		int count=0;
		String order = null;
		for(String key:keys)
		{
			String value = map.get(key)[0];
			if(value !=null && value.length() !=0)
			{
				String aContition = get_acontition_for_oracle(key ,value.trim());
				if(!"order by".equals(key))
				{
					count++;
					
					if(count==1)
					{
						
						Contition.append(" where " + aContition);
					}
					else
					{					
						Contition.append(" and " + aContition);					
					}
				}
				else
				{
					order = aContition;
				}				
			}
		}
		if(order!=null)
		{
			Contition.append(" " + order);
		}
		return Contition.toString();
	}
	private String get_acontition_for_oracle(String key, String value) 
	{
		String aContition = null;
		if("spotno".equals(key) || "memno".equals(key) || "spotlook".equals(key) ||
				"spotlat".equals(key) || "spotlong".equals(key) || "spotstay".equals(key))
		{
			aContition = key + "=" + value;
		}
		else if("spotclass".equals(key) || "spotcon".equals(key) || "spottown".equals(key) ||
				"spotname".equals(key) || "spotphone".equals(key) || "spotaddress".equals(key) ||
				"spotcontent".equals(key) || "spotsite".equals(key) || "spotsort".equals(key) ||
				"spotstatus".equals(key))
		{
			aContition = key + " like '%" + value + "%'";
		}
		else if("order by".equals(key))
		{
			aContition = key + " " + value;
		}
		else if("rownum".equals(key))
		{
			aContition = key + " " + value;
		}
		return aContition;
	}
}
