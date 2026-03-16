// header.js
// ※ JSP(header.jsp)가 HTML 렌더링을 담당하므로
//    이 파일은 로그아웃 버튼 이벤트만 처리합니다.

document.addEventListener("DOMContentLoaded", function () {
    const logoutBtn = document.querySelector(".headerBtnText.logout");
    if (logoutBtn) {
        logoutBtn.addEventListener("click", function (e) {
            e.preventDefault();
            if (confirm("로그아웃 하시겠습니까?")) {
                // TODO: Servlet 연동 후 /unibridge/user/logout 으로 변경
                window.location.href = logoutBtn.href;
            }
        });
    }
});
