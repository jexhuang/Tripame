<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ page import="com.spot.model.*"%>
<%@ page import="com.trip.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.route.model.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>�ڪ���{</title>
<style>
hr {
	background-color: red;
}

.tripFrame {
	border: 1px solid #cccccc;
	margin-left: 65px;
	margin-top: 10px;
	float: left;
	box-shadow: 2px 2px 5px 2px #cccccc;
	border-radius: 10px;
}

a img:hover {
	opacity: 0.85;
}
</style>
<script>
function deleteTrip(tripno){
	var xhr=new XMLHttpRequest();
	var name = "#"+tripno;
	  //�]�w�n�^�I��� 
	  xhr.onreadystatechange=function(){
		  if(xhr.readyState==4){
			  if(xhr.status==200){
					$(name).empty();
					window.location.reload();
				  }
			  else{
				  alert(xhr.status);
				  }
			  }
		  };
	  //�إߦnGet�s���P�e�X�ШD
		var url='<%=request.getContextPath()%>'+ "/Trip/tripplan?delete=deleteTrip&tripNo=" + tripno;
		xhr.open("Get", url, true);
		xhr.send(null);
		return false;
	}
</script>
</head>
<jsp:include page="/Front/select_page.jsp" />
<body style="font-family: '�L�n������'">
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<ol class="breadcrumb">
				<li><a
						href="<%=request.getContextPath()%>/Front/front_index.jsp">����</a></li>
					<li><a
						href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">�|���M��</a></li>
					<li class="active">�ڪ���{</li>
				</ol>
			</div>
		</div>
		<div class="row clearfix">
			<div class="col-md-12 column" >
					<img
						src="<%=request.getContextPath()%>/mem/MemPicReader?memno=${memvo.memno}"
						width="120" height="160">
					<font style="font-family: '�L�n������';font-size:36px">${memvo.memname}���L����{</font>
					<HR>
				</div>		
			

		</div>
		
		<div class="row clearfix">
			<div class="col-md-12 column">
				<%
					MemVO memVO = new MemVO();
					RouteVO routeVO = new RouteVO();
					memVO = (MemVO) session.getAttribute("memvo");

					Integer memno = memVO.getMemno();//���o�ثe�ϥΪ̪��|���s��

					TripService tripSvc = new TripService();
					RouteService routeSvc = new RouteService();

					List<TripVO> tripList = new ArrayList<TripVO>();
					List<SpotVO> spotList = new ArrayList<SpotVO>();

					tripList = tripSvc.getTripsByMemno(memno);

					for (int i = tripList.size() - 1; i >= 0; i--) {//���Xlist�����Ҧ����
							Integer tripno = tripList.get(i).getTripno();//��trip����Xtripno

							routeVO = routeSvc.getSpotno(tripno);////��route���X�ŦXtripno���BrouteSeq��days���L1��tripno���
							if (routeVO == null) {
									continue;
							}
							String tripbegin[] = tripList.get(i).getTripbegin()
										.toLocaleString().split(":");
							String begin = tripbegin[0] + ":" + tripbegin[1];
							String tripend[] = tripList.get(i).getTripend()
										.toLocaleString().split(":");
							String end = tripend[0] + ":" + tripend[1];

							Integer spotno = routeVO.getSpotno();//��route����Xspotno

							String imgUrl = "<img src='" + request.getContextPath()
										+ "/spot/SpotList_Img?spotno=" + spotno
										+ "' width='215' height='160' title='�˵���{'>";

							out.println("<div id='"
										+ tripno
										+ "' class='col-md-3 column tripFrame' style='text-align:center;'><form  class='form-horizontal' role='form' action='"
										+ request.getContextPath()
										+ "/Trip/route' method='post'>");
								out.println("<head'><h3 style=\"font-family:'�L�n������'\";><button type='button' class='close' name='deleteButton' data-dismiss='modal' aria-hidden='true' onclick='deleteTrip("
										+ tripno
										+ ")'>X</button>"
										+ tripList.get(i).getTripname() + "</h3></head><hr>");
								out.println("<body><a href='" + request.getContextPath()
										+ "/Trip/tripplan?checkRoute=checkRoute&tripno="+tripList.get(i).getTripno()
										+ "' role='button' class='btn'>" + imgUrl
										+ "</a></body><hr>");
								out.println("<footer>�}�l�G" + begin + "<br>�����G" + end
										+ "</footer>");
								out.println("<input type='hidden' name='tripNo' value='"
										+ tripno + "'></form>");
								out.println("</div>");//col-md-4_close
							}
				%>
			</div>
		</div>
	</div>
</body>
</html>

