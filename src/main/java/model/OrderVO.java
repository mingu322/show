package model;

public class OrderVO extends CartVO {
	private int oid;
	private String pid;
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	@Override
	public String toString() {
		return "OrderVO [oid=" + oid + ", pid=" + pid + ", getQnt()=" + getQnt() + ", getGid()=" + getGid()
				+ ", getPrice()=" + getPrice() + "]";
	}
	
	
}
