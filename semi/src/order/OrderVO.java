package order;

import purchase.PurchaseVO;

public class OrderVO extends PurchaseVO {
	private String p_id;
	private int price;
	private int quantity;

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "OrderVO [p_id=" + p_id + ", price=" + price + ", quantity=" + quantity 
				+ ", getO_id()=" + getO_id() + "]";
	}

}