package gdu.mall.vo; //vo타입은 테이블과 동일하게 만듦

public class Manager {
	//보안을 위해 private으로 변수 선언. public - 모두 접근 가능, private - 해당하는 클래스에서만 접근 가능.
	//private으로 변수 선언 시, 외부에서 접근 가능한 getter(리턴값), setter(저장값? 세팅값?)메서드를 만들어준다.
	private int managerNo;
	private String managerId;
	private String managerPw;
	private String managerName;
	private String managerDate;
	private int managerLevel;
	public int getManagerNo() {
		return managerNo;
	}
	public void setManagerNo(int managerNo) {
		this.managerNo = managerNo;
	}
	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
	public String getManagerPw() {
		return managerPw;
	}
	public void setManagerPw(String managerPw) {
		this.managerPw = managerPw;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getManagerDate() {
		return managerDate;
	}
	public void setManagerDate(String managerDate) {
		this.managerDate = managerDate;
	}
	public int getManagerLevel() {
		return managerLevel;
	}
	public void setManagerLevel(int managerLevel) {
		this.managerLevel = managerLevel;
	}
	
}
