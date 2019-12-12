import java.util.Formatter;
public class Task1 {
	public static void frequentist_estimate(int n){
		StringBuilder s = new StringBuilder();
		double number_of_a = 0;
		String t ="";
		for(int i = 0; i< n; i++){
			double random_num = Math.random();
			if(random_num > 0.1)
				t = "b";
			else if(random_num <= 0.1){
				t= "a";
				number_of_a++;
			}
			s.append(t);
		}
		Formatter res = new Formatter();
		double frequentist = number_of_a/ s.length();
		res.format("%.4f",frequentist);
		System.out.println("p(c = 'a')= "+ res);
	}
	public static void main(String args[]){
		frequentist_estimate(3100);
		
	}
}
