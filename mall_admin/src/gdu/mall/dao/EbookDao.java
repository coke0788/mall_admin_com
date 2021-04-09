package gdu.mall.dao;
import gdu.mall.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import gdu.mall.vo.*;


public class EbookDao {
	
	//목록 메서드
	public static ArrayList<Ebook> selectEbookList(int rowPerPage, int beginRow, String categoryName) throws Exception{
		//2. 리턴타입 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		//1. 쿼리 및 처리
		String sql="";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		if(categoryName.equals("")) { //카테고이름이 널이라면 카테고리값 안 받아옴.
			sql="SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice, ebook_img ebookImg FROM ebook ORDER BY ebook_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {//카테고리가 널이 아니라면, 선택값이 있담녀, 카테고리값 받아옴.
			sql="SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice, ebook_img ebookImg FROM ebook WHERE category_name=? ORDER BY ebook_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookImg(rs.getString("ebookImg"));
			list.add(e);
		}
		//4. 리턴
		return list;
	}
	//전체 행의 수
		public static int totalCount(String categoryName) throws Exception{
			int totalRow=0;
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = null;
			String sql = "";
			//카테고리네임이 선택되지 않으면
			if(categoryName=="") {
				sql = "SELECT COUNT(*) cnt FROM ebook";
				stmt = conn.prepareStatement(sql);
			} else { //카테고리 네임이 선택 되면
				sql = "SELECT COUNT(*) cnt FROM ebook WHERE category_name=?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, categoryName);
				
			}
			ResultSet rs = stmt.executeQuery();
			System.out.println("토탈페이지 stmt : "+stmt);
			if(rs.next()) {
				totalRow = rs.getInt("cnt");
			}
			return totalRow;
		}
	//입력 메서드
		//매개변수가 너무 많기 때문에 만들어놓은 vo를 매개변수로 그대로 가져온다.
		public static int insertEbook(Ebook ebook) throws Exception{
			/*
			 * 쿼리문
			 * INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, 
			 * ebook_img, ebook_date, ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중') 
			 */
			//1. 쿼리
			String sql="INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중')";
			//2.리턴타입 초기화
			int rowCnt=0;
			//3.처리
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookISBN());
			stmt.setString(2, ebook.getCategoryName());
			stmt.setString(3, ebook.getEbookTitle());
			stmt.setString(4, ebook.getEbookAuthor());
			stmt.setString(5, ebook.getEbookCompany());
			stmt.setInt(6, ebook.getEbookPageCount());
			stmt.setInt(7, ebook.getEbookPrice());
			stmt.setString(8, ebook.getEbookSummary());
			rowCnt=stmt.executeUpdate();
			//4.리턴
			return rowCnt;
		}
	//상세페이지 메서드
		public static Ebook selectEbookOne(String ebookISBN) throws Exception{
			//쿼리는 넘버 빼고 다 가져와야 함.
			//1. 쿼리
			String sql="SELECT ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state FROM ebook WHERE ebook_isbn=?";
			//2.리턴타입 초기화
			Ebook ebook=null;
			//3.처리
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebookISBN);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				ebook=new Ebook();
				ebook.setEbookISBN(rs.getString("ebook_isbn"));
				ebook.setCategoryName(rs.getString("category_name"));
				ebook.setEbookTitle(rs.getString("ebook_title"));
				ebook.setEbookAuthor(rs.getString("ebook_author"));
				ebook.setEbookCompany(rs.getString("ebook_company"));
				ebook.setEbookPageCount(rs.getInt("ebook_page_count"));
				ebook.setEbookPrice(rs.getInt("ebook_price"));
				ebook.setEbookSummary(rs.getString("ebook_summary"));
				ebook.setEbookImg(rs.getString("ebook_img"));
				ebook.setEbookDate(rs.getString("ebook_date"));
				ebook.setEbookState(rs.getString("ebook_state"));
			}
			//4.리턴
			return ebook;
		}
	//ISBN 중복 확인 메서드
		public static String selectEbookISBN(String ebookISBN) throws Exception{
			//1.쿼리
			String sql="SELECT ebook_isbn FROM ebook WHERE ebook_ISBN=?";
			//2. 리턴타입 초기화
			String returnEbookISBN=null;
			//3.처리
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebookISBN);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				returnEbookISBN=rs.getString("ebook_isbn");
			}
			//4.리턴
			return returnEbookISBN;
		}
	//img 수정 메서드
		public static int updateEbookImg(Ebook ebook) throws Exception{
			//sql
			String sql="UPDATE ebook SET ebook_img=? WHERE ebook_isbn=?";
			//reset return
			int rowCnt=0;
			//db, execute
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookImg());
			stmt.setString(2, ebook.getEbookISBN());
			System.out.println("img수정 stmt:"+stmt);
			rowCnt=stmt.executeUpdate();
			//return
			return rowCnt;
			
		}
	//state 수정 메서드
		public static int updateEbookState(Ebook ebook) throws Exception{
			//sql
			String sql="UPDATE ebook SET ebook_state=? WHERE ebook_isbn=?";
			//reset return
			int rowCnt=0;
			//db, execute
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookState());
			stmt.setString(2, ebook.getEbookISBN());
			System.out.println("state수정 stmt:"+stmt);
			rowCnt=stmt.executeUpdate();
			//return
			return rowCnt;
		}
	//summary 수정 메서드
		public static int updateEbookSummary(Ebook ebook) throws Exception{
			//sql
			String sql="UPDATE ebook SET ebook_summary=? WHERE ebook_isbn=?";
			//reset return
			int rowCnt=0;
			//db, execute
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookSummary());
			stmt.setString(2, ebook.getEbookISBN());
			//디버깅
			System.out.println("수정 stmt:"+stmt);
			rowCnt=stmt.executeUpdate();
			//return
			return rowCnt;
		}
	//삭제 메서드
		public static int deleteEbook(Ebook ebook) throws Exception{
			//sql
			String sql="DELETE FROM ebook WHERE ebook_isbn=?";
			//reset return
			int rowCnt=0;
			//db, execute
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookISBN());
			//디버깅
			System.out.println("삭제 stmt:"+stmt);
			rowCnt=stmt.executeUpdate();
			//return
			return rowCnt;
		}
	//전체 수정 메서드
		public static int updateEbook(Ebook ebook) throws Exception{
			//sql
			String sql="UPDATE ebook SET ebook_state=?, ebook_ISBN=?, ebook_Title=?, category_name=?, ebook_author=?, ebook_company=?, ebook_page_count=?, ebook_price=?, ebook_summary=? WHERE ebook_isbn=?";
			//reset return
			int rowCnt=0;
			//db, execute
			Connection conn=DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookState());
			stmt.setString(2, ebook.getEbookISBN());
			stmt.setString(3, ebook.getEbookTitle());
			stmt.setString(4, ebook.getCategoryName());
			stmt.setString(5, ebook.getEbookAuthor());
			stmt.setString(6, ebook.getEbookCompany());
			stmt.setInt(7, ebook.getEbookPageCount());
			stmt.setInt(8, ebook.getEbookPrice());
			stmt.setString(9, ebook.getEbookSummary());
			stmt.setString(10, ebook.getEbookISBN());
			System.out.println("전체수정 stmt:"+stmt);
			rowCnt=stmt.executeUpdate();
			//return
			return rowCnt;
		}
}