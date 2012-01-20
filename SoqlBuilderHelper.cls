public class SoqlBuilderHelper
{


public static Operator convertStringToFieldOperator(String s) {
    
    if(s == 'EQUALS') return Operator.EQUALS;
    if(s == 'NOT_EQUALS') return Operator.NOT_EQUALS;
    if(s == 'LESS_THAN') return Operator.LESS_THAN;
    if(s == 'LESS_THAN_OR_EQUAL_TO') return Operator.LESS_THAN_OR_EQUAL_TO;
    if(s == 'GREATER_THAN') return Operator.GREATER_THAN;
    if(s == 'GREATER_THAN_OR_EQUAL_TO') return Operator.GREATER_THAN_OR_EQUAL_TO;
    
    /* Not using at the moment
    if(s == 'LIKEX') return Operator.LIKEX;
    if(s == 'INCLUDES') return Operator.INCLUDES;
    if(s == 'EXCLUDES') return Operator.EXCLUDES;
    if(s == 'INX') return Operator.INX;
    if(s == 'NOT_IN') return Operator.NOT_IN;
    */
    return null;
    
}

public static UnitOfTime convertStringToUnitOfTime(String s) {
    
    if(s == 'Today') return UnitOfTime.Day;
    if(s == 'This Week') return UnitOfTime.Week;
    if(s == 'This Month') return UnitOfTime.Month;
    if(s == 'This (Calendar) Quarter') return UnitOfTime.Quarter;
    if(s == 'This (Calendar) Year') return UnitOfTime.Year;

    return null;
    
}


public static DateFormula convertStringToDateFormula(String s) {
    
    if(s == 'Today') return new DateFormula().thisx(UnitOfTime.Day);
    if(s == 'This Week') return new DateFormula().thisx(UnitOfTime.Week);
    if(s == 'This Month') return new DateFormula().thisx(UnitOfTime.Month); 
    if(s == 'This (Calendar) Quarter') return new DateFormula().thisx(UnitOfTime.Quarter);
    if(s == 'This (Calendar) Year') return new DateFormula().thisx(UnitOfTime.Year);
    if(s == 'This (Fiscal) Quarter') return new DateFormula().thisx(UnitOfTime.FiscalQuarter);
    if(s == 'This (Fiscal) Year') return new DateFormula().thisx(UnitOfTime.FiscalYear);

    if(s == 'Yesterday') return new DateFormula().last(UnitOfTime.Day);
    if(s == 'Last Week') return new DateFormula().last(UnitOfTime.Week);
    if(s == 'Last Month') return new DateFormula().last(UnitOfTime.Month);
    if(s == 'Last (Calendar) Quarter') return new DateFormula().last(UnitOfTime.Quarter);
    if(s == 'Last (Calendar) Year') return new DateFormula().last(UnitOfTime.Year);
    if(s == 'Last (Fiscal) Quarter') return new DateFormula().last(UnitOfTime.FiscalQuarter);
    if(s == 'Last (Fiscal) Year') return new DateFormula().last(UnitOfTime.FiscalYear);

    if(s == 'TODAY') return new DateFormula().thisx(UnitOfTime.Day);
    if(s == 'THIS_WEEK') return new DateFormula().thisx(UnitOfTime.Week);
    if(s == 'THIS_MONTH') return new DateFormula().thisx(UnitOfTime.Month); 
    if(s == 'THIS_QUARTER') return new DateFormula().thisx(UnitOfTime.Quarter);
    if(s == 'THIS_YEAR') return new DateFormula().thisx(UnitOfTime.Year);
    if(s == 'THIS_FISCAL_QUARTER') return new DateFormula().thisx(UnitOfTime.FiscalQuarter);
    if(s == 'THIS_FISCAL_YEAR') return new DateFormula().thisx(UnitOfTime.FiscalYear);
    if(s == 'YESTERDAY') return new DateFormula().last(UnitOfTime.Day);
    if(s == 'LAST_WEEK') return new DateFormula().last(UnitOfTime.Week);
    if(s == 'LAST_MONTH') return new DateFormula().last(UnitOfTime.Month);
    if(s == 'LAST_90_DAYS') return new DateFormula().last90Days();
    if(s == 'LAST_QUARTER') return new DateFormula().last(UnitOfTime.Quarter);
    if(s == 'LAST_YEAR') return new DateFormula().last(UnitOfTime.Year);
    if(s == 'LAST_FISCAL_QUARTER') return new DateFormula().last(UnitOfTime.FiscalQuarter);
    if(s == 'LAST_FISCAL_YEAR') return new DateFormula().last(UnitOfTime.FiscalYear);
    if(s == 'TOMORROW') return new DateFormula().next(UnitOfTime.Day);
    if(s == 'NEXT_WEEK') return new DateFormula().next(UnitOfTime.Week);
    if(s == 'NEXT_MONTH') return new DateFormula().next(UnitOfTime.Month);
    if(s == 'NEXT_90_DAYS') return new DateFormula().next90Days();
    if(s == 'NEXT_QUARTER') return new DateFormula().next(UnitOfTime.Quarter);
    if(s == 'NEXT_YEAR') return new DateFormula().next(UnitOfTime.Year);
    if(s == 'NEXT_FISCAL_QUARTER') return new DateFormula().next(UnitOfTime.FiscalQuarter);
    if(s == 'NEXT_FISCAL_YEAR') return new DateFormula().next(UnitOfTime.FiscalYear);
    
    return null;
    
}

}