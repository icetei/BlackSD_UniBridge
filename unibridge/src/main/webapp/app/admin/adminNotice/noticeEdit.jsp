<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>공지사항 관리 - 수정</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/adminNotice/noticeEdit.css" />
</head>
<body>

  <div id="header-wrap"></div>

  <div class="form-wrap">
    <h1 class="page-title">공지사항 관리</h1>

    <form id="writeForm" method="post" action = "${pageContext.request.contextPath}/noticeEditOk.admin" enctype="multipart/form-data">
      
      <input type="hidden" name="boardNumber" value="${board.noticeboardNumber}">
      <!-- 수정하기 + 제목 입력 -->
      <div class="form-title-row">
        <span class="form-title-label">수정하기</span>
        <input
          type="text"
          id="inputTitle"
          class="form-title-input"
          name="boardTitle"
          value="${board.boardTitle}"
        />
      </div>
  
      <!-- 내용 -->
      <textarea id="inputContent" class="form-content-area" name="boardContent">${board.boardContent}</textarea>
  
      <!-- 파일 첨부 -->
      <div class="form-file-section">
        <span class="form-file-label-text">파일 첨부</span>
         <input type="file" id="fileInput" name="file" value="${board.file.fileName}"/>
      </div>
  
      <!-- 버튼 -->
      <div class="form-actions">
        <button type="submit" class="btn btn-blue" id="btnSave">수정</button>
        <button type="button" class="btn btn-red" id="btnEditCancel">취소</button>
      </div>

    </form>

<script>
  fetch("${pageContext.request.contextPath}/header/adminHeader.jsp")
    .then(res => res.text())
    .then(html => {
      document.getElementById("header-wrap").innerHTML = html;
      const s = document.createElement("script");
      s.src = "${pageContext.request.contextPath}/assets/js/adminHeader.js";
      document.body.appendChild(s);
    });
</script>

<script>
	const boardNumber = "${board.noticeboardNumber}";
</script>

  <script src="${pageContext.request.contextPath}/assets/js/admin/adminNotice/noticeEdit.js"></script>
</body>
</html>
