<?php
// 发布动态（本php接口完美融合博爱封装的afnetworking，本人亲自使用并实验）
// 下方要根据你的访问地址和实际数据库设计修改
$conn = mysql_connect("localhost","root","root") or die ("connect failed".mysql_error());
// 防止中文乱码
mysql_query("SET NAMES UTF8");

// 2、选择数据库
mysql_select_db("wanyue",$conn)or die ("wanyue failed".mysql_error());
// 选择你要提交的参数分别是用户id 、用户发布内容、用户发布图片数组的长度、用户的经纬度（可以根据你的需要删减）
 $band_id=$_POST["band_id"];
 $bandstate_content=$_POST["bandstate_content"];
 $band_count=$_POST["images_count"];
 $band_longitude=$_POST["userlongitude"];
 $band_latitude=$_POST["userlatitude"];
// 获取当前数据库时间可以避免图片名重复
 date_default_timezone_set("PRC");
 $band_state_time= date("Y-m-d H:i:s",time());
// 将动态发布内容插入表中（数据根据您的用户表自己删减但基本是这个类型）
$sql = "insert into t_bandState (band_id,bandState_content,band_state_time,band_longitude,band_latitude) 
      values('$band_id','$bandstate_content','$band_state_time','$band_longitude','$band_latitude')";
      mysql_query($sql);
     $bandstate_id=mysql_insert_id();
     // 循环遍历将您上传的图片一张一张移动到你的数据库文件夹，图片名改为当前时间
 	for ($i=0; $i < "$band_count"; $i++){
      $filename = "images/header/".time()."$i".".jpg";//保存的相对路径
      move_uploaded_file($_FILES["picflie"."$i"]["tmp_name"], $filename);
     if ($i=="$band_count"-1) {
        $str="$str"."$filename";
        break;
      }
      else{
      $str="$str"."$filename"."__";
      }
     }
// 图片地址名存储会以"__"拼接，所以在接收查询的时候要分割
     //下方的sql语句根据你的实际情况修改
   $sql1 = " insert into t_band_state_picture (bandState_id,bandstate_picture_name) values('$bandstate_id','$str')";
     mysql_query($sql1);
// 返回json
	 $data = array(
          "resultCode" =>200,
          "message" =>"上传动态成功"
          // "band_count"=>intval('$band_count')
          );
        $json = json_encode($data);
      echo ($json);
	
?>
   