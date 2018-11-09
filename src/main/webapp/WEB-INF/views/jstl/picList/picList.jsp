<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<title>图片管理</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<!--bootstrap基础引用 start-->
	<script type="text/javascript" src="../public/bootstrap/jquery-3.1.1.min.js"></script>
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
	<script type="text/javascript">
	$(function(){
		var selNode="";
			divLoad();
			onLoad();

			BindEvent();
			
			function divLoad(){
				$("#picDiv").load('../pic/render');
			}
			
			 //页面加载
			 function onLoad()
			 {
		     	//渲染树
		     	$('#left-tree').treeview({
		     		data: getTree(),
		     		levels: 2,
		     		onNodeSelected:function(event, node){
		     			//$('#editName').val(node.text);
		     			$("#picDiv").load("../pic/render?id="+node.id);
		     			selNode = node;
		     			change_tree();
		     		},
					showCheckbox:false//是否显示多选
				});
		     }
			 
			var findSearchableNodes = function() {
				return $('#left-tree').treeview('search', [
					$.trim($('#queryName').val()), {
						ignoreCase : false, //忽略大小写
						exactMatch : false, //准确匹配
						revealResults : true
					} ]);
			};
			 
			$('#queryName').on('keyup', function(e) {
				var str = $('#queryName').val();
				$.ajax({
                    type: "post",
                    url: "../pic/refreshTree",
                    data: {text:str},
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    success: function(data){
        		     	$('#left-tree').treeview({
        		     		data: data,
        		     		levels: 100,
        		     		onNodeSelected:function(event, node){
        		     			$("#picDiv").load("../pic/render?id="+node.id);
        		     			selNode = node;
        		     			change_tree();
        		     		},
        					showCheckbox:false//是否显示多选
        				}); 
                    }
                });
			});
			 
			 
			 //展开节点
			 function change_tree(){
				 if ($(event.target).children(".glyphicon").hasClass("glyphicon-plus") || $(event.target).children(".glyphicon").hasClass("glyphicon-minus")) 
				 {
				   $(event.target).children(".glyphicon")[0].click();
				 }
			}
			 
		     //事件注册
		     function BindEvent()
		     {
		    	 $("#selectAll").click(function () {
		    		 $("input[name='checkbox']").attr("checked","true"); 
		    	 });
		    	 
		    	 $("#cancelAll").click(function () {
		    		 $("input[name='checkbox']").removeAttr("checked"); 
		    	 });
		    	 
		    	 $("#picDel").click(function () {
		    		 	var arr = new Array();
		    		 	$('input:checkbox:checked').each(function(i){
		                    arr[i] = $(this).val();
		                });
		                var vals = arr.join(",");
		    		 $.ajax({
                         type: "post",
                         url: "../pic/delPic",
                         data: {ids:vals},
                         dataType: "json",
                         success: function(data){
                        	 $("#picDiv").load("../pic/render?id="+selNode.id);
                         }
                     });
		    	 }); 
		    	 
		    	 

		    	 
		     	 //保存-新增
		     	 $("#Save").click(function () {
		     	 	$('#addOperation-dialog').modal('hide')
                         //静态添加节点
                         var parentNode = $('#left-tree').treeview('getSelected');
                         var node = {
                         	text: $('#addName').val()
                         };
                         
                         $.ajax({
                             type: "post",
                             url: "../pic/addNode",
                             data: {pid:parentNode[0].id,name:node.text},
                             dataType: "json",
                             success: function(data){
                            	 node.id=data;
                            	 $('#left-tree').treeview('addNode', [node, parentNode]);
                             }
                         });
                         
                        

                    });
		     	}
		     	//保存-编辑
		     	$('#Edit').click(function(){
		     		var node = $('#left-tree').treeview('getSelected');
					var newNode={
						text:$('#editName').val()
					};
				$('#left-tree').treeview('updateNode', [ node, newNode]);
		     	});
		     	
		     	$('#updateSave').click(function(){
		     		var node = $('#left-tree').treeview('getSelected');
					var newNode={
						text:$('#updateName').val()
					};
					 $.ajax({
                         type: "post",
                         url: "../pic/updateNode",
                         data: {id:node[0].id,name:$('#updateName').val()},
                         dataType: "json",
                         success: function(data){
                        	 $('#left-tree').treeview('updateNode', [ node, newNode]);
                        	 $('#updateOperation-dialog').modal('hide');
                         }
                     });
					
					
		     	});

	     	$("#btnUpdate").click(function(){
				var node = $('#left-tree').treeview('getSelected');
				if (node.length == 0) {
					$.showMsgText('请选择节点');
					return;
				}
				$('#updateName').val(node[0].text);
				$('#updateOperation-dialog').modal('show');
				
			}); 	

			//显示-添加
			$("#btnAdd").click(function(){
				var node = $('#left-tree').treeview('getSelected');
				if (node.length == 0) {
					$.showMsgText('请选择节点');
					return;
				}
				$('#addName').val('');
				$('#addOperation-dialog').modal('show');
				
			});
			//显示-编辑
			$("#btnEdit").click(function(){
				var node=$('#left-tree').treeview('getSelected');
				$('#editShow').show();

			});
			//删除
			$("#btnDel").click(function(){
				var node = $('#left-tree').treeview('getSelected');
				if (node.length == 0) {
					$.showMsgText('请选择节点');
					return;
				}
				if(node[0].nodes != undefined){
					  $.showMsgText('该节点下包含子节点不能删除');
					  return;
				  }
				  BootstrapDialog.confirm({
                        title: '提示',
                        message: '确定删除此节点?',
                        size: BootstrapDialog.SIZE_SMALL,
                        type: BootstrapDialog.TYPE_DEFAULT,
                        closable: true,
                        btnCancelLabel: '取消', 
                        btnOKLabel: '确定', 
                        callback: function (result) {
                            if(result)
                            {
                                del();
                            }
                        }
                    });
				  function del(){
					  $.ajax({
                          type: "post",
                          url: "../pic/delNode",
                          data: {id:node[0].id},
                          dataType: "json",
                          success: function(data){
                        	  $('#left-tree').treeview('removeNode', [ node, { silent: true } ]);
                          }
                      });
					
				  }
				
			});
			
			
			$("#picAdd").click(function(){
				var node = $('#left-tree').treeview('getSelected');
				if (node.length == 0 || node[0].id==0) {
					$.showMsgText('请选择节点');
					return;
				}
				$("#showModal").modal({  
					   remote: "../pic/picModal?id="+node[0].id
					});
				//$('#exampleModal').modal('show');
				//$('#snodeid').val(node[0].id);
			});
			

			//获取树数据
			function getTree(){
				var tree = '${nodes}';
				return tree;             
			}
			/*-----页面pannel内容区高度自适应 start-----*/
			$(window).resize(function () {
				setCenterHeight();
			});
			setCenterHeight();
			function setCenterHeight() {
				var height = $(window).height();
				var centerHight = height - 240;
				$(".right_centent").height(centerHight).css("overflow", "auto");
			}
			/*-----页面pannel内容区高度自适应 end-----*/
		});
		

	</script>
