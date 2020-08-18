<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Upload with Ajax</h1>

<div class='uploadDiv'>
	<input type='file' name='uploadFile' multiple>
</div>

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
</style>

<div class='uploadResult'>
	<ul>
	
	</ul>
</div>

<button id='uploadBtn'>Upload</button>

<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script>
$(function() 
{
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alx)$");
	var maxSize = 5242880; //5MB
	
	function checkExtension(fileName, fileSize)
	{
		if(fileSize >= maxSize)
		{
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName))
		{
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	// <input type='file'의 초기화
	var cloneObj = $(".uploadDiv").clone();
	
	$("#uploadBtn").on("click", function(e) 
	{
		//파일 업로드 객체
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files);
		
		//add filedata to formdata
		for(var i = 0; i < files.length; i++)
		{
			if(!checkExtension(files[i].name, files[i].size))
				return false;
			
			formData.append("uploadFile", files[i]);	
		}
		
		$.ajax
		({
			url: '/ex05/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result)
			{
				console.log(result);
				
				showUploadedFile(result);
				
				$(".uploadDiv").html(cloneObj.html());
			}
		});
	});
	
	// 결과 목록을 보여주는 함수
	var uploadResult = $(".uploadResult ul");

	function showUploadedFile(uploadResultArr)
	{
		var str = "";
		
		$(uploadResultArr).each(function(i, obj) 
		{
			if(!obj.image)
				str += "<li><img src='/jex05/resources/img/attach.png'>" + obj.fileName + "</li>";
				
			else
				str += "<li>" + obj.fileName + "</li>";
				
		});
		
		uploadResult.append(str);
	}
})
</script>
</body>
</html>