package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;

public class ClientDao {
	
	//전체 행의 수
	public static int totalCount(String searchWord) throws Exception{
		
		int totalRow = 0;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		//검색어가 공백이면
		if(searchWord.equals("")) {
			sql = "SELECT COUNT(*) cnt FROM client";
			stmt = conn.prepareStatement(sql);
		} else { //검색어가 공백이 아니면 like연산자로 검색어 받아오기
			sql = "SELECT COUNT(*) cnt FROM client WHERE client_mail LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			
		}
		ResultSet rs = stmt.executeQuery();
		//디버깅
		System.out.println("토탈페이지 stmt : "+stmt);
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		//4. 리턴
		return totalRow;
	}
	
	//목록
	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow, String searchWord) throws Exception{
		
		//1. 리턴타입초기화
		// 리턴 타입이 ArrayList<Manager>(배열, 참조타입)인 list를 new 객체를 만들어 값 초기화.
		ArrayList<Client> list = new ArrayList<>();
		
		/* 2. 쿼리 및 처리
		 * 클라이언트 데이트와 메일과 검색어를 가져올거임. 
		 * 검색어가 공백인 경우 :
		 * SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?, ?
		 * 검색어가 공백이 아닌 경우 :
		 * SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail like ? ORDER BY client_date DESC LIMIT ?, ?
		 */
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = null;
		String sql = "";
		if(searchWord.equals("")) {
			sql="SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else { //like는 ?글자가 client_mail에 있는지 찾는 연산자.
			sql="SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail LIKE ? ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%"); //%가 앞에 붙으면 "아무거나 + 검색어"가 검색이 됨.
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}

		//디버깅
		System.out.println("목록 stmt :" + stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) { //rs.next 메서드는 값이 없을 때까지 실행문(여기선 While문)을 실행시킴.
			//오버라이딩. Client 클래스(부모)의 값을 참조해서 재정의함.
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);//list에 쿼리값 정의한 것들을 저장.
		}
		
		//3. 리턴
		return list;
		
	}
	//삭제 메서드
	public static int deleteClient(String clientMail) throws Exception{
		//1. sql
		String sql = "DELETE from client WHERE client_mail=?";
		//2. 리턴타입 초기화
		int rowCnt = 0;
		//3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		rowCnt = stmt.executeUpdate();
		//디버깅
		System.out.println("삭제 stmt:"+stmt);
		//4. 리턴
		return rowCnt;
	}
	//수정 메서드
	public static int updateClient(String clientMail, String clientPw) throws Exception{
		//1. sql
		String sql = "UPDATE client SET client_pw=? WHERE client_mail=?";
		//2. 리턴타입 초기화
		int rowCnt = 0;
		//3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientPw);
		stmt.setString(2, clientMail);
		rowCnt = stmt.executeUpdate();
		//디버깅
		System.out.println("수정 stmt"+stmt);
		//4. 리턴
		return rowCnt;
	}
}