</head>
<body style="padding: 10px;">

	<header class="container" style="margin-bottom: 20px;width:1400px;">
		<div class="row">
			<div class="col-md-4">
				<input id="btnAdd" class="btn btn-primary" type="button" value="添加节点">
				<input id="btnDel" class="btn btn-danger" type="button" value="删除节点">
				<input id="btnUpdate" class="btn btn-danger" type="button" value="修改节点">
			</div>
			<div class="col-md-8">
				<input id="picAdd" class="btn btn-primary" type="button" value="上传图片">
				<input id="picDel" class="btn btn-danger" type="button" value="删除图片">
				<input id="selectAll" class="btn btn-danger" type="button" value="全选">
				<input id="cancelAll" class="btn btn-danger" type="button" value="反选">
			</div>
		</div>
	</header>


	<div class="container" style="width:1400px;height:600px;">
		<div class="row">
			<div class="col-md-4">
				<div class="panel panel-primary ">
					<div class="panel-heading">
						<h3 class="panel-title">树</h3>
					</div>
					<div class="panel-body " style="height: 600px; overflow: auto;">
						<input id="queryName" type="text"  class="form-control" />
						<div id="left-tree" style="margin-top: 10px;"></div>
					</div>
				</div>
			</div>
			<div class="col-md-8">
				<div class="panel panel-primary ">
					<div class="panel-heading">
						<h3 class="panel-title">图片</h3>
					</div>
					<!--编辑操作权限 start-->
                <div class="panel-body " style="height: 600px; overflow: auto;">
                <div  id="editShow">
                	<div id="picDiv" ></div>
                </div>
                </div>
                <!--编辑操作权限 end-->
				</div>
			</div>
		</div>
	</div>
	<div>
		<!--弹出框 新增权限 start-->
		<div class="modal fade" id="addOperation-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">

				<div class="modal-content radius_5">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">新增</h4>
					</div>
					<div class="modal-body">
						<div group="" item="add">
							<div>
								<div class="input-group margin-t-5">
									<span class="input-group-addon">名称:</span>
									<input id="addName" type="text" class="form-control" />
								</div>

							</div>
						</div>

					</div>
					<div class="modal-footer">
						<button id="Save" type="button" class="btn btn-primary">保存</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>

					</div>
				</div>


			</div>
		</div>
		<!--弹出框 新增权限 end-->
		
		<!--弹出框 更新 start-->
		<div class="modal fade" id="updateOperation-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">

				<div class="modal-content radius_5">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">编辑</h4>
					</div>
					<div class="modal-body">
						<div group="" item="add">
							<div>
								<div class="input-group margin-t-5">
									<span class="input-group-addon">名称:</span>
									<input id="updateName" type="text" class="form-control" />
								</div>

							</div>
						</div>

					</div>
					<div class="modal-footer">
						<button id="updateSave" type="button" class="btn btn-primary">保存</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>

					</div>
				</div>


			</div>
		</div>
		<!--弹出框 新增权限 end-->
		
		
		<!-- Modal -->
		<div class="modal fade" style="top:13%;"  tabindex="-1" role="dialog" id="showModal">
		      <div class="modal-dialog" role="document">
		          <div class="modal-content">
		            <!-- 内容会加载到这里 -->
		        </div><!-- /.modal-content -->
		   </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
 
	</div>
</div>
</body>
</html>
