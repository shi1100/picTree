<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<!--bootstrap基础引用 start-->
	<link rel="stylesheet" href="../public/bootstrap/bootstrap.min.css" >
	<script type="text/javascript" src="../public/bootstrap/bootstrap.min.js"></script>
	<!--bootstrap基础引用 end-->
	<!--bootstrap-treeview start-->
	<link rel="stylesheet" type="text/css" href="../public/plugins/bootstrap-treeview/bootstrap-treeview.min.css">
	<script type="text/javascript" src="../public/plugins/bootstrap-treeview/bootstrap-treeview.js"></script>
	<!--bootstrap-treeview end-->
	<!--bootstrap-dialog start-->
	<link rel="stylesheet" type="text/css" href="../public/plugins/bootstrap-dialog/bootstrap-dialog.min.css">
	<script type="text/javascript" src="../public/plugins/bootstrap-dialog/bootstrap-dialog.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="../public/stylesheets/fileinput.css">
	
	<script src="../public/bootstrap/fileinput.js" type="text/javascript"></script>
    <script src="../public/bootstrap/fileinput_locale_zh.js" type="text/javascript"></script>
	<!--bootstrap-dialog end-->
	<script type="text/javascript" src="../public/javascripts/customPlugin.js"></script>
</head>
 <script>
  $("#file-1").fileinput({
  	  uploadUrl:'../pic/addPic?id='+$("#snodeid").val(),
  	  language: 'zh', //设置语言
      allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
      //uploadExtraData:{"id": },
      uploadAsync: true, //默认异步上传
      showUpload: true, //是否显示上传按钮
      showRemove : true, //显示移除按钮
      showPreview : true, //是否显示预览
      showCaption: false,//是否显示标题
      browseClass: "btn btn-default", //按钮样式
      //dropZoneEnabled: true,//是否显示拖拽区域
      //minImageWidth: 50, //图片的最小宽度
      //minImageHeight: 50,//图片的最小高度
      //maxImageWidth: 1000,//图片的最大宽度
      //maxImageHeight: 1000,//图片的最大高度
      //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
      //minFileCount: 0,
      maxFileCount: 50, //表示允许同时上传的最大文件个数
      enctype: 'multipart/form-data',
      validateInitialCount:true,
      previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
      msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",

      }).on('filepreupload', function(event, data, previewId, index) {     //上传中
          var form = data.form, files = data.files, extra = data.extra,
          response = data.response, reader = data.reader;
          console.log('文件正在上传');
      }).on("fileuploaded", function (event, data, previewId, index) {    //一个文件上传成功
          console.log('文件上传成功！'+data.id);
          $("#picDiv").load("../pic/render?id="+$("#snodeid").val());

      }).on('fileerror', function(event, data, msg) {  //一个文件上传失败
          console.log('文件上传失败！'+data.id);
      });
  
	  $('body').on('hidden.bs.modal', '.modal', function () {
		    $(this).removeData('bs.modal');
		});
  </script>
<style>

</style>
<body>

      <div class="modal-header">
      	<input id="snodeid" type="hidden" value="${snodeid}"  class="form-control" />
        <h5 class="modal-title" id="exampleModalLabel">上传图片</h5>
      </div>
      <div class="modal-body">
        <input id="file-1" type="file" multiple class="file" data-overwrite-initial="false" data-min-file-count="1">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
      </div>
    </body>
<script>