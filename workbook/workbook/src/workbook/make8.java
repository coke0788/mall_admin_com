package workbook;

public class make8 {

	public static void main(String[] args) {
		/*
		 * 다음 배열에서 받아온 숫자와 가장 가까운 숫자를 구하는 메소드를 선언하시오
		 * int[] arr = {45, 17, 22, 1, 98};
		 * 객체변수명.메소드명(7);
		 * 출력결과 : 1
		 */
		closedNum(7);
	}
	public static void closedNum(int num) {
		int[] arr = {45, 17, 22, 1, 98};
		int[] val={0, 0, 0, 0, 0};
		int storage=0;
		int result=0;
		for(int i=0; i<arr.length; i++) {
			val[i]=arr[i]-num;
				if(val[i]<0) {
					val[i]=-val[i];
				}
		}
		storage=val[0];
		result=arr[0];
		for(int j=0; j<arr.length; j++) {
			if(storage>val[j]) {
				storage=val[j];
				result=arr[j];
			} else{
			}
		}
		System.out.println(result);
	}
}