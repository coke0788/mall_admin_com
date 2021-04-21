package workbook;

public class make5 {

	
	public static void main(String[] args) {
		/*
		 * 피보나치 수열 10 개를 출력해보자
		 * 1 1 2 3 5 8 13 21 34 55
		 * a=1, b=0 sum=1 / sum=x+y(1) x=y+sum(1) y=sum+x(2)
		 * a=1, b=1, sum=2
		 * a=2, b=3 sum=5
		 * a=3 b=5 sum=8
		 * a=5 b=8 sum=13
		 * 
		 */
		int x = 1;
		int y = 1;
		int px = 1;
		int sum = 0;
		System.out.print(x+"/");
		System.out.print(y+"/");
		for(int i=1; i<=8; i++) {
			sum=x+y; //2 3 5   
			x=sum; //2 3 5
			y=px; //1 2 3
			px=x; //2 3 5
			System.out.print(sum+"/");
		}

		
	}

}
