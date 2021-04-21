package workbook;

public class make4 {
	public static void main(String[] args) {
		//2 ~ 9 단에 해당하는 구구단을 출력하시오.
		for(int i=2; i<=9; i++) {
			for(int j=1; j<=9; j++) {
				System.out.printf(i+"x"+j+"="+(i*j)+"/");
				if(j==9) {
					System.out.println("");
				}
			}
		}
	}
}
