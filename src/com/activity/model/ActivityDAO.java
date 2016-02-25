package com.activity.model;

import hibernate.util.HibernateUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;

import com.emp.model.EmpVO;


public class ActivityDAO implements ActivityDAO_interface
{
	
	private static final String GET_ALL_STMT = "from ActivityVO order by actno desc";
	@Override
	public void insert(ActivityVO activityVO) 
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(activityVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

		
	}

	@Override
	public void update(ActivityVO activityVO) 
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(activityVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	@Override
	public void delete(Integer actno) 
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();

			ActivityVO activityVO = new ActivityVO();
			activityVO.setActno(actno);
			session.delete(activityVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

	}

	@Override
	public ActivityVO findPrimaryKey(Integer actno) 
	{
		ActivityVO actVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			actVO = (ActivityVO) session.get(ActivityVO.class, actno);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return actVO;

	}

	@Override
	public List<ActivityVO> getAll() 
	{
		List<ActivityVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;

	}
	
	@Override
	public List<ActivityVO> getAll(Map<String, String[]> map) 
	{
		List<ActivityVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from ActivityVO "+getContition(map));
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
		if("actno".equals(key) || "acthours".equals(key) || "actlat".equals(key) ||
				"actlong".equals(key) || "actprice".equals(key) || "actstay".equals(key))
		{
			aContition = key + "=" + value;
		}
		else if("actcon".equals(key) || "acttown".equals(key) || "actname".equals(key) ||
				"actphone".equals(key) || "actaddress".equals(key) || "actcontent".equals(key) ||
				"actsite".equals(key) || "actorg".equals(key) || "actstatus".equals(key))
		{
			aContition = key + " like '%" + value + "%'";
		}
		else if("actbegin".equals(key))
		{
			aContition = "to_char(" + key + ",'yyyy-mm-dd')<='" + value + "'";
		}
		else if("actend".equals(key))
		{
			aContition = "to_char(" + key + ",'yyyy-mm-dd')>='" + value + "'";
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
