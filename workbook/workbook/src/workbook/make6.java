package workbook;

public class make6 {
	public static void main(String[] args) {
		/*
		 * 다음 배열을 오름차순으로 정렬하고 출력하시오
		 * int[] arr = {5, 7, 3};
		 * for(int i : arr) {
		 * System.out.print(i + “ “);
		 * }
		 * 출력결과 : 3 5 7 
		 */
		int[] arr = {5, 7, 3};
		int swap=0;
			if(arr[0]>arr[2]) { //0번째가 2번째보다 크면 0번째를 제일 뒤로
				swap=arr[2];
				arr[2]=arr[0];
				arr[0]=swap;
			}
			if(arr[1]>arr[2]) { //1번째가 2번째보다 크면 1번째를 제일 뒤로
				swap=arr[2];
				arr[2]=arr[1];
				arr[2]=swap;
			}  
		System.out.printf("%s,%s,%s", arr[0], arr[1], arr[2]);
	}
}
