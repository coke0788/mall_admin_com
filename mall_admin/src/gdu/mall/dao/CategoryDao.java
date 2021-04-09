package gdu.mall.dao;
import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class CategoryDao {
	//목록 메서드
	public static ArrayList<String> categoryNameList() throws Exception{
		//1. 쿼리
		String sql="SELECT category_name categoryName FROM category ORDER BY category_weight DESC";
		//2. 리턴타입 초기화
		// 리턴 타입이 ArrayList<Manager>(배열, 참조타입)인 list를 new 객체를 만들어 값 초기화.
		ArrayList<String> list = new ArrayList<>();
		//3. 처리
		//드라이버 설정 : DBUtil.java 클래스에 메소드를 생성해 놓았기 때문에 해당 메소드만 공통으로 호출하여 사용하면 된다.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) { //rs.next 메서드는 값이 없을 때까지 실행문(여기선 While문)을 실행시킴.
			//값타입 변수를 new 객체를 만들어서 값 초기화
			String cn = rs.getString("categoryName");
			list.add(cn); //list에 쿼리값 정의한 것들을 저장.
		}
		//디버깅
		System.out.println("카테고리 목록 stmt : " + stmt);
		//4. 리턴
		return list;
	}
	
	//목록 메서드
	public static ArrayList<Category> selectCategoryList() throws Exception{
		//1. 쿼리
		String sql="SELECT category_no categoryNo, category_name categoryName, category_weight categoryWeight FROM category ORDER BY category_weight DESC";
		//2. 리턴타입 초기화
		ArrayList<Category> list = new ArrayList<>();
		//3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		//select의 경우만 resultset타입을 사용, 이외는 1개행 수정 -> 1(정수형 값타입) 반환 과 같이 정수 값으로 반환 되기 때문에 int로 받아서 저장.
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			//오버라이딩. Category 클래스(부모)의 값을 참조해서 재정의함.
			Category c = new Category();
			//Manager vo 클래스에 있는 변수를 사용할 것이지만 Private 접근제한자로 접근을 막아놓았기 때문에 접근 가능한 setter메소드 사용. 
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryWeight(rs.getInt("categoryWeight"));
			list.add(c);
		}
		//디버깅
		System.out.println("카테고리 목록 stmt : " + stmt);
		//4. 리턴
		return list;
	}
	//삭제 메서드
	public static int deleteCategory(int categoryNo) throws Exception{
		//1.쿼리
		String sql="DELETE from category WHERE category_no=?";
		//2. 리턴타입 초기화
		int rowCnt=0;
		//3. 처리
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rowCnt=stmt.executeUpdate();
		//디버깅
		System.out.println("카테고리 삭제 stmt:"+stmt);
		//4. 리턴
		return rowCnt;
	}
	//수정 메서드
	public static int updateCategory(int categoryWeight, int categoryNo) throws Exception{
		//1.쿼리
		String sql="UPDATE category SET category_weight=? WHERE category_no=?";
		//2. 리턴타입 초기화
		int rowCnt=0;
		//3. 처리
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight);
		stmt.setInt(2, categoryNo);
		rowCnt=stmt.executeUpdate();
		//디버깅
		System.out.println("카테고리 수정 stmt :" + stmt);
		//4. 리턴
		return rowCnt;
	}
	//등록 메서드
	public static int insertCategory(String categoryName, int categoryWeight) throws Exception{
		//1.쿼리
		String sql="INSERT INTO category(category_name, category_weight, category_date) VALUES(?, ?, now())";
		//2. 리턴타입 초기화
		int rowCnt=0;
		//3. 처리
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, categoryWeight);
		rowCnt=stmt.executeUpdate();
		//디버깅
		System.out.println("카테고리 등록 stmt : " + stmt);
		//4. 리턴
		return rowCnt;
	}
	//제목 중복확인
	public static String selectCategoryName(String categoryName) throws Exception{
		//1.쿼리
		String sql="SELECT category_name FROM category WHERE category_name=?";
		//2. 리턴타입 초기화
		String returnCategoryName=null;
		//3. 처리
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnCategoryName = rs.getString("category_name");
		}
		//디버깅
		System.out.println("카테고리 중복확인 stmt : " + stmt);
		//4.리턴
		return returnCategoryName;
	}
}
