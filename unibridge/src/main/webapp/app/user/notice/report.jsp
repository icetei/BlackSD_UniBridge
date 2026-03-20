<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>학습 보고서 목록 - UniBridge</title>

<%-- CSS 경로 절대경로화 --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/user/notice/report.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/user/notice/popup.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/user/notice/calendar.css">

<%-- JS 로드 (module 설정 유지) --%>
<script type="module"
	src="${pageContext.request.contextPath}/assets/js/user/notice/report.js"
	defer></script>
<script type="module"
	src="${pageContext.request.contextPath}/assets/js/user/notice/subjectSelector.js"
	defer></script>
<script type="module"
	src="${pageContext.request.contextPath}/assets/js/user/notice/calendar.js"
	defer></script>
</head>
<body>
	<jsp:include page="/app/user/header.jsp" />

	<div id="root">
		<div class="main-container">
			<%-- 상단 필터 영역 --%>
			<div class="filter-container">
				<div class="filter-container__inner">
					<div class="filter-container__inner__left">
						<%-- 날짜 필터 --%>
						<div class="filter-date-container">
							<div class="filter-date-container__inner">
								<div class="filter-date-placeholder filter-placeholder"
									id="dateFilterText">
									<c:choose>
										<c:when test="${not empty param.startDate}">
                                            ${param.startDate} ~ ${param.endDate}
                                        </c:when>
										<c:otherwise>기간 선택 · 전체</c:otherwise>
									</c:choose>
								</div>
								<div class="filter-date-selector" id="dateFilterTrigger"></div>
							</div>

							<%-- 달력 패널 (calendar.js에서 제어) --%>
							<div class="date-picker-panel" id="datePickerPanel">
								<div class="date-picker-top">
									<div class="date-picker-title">기간 선택</div>
									<button type="button" class="date-picker-close"
										id="datePickerClose">x</button>
								</div>
								<div class="date-picker-quick">
									<button type="button" class="quick-btn active" data-range="all">전체</button>
									<button type="button" class="quick-btn" data-range="today">오늘</button>
									<button type="button" class="quick-btn" data-range="week">이번
										주</button>
									<button type="button" class="quick-btn" data-range="month">이번
										달</button>
								</div>
								<div class="date-picker-calendar">
									<div class="calendar-header">
										<button type="button" class="month-nav" id="prevMonth">&lt;</button>
										<div class="month-title" id="monthTitle"></div>
										<button type="button" class="month-nav" id="nextMonth">&gt;</button>
									</div>
									<div class="week-row">
										<div>일</div>
										<div>월</div>
										<div>화</div>
										<div>수</div>
										<div>목</div>
										<div>금</div>
										<div>토</div>
									</div>
									<div class="day-grid" id="dayGrid"></div>
								</div>
								<div class="date-picker-bottom">
									<div class="selected-range" id="selectedRange">전체 기간</div>
									<div class="date-picker-actions">
										<button type="button" class="action-btn reset-btn"
											id="resetDate">초기화</button>
										<button type="button" class="action-btn apply-btn"
											id="applyDate">적용</button>
									</div>
								</div>
							</div>
						</div>

						<%-- 과목 필터 --%>
						<div class="filter-subject-container">
							<div class="filter-subject-placeholder filter-placeholder">필터링할
								과목명을 선택해주세요.</div>
							<div class="filter-subject-selector">▼</div>
							<div class="filter-subject-dropdown disabled">
								<ul class="filter-subject-dropdown__inner">
									<%-- 과목 리스트도 서버에서 받아온다면 c:forEach 사용 가능 --%>
									<li class="filter-subject-item">전체 과목</li>
								</ul>
							</div>
						</div>
					</div>

					<div class="filter-container__inner__right">
						<div class="filter-apply-button" onclick="location.reload();">필터
							적용</div>
						<div class="filter-create-container">새 학습 보고서 작성</div>
					</div>
				</div>
			</div>

			<div class="list-container">
				<%-- 왼쪽 사이드바 (현황) --%>
				<aside class="nav-container">
					<div class="cur-status-container">
						<div class="cur-status-title-container">
							<div class="cur-status-title-container__inner">
								<span>전체 현황</span>
							</div>
						</div>
						<div class="cur-status-content-container">
							<div class="cur-status-content-container__inner">
								<div class="content-container">
									<div class="status-title">
										<div class="title">전체 학습일지</div>
										<%-- Controller에서 넘겨준 리스트 사이즈 혹은 status 맵 사용 --%>
										<div class="value">${reportList.size()}</div>
									</div>
									<div class="status-content">
										<span>현재 등록된 멘토·멘티 학습일지 총 개수</span>
									</div>
								</div>
								<div class="content-container">
									<div class="status-title">
										<div class="title">이번 주 작성 수</div>
										<div class="value">${status.WEEK_COUNT != null ? status.WEEK_COUNT : 0}</div>
									</div>
									<div class="status-content">
										<span>이번 주에 작성된 학습일지 개수</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</aside>

				<%-- 메인 리스트 영역 --%>
				<main class="list-container__inner">
					<div class="list-title-container">
						<div class="list-main-title">학습일지 목록</div>
						<div class="list-sub-title">멘토·멘티 학습일지를 날짜, 상태, 성취도 기준으로 확인할
							수 있습니다.</div>
					</div>

					<%-- 리스트 컨테이너 시작 --%>
					<div class="list-content-container">
						<div class="list-content">
							<%-- CSS에서 정의한 컬럼 헤더 영역 추가 --%>
							<div class="list-content__body">
								<div class="list-content__body-title">
									<div class="write-date">작성일</div>
									<div class="report-name">보고서 제목</div>
									<div class="subject-name">과목명</div>
									<div class="week">주차</div>
									<div class="session">회차</div>
									<div class="actions">관리</div>
								</div>
								<%-- 실제 데이터 반복 구간 --%>
								<ul class="list-content__body-content">
									<c:choose>
										<c:when test="${not empty reportList}">
											<c:forEach var="report" items="${reportList}">
												<li class="list-learning-content"
													data-id="${report.reportNumber}">
													<div class="date">${report.reportDate}</div>

													<div class="report-name">
														<div class="title">${report.subjectSummary}</div>
													</div>

													<div class="mentor-mentee-name">
														<div class="mentor">멘토이름</div>
														<%-- 필요시 데이터 바인딩 --%>
														<div class="mentee">멘티이름</div>
													</div>

													<div class="subject-name">${report.subjectTitle}</div>

													<div class="week">${report.reportWeek}주차</div>

													<div class="session">${report.reportSession}회차</div>

													<div class="actions">
														<button type="button" class="detail">상세보기</button>
														<button type="button" class="modify">수정</button>
													</div>
												</li>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<li class="no-data"
												style="text-align: center; padding: 40px; list-style: none;">등록된
												학습일지가 없습니다.</li>
										</c:otherwise>
									</c:choose>
								</ul>
							</div>
						</div>
					</div>
				</main>
			</div>
		</div>

		<%-- 팝업 컨테이너 (JS에서 HTML 주입) --%>
		<div class="popup-container">
			<div class="dim"></div>
		</div>
	</div>

	<jsp:include page="/app/user/footer.jsp" />
</body>
</html>