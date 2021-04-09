package gdu.mall.dao;
import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;
import java.sql.*;
import java.util.*;

public class NoticeDao {
	//목록 메서드
	public static ArrayList<Notice> selectNoticeList(int rowPerPage, int beginRow, String searchWord) throws Exception{
		//reset return
		ArrayList<Notice> list = new ArrayList<>();
		//sql
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=null;
		String sql="";
		if(searchWord.equals("")) {
			sql="SELECT notice_no, notice_title, notice_content, notice_date, manager_id FROM notice ORDER BY notice_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql="SELECT notice_no, notice_title, notice_content, notice_date, manager_id FROM notice WHERE notice_title LIKE ? ORDER BY notice_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		//db, execute
		ResultSet rs = stmt.executeQuery();
		//디버깅
		System.out.println("목록 stmt :"+stmt);
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("notice_no"));
			n.setNoticeTitle(rs.getString("notice_title"));
			n.setNoticeContent(rs.getString("notice_content"));
			n.setNoticeDate(rs.getString("notice_date"));
			n.setManagerId(rs.getString("manager_id"));
			list.add(n);
		}
		//return
		return list;
	}
	//전체 페이지 메소드
	public static int totalCount(String searchWord) throws Exception{
		//reset return
		int totalRow=0;
		//sql
		String sql="";
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=null;
		if(searchWord.equals("")) {
			sql="SELECT COUNT(*) cnt FROM notice";
			stmt=conn.prepareStatement(sql);
		} else {
			sql="SELECT COUNT(*) cnt FROM notice WHERE notice_title LIKE ?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
		//db, execute
		ResultSet rs = stmt.executeQuery();
		//디버깅
		System.out.println("전체개수 stmt :"+stmt);
		if(rs.next()) {
			totalRow=rs.getInt("cnt");
		}
		//return
		return totalRow;
	}
	//등록 메서드
	//매개변수를 하나하나 수정할 때마다 추가/삭제 등 하는 것보다 그냥 vo패키지의 클래스들을 뭉텅 가져오는게 유지보수가 편리함. 사용할 때는 action파일에서 생성자? 연산자? 생성을 추가로 해줘야함.
	public static int insertNotice(Notice notice) throws Exception{
		//sql
		/*You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near
		 *위 오류 보통 sql문 오타난거임. 
		*/
		String sql="INSERT INTO notice(notice_title,notice_content,notice_date,manager_id) VALUES (?,?,now(),?)";
		//reset return
		int rowCnt=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setString(3, notice.getManagerId());
		System.out.println("등록 stmt:"+stmt);
		rowCnt=stmt.executeUpdate();
		
		//return
		return rowCnt;
	}
	//상세페이지 메서드
	public static Notice selectNoticeOne(int noticeNo)throws Exception{
		//sql
		String sql="SELECT notice_no, notice_title, notice_content, notice_date, manager_id FROM notice WHERE notice_no=?";
		//reset return
		Notice notice=null;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()) {
			notice=new Notice();
			notice.setNoticeNo(rs.getInt("notice_no"));
			notice.setNoticeTitle(rs.getString("notice_title"));		
			notice.setNoticeContent(rs.getString("notice_content"));
			notice.setNoticeDate(rs.getString("notice_date"));
			notice.setManagerId(rs.getString("manager_id"));
			}
		
		//return
		return notice;
	}
	//삭제 메소드
	public static int deleteNotice(int noticeNo) throws Exception{
		//sql
		String sql="DELETE FROM notice WHERE notice_no=?";
		//reset return
		int rowCnt=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println("삭제stmt:"+stmt);
		rowCnt=stmt.executeUpdate();
		//return
		return rowCnt;
	}
	//수정 메소드
	public static int updateNotice(Notice notice) throws Exception{
		//sql
		String sql="UPDATE notice SET notice_title=?, notice_content=? WHERE notice_no=?";
		//reset return
		int rowCnt=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		rowCnt=stmt.executeUpdate();
		//return
		return rowCnt;
	}
}
