package workbook;

public class make3 {
	//1 부터 100 사이의 3 배수들의 합계를 출력하시오
	public static void main(String[] args) {
		int sum=0;
		for(int i=1; i<=100; i++) {
			if(i%3==0) {
				sum+=i;
			}
		}
		System.out.println(sum);
	}

}
