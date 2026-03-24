document.addEventListener("DOMContentLoaded", () => {


document.getElementById("btnList").addEventListener("click", () => {
      window.location.href = "noticeList.admin";
    });
  
  

document.getElementById("btnEdit").addEventListener("click", () => {
      window.location.href = `noticeEdit.admin?boardNumber=${boardNumber}`;
    });
  


document.getElementById("btnDelete").addEventListener("click", () => {
  if (confirm("공지사항을 삭제하시겠습니까?")) {
    window.location.href = `noticeDeleteOk.admin?boardNumber=${boardNumber}`;
  }
});
  

});
