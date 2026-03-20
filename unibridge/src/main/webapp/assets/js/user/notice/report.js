import { insertLrViewerPopup } from "./popupUtils.js";

document.addEventListener("DOMContentLoaded", () => {
	const listContainer = document.querySelector(".list-content-container");
	const writeBtn = document.querySelector(".filter-create-container");

	if (listContainer) {
		listContainer.addEventListener("click", (e) => {
			// 1. 상세보기 클릭
			const detailBtn = e.target.closest(".detail") || e.target.closest(".view-detail");
			if (detailBtn) {
				const item = detailBtn.closest(".list-learning-content") || detailBtn.closest(".report-item");
				
				// JSP의 data-id에 담긴 값은 이제 reportNumber입니다.
				const reportNumber = item.dataset.id; 
				openDetailPopup(reportNumber);
			}

			// 2. 수정하기 클릭
			const modifyBtn = e.target.closest(".modify");
			if (modifyBtn) {
				const reportNumber = modifyBtn.closest(".list-learning-content").dataset.id;
				// openModifyPopup(reportNumber); 
			}
		});
	}

	// 작성 버튼 클릭 시
	if (writeBtn) {
		writeBtn.onclick = () => {
			document.querySelector(".popup-container").classList.add("active");
		};
	}
});

async function openDetailPopup(reportNumber) {
	const popupContainer = document.querySelector(".popup-container");

	try {
		// [수정] 파라미터명을 reportNumber로 변경하여 서버(Controller)와 맞춥니다.
		const response = await fetch(`reportDetailOk.rep?reportNumber=${reportNumber}`);
		
		// 서버에서 보낸 JSON 데이터를 받습니다.
		const data = await response.json();

		popupContainer.classList.add('active');
		
		// [수정] 전송받은 데이터(data)를 팝업 유틸에 전달합니다.
		// (기존 코드의 result.data 대신 서버에서 바로 보낸 DTO 객체인 data를 그대로 사용)
		insertLrViewerPopup({ target: popupContainer, data: data });

	} catch (error) {
		console.error("데이터 로드 실패:", error);
		alert("상세 데이터를 불러오는 중 오류가 발생했습니다.");
	}
}