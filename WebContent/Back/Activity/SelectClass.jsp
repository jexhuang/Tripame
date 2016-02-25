<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script>
function changeSelect()
{
	var selectclass = document.getElementById("selectclass").value;
	var selectsort = document.getElementById("selectsort");
	var two = document.getElementById("two").value;
	if(selectclass=='請選擇')
	{
		document.getElementById("selectsort").options.length = 0;
		var option = document.createElement("option");
		option.text = "請選擇分類";
		selectsort.add(option);
	}
	else if(selectclass=='景點')
	{
		document.getElementById("selectsort").options.length = 0;
		var all = document.createElement("option");
		var light = document.createElement("option");
		var night = document.createElement("option");;
		all.text = "無";
		light.text = "日景";
		night.text = "夜景";
		all.selected = "${(SpotVO.spotsort=='無')?'true':'false'}";
		light.selected = "${(SpotVO.spotsort=='日景')?'true':'false'}";
		night.selected = "${(SpotVO.spotsort=='夜景')?'true':'false'}";
		selectsort.add(all);
		selectsort.add(light);
		selectsort.add(night);
	}
	else if(selectclass=='美食')
	{
		document.getElementById("selectsort").options.length = 0;
		var all = document.createElement("option");
		var restaurant = document.createElement("option");
		var snack = document.createElement("option");
		all.text = "無";
		restaurant.text = "餐廳";
		snack.text = "小吃";
		all.selected = "${(SpotVO.spotsort=='無')?'true':'false'}";
		restaurant.selected = "${(SpotVO.spotsort=='餐廳')?'true':'false'}";
		snack.selected = "${(SpotVO.spotsort=='小吃')?'true':'false'}";
		selectsort.add(all);
		selectsort.add(restaurant);
		selectsort.add(snack);
	}
	else if(selectclass=='住宿')
	{
		document.getElementById("selectsort").options.length = 0;
		var all = document.createElement("option");
		var hotel = document.createElement("option");
		var bed = document.createElement("option");
		var motel = document.createElement("option");
		all.text = "無";
		hotel.text = "飯店";
		bed.text = "民宿";
		motel.text = "摩鐵";
		all.selected = "${(SpotVO.spotsort=='無')?'true':''}";
		hotel.selected = "${(SpotVO.spotsort=='飯店')?'true':''}";
		bed.selected = "${(SpotVO.spotsort=='民宿')?'true':''}";
		motel.selected = "${(SpotVO.spotsort=='摩鐵')?'true':''}";
		selectsort.add(all);
		selectsort.add(hotel);
		selectsort.add(bed);
		selectsort.add(motel);
	}
}
</script>
</head>
<body >
	<div class="form-group">
		<label class="col-sm-2 control-label">分類</label>
		<div class="col-sm-2">
			<select id="selectclass" name="spotclass" onchange="changeSelect()">
				<option  ${(SpotVO.spotclass=='請選擇')?'selected':'' }>請選擇</option>
				<option  ${(SpotVO.spotclass=='景點')?'selected':'' }>景點</option>
				<option  ${(SpotVO.spotclass=='美食')?'selected':'' }>美食</option>
				<option  ${(SpotVO.spotclass=='住宿')?'selected':'' }>住宿</option>
			</select>
		</div>		
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label">類別</label>
		<div class="col-sm-2">
			<select id="selectsort" name="spotsort"></select>
			<input type="hidden" id="two" value="${SpotVO.spotsort }">	
		</div>			
	</div>	
</body>
</html>