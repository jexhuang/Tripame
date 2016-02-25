package com.route.model;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
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

import com.activity.model.ActivityVO;
import com.spot.model.SpotVO;
import com.trip.model.TripVO;

public class RouteDAO implements RouteDAO_interface {

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO route (routeno,tripno,spotno,actno,routeseq,days) "
			+ "VALUES (route_seq.NEXTVAL, ?, ?, ?, ? ,?)";//共6個欄位
	private static final String GET_ALL_STMT = "SELECT * FROM route";
	private static final String GET_ONE_STMT = "SELECT * FROM route where tripno = ? and days = ? order by routeno";
	private static final String GET_spotno_STMT = "SELECT spotno FROM route where tripno = ? AND routeseq=1 AND days=1";
	private static final String GET_Trips_ByTripno_STMT = "SELECT * FROM trip where tripno = ? ";
	private static final String GET_Spots_BySpotno_STMT = "SELECT * FROM spot where spotno = ? ";
	private static final String GET_Acts_ByActno_STMT = "SELECT * FROM act where actno = ? ";
	private static final String GET_MaxDay = "SELECT max(days) from route where tripno = ? ";
	
	private static final String DELETE_ROUTE = "DELETE FROM route where tripno = ?";

	private static final String UPDATE = "UPDATE route set tripno=?, spotno=?, actno=?, days=?, routeseq=? where routeno = ?";
	
	
	@Override
	public Integer getMaxDay(Integer tripno){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer day = 0;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MaxDay);

			pstmt.setInt(1, tripno);

			rs = pstmt.executeQuery();
			
			rs.next();
			day=rs.getInt(1);
			
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
		return day;
	}

	@Override
	public void insert(RouteVO routeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, routeVO.getTripno());
			pstmt.setInt(2, routeVO.getSpotno());
			pstmt.setInt(3, routeVO.getActno());
			pstmt.setInt(4, routeVO.getRouteseq());
			pstmt.setString(5, routeVO.getDays());
			
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
	}// insert_end

	@Override
	public void update(RouteVO routeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, routeVO.getTripno());
			pstmt.setInt(2, routeVO.getSpotno());
			pstmt.setInt(3, routeVO.getActno());
			pstmt.setInt(4, routeVO.getRouteseq());
			pstmt.setString(5, routeVO.getDays());
			pstmt.setInt(6, routeVO.getRouteno());
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

			// 刪除行程表
			pstmt = con.prepareStatement(DELETE_ROUTE);
			pstmt.setInt(1, tripno);
			pstmt.executeUpdate();
			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);

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
	public RouteVO findSpotno(Integer tripno) {
		RouteVO routeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_spotno_STMT);

			pstmt.setInt(1, tripno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				routeVO = new RouteVO();
				routeVO.setSpotno(rs.getInt("spotno"));
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
		return routeVO;
	}// findByPrimaryKey_end
	
	@Override
	public List<RouteVO> findByForeignKey(Integer tripno, Integer days) {
		List<RouteVO> list = new ArrayList<RouteVO>();
		RouteVO routeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, tripno);
			pstmt.setInt(2, days);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// TripVO 也稱為 Domain objects
				routeVO = new RouteVO();
				routeVO.setRouteno(rs.getInt("routeno"));
				routeVO.setTripno(rs.getInt("tripno"));
				routeVO.setSpotno(rs.getInt("spotno"));
				routeVO.setActno(rs.getInt("actno"));
				routeVO.setRouteseq(rs.getInt("routeseq"));
				routeVO.setDays(rs.getString("days"));
				list.add(routeVO);
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
		return list;
	}// findByPrimaryKey_end
	
	@Override
	public List<RouteVO> getAll() {
		List<RouteVO> list = new ArrayList<RouteVO>();
		RouteVO routeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				routeVO = new RouteVO();
				routeVO.setRouteno(rs.getInt("routeno"));
				routeVO.setTripno(rs.getInt("tripno"));
				routeVO.setSpotno(rs.getInt("spotno"));
				routeVO.setActno(rs.getInt("actno"));
				routeVO.setRouteseq(rs.getInt("routeseq"));
				routeVO.setDays(rs.getString("days"));
				list.add(routeVO); // Store the row in the list
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
	public List<TripVO> getTripsByTripno(Integer tripno) {
		List<TripVO> list = new ArrayList<TripVO>();
		TripVO tripVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Trips_ByTripno_STMT);
			pstmt.setInt(1, tripno);
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
	}// getTripsByTripno_end

	@Override
	public List<SpotVO> getSpotsByspotno(Integer spotno) {
		List<SpotVO> list = new ArrayList<SpotVO>();
		SpotVO spotVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Spots_BySpotno_STMT);
			pstmt.setInt(1, spotno);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				spotVO = new SpotVO();
				spotVO.setSpotno(rs.getInt("spotno"));
				spotVO.setMemno(rs.getInt("memno"));
				spotVO.setSpotclass(rs.getString("spotclass"));
				spotVO.setSpotcon(rs.getString("spotcon"));
				spotVO.setSpotname(rs.getString("spotname"));
				spotVO.setSpotphone(rs.getString("spotphone"));
				spotVO.setSpotaddress(rs.getString("spotaddress"));
				spotVO.setSpotcontent(rs.getString("spotcontent"));
				InputStream in = rs.getBinaryStream("spotpic");
				 if(in != null)
				 {
					 ByteArrayOutputStream baos = new ByteArrayOutputStream();				
						byte[] buffer=new byte[4096];
						int read=0;
						while((read=in.read(buffer))!=-1)
						{
							baos.write(buffer, 0, read);					
						}
						byte[] out=baos.toByteArray();
						spotVO.setSpotpic(out);
				 }
				spotVO.setSpotsite(rs.getString("spotsite"));
				spotVO.setSpotsort(rs.getString("spotsort"));
				spotVO.setSpotlook(rs.getInt("spotlook"));
				spotVO.setSpotlat(rs.getDouble("spotlat"));
				spotVO.setSpotlong(rs.getDouble("spotlong"));
				spotVO.setSpotstatus(rs.getString("spotstatus"));
				spotVO.setSpotstay(rs.getInt("spotstay"));
			
				list.add(spotVO); // Store the row in the list
			}
	
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	}


}
