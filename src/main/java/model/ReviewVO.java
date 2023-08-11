package model;

public class ReviewVO extends UserVO{
	private int rid;
	private String gid;
	private String revDate;
	private String content;
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public String getGid() {
		return gid;
	}
	public void setGid(String gid) {
		this.gid = gid;
	}
	public String getRevDate() {
		return revDate;
	}
	public void setRevDate(String revDate) {
		this.revDate = revDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "ReviewVO [rid=" + rid + ", gid=" + gid + ", revDate=" + revDate + ", content=" + content + ", getUid()="
				+ getUid() + ", getUname()=" + getUname() + ", getPhoto()=" + getPhoto() + "]";
	}
	
	
}
