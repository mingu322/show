package model;

public class CountVO {
	private int rcnt; //댓글수
	private int fcnt; //좋아요수
	private int ucnt; //사용자 좋아요 체크여부
	
	public int getRcnt() {
		return rcnt;
	}
	public void setRcnt(int rcnt) {
		this.rcnt = rcnt;
	}
	public int getFcnt() {
		return fcnt;
	}
	public void setFcnt(int fcnt) {
		this.fcnt = fcnt;
	}
	public int getUcnt() {
		return ucnt;
	}
	public void setUcnt(int ucnt) {
		this.ucnt = ucnt;
	}
	
	
}
