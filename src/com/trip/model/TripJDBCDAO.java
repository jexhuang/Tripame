package com.trip.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class TripJDBCDAO implements TripDAO_interface {
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "user1";
	String passwd = "u111";

	private static final String INSERT_STMT = "INSERT INTO trip (tripno,memno,triplong,triplat,tripbegin,tripend) "
			+ "VALUES (trip_seq.NEXTVAL, ?, ?, ?, ?, ?)";//共6個欄位
	private static final String GET_ALL_STMT = "SELECT * FROM trip";
	private static final String GET_ONE_STMT = "SELECT * FROM trip WHERE tripno = ?";
	private static final String GET_Trips_ByMemno_STMT = "SELECT * FROM trip where memno = ? order by tripno";

	private static final String DELETE_trip = "DELETE FROM trip where tripno = ?";
	private static final String UPDATE = "UPDATE trip set memno=?, triplong=?, triplat=?, tripbegin=?, tripend=? where tripno = ?";
	
	
	public static void main(String[] args){
		
//		TripJDBCDAO dao = new TripJDBCDAO();
//		
//		TripVO empVO1 = new TripVO();
//		empVO1.setMemno(10001);
//		empVO1.setTriplong(12.345);
//		empVO1.setTriplat(30.123);
//		empVO1.setTripbegin(Date.valueOf("2014-01-01"));
//		empVO1.setTripend(Date.valueOf("2014-01-06"));
//		dao.insert(empVO1);
//					
		
//		//更新
//		TripVO empVO2 = new TripVO();
//		empVO2.setTripno(20001);
//		empVO2.setMemno(1);
//		empVO2.setTriplong(1.123);
//		empVO2.setTriplat(2.345);
//		empVO2.setTripbegin(Date.valueOf("2014-01-01"));
//		empVO2.setTripend(Date.valueOf("2014-01-06"));
//		dao.update(empVO2);
		
//		//刪除
//		dao.delete(20005);
		
//		
		//查詢-單筆
//		TripVO deptVO3 = dao.findByPrimaryKey(20001);
//		System.out.print(deptVO3.getTripno()+ ",");
//		System.out.print(deptVO3.getMemno()+ ",");
//		System.out.print(deptVO3.getTriplong()+ ",");
//		System.out.print(deptVO3.getTriplat()+ ",");
//		System.out.print(deptVO3.getTripbegin()+ ",");
//		System.out.print(deptVO3.getTripend());
//		System.out.println("------------------------------");
//		
//		
//		//查詢-全部
//		List<TripVO> list = dao.getAll();
//		for(TripVO aDept : list){
//			System.out.print(aDept.getTripno()+ ",");
//			System.out.print(aDept.getMemno()+ ",");
//			System.out.print(aDept.getTriplong()+ ",");
//			System.out.print(aDept.getTriplat()+ ",");
//			System.out.print(aDept.getTripbegin()+ ",");
//			System.out.print(aDept.getTripend());
//			System.out.println();
//		}
//		Set<TripVO> list = dao.getTripsByMemno(1);
//		for(TripVO aDept : list){
//			System.out.print(aDept.getTripno()+ ",");
//			System.out.print(aDept.getMemno()+ ",");
//			System.out.print(aDept.getTriplong()+ ",");
//			System.out.print(aDept.getTriplat()+ ",");
//			System.out.print(aDept.getTripbegin()+ ",");
//			System.out.print(aDept.getTripend());
//			System.out.println();
//		}
		
		
	}
	

	@Override
	public Integer insert(TripVO tripVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		int autoIncKeyFromApi = -1;
		try {

			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, tripVO.getMemno());
			pstmt.setDouble(2, tripVO.getTriplong());
			pstmt.setDouble(3, tripVO.getTriplat());
			pstmt.setTimestamp(4, tripVO.getTripbegin());
			pstmt.setTimestamp(5, tripVO.getTripend());

			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				autoIncKeyFromApi = rs.getInt(1);
			}

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return autoIncKeyFromApi;

	}// insert_end

	@Override
	public void update(TripVO tripVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, tripVO.getMemno());
			pstmt.setDouble(2, tripVO.getTriplong());
			pstmt.setDouble(3, tripVO.getTriplat());
			pstmt.setTimestamp(4, tripVO.getTripbegin());
			pstmt.setTimestamp(5, tripVO.getTripend());
			pstmt.setInt(6, tripVO.getTripno());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}// update_end

	@Override
	public void delete(Integer tripno) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			con = DriverManager.getConnection(url, userid, passwd);
			// 1●設定於 pstm.executeUpdate()之前
//			con.setAutoCommit(false);
			
			// 刪除行程
			pstmt = con.prepareStatement(DELETE_trip);
			pstmt.setInt(1, tripno);
			pstmt.executeUpdate();
			System.out.println(tripno);
//			// 2●設定於 pstm.executeUpdate()之後
//			con.commit();
//			con.setAutoCommit(true);

			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}// delete_end

	@Override
	public TripVO findByPrimaryKey(Integer tripno) {
		TripVO tripVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, tripno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// TripVO 也稱為 Domain objects
				tripVO = new TripVO();
				tripVO.setTripno(rs.getInt("tripno"));
				tripVO.setMemno(rs.getInt("memno"));
				tripVO.setTriplong(rs.getDouble("triplong"));
				tripVO.setTriplat(rs.getDouble("triplat"));
				tripVO.setTripbegin(rs.getTimestamp("tripbegin"));
				tripVO.setTripend(rs.getTimestamp("tripend"));
			}

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return tripVO;
	}// findByPrimaryKey_end

	@Override
	public List<TripVO> getAll() {
		List<TripVO> list = new ArrayList<TripVO>();
		TripVO tripVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				tripVO = new TripVO();
				tripVO.setTripno(rs.getInt("tripno"));
				tripVO.setMemno(rs.getInt("memno"));
				tripVO.setTriplong(rs.getDouble("triplong"));
				tripVO.setTriplat(rs.getDouble("triplat"));
				tripVO.setTripbegin(rs.getTimestamp("tripbegin"));
				tripVO.setTripend(rs.getTimestamp("tripend"));
				list.add(tripVO); // Store the row in the list
			}

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}// getAll_end

	@Override
	public List<TripVO> getTripsByMemno(Integer memno) {
		List<TripVO> set = new ArrayList<TripVO>();
		TripVO tripVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_Trips_ByMemno_STMT);
			pstmt.setInt(1, memno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				tripVO = new TripVO();
				tripVO.setTripno(rs.getInt("tripno"));
				tripVO.setMemno(rs.getInt("memno"));
				tripVO.setTriplong(rs.getDouble("triplong"));
				tripVO.setTriplat(rs.getDouble("triplat"));
				tripVO.setTripbegin(rs.getTimestamp("tripbegin"));
				tripVO.setTripend(rs.getTimestamp("tripend"));
				set.add(tripVO); // Store the row in the list
			}

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return set;

	}// getTripsByMemno_end
}

