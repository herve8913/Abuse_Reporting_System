package bean;
import java.util.Calendar;
import java.util.Date;


public class CalculateAge {
	
	public static int getAge(Date birthDay) throws Exception {  
		  
	    Calendar cal = Calendar.getInstance();  
	  
	    if (cal.before(birthDay)) {  
	        return 0;  
	    }  
	  
	    int yearNow = cal.get(Calendar.YEAR);  
	    int monthNow = cal.get(Calendar.MONTH);  
	    int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);  
	    cal.setTime(birthDay);  
	  
	    int yearBirth = cal.get(Calendar.YEAR);  
	    int monthBirth = cal.get(Calendar.MONTH);  
	    int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);  
	  
	    int age = yearNow - yearBirth;  
	  
	    if (monthNow <= monthBirth) {  
	        if (monthNow == monthBirth) {  
	            if (dayOfMonthNow < dayOfMonthBirth) {  
	                age--;  
	            }  
	        } else {  
	            age--;  
	        }  
	    }  
	    return age;  
	}  
	
	public static int getAge(java.sql.Date birthdate) throws Exception{
		
		Date birthday = new Date(birthdate.getTime());
		
		return getAge(birthday);
	}
	
}
