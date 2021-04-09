package gdu.mall.dao;
import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;
import java.sql.*;
import java.util.*;


public class OrdersDao {
	//orders의 리스트가 아니고 orders join ebook join client 리스트르 받아야함.
	/*
	 * SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState 
	 * FROM orders o INNER JOIN ebook e inner join client c ON o.ebook_no=e.ebook_no AND o.client_no=c.client_no ORDER BY o.orders_no desc
	 */
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception{
		//sql
		String sql="SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_ISBN ebookISBN, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e inner join client c ON o.ebook_no=e.ebook_no AND o.client_no=c.client_no ORDER BY o.orders_date DESC LIMIT ?, ?";
		//reset return 
		ArrayList<OrdersAndEbookAndClient> list=new ArrayList<>();
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs=stmt.executeQuery();
		System.out.println("orders 목록 stmt : "+stmt);
		while(rs.next()) {//작은 보따리들을 모아서 큰 보따리에 모아넣는다. 
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			//oec.orders에 위의 o들을 채워넣는다.
			oec.setOrders(o);
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			//oec.ebook에 위의 e를 채워넣는다.
			oec.setEbook(e);
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			//oec.client에 위의 c를 채워넣는다.
			oec.setClient(c);
			list.add(oec);
		}
		//return
		return list;
	}
	public static int totalCnt() throws Exception{
		//sql
		String sql="SELECT COUNT(*) cnt FROM orders";
		//reset return
		int totalRow=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		ResultSet rs=stmt.executeQuery();
		System.out.println("전체개수 stmt:"+stmt);
		while(rs.next()) {
			totalRow=rs.getInt("cnt");
		}
		//return
		return totalRow;
	}
	public static int updateOrders(String ordersState, int ordersNo) throws Exception{
		//sql
		String sql="UPDATE orders SET orders_state=? WHERE orders_no=?";
		//reset return
		int rowCnt=0;
		//db, execute
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, ordersNo);
		rowCnt=stmt.executeUpdate();
		//return
		return rowCnt;
	}
}
