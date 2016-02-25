package com.spotboard.model;

import hibernate.util.HibernateUtil;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;

import com.spot.model.SpotVO;

public class SpotboardDAO implements SpotboardDAO_interface
{
	private static final String GET_All = "from SpotboardVO order by sbno desc";
	@Override
	public void insert(SpotboardVO spotboardVO) 
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(spotboardVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}


	@Override
	public void delete(Integer sbno) 
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();

			SpotboardVO sbVO = new SpotboardVO();
			sbVO.setSbno(sbno);
			session.delete(sbVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	@Override
	public List<SpotboardVO> getAll() 
	{
		List<SpotboardVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_All);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	@Override
	public List<SpotboardVO> getAll(Map<String, String[]> map) 
	{
		List<SpotboardVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from SpotboardVO "+getContition(map));
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
		if("sbno".equals(key) || "spotno".equals(key) || "memno".equals(key))
		{
			aContition = key + "=" + value;
		}
		else if("sbcontent".equals(key))
		{
			aContition = key + " like '%" + value + "%'";
		}
		else if("sbtime".equals(key))
		{
			aContition = "to_char(" + key + ",'YYYY-MM-DD hh:mm a')>='" + value + "'";
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
