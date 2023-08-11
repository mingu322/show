package model;

public class PurchaseVO extends UserVO{
	private String pid;
	private int purSum;
	private int status;
	private String purDate;
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public int getPurSum() {
		return purSum;
	}
	public void setPurSum(int purSum) {
		this.purSum = purSum;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getPurDate() {
		return purDate;
	}
	public void setPurDate(String purDate) {
		this.purDate = purDate;
	}
	
	@Override
	public String toString() {
		return "PurchaseVO [pid=" + pid + ", purSum=" + purSum + ", status=" + status + ", purDate=" + purDate
				+ ", getUid()=" + getUid() + ", getUname()=" + getUname() + ", getPhone()=" + getPhone()
				+ ", getAddress1()=" + getAddress1() + ", getAddress2()=" + getAddress2() + "]";
	}
	
	
}
