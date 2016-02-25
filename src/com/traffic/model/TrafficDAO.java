package com.traffic.model;

import hibernate.util.HibernateUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;

import com.activity.model.ActivityVO;
import com.mem.model.MemVO;

public class TrafficDAO implements TrafficDAO_interface {

	private static final String GET_ALL_STMT = "FROM TrafficVO";

	@Override
	public void insert(TrafficVO trafficVO) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(trafficVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}	

	}

	@Override
	public void update(TrafficVO trafficVO) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(trafficVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}	
	}

	@Override
	public void delete(Integer trano) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();


			TrafficVO traVO = new TrafficVO();
			traVO.setTrano(trano);
			session.delete(traVO);


			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	@Override
	public TrafficVO findByPrimaryKey(Integer trano) {

		TrafficVO traVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			traVO = (TrafficVO) session.get(TrafficVO.class, trano);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}


		return traVO;
	}

	@Override
	public List<TrafficVO> getAll() {
		List<TrafficVO> list = null;
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
	public List<TrafficVO> getAll(Map<String,String[]> map) {

		List<TrafficVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from TrafficVO "+getContition(map));
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
		if("trano".equals(key))
		{
			aContition = key + "=" + value;
		}
		else if("traclass".equals(key) || "traname".equals(key) || "traphone".equals(key) ||
				"tracon".equals(key) || "traaddress".equals(key) || "trasite".equals(key))
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