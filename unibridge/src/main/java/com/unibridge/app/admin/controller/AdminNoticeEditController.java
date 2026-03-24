package com.unibridge.app.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.unibridge.app.Execute;
import com.unibridge.app.Result;
import com.unibridge.app.admin.dao.AdNoticeBoardDAO;
import com.unibridge.app.admin.dto.AdNoticeBoardDTO;

public class AdminNoticeEditController implements Execute {

	@Override
	public Result execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("===관리자 공지 수정 페이지===");
		int boardNumber = Integer.valueOf(request.getParameter("boardNumber"));
		AdNoticeBoardDAO boardDAO = new AdNoticeBoardDAO();
		Result result = new Result();
		System.out.println("boardNumber 값 : " + boardNumber);
		AdNoticeBoardDTO boardDTO = boardDAO.selectBoard(boardNumber);
		request.setAttribute("board", boardDTO);
		

		
		result.setPath("/app/admin/adminNotice/noticeEdit.jsp");
		result.setRedirect(false);

		return result;

	}
	

}
