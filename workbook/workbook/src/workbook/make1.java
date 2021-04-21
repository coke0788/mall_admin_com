package workbook;
public class make1 {
	/*
	 * 다음 주어진 성적을 기반으로 성적을 구하시오.
	 * int score = 77;
	 * A+ : 95 ~ 100, A : 90 ~ 94, B+: 85 ~ 89, B: 80 ~ 84, C+: 75 ~ 79, C: 70 ~ 74, F : 0 ~ 69
	 */
	public static void main (String[] args) {
		int score = 77;
		if (score >= 95 && score <=100) {
			System.out.println("성적은 A입니다.");
		} else if (score >= 90 && score <=94) {
			System.out.println("성적은 B입니다.");
		}  else if (score >= 75 && score <=79) {
			System.out.println("성적은 C+입니다.");
		}  else if (score >= 70 && score <=74) {
			System.out.println("성적은 C입니다.");
		} else {
			System.out.println("성적은 F입니다.");
		}
	}
}
