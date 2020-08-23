<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<!-- /.pane-heading -->
			<div class="panel-body">
				<form role="form" action="/ex02/board/register" method="post">
					<div class="form-group">
						<label>Title</label> <input class="form-control" name='title'>
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer'>
					</div>
					<button type="submit" class="btn btn-default">Submit Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- ./panel panel-default -->
	</div>
	<!-- ./col-lg-12 -->
</div>
<!-- ./row -->

<!-- 
		파일 업로드
 -->
 <style>
.uploadResult
{
	width: 100%;
	background-color: gray;
}
.uploadResult ul
{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li
{
	list-style: none;
	padding: 10px;
}
.uploadResult ul li img
{
	width: 20px;
}
.uploadResult ul li span
{
	color: white;
}
.bigPictureWrapper
{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture
{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img
{
	width: 600px;
}
</style>

 <div class="row">
 	<div class="col-lg-12">
 		<div class="panel panel-default">
 			<div class="panel-heading">File Attach</div>
 			<!-- /.panel-heading -->
 			<div class="panel-body">
 				<div class="form-group uploadDiv">
 					<input type="file" name='uploadFile' multiple>
 				</div>
 				<div class='uploadResult'>
 					<ul>
 					
 					</ul>
 				</div>
 			</div>
 			<!--  end panel-body -->
 		</div>
 		<!-- end panel-body -->
 	</div>
 	<!-- end panenl -->
 </div>
 <!-- /.row -->

<script>
$(function()
{
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e) 
	{
		e.preventDefault();
		
		console.log("submit clicked");
	});
})
</script>

<%@ include file="../includes/footer.jsp" %>

