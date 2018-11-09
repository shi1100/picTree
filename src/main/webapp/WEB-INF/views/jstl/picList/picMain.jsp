<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../public/bootstrap/bootstrap.min.css" >
<script type="text/javascript" src="../public/bootstrap/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="../public/plugins/bootstrap-treeview/bootstrap-treeview.min.css">
<script type="text/javascript" src="../public/plugins/bootstrap-treeview/bootstrap-treeview.js"></script>
</head>
<style>
.center {
  width: 160px;
  height: 200px;
  padding: 5px;
  display: inline-block;float: left;
}
</style>
<body>
<input id="tid" type="hidden" value="${tid}" />
<div>
	<div style="padding: 0px 20px;" >
	  	<c:forEach var="entity" items="${picList}">
	  		<div class="center">
	  			<img style="width:150px;height:150px;" src="<%=request.getContextPath() %>${entity.path}" onclick="showimage('<%=request.getContextPath() %>${entity.path}')"/>
		  		<input type="checkbox" name="checkbox" value="${entity.id}"> 
		  		<input id="delPic" onclick="delPic(${entity.id})" class="btn btn-primary" type="button" value="删除">
		  		<input id="enlargePic" class="btn btn-primary" type="button" onclick="showimage('<%=request.getContextPath() %>${entity.path}')" value="放大">
  			</div>
  		</c:forEach>
	</div>

	
  	
  	﻿ <div class="modal fade bs-example-modal-lg text-center" id="imgModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" >
	        <div class="modal-dialog modal-lg" style="display: inline-block; width: auto;">
	          <div class="modal-content">
	           <img  id="imgInModalID"  
					 class="carousel-inner img-responsive img-rounded" 
					 onclick="closeImageViewer()"
					 onmouseover="this.style.cursor='pointer';this.style.cursor='hand'" 
					 onmouseout="this.style.cursor='default'"  
					 />
          </div>
        </div>
      </div>
</div>
</body>
<script>
	function delPic(id){
		$.ajax({
            type: "post",
            url: "../pic/delPic",
            data: {ids:id},
            dataType: "json",
            success: function(data){
           		 $("#picDiv").load("../pic/render?id="+$("#tid").val());
            }
        });
		
	}
	function showimage(source)
    {
        $("#imgModal").find("#imgInModalID").attr("src",source);
        $("#imgModal").modal();
    }
	 //关闭
	function closeImageViewer(){
		$("#imgModal").modal('hide');
	}
</script>
</html>