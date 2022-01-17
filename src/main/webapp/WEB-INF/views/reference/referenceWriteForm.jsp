<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.file-box {
	width: 100%;
	height: 200px;
	text-align: center;
	line-height: 200px;
	font-size: 2rem;
	font-weight: bold;
}
.file-box span {
	
}
.file-list-box {
	width: 100%;
	height: 100px;
}

</style>
<script type="text/javascript">

/* 썸머노트 */
$(document).ready(function() {
	$('#summernote').summernote({
		placeholder : '내용을 입력해 주세요',
		height : 300,
		lang: "ko-KR"
	});
	$('#input_file').bind('change',function(){
		selectFile(this.files);
	});
});

/* drap and drop */
 
    // 파일 리스트 번호
    var fileIndex = 0;
    // 등록할 전체 파일 사이즈
    var totalFileSize = 0;
    // 파일 리스트
    var fileList = new Array();
    // 파일 사이즈 리스트
    var fileSizeList = new Array();
    // 등록 가능한 파일 사이즈 MB
    var uploadSize = 100;
    // 등록 가능한 총 파일 사이즈 MB
    var maxUploadSize = 500;
 
    $(function (){
        // 파일 드롭 다운
        fileDropDown();
    });
 
    // 파일 드롭 다운
    function fileDropDown(){
        var dropZone = $("#file-box");
        //Drag기능 
        dropZone.on('dragenter',function(e){
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#E3F2FC');
        });
        dropZone.on('dragleave',function(e){
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#FFFFFF');
        });
        dropZone.on('dragover',function(e){
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#E3F2FC');
        });
        dropZone.on('drop',function(e){
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#FFFFFF');
            
            var files = e.originalEvent.dataTransfer.files;
            if(files != null){
                if(files.length < 1){
                    alert("폴더 업로드 불가");
                    return;
                }
                selectFile(files)
            }else{
                alert("ERROR");
            }
        });
    }
 
    // 파일 선택시
    function selectFile(files){
    	
		var files = null;
    	
    	if(filesObj != null){
    		files = filesObj;
    	} else {
    		// 직접 파일 등록시
    		files = $('#multipartFileList_' + fileIndex)[0].files;
    	}
        // 다중파일 등록
        if(files != null){
            for(var i = 0; i < files.length; i++){
                // 파일 이름
                var fileName = files[i].name;
                var fileNameArr = fileName.split("\.");
                // 확장자
                var ext = fileNameArr[fileNameArr.length - 1];
                // 파일 사이즈(단위 :MB)
                var fileSize = files[i].size / 1024 / 1024;
                
                if($.inArray(ext, ['exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml']) >= 0){
                    // 확장자 체크
                    alert("등록 불가 확장자");
                    break;
                }else if(fileSize > uploadSize){
                    // 파일 사이즈 체크
                    alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
                    break;
                }else{
                    // 전체 파일 사이즈
                    totalFileSize += fileSize;
                    
                    // 파일 배열에 넣기
                    fileList[fileIndex] = files[i];
                    
                    // 파일 사이즈 배열에 넣기
                    fileSizeList[fileIndex] = fileSize;
 
                    // 업로드 파일 목록 생성
                    addFileList(fileIndex, fileName, fileSize);
 
                    // 파일 번호 증가
                    fileIndex++;
                }
            }
        }else{
            alert("ERROR");
        }
    }
 
    // 업로드 파일 목록 생성
    function addFileList(fIndex, fileName, fileSize){
    	var roundMbSize = fileSize.toFixed(2);
        var html = "";
        html += "    <tr id='fileTr_" + fIndex + "'><td>";
        html +=         fileName + " / " + roundMbSize + "MB "  + "<a href='#' onclick='deleteFile(" + fIndex + "); return false;' class='btn small bg_02'>삭제</a>"
        html += "    </td></tr>"
 
        $('#file-list-box').append(html);
    }
 
    // 업로드 파일 삭제
    function deleteFile(fIndex){
        // 전체 파일 사이즈 수정
        totalFileSize -= fileSizeList[fIndex];
        
        // 파일 배열에서 삭제
        delete fileList[fIndex];
        
        // 파일 사이즈 배열 삭제
        delete fileSizeList[fIndex];
        
        // 업로드 파일 테이블 목록에서 삭제
        $("#fileTr_" + fIndex).remove();
    }
 
    // 파일 등록
    function uploadFile(){
        // 등록할 파일 리스트
        var uploadFileList = Object.keys(fileList);
        
        // 용량을 500MB를 넘을 경우 업로드 불가
        if(totalFileSize > maxUploadSize){
            // 파일 사이즈 초과 경고창
            alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
            return;
        }
        
        if(frm.rf_title.value=="") {
        	alert("제목을 입력해주세요");
        } else if(frm.rf_content.value==""){
        	alert("내용을 입력해주세요");
        	return;
        } else if(frm.rfk_seq.value == "0"){
        	alert("글 종류를 선택하세요");
        	return;
        } else {
        	if(confirm("등록 하시겠습니까?")){
            var formData = new FormData();
            formData.append('rf_writer',frm.rf_writer.value);
            formData.append('m_id',frm.m_id.value);
            formData.append('rf_title',frm.rf_title.value);
            formData.append('rf_content',frm.rf_content.value);
          	formData.append('rfk_seq',frm.rfk_seq.value);
            for(var i = 0; i < uploadFileList.length; i++){
                formData.append('files', fileList[uploadFileList[i]]);
            }
            
            $.ajax({
                url:"${path}/reference/referenceWrite/pageNum/${pageNum}",
                data:formData,
                type:'POST',
                enctype:'multipart/form-data',
                processData:false,
                contentType:false,
                success:function(data){
                        alert("글이 등록되었습니다.");
                        location.href="${path}/reference/referenceMain/pageNum/${pageNum}";
                }
            });
        }
       }
    }
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">글 쓰기</h2>
		<form name="frm" method="post" enctype="multipart/form-data" id="frm">
			<input type="hidden" name="rf_writer" value="${sideNav.m_name }">
			<input type="hidden" name="m_id" value="${sideNav.m_id }">
			<table class="table table-bordered mt-3">
					<tr>
						<th>제목</th>
						<td><input type="text" class="form-control" name="rf_title" required="required" autofocus="autofocus"></td>
					</tr>
					<tr>
						<th align="center">글쓴이</th>
						<td>${sideNav.m_name}&nbsp&nbsp${sideNav.r_name }님</td>
					</tr>
					<tr>
						<th style="line-height: 40px;">글 종류</th>
						<td>
							<select class="form-control" name="rfk_seq" style="display: inline-block; width: 200px; height: 40px;">
							<option value="0">선택</option>
								<c:forEach var="kind" items="${kindList }">
									<option value="${kind.rfk_seq }">${kind.rfk_name }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<textarea id="summernote" name="rf_content" rows="10" cols="100" required="required"></textarea>
						</td>
					</tr>
					<tr>
						<th colspan="2">파일첨부</th>
					</tr>
					<tr>
						<td colspan="2">
							<label class="input-file-button" for="input_file">
								파일선택
							</label>
							<input type="file" id="input_file" multiple="multiple" style="display: none;">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="file-box" id="file-box">
								파일을 드래그 하세요
							</div>
						</td>
					</tr>
					<tr>
						<th colspan="2" align="center">
								<span class="file-list-subject">파일 목록</span>
						</th>
					</tr>
					<tr>
						<td colspan="2">
							<table class="file-list-box" id="file-list-box">
							</table>
						</td>
					</tr>
			</table>
			<div align="center" style="width: 100%;">
				<input type="button" onclick="uploadFile(); return false;" class="btn btn-primary btn-lg" value="등록">
			</div>
		</form>
	</div>
</body>

</html>