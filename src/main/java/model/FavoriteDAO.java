package model;

import java.sql.*;

import org.json.simple.JSONObject;

public class FavoriteDAO {
	//좋아요 추가
	public void insert(String gid, String uid) {
		try {
			String sql="insert into favorite(gid, uid) values(?,?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ps.setString(2, uid);
			ps.execute();
		}catch(Exception e) {
			System.out.println("좋아요 추가:" + e.toString());
		}
	}
	
	//좋아요 추가
	public void delete(String gid, String uid) {
		try {
			String sql="delete from favorite where gid=? and uid=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ps.setString(2, uid);
			ps.execute();
		}catch(Exception e) {
			System.out.println("좋아요 삭제:" + e.toString());
		}
	}
	
	//좋아요 유무
	public JSONObject read(String gid, String uid) {
		JSONObject obj=new JSONObject();
		try {
			String sql="select count(*) fcnt,";
			sql+="(select count(*) from favorite where gid=? and uid=?) ucnt " ;
			sql+="from favorite where gid=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ps.setString(2, uid);
			ps.setString(3, gid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				obj.put("ucnt", rs.getInt("ucnt"));
				obj.put("fcnt", rs.getInt("fcnt"));
			}
		}catch(Exception e) {
			System.out.println("좋아요유무:" + e.toString());
		}
		return obj;
	}
}