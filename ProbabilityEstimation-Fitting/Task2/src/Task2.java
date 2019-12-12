public class Task2 {
	public static double frequentist_estimate(int n){
		StringBuilder s = new StringBuilder();
		double number_of_a = 0;
		String t = "";
		for(int i = 0; i< n; i++){
			double random_num = Math.random();
			if(random_num > 0.1)
				t = "b";
			else if(random_num <= 0.1){
				t = "a";
				number_of_a++;
			}
			s.append(t);
		}
		double frequentist = number_of_a/ n;
		return frequentist;
	}
	public static void main(String args[]){
		//long startTime = System.currentTimeMillis(); 
		double f = 0.0;
		int u = 0;
		int v = 0;
		int w = 0;
		int x = 0;
		int y = 0;
		for(int i=0; i<10000;i++){
			f= frequentist_estimate(3100);
			if(f < 0.08)
				u++;
			if(f < 0.09)
				v++;
			if(f >= 0.09 && f <= 0.11)
				w++;
			if(f > 0.11)
				x++;
			if(f > 0.12)
				y++;
		}
			
		System.out.println("In "+u+" of the simulations p(c = 'a') < 0.08.");
		System.out.println("In "+v+" of the simulations p(c = 'a') < 0.09.");
		System.out.println("In "+w+" of the simulations p(c = 'a') is in the interval [0.09, 0.11].");
		System.out.println("In "+x+" of the simulations p(c = 'a') > 0.11.");
		System.out.println("In "+y+" of the simulations p(c = 'a') > 0.12.");
		//long endTime = System.currentTimeMillis();
		//long exetime = endTime - startTime;
		//System.out.println(exetime/1000);
	}
}
