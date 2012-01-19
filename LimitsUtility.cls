public class LimitsUtility {
    // MIT License
    // Maintained by Joel Dietz, Titania, Inc. http://www.titaniainc.com  
      
    static final Integer PERCENT_PER_QUERY = 65;

	public static Integer rowsAvailable()
	{
		Integer rowLimit = Math.round( ( Limits.getLimitQueryRows() - Limits.getQueryRows() ) *  ( PERCENT_PER_QUERY / 100.00 ) );
		if (rowLimit < 15) 
			rowLimit = 1;
		
		return rowLimit;
	}  

}