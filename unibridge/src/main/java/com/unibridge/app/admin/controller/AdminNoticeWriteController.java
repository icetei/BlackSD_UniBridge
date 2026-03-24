package com.unibridge.app.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.unibridge.app.Execute;
import com.unibridge.app.Result;
import com.unibridge.app.admin.dao.AdminDAO;

public class AdminNoticeWriteController implements Execute{

	@Override
	public Result execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("게시글 작성 페이지 컨트롤러 이동 완료");
		Result result = new Result();
		HttpSession session = request.getSession();
		Integer adminNumber = (Integer)session.getAttribute("adminNumber");
		String path = null;
		
		System.out.println("작성 관리자 번호 : " + adminNumber);
		
		path = "/app/admin/adminNotice/noticeWrite.jsp";
		
		result.setPath(path);
		result.setRedirect(false);
		
		return result;
	}

}
