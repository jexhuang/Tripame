package com.forumsrep.model;

import hibernate.util.HibernateUtil;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;

import com.forums.model.ForumsVO;

public class ForumsrepDAO implements ForumsrepDAO_interface{

	private static final String GET_ALL_STMT ="FROM ForumsrepVO order by reptime desc";
	private static final String GET_ONE_STMT = "FROM ForumsrepVO where forno = ? order by reptime";
	private static final String DELETE = "DELETE FROM ForumsrepVO where forno = ?";
	private static final String COUNT ="SELECT count(*) FROM ForumsrepVO where forno =?";
	private static final String LASTTIME="Select MAX(reptime) from ForumsrepVO where forno=?";
	@Override
	public void insert(ForumsrepVO forumsrepVO) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(forumsrepVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}	


	}

	@Override
	public void update(ForumsrepVO forumsrepVO) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(forumsrepVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}	

	}
	@Override
	public Timestamp getLastTime(Integer forno){
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Timestamp time=null;
		try {
			session.beginTransaction();
			Query query = session.createQuery(LASTTIME);
			query.setParameter(0, forno);
			time=(Timestamp)query.list().get(0);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}	
			
		return time;
		
	}
	
	
	
	@Override
	public Integer getCount(Integer forno){

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Long len;
		try {
			session.beginTransaction();
			Query query = session.createQuery(COUNT);
			query.setParameter(0, forno);
			len=(Long)query.list().get(0);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}	
			
		return len.intValue();
	
	}

	@Override
	public void deleteByRepno(Integer repno) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			ForumsrepVO forumsrepVO = new ForumsrepVO();
			forumsrepVO.setRepno(repno);
			session.delete(forumsrepVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

	}
	
	
	@Override
	public void deleteByForno(Integer forno) {

		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(DELETE);
			query.setParameter(0, forno);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

	}

	
	@Override
	public ForumsrepVO findByRepno(Integer repno) {
		
		ForumsrepVO repVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			repVO = (ForumsrepVO) session.get(ForumsrepVO.class, repno);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return repVO;
	}
	
	
	
	
	
	@Override
	public List<ForumsrepVO> findByPrimaryKey(Integer forno) {
		
		List<ForumsrepVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ONE_STMT);
			query.setParameter(0, forno);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
		
//		List<ForumsrepVO> list = null;
//		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			list = (List<ForumsrepVO>)session.get(ForumsrepVO.class, forno);
//			session.getTransaction().commit();
//		} catch (RuntimeException ex) {
//			session.getTransaction().rollback();
//			throw ex;
//		}
//		return list;
		
		
		
//		List<ForumsrepVO> list = new ArrayList<ForumsrepVO>();
//		ForumsrepVO forumsrepVO = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ONE_STMT);
//			pstmt.setInt(1, forno);
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				// empVo 也稱為 Domain objects
//				forumsrepVO = new ForumsrepVO();
//				forumsrepVO.setRepno(rs.getInt("repno"));
//				forumsrepVO.setForno(rs.getInt("forno"));
//				forumsrepVO.setMemno(rs.getInt("memno"));
//				forumsrepVO.setRepcontent(rs.getString("repcontent"));
//				forumsrepVO.setReptime(rs.getTimestamp("reptime"));
//				list.add(forumsrepVO);
//				}
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return list;
	}

	@Override
	public List<ForumsrepVO> getAll() {
		
		List<ForumsrepVO> list = null;
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
//		List<ForumsrepVO> list = new ArrayList<ForumsrepVO>();
//		ForumsrepVO forumsrepVO = null;
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ALL_STMT);
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				// empVO 也稱為 Domain objects
//				forumsrepVO = new ForumsrepVO();
//				forumsrepVO.setRepno(rs.getInt("repno"));
//				forumsrepVO.setForno(rs.getInt("forno"));
//				forumsrepVO.setMemno(rs.getInt("memno"));
//				forumsrepVO.setRepcontent(rs.getString("repcontent"));
//				forumsrepVO.setReptime(rs.getTimestamp("reptime"));
//				list.add(forumsrepVO); // Store the row in the list
//			}
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return list;
	}
}
	
	

