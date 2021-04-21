
package workbook;

public class make7 {

	public static void main(String[] args) {
		/*
		 * 특정 숫자를 받아 구구단을 출력하는 메소드 생성하시오
		 * 객체변수명.gugu(7);
		 * 출력결과 : 7 단출력
		 */
		gugu(7);
	}
	public static void gugu(int dan) {
		for(int i=1; i<=9; i++) {
			System.out.println(dan+"x"+i+"="+dan*i);
		}
	}
}
