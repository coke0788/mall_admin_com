package gdu.mall.vo;

public class Category {
	private int categoryNo;
	private String categoryName;
	private int categoryWeight;
	private String categoryDate;
	public int getCategoryNo() {
		return categoryNo;
	}
	
	//private으로 변경하면 set와 get가 필요
	//set-> 입력 있고  return 없음. get -> 입력 없고 return 있음.
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getCategoryWeight() {
		return categoryWeight;
	}
	public void setCategoryWeight(int categoryWeight) {
		this.categoryWeight = categoryWeight;
	}
	public String getCategoryDate() {
		return categoryDate;
	}
	public void setCategoryDate(String categoryDate) {
		this.categoryDate = categoryDate;
	}
}
