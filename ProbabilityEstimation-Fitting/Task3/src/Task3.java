public class Task3 {
	public static void main(String args[]){
		String str = args[0];
		double prior[] = {0.9,0.04,0.03,0.02,0.01};
		double m[] = {0.1,0.3,0.5,0.7,0.9};
		double sum;
		if(str.length()!= 0 && str != null){
			char inputArray[] = str.toCharArray();
			for(char c : inputArray){
				sum = 0.0;
				if(c == 'a'){
					for(int i= 0; i< prior.length; i++){
						double temp = m[i] * prior[i];
						sum += temp;
					}
					for(int j= 0; j< prior.length; j++){
						prior[j]= (m[j] * prior[j])/sum;
					}
						
				}
				if(c == 'b'){
					sum = 0.0;
					for(int i= 0; i< prior.length; i++){
						double temp = (1-m[i]) * prior[i];
						sum += temp;
					}
					for(int j= 0; j< prior.length; j++){
						prior[j]= ((1-m[j]) * prior[j])/sum;
					}
				}
			}
		}
		sum = 0.0;
		for(int i= 0; i< m.length; i++){
			double temp = (m[i]) * prior[i];
			sum += temp;
			System.out.println(String.format("p(m= %.4f | data = %.4f",m[i], prior[i]));
		}
		System.out.println(String.format("p(c= 'a' | data = %.4f",sum));
	}
}
