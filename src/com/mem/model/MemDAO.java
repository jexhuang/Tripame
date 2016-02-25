package com.mem.model;

import hibernate.util.HibernateUtil;

import java.util.*;
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


public class MemDAO implements MemDAO_interface {
  
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可

	private static final String GET_ALL_STMT = "FROM MemVO order by memno desc";
	private static final String GET_KEY="select mem_seq.currVal from dual";
	@Override
	public void insert(MemVO memVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();			
			session.saveOrUpdate(memVO);
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		}	
	}

	@Override
	public MemVO update(MemVO memVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(memVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

		return memVO;
		

	}

	@Override
	public void delete(Integer memno) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();


			MemVO memVO = new MemVO();
			memVO.setMemno(memno);
			session.delete(memVO);


			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}


	}

	@Override
	public MemVO findByPrimaryKey(Integer memno) {

		MemVO memVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			memVO = (MemVO) session.get(MemVO.class, memno);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}


		return memVO;
	}

	@Override
	public List<MemVO> getAll() {
		
		List<MemVO> list = null;
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