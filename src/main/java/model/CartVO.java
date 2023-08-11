package model;

public class CartVO extends GoodsVO{
	private int qnt;

	public int getQnt() {
		return qnt;
	}

	public void setQnt(int qnt) {
		this.qnt = qnt;
	}

	@Override
	public String toString() {
		return "CartVO [qnt=" + qnt + ", getGid()=" + getGid() + ", getTitle()=" + getTitle() + ", getPrice()="
				+ getPrice() + ", getImage()=" + getImage() + "]";
	}

	
	
}
