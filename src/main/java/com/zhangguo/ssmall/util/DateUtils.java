package com.zhangguo.ssmall.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
	
	
	
	 public static String formateString(Date date,String pattern) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        String str = sdf.format(date);
        return str;
    }

}
