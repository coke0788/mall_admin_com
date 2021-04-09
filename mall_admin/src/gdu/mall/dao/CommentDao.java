package gdu.mall.dao;
import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class CommentDao {
	public static int insertComment(Comment comment) throws Exception{
		//sql
		String sql="INSERT INTO comment(notice_no, manager_id, comment_content, comment_date) VALUES (?, ?, ?, now())";
		//reset return
		int rowCnt=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		rowCnt=stmt.executeUpdate();
		System.out.println("작성 stmt:"+stmt);
		//return
		return rowCnt;
	}
	
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo)throws Exception{
		//sql
		// SELECT * FROM comment WHERE notice_no=?
		String sql="SELECT comment_no, manager_id, comment_content, comment_date FROM comment WHERE notice_no=? ORDER BY comment_date DESC";
		ArrayList<Comment> list = new ArrayList<Comment>();
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println("목록 stmt:"+stmt);
		while(rs.next()) {
			//오버라이딩? Comment
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("comment_no"));
			c.setManagerId(rs.getString("manager_id"));
			c.setCommentContent(rs.getString("comment_content"));
			c.setCommentDate(rs.getString("comment_date"));
			list.add(c);
		}
		//return
		return list;
	}
	//자바에서는 매개변수(타입이든 개수든)만 다르면 메소드이름이 같아도 됨=오버로딩.
	public static int deleteComment(int commentNo)throws Exception{ 
		//DELETE FROM comment WHERE comment_no=?
		String sql="DELETE FROM comment WHERE comment_no=?";
		int rowCnt=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		rowCnt=stmt.executeUpdate();
		System.out.println("삭제 stmt:"+stmt);
		//return
		return rowCnt;
	}
	public static int deleteComment(int commentNo, String managerId)throws Exception{
		//DELETE FROM comment WHERE comment_no=? and manager_id=?
		String sql="DELETE FROM comment WHERE comment_no=? and manager_id=?";
		int rowCnt=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		rowCnt=stmt.executeUpdate();
		System.out.println("삭제 stmt:"+stmt);
		//return
		return rowCnt;
	}
	public static int selectCommentCnt(int noticeNo) throws Exception{
		int rowCnt=0;
		//행의 개수 카운트. 0이 리턴될 경우 코멘트가 존재하지 않음.
		String sql="SELECT count(*) cnt FROM comment WHERE notice_no=?";
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println("개수 stmt:"+stmt);
		if(rs.next()) {
			rowCnt=rs.getInt("cnt");
		}
		return rowCnt;
	}
}
