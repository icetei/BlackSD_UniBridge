package com.unibridge.app.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.unibridge.app.admin.dto.AdNoticeBoardDTO;
import com.unibridge.config.MyBatisConfig;

public class AdNoticeBoardDAO {
	
	public SqlSession sqlSession;

	   public AdNoticeBoardDAO() {
	      sqlSession = MyBatisConfig.getSqlSessionFactory().openSession(true);
	   }
	   //총 개수 조회
		public int getTotal() {
			System.out.println("게시글 총 개수 조회 - getTotal");
			return sqlSession.selectOne("admin.noticeGetTotal");
		}
	   
		//필터링 개수 조회
		public int getRenderingDateType(Map<String, String> pagefilter) {
			System.out.println("게시글 필터 후 개수 조회 - getRenderingDateType");
			return sqlSession.selectOne("admin.noticeGetRenderingDateTypeTotal", pagefilter);
		}
		
		public int getRenderingDate(Map<String, String> pagefilter) {
			System.out.println("게시글 필터 후 개수 조회 - getRenderingDate");
			return sqlSession.selectOne("admin.noticeGetRenderingDateTotal", pagefilter);
		}
		
		public int getRenderingType(Map<String, String> pagefilter) {
			System.out.println("게시글 필터 후 개수 조회 - getRenderingType");
			return sqlSession.selectOne("admin.noticeGetRenderingTypeTotal", pagefilter);
		}
		
		
		//공지 게시판 전체 목록 확인
		public List<AdNoticeBoardDTO> selectAll(Map<String, String> pageRow){
			System.out.println("모든 게시글 조회하기");
			List<AdNoticeBoardDTO> list = sqlSession.selectList("admin.noticeSelectAll", pageRow);
			System.out.println("조회 결과 " + list);
			return list;
		}
		
	   //공지 게시판 필터링 목록 확인
		public  List<AdNoticeBoardDTO> selectDateTypeFilter(Map<String, String> pagefilter){
			System.out.println("랜더링 게시글 조회하기 - selectDateTypeFilter 메소드 실행 : " + pagefilter);
			List<AdNoticeBoardDTO> list = sqlSession.selectList("admin.noticeSelectDateTypeFilter", pagefilter);
			System.out.println("조회 결과 : " + list);
			return list;
		}
		
		public  List<AdNoticeBoardDTO> selectDateFilter(Map<String, String> pagefilter){
			System.out.println("랜더링 게시글 조회하기 - selectFilter 메소드 실행 : " + pagefilter);
			List<AdNoticeBoardDTO> list = sqlSession.selectList("admin.noticeSelectDateFilter", pagefilter);
			System.out.println("조회 결과 : " + list);
			return list;
		}
		
		public  List<AdNoticeBoardDTO> selectTypeFilter(Map<String, String> pagefilter){
			System.out.println("랜더링 게시글 조회하기 - selectTypeFilter 메소드 실행 : " + pagefilter);
			List<AdNoticeBoardDTO> list = sqlSession.selectList("admin.noticeSelectTypeFilter", pagefilter);
			System.out.println("조회 결과 : " + list);
			return list;
		}
		
		public AdNoticeBoardDTO selectBoard(int boardNumber) {
			System.out.println("게시글 상세 페이지 조회(단건조회) - selectBoard 메소드 실행");
			return sqlSession.selectOne("admin.noticeSelectOne", boardNumber);
		}
		
		public int insertBoard(AdNoticeBoardDTO boardDTO) {
			System.out.println("게시글 작성 - insertBoard 메소드 실행");
			int insert = sqlSession.insert("admin.noticeInsert", boardDTO);
			System.out.println(boardDTO + "===출력");
			System.out.println("insert 결과 : " + insert);
			System.out.println("생성된 boardNumber : " + boardDTO.getNoticeboardNumber());
			return boardDTO.getNoticeboardNumber();
		}
		
		public Integer fileNumberSelect(int boardNumber) {
			return sqlSession.selectOne("admin.noticeNumberToFileNumber",boardNumber);
		}
		
		public void updateBoard(AdNoticeBoardDTO boardDTO) {
			System.out.println("게시글 수정 - updateBoard 메소드 실행");
			sqlSession.update("admin.noticeUpdate", boardDTO);
			System.out.println("게시글 수정 쿼리 실행 완료");
		}
		
		public void deleteBoard(int boardNumber) {
			System.out.println("게시글 삭제");
			sqlSession.delete("admin.noticeDelete", boardNumber);
			System.out.println("게시글 삭제 쿼리 실행 완료");
		}
		
}
