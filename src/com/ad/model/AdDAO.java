package com.ad.model;

import hibernate.util.HibernateUtil;

import java.util.*;
import java.sql.Date;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;

import com.emp.model.EmpVO;
import com.mem.model.MemVO;

public class AdDAO implements AdDAO_interface {
	
	private static final String GET_ALL_STMT = "FROM AdVO order by adno desc";
	private static final String ADEND ="Select Min(adend) from AdVO where adstatus like '上架中'";
	@Override
	public void insert(AdVO adVO) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(adVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}


	}

	@Override
	public void update(AdVO adVO) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(adVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

	}

	@Override
	public void delete(Integer adno) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			AdVO adVO = new AdVO();
			adVO.setAdno(adno);
			session.delete(adVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	@Override
	public AdVO findByPrimaryKey(Integer adno) {

		AdVO adVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			adVO = (AdVO) session.get(AdVO.class, adno);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return adVO;
	}
	@Override
	public Date getEndDate(){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Date date=null;
		try {
			session.beginTransaction();
			Query query = session.createQuery(ADEND);
			date=(Date)query.list().get(0);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}	
			
		return date;
		
	}
	
	@Override
	public List<AdVO> getAll() {
		List<AdVO> list = null;
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
}