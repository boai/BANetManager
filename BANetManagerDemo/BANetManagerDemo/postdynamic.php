<?php
// 发布动态
$conn = mysql_connect("localhost","root","root") or die ("connect failed".mysql_error());
// 防止中文乱码
mysql_query("SET NAMES UTF8");

// 2、选择数据库
mysql_select_db("wanyue",$conn)or die ("wanyue failed".mysql_error());

 $band_id=$_POST["band_id"];
 $bandstate_content=$_POST["bandstate_content"];
 $band_count=$_POST["images_count"];
 $band_longitude=$_POST["userlongitude"];
 $band_latitude=$_POST["userlatitude"];

 date_default_timezone_set("PRC");
 $band_state_time= date("Y-m-d H:i:s",time());
// 将动态发布内容插入表中
$sql = "insert into t_bandState (band_id,bandState_content,band_state_time,band_longitude,band_latitude) 
      values('$band_id','$bandstate_content','$band_state_time','$band_longitude','$band_latitude')";
      mysql_query($sql);
     $bandstate_id=mysql_insert_id();
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
   