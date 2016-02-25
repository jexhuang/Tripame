package com.trip.model;

import java.sql.Connection;
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

public class TripDAO implements TripDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO trip (tripno,memno,tripname,triplong,triplat,tripbegin,tripend) "
			+ "VALUES (trip_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";// 共7個欄位
	private static final String GET_ALL_STMT = "SELECT * FROM trip";
	private static final String GET_ONE_STMT = "SELECT * FROM trip WHERE tripno = ?";
	private static final String GET_Trips_ByMemno_STMT = "SELECT * FROM trip where memno = ? order by tripno";
	private static final String GET_KEY="select trip_seq.currVal from dual";
	private static final String DELETE_trip = "DELETE FROM trip where tripno = ?";
	private static final String UPDATE = "UPDATE trip set memno=?, tripname=?, triplong=?, triplat=?, tripbegin=?, tripend=? where tripno = ?";

	@Override
	public Integer insert(TripVO tripVO) {

		Connection con = null;
		String next_deptno = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt1 = con.prepareStatement(GET_KEY);
			con.setAutoCommit(false);
			pstmt.setInt(1, tripVO.getMemno());
			pstmt.setString(2, tripVO.getTripname());
			pstmt.setDouble(3, tripVO.getTriplong());
			pstmt.setDouble(4, tripVO.getTriplat());
			pstmt.setTimestamp(5, tripVO.getTripbegin());
			pstmt.setTimestamp(6, tripVO.getTripend());

			pstmt.executeUpdate();
			
			ResultSet rs = pstmt1.executeQuery();
			if (rs.next()) {
				next_deptno = rs.getString(1);//自增主鍵值
			}
			rs.close();
			con.commit();
			con.setAutoCommit(true);
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
		return Integer.parseInt(next_deptno);
	}// insert_end

	@Override
	public void update(TripVO tripVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, tripVO.getMemno());
			pstmt.setString(2, tripVO.getTripname());
			pstmt.setDouble(3, tripVO.getTriplong());
			pstmt.setDouble(4, tripVO.getTriplat());
			pstmt.setTimestamp(5, tripVO.getTripbegin());
			pstmt.setTimestamp(6, tripVO.getTripend());
			pstmt.setInt(7, tripVO.getTripno());

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

			con = ds.getConnection();

			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			
			// 刪除行程
			pstmt = con.prepareStatement(DELETE_trip);
			pstmt.setInt(1, tripno);
			pstmt.executeUpdate();
			
			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("trip:"+tripno+"已刪除");
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

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, tripno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// TripVO 也稱為 Domain objects
				tripVO = new TripVO();
				tripVO.setTripno(rs.getInt("tripno"));
				tripVO.setMemno(rs.getInt("memno"));
				tripVO.setTripname(rs.getString("tripname"));
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

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				tripVO = new TripVO();
				tripVO.setTripno(rs.getInt("tripno"));
				tripVO.setMemno(rs.getInt("memno"));
				tripVO.setTripname(rs.getString("tripname"));
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
		List<TripVO> list = new ArrayList<TripVO>();
		TripVO tripVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Trips_ByMemno_STMT);
			pstmt.setInt(1, memno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				tripVO = new TripVO();
				tripVO.setTripno(rs.getInt("tripno"));
				tripVO.setMemno(rs.getInt("memno"));
				tripVO.setTripname(rs.getString("tripname"));
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

	}// getTripsByMemno_end
}
