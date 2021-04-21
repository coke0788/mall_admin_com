package workbook;

public class make2 {
	/*
	 * 다음 주어진 변수들을 조건문을 사용하여 오름차순으로 정렬하고 출력하시오
	 * int a = 5;
	 * int b = 7;
	 * int c = 3;
	 * System.out.println(a + “ “ + b + “ “ + c);
	 * 출력결과 : 3 5 7
	 */
	public static void main(String[] args) {
		int a = 5;
		int b = 7;
		int c = 3;
		if(a > b && b > c ) {
			System.out.println(c + "" + b + "" + a);
		} else if(a > c && c > b) {
			System.out.println(b + "" + c + "" + a);
		} else if(b > a && a > c) {
		System.out.println(c + "" + a + "" + b);
		} else if(b > c && c > a) {
			System.out.println(a + "" + c + "" + b);
		} else if(c > a && a > b) {
			System.out.println(b + "" + a + "" + c);
		} else {
			System.out.println(a + "" + b + "" + c);
		}
	}
}
