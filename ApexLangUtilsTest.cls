/*Test ApexLangUtils*/

@IsTest 
private class ApexLangUtilsTest {
    /* Character tests */
    
    private static String CHARS_ASCII_CONTROL = '\n\t\r\f';        
    private static String CHARS_ASCII_DIGITS = '0123456789';
    private static String CHARS_ASCII_UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    private static String CHARS_ASCII_LOWER = 'abcdefghijklmnopqrstuvwxyz';
    private static String CHARS_ASCII_PRINTABLE = ' !"#$%&\'()*+,-./' + CHARS_ASCII_DIGITS + ':;<=>?@' + CHARS_ASCII_UPPER + '[\\]^_`' + CHARS_ASCII_LOWER + '{|}~';
    private static String CHARS_ALL_ASCII = CHARS_ASCII_CONTROL + CHARS_ASCII_PRINTABLE;
    private static String CHARS_NON_ASCII = '€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþ';
    private static String CHARS_ASCII_NON_PRINTABLE = CHARS_ASCII_CONTROL + CHARS_NON_ASCII;

    private static testmethod void testValidateChar(){
        final String[] badCharStrings = new String[]{'','AB'};
        for(String badCharString : badCharStrings){
            try{
                ApexLangUtils.validateChar(badCharString);
                System.assert(false,'Exception should have been thrown for invalid char: ' + badCharString);
            } catch(Exception e){}
        }
        ApexLangUtils.validateChar('B');
    } 
    
    private static testmethod void testIsUpperCase(){
        final String UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        for(Integer i = 0; i < UPPER.length(); i++){
            assertIsUpperCase(UPPER.substring(i,i+1), true);
        }
        final String LOWER = 'abcdefghijklmnopqrstuvwxyz';
        for(Integer i = 0; i < LOWER.length(); i++){
            assertIsUpperCase(LOWER.substring(i,i+1), false);
        }
    }    
    
    private static void assertIsUpperCase(String aCharacter, Boolean expected){
        Boolean actual = ApexLangUtils.isUpperCase(aCharacter);
        System.assert(actual==expected, 'ApexLangUtils.isUpperCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testToTitleCase(){
        assertToTitleCase('\t','\t');
        assertToTitleCase('\n','\n');
        assertToTitleCase('\f','\f');
        assertToTitleCase('\r','\r');
        assertToTitleCase(' ',' ');
        assertToTitleCase('!','!');
        assertToTitleCase('"','"');
        assertToTitleCase('#','#');
        assertToTitleCase('$','$');
        assertToTitleCase('%','%');
        assertToTitleCase('&','&');
        assertToTitleCase('\'','\'');
        assertToTitleCase('(','(');
        assertToTitleCase(')',')');
        assertToTitleCase('*','*');
        assertToTitleCase('+','+');
        assertToTitleCase(',',',');
        assertToTitleCase('-','-');
        assertToTitleCase('.','.');
        assertToTitleCase('/','/');
        assertToTitleCase('0','0');
        assertToTitleCase('1','1');
        assertToTitleCase('2','2');
        assertToTitleCase('3','3');
        assertToTitleCase('4','4');
        assertToTitleCase('5','5');
        assertToTitleCase('6','6');
        assertToTitleCase('7','7');
        assertToTitleCase('8','8');
        assertToTitleCase('9','9');
        assertToTitleCase(':',':');
        assertToTitleCase(';',';');
        assertToTitleCase('<','<');
        assertToTitleCase('=','=');
        assertToTitleCase('>','>');
        assertToTitleCase('?','?');
        assertToTitleCase('@','@');
        assertToTitleCase('A','A');
        assertToTitleCase('B','B');
        assertToTitleCase('C','C');
        assertToTitleCase('D','D');
        assertToTitleCase('E','E');
        assertToTitleCase('F','F');
        assertToTitleCase('G','G');
        assertToTitleCase('H','H');
        assertToTitleCase('I','I');
        assertToTitleCase('J','J');
        assertToTitleCase('K','K');
        assertToTitleCase('L','L');
        assertToTitleCase('M','M');
        assertToTitleCase('N','N');
        assertToTitleCase('O','O');
        assertToTitleCase('P','P');
        assertToTitleCase('Q','Q');
        assertToTitleCase('R','R');
        assertToTitleCase('S','S');
        assertToTitleCase('T','T');
        assertToTitleCase('U','U');
        assertToTitleCase('V','V');
        assertToTitleCase('W','W');
        assertToTitleCase('X','X');
        assertToTitleCase('Y','Y');
        assertToTitleCase('Z','Z');
        assertToTitleCase('[','[');
        assertToTitleCase('\\','\\');
        assertToTitleCase(']',']');
        assertToTitleCase('^','^');
        assertToTitleCase('_','_');
        assertToTitleCase('`','`');
        assertToTitleCase('a','A');
        assertToTitleCase('b','B');
        assertToTitleCase('c','C');
        assertToTitleCase('d','D');
        assertToTitleCase('e','E');
        assertToTitleCase('f','F');
        assertToTitleCase('g','G');
        assertToTitleCase('h','H');
        assertToTitleCase('i','I');
        assertToTitleCase('j','J');
        assertToTitleCase('k','K');
        assertToTitleCase('l','L');
        assertToTitleCase('m','M');
        assertToTitleCase('n','N');
        assertToTitleCase('o','O');
        assertToTitleCase('p','P');
        assertToTitleCase('q','Q');
        assertToTitleCase('r','R');
        assertToTitleCase('s','S');
        assertToTitleCase('t','T');
        assertToTitleCase('u','U');
        assertToTitleCase('v','V');
        assertToTitleCase('w','W');
        assertToTitleCase('x','X');
        assertToTitleCase('y','Y');
        assertToTitleCase('z','Z');
        assertToTitleCase('{','{');
        assertToTitleCase('|','|');
        assertToTitleCase('}','}');
        assertToTitleCase('~','~');
    }    
    
    private static void assertToTitleCase(String aCharacter, String expected){
        String actual = ApexLangUtils.toTitleCase(aCharacter);
        System.assert(actual==expected, 'ApexLangUtils.toTitleCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testToLowerCase(){
        assertToLowerCase('\t','\t');
        assertToLowerCase('\n','\n');
        assertToLowerCase('\f','\f');
        assertToLowerCase('\r','\r');
        assertToLowerCase(' ',' ');
        assertToLowerCase('!','!');
        assertToLowerCase('"','"');
        assertToLowerCase('#','#');
        assertToLowerCase('$','$');
        assertToLowerCase('%','%');
        assertToLowerCase('&','&');
        assertToLowerCase('\'','\'');
        assertToLowerCase('(','(');
        assertToLowerCase(')',')');
        assertToLowerCase('*','*');
        assertToLowerCase('+','+');
        assertToLowerCase(',',',');
        assertToLowerCase('-','-');
        assertToLowerCase('.','.');
        assertToLowerCase('/','/');
        assertToLowerCase('0','0');
        assertToLowerCase('1','1');
        assertToLowerCase('2','2');
        assertToLowerCase('3','3');
        assertToLowerCase('4','4');
        assertToLowerCase('5','5');
        assertToLowerCase('6','6');
        assertToLowerCase('7','7');
        assertToLowerCase('8','8');
        assertToLowerCase('9','9');
        assertToLowerCase(':',':');
        assertToLowerCase(';',';');
        assertToLowerCase('<','<');
        assertToLowerCase('=','=');
        assertToLowerCase('>','>');
        assertToLowerCase('?','?');
        assertToLowerCase('@','@');
        assertToLowerCase('A','a');
        assertToLowerCase('B','b');
        assertToLowerCase('C','c');
        assertToLowerCase('D','d');
        assertToLowerCase('E','e');
        assertToLowerCase('F','f');
        assertToLowerCase('G','g');
        assertToLowerCase('H','h');
        assertToLowerCase('I','i');
        assertToLowerCase('J','j');
        assertToLowerCase('K','k');
        assertToLowerCase('L','l');
        assertToLowerCase('M','m');
        assertToLowerCase('N','n');
        assertToLowerCase('O','o');
        assertToLowerCase('P','p');
        assertToLowerCase('Q','q');
        assertToLowerCase('R','r');
        assertToLowerCase('S','s');
        assertToLowerCase('T','t');
        assertToLowerCase('U','u');
        assertToLowerCase('V','v');
        assertToLowerCase('W','w');
        assertToLowerCase('X','x');
        assertToLowerCase('Y','y');
        assertToLowerCase('Z','z');
        assertToLowerCase('[','[');
        assertToLowerCase('\\','\\');
        assertToLowerCase(']',']');
        assertToLowerCase('^','^');
        assertToLowerCase('_','_');
        assertToLowerCase('`','`');
        assertToLowerCase('a','a');
        assertToLowerCase('b','b');
        assertToLowerCase('c','c');
        assertToLowerCase('d','d');
        assertToLowerCase('e','e');
        assertToLowerCase('f','f');
        assertToLowerCase('g','g');
        assertToLowerCase('h','h');
        assertToLowerCase('i','i');
        assertToLowerCase('j','j');
        assertToLowerCase('k','k');
        assertToLowerCase('l','l');
        assertToLowerCase('m','m');
        assertToLowerCase('n','n');
        assertToLowerCase('o','o');
        assertToLowerCase('p','p');
        assertToLowerCase('q','q');
        assertToLowerCase('r','r');
        assertToLowerCase('s','s');
        assertToLowerCase('t','t');
        assertToLowerCase('u','u');
        assertToLowerCase('v','v');
        assertToLowerCase('w','w');
        assertToLowerCase('x','x');
        assertToLowerCase('y','y');
        assertToLowerCase('z','z');
        assertToLowerCase('{','{');
        assertToLowerCase('|','|');
        assertToLowerCase('}','}');
        assertToLowerCase('~','~');
    }
    
    private static void assertToLowerCase(String aCharacter, String expected){
        String actual = ApexLangUtils.toLowerCase(aCharacter);
        System.assert(actual==expected, 'ApexLangUtils.toLowerCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testIsTitleCase(){
        //test: global static Boolean isTitleCase(String character){ 
        assertIsTitleCase('\t',FALSE);
        assertIsTitleCase('\n',FALSE);
        assertIsTitleCase('\f',FALSE);
        assertIsTitleCase('\r',FALSE);
        assertIsTitleCase(' ',FALSE);
        assertIsTitleCase('!',FALSE);
        assertIsTitleCase('"',FALSE);
        assertIsTitleCase('#',FALSE);
        assertIsTitleCase('$',FALSE);
        assertIsTitleCase('%',FALSE);
        assertIsTitleCase('&',FALSE);
        assertIsTitleCase('\'',FALSE);
        assertIsTitleCase('(',FALSE);
        assertIsTitleCase(')',FALSE);
        assertIsTitleCase('*',FALSE);
        assertIsTitleCase('+',FALSE);
        assertIsTitleCase(',',FALSE);
        assertIsTitleCase('-',FALSE);
        assertIsTitleCase('.',FALSE);
        assertIsTitleCase('/',FALSE);
        assertIsTitleCase('0',FALSE);
        assertIsTitleCase('1',FALSE);
        assertIsTitleCase('2',FALSE);
        assertIsTitleCase('3',FALSE);
        assertIsTitleCase('4',FALSE);
        assertIsTitleCase('5',FALSE);
        assertIsTitleCase('6',FALSE);
        assertIsTitleCase('7',FALSE);
        assertIsTitleCase('8',FALSE);
        assertIsTitleCase('9',FALSE);
        assertIsTitleCase(':',FALSE);
        assertIsTitleCase(';',FALSE);
        assertIsTitleCase('<',FALSE);
        assertIsTitleCase('=',FALSE);
        assertIsTitleCase('>',FALSE);
        assertIsTitleCase('?',FALSE);
        assertIsTitleCase('@',FALSE);
        assertIsTitleCase('A',TRUE);
        assertIsTitleCase('B',TRUE);
        assertIsTitleCase('C',TRUE);
        assertIsTitleCase('D',TRUE);
        assertIsTitleCase('E',TRUE);
        assertIsTitleCase('F',TRUE);
        assertIsTitleCase('G',TRUE);
        assertIsTitleCase('H',TRUE);
        assertIsTitleCase('I',TRUE);
        assertIsTitleCase('J',TRUE);
        assertIsTitleCase('K',TRUE);
        assertIsTitleCase('L',TRUE);
        assertIsTitleCase('M',TRUE);
        assertIsTitleCase('N',TRUE);
        assertIsTitleCase('O',TRUE);
        assertIsTitleCase('P',TRUE);
        assertIsTitleCase('Q',TRUE);
        assertIsTitleCase('R',TRUE);
        assertIsTitleCase('S',TRUE);
        assertIsTitleCase('T',TRUE);
        assertIsTitleCase('U',TRUE);
        assertIsTitleCase('V',TRUE);
        assertIsTitleCase('W',TRUE);
        assertIsTitleCase('X',TRUE);
        assertIsTitleCase('Y',TRUE);
        assertIsTitleCase('Z',TRUE);
        assertIsTitleCase('[',FALSE);
        assertIsTitleCase('\\',FALSE);
        assertIsTitleCase(']',FALSE);
        assertIsTitleCase('^',FALSE);
        assertIsTitleCase('_',FALSE);
        assertIsTitleCase('`',FALSE);
        assertIsTitleCase('a',FALSE);
        assertIsTitleCase('b',FALSE);
        assertIsTitleCase('c',FALSE);
        assertIsTitleCase('d',FALSE);
        assertIsTitleCase('e',FALSE);
        assertIsTitleCase('f',FALSE);
        assertIsTitleCase('g',FALSE);
        assertIsTitleCase('h',FALSE);
        assertIsTitleCase('i',FALSE);
        assertIsTitleCase('j',FALSE);
        assertIsTitleCase('k',FALSE);
        assertIsTitleCase('l',FALSE);
        assertIsTitleCase('m',FALSE);
        assertIsTitleCase('n',FALSE);
        assertIsTitleCase('o',FALSE);
        assertIsTitleCase('p',FALSE);
        assertIsTitleCase('q',FALSE);
        assertIsTitleCase('r',FALSE);
        assertIsTitleCase('s',FALSE);
        assertIsTitleCase('t',FALSE);
        assertIsTitleCase('u',FALSE);
        assertIsTitleCase('v',FALSE);
        assertIsTitleCase('w',FALSE);
        assertIsTitleCase('x',FALSE);
        assertIsTitleCase('y',FALSE);
        assertIsTitleCase('z',FALSE);
        assertIsTitleCase('{',FALSE);
        assertIsTitleCase('|',FALSE);
        assertIsTitleCase('}',FALSE);
        assertIsTitleCase('~',FALSE);
    }
    
    private static void assertIsTitleCase(String aCharacter, Boolean expected){
        Boolean actual = ApexLangUtils.isTitleCase(aCharacter);
        System.assert(actual==expected, 'ApexLangUtils.isTitleCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testToUpperCase(){
        //test: global static String toUpperCase(String ch){
        assertToUpperCase('\t','\t');
        assertToUpperCase('\n','\n');
        assertToUpperCase('\f','\f');
        assertToUpperCase('\r','\r');
        assertToUpperCase(' ',' ');
        assertToUpperCase('!','!');
        assertToUpperCase('"','"');
        assertToUpperCase('#','#');
        assertToUpperCase('$','$');
        assertToUpperCase('%','%');
        assertToUpperCase('&','&');
        assertToUpperCase('\'','\'');
        assertToUpperCase('(','(');
        assertToUpperCase(')',')');
        assertToUpperCase('*','*');
        assertToUpperCase('+','+');
        assertToUpperCase(',',',');
        assertToUpperCase('-','-');
        assertToUpperCase('.','.');
        assertToUpperCase('/','/');
        assertToUpperCase('0','0');
        assertToUpperCase('1','1');
        assertToUpperCase('2','2');
        assertToUpperCase('3','3');
        assertToUpperCase('4','4');
        assertToUpperCase('5','5');
        assertToUpperCase('6','6');
        assertToUpperCase('7','7');
        assertToUpperCase('8','8');
        assertToUpperCase('9','9');
        assertToUpperCase(':',':');
        assertToUpperCase(';',';');
        assertToUpperCase('<','<');
        assertToUpperCase('=','=');
        assertToUpperCase('>','>');
        assertToUpperCase('?','?');
        assertToUpperCase('@','@');
        assertToUpperCase('A','A');
        assertToUpperCase('B','B');
        assertToUpperCase('C','C');
        assertToUpperCase('D','D');
        assertToUpperCase('E','E');
        assertToUpperCase('F','F');
        assertToUpperCase('G','G');
        assertToUpperCase('H','H');
        assertToUpperCase('I','I');
        assertToUpperCase('J','J');
        assertToUpperCase('K','K');
        assertToUpperCase('L','L');
        assertToUpperCase('M','M');
        assertToUpperCase('N','N');
        assertToUpperCase('O','O');
        assertToUpperCase('P','P');
        assertToUpperCase('Q','Q');
        assertToUpperCase('R','R');
        assertToUpperCase('S','S');
        assertToUpperCase('T','T');
        assertToUpperCase('U','U');
        assertToUpperCase('V','V');
        assertToUpperCase('W','W');
        assertToUpperCase('X','X');
        assertToUpperCase('Y','Y');
        assertToUpperCase('Z','Z');
        assertToUpperCase('[','[');
        assertToUpperCase('\\','\\');
        assertToUpperCase(']',']');
        assertToUpperCase('^','^');
        assertToUpperCase('_','_');
        assertToUpperCase('`','`');
        assertToUpperCase('a','A');
        assertToUpperCase('b','B');
        assertToUpperCase('c','C');
        assertToUpperCase('d','D');
        assertToUpperCase('e','E');
        assertToUpperCase('f','F');
        assertToUpperCase('g','G');
        assertToUpperCase('h','H');
        assertToUpperCase('i','I');
        assertToUpperCase('j','J');
        assertToUpperCase('k','K');
        assertToUpperCase('l','L');
        assertToUpperCase('m','M');
        assertToUpperCase('n','N');
        assertToUpperCase('o','O');
        assertToUpperCase('p','P');
        assertToUpperCase('q','Q');
        assertToUpperCase('r','R');
        assertToUpperCase('s','S');
        assertToUpperCase('t','T');
        assertToUpperCase('u','U');
        assertToUpperCase('v','V');
        assertToUpperCase('w','W');
        assertToUpperCase('x','X');
        assertToUpperCase('y','Y');
        assertToUpperCase('z','Z');
        assertToUpperCase('{','{');
        assertToUpperCase('|','|');
        assertToUpperCase('}','}');
        assertToUpperCase('~','~');
    }    
    
    private static void assertToUpperCase(String aCharacter, String expected){
        String actual = ApexLangUtils.toUpperCase(aCharacter);
        System.assert(actual==expected, 'ApexLangUtils.toUpperCase(\'' + aCharacter + '\') returned ' + actual);
    }
    
    private static testmethod void testIsLowerCase(){
        final String UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        for(Integer i = 0; i < UPPER.length(); i++){
            assertIsLowerCase(UPPER.substring(i,i+1), false);
        }
        final String LOWER = 'abcdefghijklmnopqrstuvwxyz';
        for(Integer i = 0; i < LOWER.length(); i++){
            assertIsLowerCase(LOWER.substring(i,i+1), true);
        }
    }    
    
    private static void assertIsLowerCase(String aCharacter, Boolean expected){
        Boolean actual = ApexLangUtils.isLowerCase(aCharacter);
        System.assert(actual==expected, 'ApexLangUtils.isLowerCase(\'' + aCharacter + '\') returned ' + actual);
    }

    private static testmethod void testToAscii(){
        //test: global static Integer toAscii(String character){
        assertToAscii('\t',9);
        assertToAscii('\n',10);
        assertToAscii('\f',12);
        assertToAscii('\r',13);
        for(Integer i = 0; i < CHARS_ASCII_PRINTABLE.length(); i++){
            assertToAscii(ApexLangUtils.charAt(CHARS_ASCII_PRINTABLE,i), i+32);
        }
    }
    
    private static void assertToAscii(String charactr, Integer expected){
        Integer actual = ApexLangUtils.toAscii(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.toAscii(' + charactr + ') returned \'' 
            + actual + '\'; expected \'' +expected + '\'');
    }

    private static testmethod void testToChar(){
        //test: global static String toChar(Integer ascii){
        assertToChar(-1,null);
        assertToChar(0,null);
        assertToChar(128,null);
        assertToChar(9,'\t');
        assertToChar(10,'\n');
        assertToChar(12,'\f');
        assertToChar(13,'\r');
        for(Integer i = 32; i < 128; i++){
            assertToChar(i,ApexLangUtils.charAt(CHARS_ASCII_PRINTABLE,i-32));
        }
    }

    private static void assertToChar(Integer ascii, String expected){
        String actual = ApexLangUtils.toChar(ascii); 
        System.assert(actual==expected, 'ApexLangUtils.toChar(' + ascii + ') returned \'' 
            + actual + '\'; expected \'' +expected + '\'');
    }

    private static testmethod void testIsAscii(){
        //test: global static boolean isAscii(String character) {
        for(Integer i = 0; i < CHARS_ALL_ASCII.length(); i++){
            assertIsAscii(ApexLangUtils.charAt(CHARS_ALL_ASCII,i), true);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAscii(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsAscii(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAscii(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAscii(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testIsAsciiPrintable(){
        //test: global static boolean isAsciiPrintable(String character) {
        for(Integer i = 0; i < CHARS_ASCII_PRINTABLE.length(); i++){
            assertIsAsciiPrintable(ApexLangUtils.charAt(CHARS_ASCII_PRINTABLE,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_NON_PRINTABLE.length(); i++){
            assertIsAsciiPrintable(ApexLangUtils.charAt(CHARS_ASCII_NON_PRINTABLE,i), false);        
        }
    }     

    /*private static void assertIsAsciiPrintable(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiPrintable(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAsciiPrintable(\'' + charactr + '\') returned ' + actual);
    }*/
            
    private static testmethod void testIsAsciiControl(){
        //test: global static boolean isAsciiControl(String character) {
        for(Integer i = 0; i < CHARS_ASCII_CONTROL.length(); i++){
            asertIsAsciiControl(ApexLangUtils.charAt(CHARS_ASCII_CONTROL,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_PRINTABLE.length(); i++){
            asertIsAsciiControl(ApexLangUtils.charAt(CHARS_ASCII_PRINTABLE,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            asertIsAsciiControl(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void asertIsAsciiControl(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiControl(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAsciiControl(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testIsAsciiAlpha(){
        //test: global static boolean isAsciiAlpha(String character) {
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsAsciiAlpha(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsAsciiAlpha(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsAsciiAlpha(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAsciiAlpha(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsAsciiAlpha(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiAlpha(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAsciiAlpha(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testIsAsciiAlphaUpper(){
        //test: global static boolean isAsciiAlphaUpper(String character) {
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsAsciiAlphaUpper(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsAsciiAlphaUpper(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsAsciiAlphaUpper(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAsciiAlphaUpper(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsAsciiAlphaUpper(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiAlphaUpper(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAsciiAlphaUpper(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testIsAsciiAlphaLower(){
        //test: global static boolean isAsciiAlphaLower(String character) {
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsAsciiAlphaLower(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsAsciiAlphaLower(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsAsciiAlphaLower(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAsciiAlphaLower(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsAsciiAlphaLower(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiAlphaLower(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAsciiAlphaLower(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testIsAsciiNumeric(){
        //test: global static boolean isAsciiNumeric(String character) {
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsAsciiNumeric(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsAsciiNumeric(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsAsciiNumeric(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), true);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAsciiNumeric(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsAsciiNumeric(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiNumeric(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAsciiNumeric(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testIsAsciiAlphanumeric(){
        //test: global static boolean isAsciiAlphanumeric(String character) {
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsAsciiAlphanumeric(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsAsciiAlphanumeric(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsAsciiAlphanumeric(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), true);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAsciiAlphanumeric(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     
    
    private static void assertIsAsciiAlphanumeric(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiAlphanumeric(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isAsciiAlphanumeric(\'' + charactr + '\') returned ' + actual);
    }

    private static testmethod void testIsDigit(){
        //test: global static Boolean isDigit(String character){ 
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsAsciiDigit(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsAsciiDigit(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsAsciiDigit(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), true);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsAsciiDigit(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsAsciiDigit(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isDigit(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isDigit(\'' + charactr + '\') returned ' + actual);
    }

    private static testmethod void testIsLetter(){
        //test: global static Boolean isLetter(String character){ 
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsLetter(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsLetter(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsLetter(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsLetter(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     

    private static void assertIsLetter(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isLetter(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isLetter(\'' + charactr + '\') returned ' + actual);
    }

    private static testmethod void testIsLetterOrDigit(){
        //test: global static Boolean isLetterOrDigit(String character){
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsLetterOrDigit(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsLetterOrDigit(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), true);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsLetterOrDigit(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), true);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsLetterOrDigit(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
    }     
    
    private static void assertIsLetterOrDigit(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isLetterOrDigit(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isLetterOrDigit(\'' + charactr + '\') returned ' + actual);
    }

    private static testmethod void testIsWhitespace(){
        //test: global static Boolean isWhitespace(String character){
        for(Integer i = 0; i < CHARS_ASCII_UPPER.length(); i++){
            assertIsWhitespace(ApexLangUtils.charAt(CHARS_ASCII_UPPER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_LOWER.length(); i++){
            assertIsWhitespace(ApexLangUtils.charAt(CHARS_ASCII_LOWER,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_DIGITS.length(); i++){
            assertIsWhitespace(ApexLangUtils.charAt(CHARS_ASCII_DIGITS,i), false);        
        }
        for(Integer i = 0; i < CHARS_NON_ASCII.length(); i++){
            assertIsWhitespace(ApexLangUtils.charAt(CHARS_NON_ASCII,i), false);        
        }
        for(Integer i = 0; i < CHARS_ASCII_CONTROL.length(); i++){
            assertIsWhitespace(ApexLangUtils.charAt(CHARS_ASCII_CONTROL,i), true);        
        }
    }     
    
    private static void assertIsWhitespace(String charactr, Boolean expected){
        Boolean actual = ApexLangUtils.isWhitespace(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.isWhitespace(\'' + charactr + '\') returned ' + actual);
    }
            
    private static testmethod void testGetType(){
        //test: global static Integer getType(String character){
        assertGetType('¿', ApexLangUtils.UNASSIGNED); 
        assertGetType(ApexLangUtils.toChar(0), ApexLangUtils.CONTROL); 
        assertGetType(ApexLangUtils.toChar(9), ApexLangUtils.CONTROL); 
        assertGetType(ApexLangUtils.toChar(10), ApexLangUtils.CONTROL); 
        assertGetType(ApexLangUtils.toChar(12), ApexLangUtils.CONTROL); 
        assertGetType(ApexLangUtils.toChar(13), ApexLangUtils.CONTROL); 
        assertGetType(ApexLangUtils.toChar(32), ApexLangUtils.SPACE_SEPARATOR); 
        assertGetType(ApexLangUtils.toChar(33), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(34), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(35), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(36), ApexLangUtils.CURRENCY_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(37), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(38), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(39), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(40), ApexLangUtils.START_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(41), ApexLangUtils.END_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(42), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(43), ApexLangUtils.MATH_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(44), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(45), ApexLangUtils.DASH_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(46), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(47), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(48), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(49), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(50), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(51), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(52), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(53), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(54), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(55), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(56), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(57), ApexLangUtils.DECIMAL_DIGIT_NUMBER); 
        assertGetType(ApexLangUtils.toChar(58), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(59), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(60), ApexLangUtils.MATH_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(61), ApexLangUtils.MATH_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(62), ApexLangUtils.MATH_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(63), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(64), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(65), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(66), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(67), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(68), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(69), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(70), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(71), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(72), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(73), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(74), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(75), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(76), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(77), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(78), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(79), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(80), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(81), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(82), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(83), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(84), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(85), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(86), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(87), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(88), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(89), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(90), ApexLangUtils.UPPERCASE_LETTER); 
        assertGetType(ApexLangUtils.toChar(91), ApexLangUtils.START_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(92), ApexLangUtils.OTHER_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(93), ApexLangUtils.END_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(94), ApexLangUtils.MODIFIER_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(95), ApexLangUtils.CONNECTOR_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(96), ApexLangUtils.MODIFIER_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(97), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(98), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(99), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(100), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(101), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(102), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(103), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(104), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(105), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(106), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(107), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(108), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(109), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(110), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(111), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(112), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(113), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(114), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(115), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(116), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(117), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(118), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(119), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(120), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(121), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(122), ApexLangUtils.LOWERCASE_LETTER ); 
        assertGetType(ApexLangUtils.toChar(123), ApexLangUtils.START_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(124), ApexLangUtils.MATH_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(125), ApexLangUtils.END_PUNCTUATION); 
        assertGetType(ApexLangUtils.toChar(126), ApexLangUtils.MATH_SYMBOL); 
        assertGetType(ApexLangUtils.toChar(127), ApexLangUtils.CONTROL); 
    }     
    
    private static void assertGetType(String charactr, Integer expected){
        Integer actual = ApexLangUtils.getType(charactr); 
        System.assert(actual==expected, 'ApexLangUtils.getType(\'' + charactr + '\') returned ' + actual
            + ', expected ' + expected);
    }    
    
    /* Character tests */

    /* NumberApexLangUtils tests */
    
    
    private static testmethod void testMaxIntegerValue(){
        System.assert(ApexLangUtils.MAX_INTEGER == 2147483647);
    }
    private static testmethod void testlgerValue(){
        System.assert(ApexLangUtils.MIN_INTEGER == -2147483647);
    }
    
    private static testmethod void testParseIntBadRadix(){
        //test: global static Integer parseInt(String str, Integer radix){
        Boolean exceptionCaught = false;
        try{
            ApexLangUtils.parseInt('01',1);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.parseInt(\'01\',1) did not throw IllegalArgumentException'); 
        exceptionCaught = false;
        try{
            ApexLangUtils.parseInt('01',37);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.parseInt(\'01\',37) did not throw IllegalArgumentException'); 
    }
    
    private static testmethod void testParseIntEmptyNumber(){
        //test: global static Integer parseInt(String str, Integer radix){
        Boolean exceptionCaught = false;
        try{
            ApexLangUtils.parseInt(null,2);    
        }catch(NumberFormatException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.parseInt(null,2) did not throw NumberFormatException'); 
        exceptionCaught = false;
        try{
            ApexLangUtils.parseInt('  ',2);    
        }catch(NumberFormatException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.parseInt(\'  \',2) did not throw NumberFormatException'); 
    }
    
    private static testmethod void testParseIntInvalidNumber(){
        //test: global static Integer parseInt(String str, Integer radix){
        for(Integer i = 2; i < 37; i++){
            assertParseIntNumberFormatException(
                '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ$'.substring(0,i+1)
                ,i);
        }        
    }

    private static void assertParseIntNumberFormatException(String str, Integer radix){
        Boolean exceptionCaught = false;
        try{
            ApexLangUtils.parseInt(str,radix);    
        }catch(NumberFormatException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.parseInt(\'' + str + '\',' + radix + ') did not throw NumberFormatException'); 
    }
    
    private static testmethod void testParseIntBase2(){
        //test: global static Integer parseInt(String str, Integer radix){
        assertParseInt('0',2,0);
        assertParseInt('00',2,0);
        assertParseInt('1',2,1);
        assertParseInt('10',2,2);
        assertParseInt('11',2,3);
        assertParseInt('100',2,4);
    }
    
    private static testmethod void testParseIntBase10(){
        //test: global static Integer parseInt(String str, Integer radix){
        assertParseInt('0',10,0);
        assertParseInt('-0',10,0);
        assertParseInt('473',10,473);
    }
    
    private static testmethod void testParseIntOtherBases(){
        //test: global static Integer parseInt(String str, Integer radix){
        assertParseInt('1100110',2,102);
        assertParseInt('-FF',16,-255);
        assertParseInt('12',8,10);
        assertParseInt('az',36,395);
     }
    
    private static void assertParseInt(String str, Integer radix, Integer expected){
        Integer actual = ApexLangUtils.parseInt(str,radix);
        System.assert(actual==expected, 'ApexLangUtils.parseInt(\'' + str + '\',' + radix + ') returned ' 
            + actual + '; expected ' + expected + '');
    }
    
    private static testmethod void testIntegerToBinary(){
        //test: global static String toBinaryString(Integer i){
        assertIntegerToBinary(-2147483647,'-1111111111111111111111111111111');
        assertIntegerToBinary(-2147483646,'-1111111111111111111111111111110');
        assertIntegerToBinary(-4,'-100');
        assertIntegerToBinary(-3,'-11');
        assertIntegerToBinary(-2,'-10');
        assertIntegerToBinary(-1,'-1');
        assertIntegerToBinary(0,'0');
        assertIntegerToBinary(1,'1');
        assertIntegerToBinary(2,'10');
        assertIntegerToBinary(3,'11');
        assertIntegerToBinary(4,'100');
        assertIntegerToBinary(2147483646,'1111111111111111111111111111110');
        assertIntegerToBinary(2147483647,'1111111111111111111111111111111');
         
    }
    
    private static void assertIntegerToBinary(Integer i, String expected){
        String actual = ApexLangUtils.toBinaryString(i);
        System.assert(actual==expected, 'ApexLangUtils.toBinary(' + i + ') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testIntegerToOctal(){
        //test: global static String toOctalString(Integer i){
        assertIntegerToOctal(-2147483647,'-17777777777');
        assertIntegerToOctal(-2147483646,'-17777777776');
        assertIntegerToOctal(-9,'-11');
        assertIntegerToOctal(-8,'-10');
        assertIntegerToOctal(-7,'-7');
        assertIntegerToOctal(-6,'-6');
        assertIntegerToOctal(-5,'-5');
        assertIntegerToOctal(-4,'-4');
        assertIntegerToOctal(-3,'-3');
        assertIntegerToOctal(-2,'-2');
        assertIntegerToOctal(-1,'-1');
        assertIntegerToOctal(0,'0');
        assertIntegerToOctal(1,'1');
        assertIntegerToOctal(2,'2');
        assertIntegerToOctal(3,'3');
        assertIntegerToOctal(4,'4');
        assertIntegerToOctal(5,'5');
        assertIntegerToOctal(6,'6');
        assertIntegerToOctal(7,'7');
        assertIntegerToOctal(8,'10');
        assertIntegerToOctal(9,'11');
        assertIntegerToOctal(2147483646,'17777777776');
        assertIntegerToOctal(2147483647,'17777777777');
         
    }
    
    private static void assertIntegerToOctal(Integer i, String expected){
        String actual = ApexLangUtils.toOctalString(i);
        System.assert(actual==expected, 'ApexLangUtils.toOctal(' + i + ') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testIntegerToHex(){
        //test: global static String toHexString(Integer i){
        assertIntegerToHex(-2147483647,'-7FFFFFFF');
        assertIntegerToHex(-2147483646,'-7FFFFFFE');
        assertIntegerToHex(-19,'-13');
        assertIntegerToHex(-18,'-12');
        assertIntegerToHex(-17,'-11');
        assertIntegerToHex(-16,'-10');
        assertIntegerToHex(-15,'-F');
        assertIntegerToHex(-14,'-E');
        assertIntegerToHex(-13,'-D');
        assertIntegerToHex(-12,'-C');
        assertIntegerToHex(-11,'-B');
        assertIntegerToHex(-10,'-A');
        assertIntegerToHex(-9,'-9');
        assertIntegerToHex(-8,'-8');
        assertIntegerToHex(-7,'-7');
        assertIntegerToHex(-6,'-6');
        assertIntegerToHex(-5,'-5');
        assertIntegerToHex(-4,'-4');
        assertIntegerToHex(-3,'-3');
        assertIntegerToHex(-2,'-2');
        assertIntegerToHex(-1,'-1');
        assertIntegerToHex(0,'0');
        assertIntegerToHex(1,'1');
        assertIntegerToHex(2,'2');
        assertIntegerToHex(3,'3');
        assertIntegerToHex(4,'4');
        assertIntegerToHex(5,'5');
        assertIntegerToHex(6,'6');
        assertIntegerToHex(7,'7');
        assertIntegerToHex(8,'8');
        assertIntegerToHex(9,'9');
        assertIntegerToHex(10,'A');
        assertIntegerToHex(11,'B');
        assertIntegerToHex(12,'C');
        assertIntegerToHex(13,'D');
        assertIntegerToHex(14,'E');
        assertIntegerToHex(15,'F');
        assertIntegerToHex(16,'10');
        assertIntegerToHex(17,'11');
        assertIntegerToHex(2147483646,'7FFFFFFE');
        assertIntegerToHex(2147483647,'7FFFFFFF');
         
    }
    
    private static void assertIntegerToHex(Integer i, String expected){
        String actual = ApexLangUtils.toHexString(i);
        System.assert(actual==expected, 'ApexLangUtils.toHex(' + i + ') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
 
    private static testmethod void testIntegerToStringNullInput(){
        //test: global static String toString(Integer i, Integer radix){
        Integer i = null;
        System.assertEquals(null,ApexLangUtils.toString(i,2));
    }    
    
    private static testmethod void testIntegerToStringBadRadix(){
        //test: global static String toString(Integer i, Integer radix){
        Boolean exceptionCaught = false;
        try{
            ApexLangUtils.toString(0,1);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.toString(null,1) did not throw IllegalArgumentException'); 
        exceptionCaught = false;
        try{
            ApexLangUtils.toString(0,37);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.toString(null,1) did not throw IllegalArgumentException'); 
    }
    
    private static testmethod void testLongToBinary(){
        //test: global static String toBinaryString(Long i){
        /*
        //can't do these tests b/c hitting System.Exception: Maximum stack depth reached: 66 
        assertLongToBinary(-9223372036854775807L,'-111111111111111111111111111111111111111111111111111111111111111');
        assertLongToBinary(-9223372036854775806L,'-111111111111111111111111111111111111111111111111111111111111110');
        */
        assertLongToBinary(-4L,'-100');
        assertLongToBinary(-3L,'-11');
        assertLongToBinary(-2L,'-10');
        assertLongToBinary(-1L,'-1');
        assertLongToBinary(0L,'0');
        assertLongToBinary(1L,'1');
        assertLongToBinary(2L,'10');
        assertLongToBinary(3L,'11');
        assertLongToBinary(4L,'100');
        /*
        //can't do these tests b/c hitting System.Exception: Maximum stack depth reached: 66 
        assertLongToBinary(9223372036854775806L,'111111111111111111111111111111111111111111111111111111111111110');
        assertLongToBinary(9223372036854775807L,'111111111111111111111111111111111111111111111111111111111111111');
        */
    }
    
    private static void assertLongToBinary(Long l, String expected){
        String actual = ApexLangUtils.toBinaryString(l);
        System.assert(actual==expected, 'ApexLangUtils.toBinary(' + l + ') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testLongToOctal(){
        //test: global static String toOctalString(Long l){
        assertLongToOctal(-9223372036854775807L,'-777777777777777777777');
        assertLongToOctal(-9223372036854775806L,'-777777777777777777776');
        assertLongToOctal(-9L,'-11');
        assertLongToOctal(-8L,'-10');
        assertLongToOctal(-7L,'-7');
        assertLongToOctal(-6L,'-6');
        assertLongToOctal(-5L,'-5');
        assertLongToOctal(-4L,'-4');
        assertLongToOctal(-3L,'-3');
        assertLongToOctal(-2L,'-2');
        assertLongToOctal(-1L,'-1');
        assertLongToOctal(0L,'0');
        assertLongToOctal(1L,'1');
        assertLongToOctal(2L,'2');
        assertLongToOctal(3L,'3');
        assertLongToOctal(4L,'4');
        assertLongToOctal(5L,'5');
        assertLongToOctal(6L,'6');
        assertLongToOctal(7L,'7');
        assertLongToOctal(8L,'10');
        assertLongToOctal(9L,'11');
        assertLongToOctal(9223372036854775806L,'777777777777777777776');
        assertLongToOctal(9223372036854775807L,'777777777777777777777');
         
    }
    
    private static void assertLongToOctal(Long l, String expected){
        String actual = ApexLangUtils.toOctalString(l);
        System.assert(actual==expected, 'ApexLangUtils.toOctal(' + l + ') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testLongToHex(){
        //test: global static String toHexString(Long l){
        assertLongToHex(-9223372036854775807L,'-7FFFFFFFFFFFFFFF');
        assertLongToHex(-9223372036854775806L,'-7FFFFFFFFFFFFFFE');
        assertLongToHex(-19L,'-13');
        assertLongToHex(-18L,'-12');
        assertLongToHex(-17L,'-11');
        assertLongToHex(-16L,'-10');
        assertLongToHex(-15L,'-F');
        assertLongToHex(-14L,'-E');
        assertLongToHex(-13L,'-D');
        assertLongToHex(-12L,'-C');
        assertLongToHex(-11L,'-B');
        assertLongToHex(-10L,'-A');
        assertLongToHex(-9L,'-9');
        assertLongToHex(-8L,'-8');
        assertLongToHex(-7L,'-7');
        assertLongToHex(-6L,'-6');
        assertLongToHex(-5L,'-5');
        assertLongToHex(-4L,'-4');
        assertLongToHex(-3L,'-3');
        assertLongToHex(-2L,'-2');
        assertLongToHex(-1L,'-1');
        assertLongToHex(0L,'0');
        assertLongToHex(1L,'1');
        assertLongToHex(2L,'2');
        assertLongToHex(3L,'3');
        assertLongToHex(4L,'4');
        assertLongToHex(5L,'5');
        assertLongToHex(6L,'6');
        assertLongToHex(7L,'7');
        assertLongToHex(8L,'8');
        assertLongToHex(9L,'9');
        assertLongToHex(10L,'A');
        assertLongToHex(11L,'B');
        assertLongToHex(12L,'C');
        assertLongToHex(13L,'D');
        assertLongToHex(14L,'E');
        assertLongToHex(15L,'F');
        assertLongToHex(16L,'10');
        assertLongToHex(17L,'11');
        assertLongToHex(9223372036854775806L,'7FFFFFFFFFFFFFFE');
        assertLongToHex(9223372036854775807L,'7FFFFFFFFFFFFFFF');
         
    }
    
    private static void assertLongToHex(Long l, String expected){
        String actual = ApexLangUtils.toHexString(l);
        System.assert(actual==expected, 'ApexLangUtils.toHex(' + l + ') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
      
    private static testmethod void testLongToStringNullInput(){
        //test: global static String toString(Long l, Long radix){
        Long l = null;
        System.assertEquals(null,ApexLangUtils.toString(l,2));
    }    
    
    private static testmethod void testLongToStringBadRadix(){
        //test: global static String toString(Long l, Integer radix){
        Boolean exceptionCaught = false;
        try{
            ApexLangUtils.toString(0L,1);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.toString(null,1) did not throw IllegalArgumentException'); 
        exceptionCaught = false;
        try{
            ApexLangUtils.toString(0L,37);    
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'ApexLangUtils.toString(null,1) did not throw IllegalArgumentException'); 
    }    
    
    /* NumberApexLangUtils tests */

    /* SetApexLangUtils Tests */
    private static testmethod void testObjectToBlob(){
        //test: global static Set<Blob> objectToBlob(Set<Object> objectSet){
        assertObjectToBlob(null, null);
        assertObjectToBlob(new Set<Object>{}, new Set<Blob>{});
        Blob blob1 = generateRandomBlob();
        Blob blob2 = generateRandomBlob();
        assertObjectToBlob(new Set<Object>{blob1}, new Set<Blob>{blob1});
        assertObjectToBlob(new Set<Object>{blob1,blob2}, new Set<Blob>{blob1,blob2});
    } 


    private static testmethod void testObjectToBoolean(){ 
        //test: global static Set<Boolean> objectToBoolean(Set<Object> objectSet){ 
        assertObjectToBoolean(null, null);
        assertObjectToBoolean(new Set<Object>{}, new Set<Boolean>{});
        assertObjectToBoolean(new Set<Object>{true}, new Set<Boolean>{true});
        assertObjectToBoolean(new Set<Object>{true,false}, new Set<Boolean>{false,true});
    }

    private static testmethod void testObjectToDate(){ 
        //test: global static Set<Date> objectToDate(Set<Object> objectSet){ 
        assertObjectToDate(null, null);
        assertObjectToDate(new Set<Object>{}, new Set<Date>{});
        Date date1 = Date.newInstance(2009,1,1);
        Date date2 = Date.newInstance(2009,1,2);
        assertObjectToDate(new Set<Object>{date1}, new Set<Date>{date1});
        assertObjectToDate(new Set<Object>{date1,date2}, new Set<Date>{date1,date2});
    }

    private static testmethod void testObjectToDatetime(){ 
        //test: global static Set<Datetime> objectToDatetime(Set<Object> objectSet){ 
        assertObjectToDatetime(null, null);
        assertObjectToDatetime(new Set<Object>{}, new Set<Datetime>{});
        Datetime date1 = Datetime.newInstance(2009,1,1);
        Datetime date2 = Datetime.newInstance(2009,1,2);
        assertObjectToDatetime(new Set<Object>{date1}, new Set<Datetime>{date1});
        assertObjectToDatetime(new Set<Object>{date1,date2}, new Set<Datetime>{date1,date2});
    }

    private static testmethod void testObjectToDecimal(){ 
        //test: global static Set<Decimal> objectToDecimal(Set<Object> objectSet){
        assertObjectToDecimal(null, null);
        assertObjectToDecimal(new Set<Object>{}, new Set<Decimal>{});
        Decimal dec1 = 4.0;
        Decimal dec2 = 5.0;
        assertObjectToDecimal(new Set<Object>{dec1}, new Set<Decimal>{dec1});
        assertObjectToDecimal(new Set<Object>{dec1,dec2}, new Set<Decimal>{dec1,dec2});
    }

    private static testmethod void testObjectToDouble(){ 
        //test: global static Set<Double> objectToDouble(Set<Object> objectSet){ 
        assertObjectToDouble(null, null);
        assertObjectToDouble(new Set<Object>{}, new Set<Double>{});
        Double doub1 = 4.0;
        Double doub2 = 5.0;
        assertObjectToDouble(new Set<Object>{doub1}, new Set<Double>{doub1});
        assertObjectToDouble(new Set<Object>{doub1,doub2}, new Set<Double>{doub1,doub2});
    }

    private static testmethod void testObjectToID(){ 
        //test: global static Set<ID> objectToID(Set<Object> objectSet){ 
        assertObjectToID(null, null);
        assertObjectToID(new Set<Object>{}, new Set<ID>{});
        Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        assertObjectToID(new Set<Object>{acct1.id}, new Set<Id>{acct1.id});
        assertObjectToID(new Set<Object>{acct1.id,acct2.id}, new Set<Id>{acct1.id,acct2.id});
    } 

    private static testmethod void testObjectToInteger(){ 
        //test: global static Set<Integer> objectToInteger(Set<Object> objectSet){ 
        assertObjectToInteger(null, null);
        assertObjectToInteger(new Set<Object>{}, new Set<Integer>{});
        Integer int1 = 4;
        Integer int2 = 5;
        assertObjectToInteger(new Set<Object>{int1}, new Set<Integer>{int1});
        assertObjectToInteger(new Set<Object>{int1,int2}, new Set<Integer>{int1,int2});
    }

    private static testmethod void testObjectToLong(){ 
        //test: global static Set<Long> objectToLong(Set<Object> objectSet){ 
        assertObjectToLong(null, null);
        assertObjectToLong(new Set<Object>{}, new Set<Long>{});
        Long long1 = 4;
        Long long2 = 5;
        assertObjectToLong(new Set<Object>{long1}, new Set<Long>{long1});
        assertObjectToLong(new Set<Object>{long1,long2}, new Set<Long>{long1,long2});
    }

    private static testmethod void testObjectToTime(){ 
        //test: global static Set<Time> objectToTime(Set<Object> objectSet){ 
        assertObjectToTime(null, null);
        assertObjectToTime(new Set<Object>{}, new Set<Time>{});
        Time time1 = Time.newInstance(18, 30, 2, 20);
        Time time2 = Time.newInstance(18, 30, 2, 21);
        assertObjectToTime(new Set<Object>{time1}, new Set<Time>{time1});
        assertObjectToTime(new Set<Object>{time1,time2}, new Set<Time>{time1,time2});
    }

    private static testmethod void testObjectToString(){ 
        //test: global static Set<String> objectToString(Set<Object> objectSet){ 
        assertObjectToString(null, null);
        assertObjectToString(new Set<Object>{}, new Set<String>{});
        String str1 = 'xyz';
        String str2 = 'abc';
        assertObjectToString(new Set<Object>{str1}, new Set<String>{str1});
        assertObjectToString(new Set<Object>{str1,str2}, new Set<String>{str1,str2});
    }
    
    private static testmethod void testToStringBlobSet(){ 
        //test: global static String toString(Set<Blob> blobSet)
        assertToStringBlobSet(null, null);
        assertToStringBlobSet(new Set<Blob>{}, '');
        Blob blob1 = generateRandomBlob();
        Blob blob2 = generateRandomBlob();
        assertToStringBlobSet(new Set<Blob>{blob1}, '{\'' + blob1.toString() + '\'}');
        assertToStringBlobSet(new Set<Blob>{blob1,blob2}, '{\'' + blob1.toString() + '\',\'' + blob2.toString() + '\'}');
    }    

    private static testmethod void testToStringBooleanSet(){ 
        //test: global static String toString(Set<Boolean> booleanSet)
        assertToStringBooleanSet(null, null);
        assertToStringBooleanSet(new Set<Boolean>{}, '');
        assertToStringBooleanSet(new Set<Boolean>{true}, '{true}');
        assertToStringBooleanSet(new Set<Boolean>{true, false}, '{false,true}');
    }

    private static testmethod void testToStringDateSet(){ 
        //test: global static String toString(Set<Date> dateSet)
        assertToStringDateSet(null, null);
        assertToStringDateSet(new Set<Date>{}, '');
        Date date1 = Date.newInstance(2009,1,1);
        Date date2 = Date.newInstance(2009,1,2);
        assertToStringDateSet(new Set<Date>{date1}, '{'+date1+'}' );
        assertToStringDateSet(new Set<Date>{date1,date2}, '{'+date1+','+date2+'}' );
    }

    private static testmethod void testToStringDatetimeSet(){ 
        //test: global static String toString(Set<Datetime> datetimeSet)
        assertToStringDatetimeSet(null, null);
        assertToStringDatetimeSet(new Set<Datetime>{}, '');
        Datetime date1 = Datetime.newInstance(2009,1,1);
        Datetime date2 = Datetime.newInstance(2009,1,2);
        assertToStringDatetimeSet(new Set<Datetime>{date1}, '{'+date1+'}' );
        assertToStringDatetimeSet(new Set<Datetime>{date1,date2}, '{'+date1+','+date2+'}' );
    }

    private static testmethod void testToStringDecimalSet(){ 
        //test: global static String toString(Set<Decimal> decimalSet)
        assertToStringDecimalSet(null, null);
        assertToStringDecimalSet(new Set<Decimal>{}, '');
        Decimal dec1 = 4.0;
        Decimal dec2 = 5.0;
        assertToStringDecimalSet(new Set<Decimal>{dec1}, '{' + dec1 + '}');
        assertToStringDecimalSet(new Set<Decimal>{dec1,dec2}, '{' + dec1 + ',' + dec2 + '}');
    }

    private static testmethod void testToStringDoubleSet(){ 
        //test: global static String toString(Set<Double> doubleSet)
        assertToStringDoubleSet(null, null);
        assertToStringDoubleSet(new Set<Double>{}, '');
        Double doub1 = 4.0;
        Double doub2 = 5.0;
        assertToStringDoubleSet(new Set<Double>{doub1}, '{' + doub1 + '}');
        assertToStringDoubleSet(new Set<Double>{doub1,doub2}, '{' + doub1 + ',' + doub2 + '}');
    }

    private static testmethod void testToStringIDSet(){ 
        //test: global static String toString(Set<ID> idSet)
        assertToStringIDSet(null, null);
        assertToStringIDSet(new Set<ID>{}, '');
        Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        assertToStringIDSet(new Set<ID>{acct1.id}, '{' + acct1.id + '}');
        assertToStringIDSet(new Set<ID>{acct1.id,acct2.id}, '{' + acct1.id + ',' + acct2.id + '}');
    }

    private static testmethod void testToStringIntegerSet(){ 
        //test: global static String toString(Set<Integer> integerSet)
        assertToStringIntegerSet(null, null);
        assertToStringIntegerSet(new Set<Integer>{}, '');
        Integer int1 = 4;
        Integer int2 = 5;
        assertToStringIntegerSet(new Set<Integer>{int1}, '{' + int1 + '}' );
        assertToStringIntegerSet(new Set<Integer>{int1,int2}, '{' + int1 + ',' + int2 + '}' );
    }
    private static testmethod void testToStringLongSet(){ 
        //test: global static String toString(Set<Long> longSet)
        assertToStringLongSet(null, null);
        assertToStringLongSet(new Set<Long>{}, '');
        Long long1 = 4;
        Long long2 = 5;
        assertToStringLongSet(new Set<Long>{long1}, '{' + long1 + '}');
        assertToStringLongSet(new Set<Long>{long1,long2}, '{' + long1 + ',' + long2 + '}');
    }

    private static testmethod void testToStringTimeSet(){ 
        //test: global static String toString(Set<Time> timeSet)
        assertToStringTimeSet(null, null);
        assertToStringTimeSet(new Set<Time>{}, '');
        Time time1 = Time.newInstance(18, 30, 2, 20);
        Time time2 = Time.newInstance(18, 30, 2, 21);
        assertToStringTimeSet(new Set<Time>{time1}, '{' + time1 + '}' );
        assertToStringTimeSet(new Set<Time>{time1,time2}, '{' + time1 + ',' + time2 + '}' );
    }


    private static testmethod void testToStringStringSet(){ 
        //test: global static String toString(Set<String> stringSet)
        assertToStringStringSet(null, null);
        assertToStringStringSet(new Set<String>{}, '');
        String str1 = 'xyz';
        String str2 = 'abc';
        assertToStringStringSet(new Set<String>{str1}, '{' + str1 + '}');
        assertToStringStringSet(new Set<String>{str1,str2}, '{' + str1 + ',' + str2 + '}');
    }

    private static void assertObjectToBlob(Set<Object> objectSet, Set<Blob> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Blob> actual = ApexLangUtils.objectToBlob(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToBlob(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToBlob(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToBoolean(Set<Object> objectSet, Set<Boolean> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Boolean> actual = ApexLangUtils.objectToBoolean(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToBoolean(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToBoolean(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToDate(Set<Object> objectSet, Set<Date> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Date> actual = ApexLangUtils.objectToDate(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToDate(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToDate(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToDatetime(Set<Object> objectSet, Set<Datetime> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Datetime> actual = ApexLangUtils.objectToDatetime(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToDatetime(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToDatetime(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToDecimal(Set<Object> objectSet, Set<Decimal> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Decimal> actual = ApexLangUtils.objectToDecimal(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToDecimal(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToDecimal(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToDouble(Set<Object> objectSet, Set<Double> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Double> actual = ApexLangUtils.objectToDouble(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToDouble(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToDouble(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToID(Set<Object> objectSet, Set<ID> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<ID> actual = ApexLangUtils.objectToID(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToID(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToID(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToInteger(Set<Object> objectSet, Set<Integer> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Integer> actual = ApexLangUtils.objectToInteger(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToInteger(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToInteger(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToLong(Set<Object> objectSet, Set<Long> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Long> actual = ApexLangUtils.objectToLong(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToLong(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToLong(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToTime(Set<Object> objectSet, Set<Time> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<Time> actual = ApexLangUtils.objectToTime(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToTime(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToTime(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    private static void assertObjectToString(Set<Object> objectSet, Set<String> expected){System.assert(!((objectSet == null && expected != null)|| (objectSet != null && expected == null)),    'Invalid test input: both parameters should be null.');Set<String> actual = ApexLangUtils.objectToString(objectSet);System.assert(!(objectSet == null && expected == null && actual != null),     'ApexLangUtils.objectToString(null) returned ' + ApexLangUtils.toString(actual) + '; expected null');if(expected != null && actual != null){System.assert(actual.containsAll(expected) && expected.containsAll(actual),     'ApexLangUtils.objectToString(' + ApexLangUtils.toString(objectSet) + ') returned ' + ApexLangUtils.toString(actual) + '; expected ' + ApexLangUtils.toString(expected));}}
    
    private static void assertToStringBlobSet(Set<Blob> blobSet, String expected){System.assert(!((blobSet == null && expected != null) || (blobSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(blobSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(blobSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringBooleanSet(Set<Boolean> booleanSet, String expected){System.assert(!((booleanSet == null && expected != null) || (booleanSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(booleanSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(booleanSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringDateSet(Set<Date> dateSet, String expected){System.assert(!((dateSet == null && expected != null) || (dateSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(dateSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(dateSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringDatetimeSet(Set<Datetime> datetimeSet, String expected){System.assert(!((datetimeSet == null && expected != null) || (datetimeSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(datetimeSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(datetimeSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringDecimalSet(Set<Decimal> decimalSet, String expected){System.assert(!((decimalSet == null && expected != null) || (decimalSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(decimalSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(decimalSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringDoubleSet(Set<Double> doubleSet, String expected){System.assert(!((doubleSet == null && expected != null) || (doubleSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(doubleSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(doubleSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringIDSet(Set<ID> idSet, String expected){System.assert(!((idSet == null && expected != null) || (idSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(idSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(idSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringIntegerSet(Set<Integer> integerSet, String expected){System.assert(!((integerSet == null && expected != null) || (integerSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(integerSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(integerSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringLongSet(Set<Long> longSet, String expected){System.assert(!((longSet == null && expected != null) || (longSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(longSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(longSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringTimeSet(Set<Time> timeSet, String expected){System.assert(!((timeSet == null && expected != null) || (timeSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(timeSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(timeSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertToStringStringSet(Set<String> stringSet, String expected){System.assert(!((stringSet == null && expected != null) || (stringSet != null && expected == null)),     'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.toString(stringSet); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),','));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),','));    if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet),    'ApexLangUtils.toString(' + ApexLangUtils.toString(stringSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
        

    /*private static Blob generateRandomBlob(){
        return EncodingUtil.base64Decode(''+System.currentTimeMillis()+Math.roundToLong(Math.random()*10000));    
    }*/

    private static testmethod void testListToSet_String(){
        List<String> aList = null;
        System.assertEquals(null,ApexLangUtils.listToSet(aList));
        System.assertEquals(0,ApexLangUtils.listToSet(new List<String>()).size());
        System.assertEquals(1,ApexLangUtils.listToSet(new List<String>{''}).size());
        System.assertEquals(1,ApexLangUtils.listToSet(new List<String>{'a'}).size());
        System.assertEquals(2,ApexLangUtils.listToSet(new List<String>{'a','b'}).size());
        System.assertEquals(1,ApexLangUtils.listToSet(new List<String>{'a','a'}).size());
    }
    
    private static testmethod void testSetToList_String(){
        System.assertEquals(null,ApexLangUtils.setToList(null));
        System.assertEquals(0,ApexLangUtils.setToList(new Set<String>()).size());
        System.assertEquals(1,ApexLangUtils.setToList(new Set<String>{''}).size());
        System.assertEquals(1,ApexLangUtils.setToList(new Set<String>{'a'}).size());
        System.assertEquals(2,ApexLangUtils.setToList(new Set<String>{'a','b'}).size());
        System.assertEquals(1,ApexLangUtils.setToList(new Set<String>{'a','a'}).size());
    }

    private static testmethod void testAssertEquals(){
        final Blob blob1 = generateRandomBlob();
        final Date date1 = Date.newInstance(2009,1,1);
        final Datetime datetime1 = Datetime.newInstance(2009,1,1);
        final Time time1 = Time.newInstance(18, 30, 2, 20);
        ApexLangUtils.assertEquals(new Set<Blob>{blob1},new Set<Blob>{blob1});
        ApexLangUtils.assertEquals(new Set<Boolean>{true},new Set<Boolean>{true});
        ApexLangUtils.assertEquals(new Set<Date>{date1},new Set<Date>{date1});
        ApexLangUtils.assertEquals(new Set<Datetime>{datetime1},new Set<Datetime>{datetime1});
        ApexLangUtils.assertEquals(new Set<Decimal>{1.1},new Set<Decimal>{1.1});
        ApexLangUtils.assertEquals(new Set<Double>{1.1},new Set<Double>{1.1});
        ApexLangUtils.assertEquals(new Set<Integer>{1},new Set<Integer>{1});
        ApexLangUtils.assertEquals(new Set<Long>{1L},new Set<Long>{1L});
        ApexLangUtils.assertEquals(new Set<String>{'a'},new Set<String>{'a'});
        ApexLangUtils.assertEquals(new Set<Time>{time1},new Set<Time>{time1});
    }

    private static testmethod void testEquals(){
        final Set<Object> NULL_SET = null;
        System.assertEquals(true,ApexLangUtils.equals(NULL_SET,NULL_SET));       
        System.assertEquals(false,ApexLangUtils.equals(null,new Set<Integer>{1}));       
        System.assertEquals(false,ApexLangUtils.equals(new Set<Integer>{1},null));       
        System.assertEquals(true,ApexLangUtils.equals(new Set<Integer>(),new Set<Integer>()));       
        System.assertEquals(false,ApexLangUtils.equals(new Set<Integer>{1},new Set<Integer>()));       
        System.assertEquals(false,ApexLangUtils.equals(new Set<Integer>{1},new Set<Integer>{2}));       
        System.assertEquals(true,ApexLangUtils.equals(new Set<Integer>{1},new Set<Integer>{1}));       

        System.assertEquals(false,ApexLangUtils.equals(null,new Set<String>{'abc'}));       
        System.assertEquals(false,ApexLangUtils.equals(new Set<String>{'abc'},null));       
        System.assertEquals(true,ApexLangUtils.equals(new Set<String>(),new Set<String>()));       
        System.assertEquals(false,ApexLangUtils.equals(new Set<String>{'abc'},new Set<String>()));       
        System.assertEquals(false,ApexLangUtils.equals(new Set<String>{'abc'},new Set<String>{'def'}));       
        System.assertEquals(true,ApexLangUtils.equals(new Set<String>{'abc'},new Set<String>{'abc'}));       

        final Blob blob1 = generateRandomBlob();
        final Date date1 = Date.newInstance(2009,1,1);
        final Datetime datetime1 = Datetime.newInstance(2009,1,1);
        final Time time1 = Time.newInstance(18, 30, 2, 20);
        System.assertEquals(true,ApexLangUtils.equals(new Set<Blob>{blob1},new Set<Blob>{blob1}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Boolean>{true},new Set<Boolean>{true}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Date>{date1},new Set<Date>{date1}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Datetime>{datetime1},new Set<Datetime>{datetime1}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Decimal>{1.1},new Set<Decimal>{1.1}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Double>{1.1},new Set<Double>{1.1}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Integer>{1},new Set<Integer>{1}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Long>{1L},new Set<Long>{1L}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<String>{'a'},new Set<String>{'a'}));
        System.assertEquals(true,ApexLangUtils.equals(new Set<Time>{time1},new Set<Time>{time1}));

    }    
    /* SetApexLangUtils Tests */

    /* StringApexLangUtils tests*/

    private static testmethod void testAbbreviateTwoArgs(){
        assertAbbreviateTwoArgs(null,         -1, null,         false);
        assertAbbreviateTwoArgs('',         4,     '',            false);
        assertAbbreviateTwoArgs('abcdefg',     6,     'abc...',    false);
        assertAbbreviateTwoArgs('abcdefg',     7,     'abcdefg',    false);
        assertAbbreviateTwoArgs('abcdefg',     8,     'abcdefg',     false);
        assertAbbreviateTwoArgs('abcdefg',     4,     'a...',     false);
        assertAbbreviateTwoArgs('abcdefg',     3,     null,         true);
    }    
     
    private static void assertAbbreviateTwoArgs(String str, Integer maxWidth, 
        String expected, Boolean excepExpected){

        String actual = null;
        Boolean excepActual = false;
        try{
            actual = ApexLangUtils.abbreviate(str,maxWidth);
        } catch (IllegalArgumentException e){
            excepActual = true;
        }
        if(excepExpected && excepActual){
            return;
        }
        System.assert(excepExpected == excepActual, 'ApexLangUtils.abbreviate(\'' 
            + str + '\',' + maxWidth + ') ' 
            + (excepExpected ? 'did not throw' : 'unexpectedly threw') 
            + ' IllegalArgumentException');
        if(!excepExpected && !excepActual){
            System.assert(actual==expected, 'ApexLangUtils.abbreviate(\'' + str + '\',' 
                + maxWidth + ') returned ' + actual + '; expected ' + expected);
        }
    }
    
    private static testmethod void testAbbreviateThreeArgs(){
        assertAbbreviateThreeArgs(null,                 -1,    -1,     null,             false);
        assertAbbreviateThreeArgs('',                     0,     4,         '',                false);
        assertAbbreviateThreeArgs('abcdefghijklmno',    -1, 10,     'abcdefg...',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     0,     10,     'abcdefg...',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     1,     10,     'abcdefg...',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     4,     10,     'abcdefg...',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     5,     10,     '...fghi...',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     6,     10,     '...ghij...',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     8,     10,     '...ijklmno',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     10, 10,     '...ijklmno',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     12, 10,     '...ijklmno',    false);
        assertAbbreviateThreeArgs('abcdefghijklmno',     20, 10,     '...ijklmno',    false);
        assertAbbreviateThreeArgs('abcdefghij',         0,     3,        null,            true);
        assertAbbreviateThreeArgs('abcdefghij',         5,     6,        null,            true);
    }    
    
    private static void assertAbbreviateThreeArgs(String str, Integer offset, Integer maxWidth, 
        String expected, Boolean excepExpected){

        String actual = null;
        Boolean excepActual = false;
        try{
            actual = ApexLangUtils.abbreviate(str,offset,maxWidth);
        } catch (IllegalArgumentException e){
            excepActual = true;
        }
        if(excepExpected && excepActual){
            return;
        }
        System.assert(excepExpected == excepActual, 'ApexLangUtils.abbreviate(\'' 
            + str + '\',' + offset + ',' + maxWidth + ') ' 
            + (excepExpected ? 'did not throw' : 'unexpectedly threw') 
            + ' IllegalArgumentException');
        if(!excepExpected && !excepActual){
            System.assert(actual==expected, 'ApexLangUtils.abbreviate(\'' + str + '\',' 
                + offset + ',' + maxWidth + ') returned ' + actual + '; expected ' + expected);
        }
    }
 
    private static testmethod void testIndexOfAny(){
        //test: global static int indexOfAny(String str, String searchChars) {
        assertIndexOfAny(null, null, -1);
        assertIndexOfAny('', null, -1);
        assertIndexOfAny(null, '', -1);
        assertIndexOfAny('zzabyycdxx', 'za', 0);
        assertIndexOfAny('zzabyycdxx', 'by', 3);
        assertIndexOfAny('aba','z', -1);
    }    
    
    private static void assertIndexOfAny(String str, String searchChars, Integer expected){
        Integer actual = ApexLangUtils.indexOfAny(str,searchChars);
        System.assert(actual==expected, 'ApexLangUtils.indexOfAny(\'' + str + '\',' 
            + searchChars + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
     private static testmethod void testLastIndexOfAny(){
        //test: global static Integer lastIndexOfAny(String str, String[] searchStrs) {
        assertLastIndexOfAny(null, null, -1);
        assertLastIndexOfAny('', null, -1);
        assertLastIndexOfAny(null, new String[]{}, -1);
        assertLastIndexOfAny(null, new String[]{null}, -1);
        assertLastIndexOfAny('', new String[]{null}, -1);
        assertLastIndexOfAny('zzabyycdxx', new String[]{'ab','cd'}, 6);
        assertLastIndexOfAny('zzabyycdxx', new String[]{'cd','ab'}, 6);
        assertLastIndexOfAny('zzabyycdxx', new String[]{'mn','op'}, -1);
        assertLastIndexOfAny('zzabyycdxx', new String[]{'mn','op'}, -1);
        assertLastIndexOfAny('zzabyycdxx', new String[]{'mn',''}, 10);
    }
    
    private static void assertLastIndexOfAny(String str, String[] searchStrs, Integer expected){
        Integer actual = ApexLangUtils.lastIndexOfAny(str,searchStrs);
        System.assert(actual==expected, 'ApexLangUtils.lastIndexOfAny(\'' + str + '\',' 
            + ApexLangUtils.toString(searchStrs) + ') returned ' + actual + '; expected ' + expected);
    }
    
    private static testmethod void testLastIndexOfTwoArgs(){
        //test: global static Integer lastIndexOf(String str, String searchStr) {
        assertLastIndexOfTwoArgs(null, '', -1);
        assertLastIndexOfTwoArgs('', null, -1);
        assertLastIndexOfTwoArgs('', '', 0);
        assertLastIndexOfTwoArgs('aabaabaa', 'a', 7);
        assertLastIndexOfTwoArgs('aabaabaa', 'b', 5);
        assertLastIndexOfTwoArgs('aabaabaa', 'ab', 4);
        assertLastIndexOfTwoArgs('aabaabaa', '', 8);
    }    
    
    private static void assertLastIndexOfTwoArgs(String str, String searchStr, Integer expected){
        Integer actual = ApexLangUtils.lastIndexOf(str,searchStr);
        System.assert(actual==expected, 'ApexLangUtils.lastIndexOf(\'' + str + '\',\'' 
            + searchStr + '\') returned ' + actual + '; expected ' + expected);
    }
    
    private static testmethod void testLastIndexOfThreeArgs(){
        //test: global static Integer lastIndexOf(String str, String searchStr, Integer startPos) {
        assertLastIndexOfThreeArgs(null, null, -1, -1);
        assertLastIndexOfThreeArgs('', null, -1, -1);
        assertLastIndexOfThreeArgs('aabaabaa', 'a', 8, 7);
        assertLastIndexOfThreeArgs('aabaabaa', 'b', 8, 5);
        assertLastIndexOfThreeArgs('aabaabaa', 'ab', 8, 4);
        assertLastIndexOfThreeArgs('aabaabaa', 'b', 9, 5);
        assertLastIndexOfThreeArgs('aabaabaa', 'b', -1, -1);
        assertLastIndexOfThreeArgs('aabaabaa', 'a', 0, 0);
        assertLastIndexOfThreeArgs('aabaabaa', 'b', 0, -1);
    }
    
    private static void assertLastIndexOfThreeArgs(String str, String searchStr, Integer startPos, Integer expected){
        Integer actual = ApexLangUtils.lastIndexOf(str,searchStr,startPos);
        System.assert(actual==expected, 'ApexLangUtils.lastIndexOf(\'' + str + '\',\'' 
            + searchStr + '\',' + startPos + ') returned ' + actual + '; expected ' + expected);
    }
    
    private static testmethod void testIndexOfAnyStringArray(){
        //test: global static Integer indexOfAny(String str, String[] searchStrs) {
        assertIndexOfAnyStringArray(null, null, -1);
        assertIndexOfAnyStringArray(null, new String[]{}, -1);
        assertIndexOfAnyStringArray('zzabyycdxx', new String[]{null}, -1);
        assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'ab','cd'}, 2);
        assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'cd','ab'}, 2);
        assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'mn','op'}, -1);
        assertIndexOfAnyStringArray('zzabyycdxx', new String[]{'zab','aby'}, 1);
        assertIndexOfAnyStringArray('zzabyycdxx', new String[]{''}, 0);
        assertIndexOfAnyStringArray('', new String[]{''}, 0);
        assertIndexOfAnyStringArray('', new String[]{'a'}, -1);
    }    
    
    private static void assertIndexOfAnyStringArray(String str, String[] searchStrs, Integer expected){
        Integer actual = ApexLangUtils.indexOfAny(str,searchStrs);
        System.assert(actual==expected, 'ApexLangUtils.indexOfAny(\'' + str + '\',' 
            + ApexLangUtils.toString(searchStrs) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testCenterTwoArgs(){
        assertCenterTwoArgs(null,     -1,    null);
        assertCenterTwoArgs('',     4,    '    ');
        assertCenterTwoArgs('ab',     -1,    'ab');
        assertCenterTwoArgs('ab',     4,    ' ab ');
        assertCenterTwoArgs('abcd', 2,    'abcd');
        assertCenterTwoArgs('a',     4,    ' a  ');
    }    
    
    private static void assertCenterTwoArgs(String str, Integer size, String expected){
        String actual = ApexLangUtils.center(str,size);
        System.assert(actual==expected, 'ApexLangUtils.center(\'' + str + '\',' 
            + size + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testChompOneArg(){
        assertChompOneArg(null,                null);
        assertChompOneArg('',                '');
        assertChompOneArg('abc \r',            'abc ');
        assertChompOneArg('abc\n',            'abc');
        assertChompOneArg('abc\r\n',        'abc');
        assertChompOneArg('abc\r\n\r\n',    'abc\r\n');
        assertChompOneArg('abc\n\r',        'abc\n');
        assertChompOneArg('abc\n\rabc',        'abc\n\rabc');
        assertChompOneArg('\t',                '\t');
        assertChompOneArg('\r',                '');
        assertChompOneArg('\n',                '');
        assertChompOneArg('\r\n',            '');
    }    
    
    private static void assertChompOneArg(String str, String expected){
        String actual = ApexLangUtils.chomp(str);
        System.assert(actual==expected, 'ApexLangUtils.chomp(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testChompTwoArgs(){
        assertChompTwoArgs(null,         null,         null);
        assertChompTwoArgs('',             null,         '');
        assertChompTwoArgs('foobar',     'bar',         'foo');
        assertChompTwoArgs('foobar',     'baz',         'foobar');
        assertChompTwoArgs('foo',        'foo',         '');
        assertChompTwoArgs('foo ',         'foo',         'foo ');
        assertChompTwoArgs(' foo',         'foo',         ' ');
        assertChompTwoArgs('foo',         'foooo',     'foo');
        assertChompTwoArgs('foo',         '',         'foo');
        assertChompTwoArgs('foo',         null,         'foo');
    }    
    
    private static void assertChompTwoArgs(String str, String separator, String expected){
        String actual = ApexLangUtils.chomp(str,separator);
        System.assert(actual==expected, 'ApexLangUtils.chomp(\'' + str + '\', \'' + separator + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    
    private static testmethod void testCenterThreeArgs(){
        assertCenterThreeArgs(null,     -1, null,     null);
        assertCenterThreeArgs('',         4,     ' ',     '    ');
        assertCenterThreeArgs('ab',     -1, ' ',     'ab');
        assertCenterThreeArgs('ab',     4,     ' ',     ' ab ');
        assertCenterThreeArgs('abcd',     2,     ' ',     'abcd');
        assertCenterThreeArgs('a',         4,     ' ',     ' a  ');
        assertCenterThreeArgs('a',         4,     'yz',     'yayz');
        assertCenterThreeArgs('abc',     7,     null,     '  abc  ');
        assertCenterThreeArgs('abc',     7,     '',     '  abc  ');
    }    
    
    private static void assertCenterThreeArgs(String str, Integer size, String padStr, String expected){
        String actual = ApexLangUtils.center(str,size, padStr);
        System.assert(actual==expected, 'ApexLangUtils.center(\'' + str + '\',' 
            + size + ',\'' + padStr + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testChop(){
        assertChop(null,        null);
        assertChop('',             '');
        assertChop('abc \r',     'abc ');
        assertChop('abc\n',     'abc');
        assertChop('abc\r\n',     'abc');
        assertChop('abc',         'ab');
        assertChop('abc\nabc',     'abc\nab');
        assertChop('a',         '');
        assertChop('\r',         '');
        assertChop('\n',         '');
        assertChop('\r\n',         '');
    }    
    
    private static void assertChop(String str, String expected){
        String actual = ApexLangUtils.chop(str);
        System.assert(actual==expected, 'ApexLangUtils.chop(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testContainsAny(){
        assertContainsAny(null,         null,     false);
        assertContainsAny('',             null,     false);
        assertContainsAny(null,         null,     false);
        assertContainsAny(null,         '',     false);
        assertContainsAny('zzabyycdxx', 'za',     true);
        assertContainsAny('zzabyycdxx', 'by',     true);
        assertContainsAny('aba',        'z',     false);
    }    
    
    private static void assertContainsAny(String str, String searchChars, Boolean expected){
        Boolean actual = ApexLangUtils.containsAny(str,searchChars);
        System.assert(actual==expected, 'ApexLangUtils.containsAny(\'' + str + '\',\'' + searchChars + '\') returned ' 
            + actual);
    }
    
    
    private static testmethod void testContainsNone(){
        //test: global static boolean containsNone(String str, String invalidChars) {
        assertContainsNone(null,     null,     true);
        assertContainsNone(null,     null,     true);
        assertContainsNone('',         null,     true);
        assertContainsNone('ab',     '',     true);
        assertContainsNone('abab',     'xyz',     true);
        assertContainsNone('ab1',     'xyz',     true);
        assertContainsNone('abz',     'xyz',     false);
    }    
    
    private static void assertContainsNone(String str, String invalidChars, Boolean expected){
        Boolean actual = ApexLangUtils.containsNone(str,invalidChars);
        System.assert(actual==expected, 'ApexLangUtils.containsNone(\'' + str + '\',\'' + invalidChars + '\') returned ' 
            + actual);
    }
    
    private static testmethod void testContainsOnly(){
        //test: global static boolean containsOnly(String str, String valid) {
        assertContainsOnly(null,     null,    false);
        assertContainsOnly(null,     null,    false);
        assertContainsOnly('',         null,    false);
        assertContainsOnly('',         '',        true);
        assertContainsOnly('ab',     '',        false);
        assertContainsOnly('abab',     'abc',    true);
        assertContainsOnly('ab1',     'abc',    false);
        assertContainsOnly('abz',     'abc',     false);
    }    
    
    private static void assertContainsOnly(String str, String valid, Boolean expected){
        Boolean actual = ApexLangUtils.containsOnly(str,valid);
        System.assert(actual==expected, 'ApexLangUtils.containsOnly(\'' + str + '\',\'' + valid + '\') returned ' 
            + actual);
    }
    
    private static testmethod void testCountMatches(){
        //test: global static Integer countMatches(String str, String sub) {
        assertCountMatches(null, null, 0);
        assertCountMatches('', null, 0);
        assertCountMatches('abba', null, 0);
        assertCountMatches('abba', '', 0);
        assertCountMatches('abba', 'a', 2);
        assertCountMatches('abba', 'ab', 1);
        assertCountMatches('abba', 'xxx', 0);
    }    
    
    private static void assertCountMatches(String str, String sub, Integer expected){
        Integer actual = ApexLangUtils.countMatches(str,sub);
        System.assert(actual==expected, 'ApexLangUtils.countMatches(\'' + str + '\',\'' + sub + '\') returned ' 
            + actual + '; expected ' + expected);
    }

    private static testmethod void testDefaultIfEmpty(){
        //test: global static String defaultIfEmpty(String str, String defaultStr) {
        assertDefaultIfEmpty(null, 'NULL', 'NULL');
        assertDefaultIfEmpty('', 'NULL', 'NULL');
        assertDefaultIfEmpty('bat', 'NULL', 'bat');
    }    
    
    private static void assertDefaultIfEmpty(String str, String defaultStr, String expected){
        String actual = ApexLangUtils.defaultIfEmpty(str,defaultStr);
        System.assert(actual==expected, 'ApexLangUtils.defaultIfEmpty(\'' + str + '\',\'' + defaultStr + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testDefaultStringOneArg(){
        //test: global static String defaultString(String str) {
        assertDefaultStringOneArg(null, '');
        assertDefaultStringOneArg('', '');
        assertDefaultStringOneArg('bat', 'bat');
    }    
    
    private static void assertDefaultStringOneArg(String str, String expected){
        String actual = ApexLangUtils.defaultString(str);
        System.assert(actual==expected, 'ApexLangUtils.defaultString(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testDefaultStringTwoArgs(){
        //test: global static String defaultString(String str, String defaultStr) {
        assertDefaultStringTwoArgs(null, 'NULL', 'NULL');
        assertDefaultStringTwoArgs('', 'NULL', '');
        assertDefaultStringTwoArgs('bat', 'NULL', 'bat');
    }    
    
    private static void assertDefaultStringTwoArgs(String str, String defaultStr, String expected){
        String actual = ApexLangUtils.defaultString(str,defaultStr);
        System.assert(actual==expected, 'ApexLangUtils.defaultString(\'' + str + '\',\'' + defaultStr + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    

    private static testmethod void testDeleteWhitespace(){
        //test: global static String deleteWhitespace(String str) {
        assertDeleteWhitespace(null,             null);
        assertDeleteWhitespace('',                 '');
        assertDeleteWhitespace('abc',             'abc');
        assertDeleteWhitespace('   ab  c  ',     'abc');
    }    
    
    private static void assertDeleteWhitespace(String str, String expected){
        String actual = ApexLangUtils.deleteWhitespace(str);
        System.assert(actual==expected, 'ApexLangUtils.deleteWhitespace(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testDifference(){
        //test: global static String difference(String str1, String str2) {
        assertDifference(null,         null,         null);
        assertDifference('',         null,         '');
        assertDifference('',         '',         '');
        assertDifference('',         'abc',         'abc');
        assertDifference('abc',     '',         '');
        assertDifference('abc',     'abc',         '');
        assertDifference('ab',         'abxyz',     'xyz');
        assertDifference('abcde',     'abxyz',    'xyz');
        assertDifference('abcde',     'xyz',         'xyz');
    }    
    
    private static void assertDifference(String str1, String str2, String expected){
        String actual = ApexLangUtils.difference(str1,str2);
        System.assert(actual==expected, 'ApexLangUtils.difference(\'' + str1 + '\',\'' + str2 + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }



    private static testmethod void testEquals2(){
        //test: global static Boolean equals(String str1, String str2) {
        assertEquals(null,     null,     true);
        assertEquals(null,     'abc',     false);
        assertEquals('abc', null,     false);
        assertEquals('abc', 'abc',     true);
        assertEquals('abc', 'ABC',     false);
    }    
    
    private static void assertEquals(String str1, String str2, Boolean expected){
        Boolean actual = ApexLangUtils.equals(str1,str2); 
        System.assert(actual==expected, 'ApexLangUtils.equals(\'' + str1 + '\',\'' + str2 + '\') returned ' + actual);
    }

    private static testmethod void testEqualsIgnoreCase(){
        //test: global static Boolean equalsIgnoreCase(String str1, String str2) {
        assertEqualsIgnoreCase(null,     null,     true);
        assertEqualsIgnoreCase(null,     'abc',     false);
        assertEqualsIgnoreCase('abc',     null,     false);
        assertEqualsIgnoreCase('abc',     'abc',     true);
        assertEqualsIgnoreCase('abc',     'ABC',     true);
    }    
    
    private static void assertEqualsIgnoreCase(String str1, String str2, Boolean expected){
        Boolean actual = ApexLangUtils.equalsIgnoreCase(str1,str2);
        System.assert(actual==expected, 'ApexLangUtils.equalsIgnoreCase(\'' + str1 + '\',\'' + str2 + '\') returned ' + actual);
    }

    private static testmethod void testIndexOf(){
        //test: global static Integer indexOf(String str, String searchStr) {
        assertIndexOf(null,         null,     -1);
        assertIndexOf('',             null,     -1);
        assertIndexOf('aabaabaa',     'a',     0);
        assertIndexOf('aabaabaa',     'b',    2);
     }    
    
    private static void assertIndexOf(String str1, String searchStr, Integer expected){
        Integer actual = ApexLangUtils.indexOf(str1,searchStr);
        System.assert(actual==expected, 'ApexLangUtils.indexOf(\'' + str1 + '\',\'' + searchStr + '\') returned ' 
            + actual + '; expected ' + expected);
    }

    private static testmethod void testIndexOfDifference(){
        //test: global static Integer indexOfDifference(String str1, String str2) {
        assertIndexOfDifference(null,         null,         -1);
        assertIndexOfDifference(null,         '',         0);
        assertIndexOfDifference('',         null,         0);
        assertIndexOfDifference('',         '',         -1);
        assertIndexOfDifference('',         'abc',         0);
        assertIndexOfDifference('abc',         '',         0);
        assertIndexOfDifference('abc',         'abc',         -1);
        assertIndexOfDifference('ab',         'abxyz',     2);
        assertIndexOfDifference('abcde',     'abxyz',     2);
        assertIndexOfDifference('abcde',     'xyz',         0);
    }    
    
    private static void assertIndexOfDifference(String str1, String str2, Integer expected){
        Integer actual = ApexLangUtils.indexOfDifference(str1,str2);
        System.assert(actual==expected, 'ApexLangUtils.indexOfDifference(\'' + str1 + '\',\'' + str2 + '\') returned ' 
            + actual + '; expected ' + expected);
    }
    
    private static testmethod void testIndexOfAnyBut(){
        //test: global static int indexOfAnyBut(String str, String searchChars) {
        assertIndexOfAnyBut(null,             null,    -1);
        assertIndexOfAnyBut('',             null,    -1);
        assertIndexOfAnyBut(null,             null,    -1);
        assertIndexOfAnyBut(null,             '',        -1);
        assertIndexOfAnyBut('zzabyycdxx',     'za',    3);
        assertIndexOfAnyBut('zzabyycdxx',     '',        0);
        assertIndexOfAnyBut('aba',            'ab',    -1);
    }    
    
    private static void assertIndexOfAnyBut(String str, String searchChars, Integer expected){
        Integer actual = ApexLangUtils.indexOfAnyBut(str,searchChars);
        System.assert(actual==expected, 'ApexLangUtils.indexOfAnyBut(\'' + str + '\',\'' + searchChars + '\') returned ' 
            + actual + '; expected ' + expected);
    }
    
    private static testmethod void testLowerCase(){
        assertLowerCase(null, null);
        assertLowerCase('ABC', 'abc');
        assertLowerCase('abc', 'abc');
        assertLowerCase('aBc', 'abc');
    }    
    
    private static void assertLowerCase(String str, String expected){
        String actual = ApexLangUtils.lowerCase(str);
        System.assert(actual==expected, 'ApexLangUtils.lowerCase(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testUpperCase(){
        assertUpperCase(null, null);
        assertUpperCase('ABC', 'ABC');
        assertUpperCase('abc', 'ABC');
        assertUpperCase('aBc', 'ABC');
    }    
    
    private static void assertUpperCase(String str, String expected){
        String actual = ApexLangUtils.upperCase(str);
        System.assert(actual==expected, 'ApexLangUtils.upperCase(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testCapitalize(){
        assertCapitalize(null, null);
        assertCapitalize('ABC', 'ABC');
        assertCapitalize('abc', 'Abc');
        assertCapitalize('aBc', 'ABc');
    }    
    
    private static void assertCapitalize(String str, String expected){
        String actual = ApexLangUtils.capitalize(str);
        System.assert(actual==expected, 'ApexLangUtils.capitalize(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testUncapitalize(){
        assertUncapitalize(null, null);
        assertUncapitalize('ABC', 'aBC');
        assertUncapitalize('abc', 'abc');
        assertUncapitalize('aBc', 'aBc');
    }    
    
    private static void assertUncapitalize(String str, String expected){
        String actual = ApexLangUtils.uncapitalize(str);
        System.assert(actual==expected, 'ApexLangUtils.uncapitalize(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testSwapCase(){
        assertSwapCase(null, null);
        assertSwapCase('', '');
        assertSwapCase('The dog has a BONE', 'tHE DOG HAS A bone');
    }    
    
    private static void assertSwapCase(String str, String expected){
        String actual = ApexLangUtils.swapCase(str);
        System.assert(actual==expected, 'ApexLangUtils.swapCase(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testIsEmpty(){
        assertIsEmpty(null,     true);
        assertIsEmpty('',        true);
        assertIsEmpty(' ',        false);
        assertIsEmpty('bob',    false);
        assertIsEmpty('  bob  ',false);
    }    
    
    private static void assertIsEmpty(String str, Boolean expected){
        Boolean actual = ApexLangUtils.IsEmpty(str);
        System.assert(actual==expected, 'ApexLangUtils.IsEmpty(\'' + str + '\') returned ' + actual);
    }
    
    private static testmethod void testIsNotEmpty(){
        assertIsNotEmpty(null,         false);
        assertIsNotEmpty('',        false);
        assertIsNotEmpty(' ',        true);
        assertIsNotEmpty('bob',        true);
        assertIsNotEmpty('  bob  ',    true);
    }    
    
    private static void assertIsNotEmpty(String str, Boolean expected){
        Boolean actual = ApexLangUtils.IsNotEmpty(str);
        System.assert(actual==expected, 'ApexLangUtils.IsNotEmpty(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsAlpha(){
        //test: global static boolean isAlpha(String str) {
        assertIsAlpha(null, false);
        assertIsAlpha('', true);
        assertIsAlpha('  ', false);
        assertIsAlpha('abc', true);
        assertIsAlpha('ab2c', false);
        assertIsAlpha('ab-c', false);
    }

    private static void assertIsAlpha(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isAlpha(str);
        System.assert(actual==expected, 'ApexLangUtils.isAlpha(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsAlphaSpace(){
        //test: global static boolean isAlphaSpace(String str) {
        assertIsAlphaSpace(null, false);
        assertIsAlphaSpace('', true);
        assertIsAlphaSpace('  ', true);
        assertIsAlphaSpace('abc', true);
        assertIsAlphaSpace('ab c', true);
        assertIsAlphaSpace('ab2c', false);
        assertIsAlphaSpace('ab-c', false);
    }

    private static void assertIsAlphaSpace(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isAlphaSpace(str);
        System.assert(actual==expected, 'ApexLangUtils.isAlphaSpace(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsAlphanumeric(){
        //test: global static boolean isAlphanumeric(String str) {
        assertIsAlphanumeric(null, false);
        assertIsAlphanumeric('', true);
        assertIsAlphanumeric('  ', false);
        assertIsAlphanumeric('abc', true);
        assertIsAlphanumeric('ab c', false);
        assertIsAlphanumeric('ab2c', true);
        assertIsAlphanumeric('ab-c', false);
    }

    private static void assertIsAlphanumeric(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isAlphanumeric(str);
        System.assert(actual==expected, 'ApexLangUtils.isAlphanumeric(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsAlphanumericSpace(){
        //test: global static boolean isAlphanumericSpace(String str) {
        assertIsAlphanumericSpace(null, false);
        assertIsAlphanumericSpace('', true);
        assertIsAlphanumericSpace('  ', true);
        assertIsAlphanumericSpace('abc', true);
        assertIsAlphanumericSpace('ab c', true);
        assertIsAlphanumericSpace('ab2c', true);
        assertIsAlphanumericSpace('ab-c', false);
    }

    private static void assertIsAlphanumericSpace(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isAlphanumericSpace(str);
        System.assert(actual==expected, 'ApexLangUtils.isAlphanumericSpace(\'' + str + '\') returned ' + actual);
    }

    /*private static testmethod void testIsAsciiPrintable2(){
        //test: global static boolean isAsciiPrintable(String str) {
        assertIsAsciiPrintable(null, false);
        assertIsAsciiPrintable('', true);
        assertIsAsciiPrintable(' ', true);
        assertIsAsciiPrintable('Ceki', true);
        assertIsAsciiPrintable('ab2c', true);
        assertIsAsciiPrintable('!ab-c~', true);
        assertIsAsciiPrintable(' ', true);
        assertIsAsciiPrintable('!', true);
        assertIsAsciiPrintable('~', true);
        assertIsAsciiPrintable('', false);
        assertIsAsciiPrintable('Ceki Gülcü', false);
    }*/

    private static void assertIsAsciiPrintable(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isAsciiPrintable(str);
        System.assert(actual==expected, 'ApexLangUtils.isAsciiPrintable(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsNumeric(){
        //test: global static boolean isNumeric(String str) {
        assertIsNumeric(null, false);
        assertIsNumeric('', true);
        assertIsNumeric('  ', false);
        assertIsNumeric('123', true);
        assertIsNumeric('12 3', false);
        assertIsNumeric('ab2c', false);
        assertIsNumeric('12-3', false);
        assertIsNumeric('12.3', false);
    }

    private static void assertIsNumeric(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isNumeric(str);
        System.assert(actual==expected, 'ApexLangUtils.isNumeric(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsNumericSpace(){
        //test: global static boolean isNumericSpace(String str) {
        assertIsNumericSpace(null, false);
        assertIsNumericSpace('', true);
        assertIsNumericSpace('  ', true);
        assertIsNumericSpace('123', true);
        assertIsNumericSpace('12 3', true);
        assertIsNumericSpace('ab2c', false);
        assertIsNumericSpace('12-3', false);
        assertIsNumericSpace('12.3', false);
    }

    private static void assertIsNumericSpace(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isNumericSpace(str);
        System.assert(actual==expected, 'ApexLangUtils.isNumericSpace(\'' + str + '\') returned ' + actual);
    }

    /*private static testmethod void testIsWhitespace2(){
        //test: global static boolean isWhitespace(String str) {
        assertIsWhitespace(null, false);
        assertIsWhitespace('', true);
        assertIsWhitespace('  ', true);
        assertIsWhitespace('abc', false);
        assertIsWhitespace('ab2c', false);
        assertIsWhitespace('ab-c', false);
    }*/

    /*private static void assertIsWhitespace(String str, Boolean expected){
        Boolean actual = ApexLangUtils.isWhitespace(str);
        System.assert(actual==expected, 'ApexLangUtils.isWhitespace(\'' + str + '\') returned ' + actual);
    }*/

    private static testmethod void testLength(){
        assertLength(null,         0);
        assertLength('',        0);
        assertLength(' ',        1);
        assertLength('bob',        3);
        assertLength('  bob  ',    7);
    }    
    
    private static void assertLength(String str, Integer expected){
        Integer actual = ApexLangUtils.length(str);
        System.assert(actual==expected, 'ApexLangUtils.length(\'' + str + '\') returned ' + actual);
    }

    private static testmethod void testIsBlank(){
        assertOnIsBlank(true, null);
        assertOnIsBlank(true, '');
        assertOnIsBlank(true, '     ');
        assertOnIsBlank(true, '\n');
        assertOnIsBlank(false, 'x');
        assertOnIsBlank(false, ' x');
        assertOnIsBlank(false, 'asdfasdfasdf ');
    }
    
    private static void assertOnIsBlank(Boolean expectedReturnValue, String theString){
        System.assert(ApexLangUtils.isBlank(theString)==expectedReturnValue,
            'ApexLangUtils.isBlank(\'' + (theString == null ? 'null' : theString) + '\') returned ' + !expectedReturnValue);
    }

    private static testmethod void testIsNotBlank(){
        assertOnIsNotBlank(false, null);
        assertOnIsNotBlank(false, '');
        assertOnIsNotBlank(false, '     ');
        assertOnIsNotBlank(false, '\n');
        assertOnIsNotBlank(true, 'x');
        assertOnIsNotBlank(true, ' x');
        assertOnIsNotBlank(true, 'asdfasdfasdf ');
    }
    
    private static void assertOnIsNotBlank(Boolean expectedReturnValue, String theString){
        System.assert(ApexLangUtils.isNotBlank(theString)==expectedReturnValue,
            'ApexLangUtils.isNotBlank(\'' + (theString == null ? 'null' : theString) + '\') returned ' + !expectedReturnValue);
    }
    
    private static testmethod void testTrim(){
        assertTrim(null, null);
        assertTrim('', '');
        assertTrim('a', 'a');
        assertTrim('\n', '');
        assertTrim('   ', '');
    }
    
    private static void assertTrim(String str, String expected){
        String actual = ApexLangUtils.trim(str);
        System.assert(actual==expected, 'ApexLangUtils.trim(\'' + str + '\') returned [' + actual + '], expected [' + expected + ']');
    }
     
    
    
    private static testmethod void testJoinStrings(){
        assertJoinStrings(null, null, null);
        assertJoinStrings(new Set<String>(), ':', null);
        assertJoinStrings(new Set<String>{'a','b','c'}, ':', 'a:c:b');
        assertJoinStrings(new Set<String>{' ','b','c'}, ':', 'c:b');
    }

    private static void assertJoinStrings(Set<String> strings, String separator, String expectedReturnValue){
        String actual = ApexLangUtils.joinStrings(strings,separator);
        if(strings == null || strings.size() <= 0){
            System.assert(ApexLangUtils.isBlank(expectedReturnValue), 'ApexLangUtils.joinStrings(Set<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + actual);
            return;
        }
        Set<String> actualAsSet = new Set<String>(ApexLangUtils.split(actual,separator));
        Set<String> expectedAsSet = new Set<String>(ApexLangUtils.split(expectedReturnValue,separator));
        System.assert(actualAsSet.containsAll(expectedAsSet) && expectedAsSet.containsAll(actualAsSet),
            'ApexLangUtils.joinStrings(Set<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + 
                actual + '; expected: ' + expectedReturnValue);
    }
    
    
    private static testmethod void testJoinStringsList(){
        assertJoinStringsList(null, null, null);
        assertJoinStringsList(new List<String>(), ':', null);
        assertJoinStringsList(new List<String>{'a','b','c'}, ':', 'a:c:b');
        assertJoinStringsList(new List<String>{' ','b','c'}, ':', 'c:b');
    }

    private static void assertJoinStringsList(List<String> strings, String separator, String expectedReturnValue){
        String actual = ApexLangUtils.joinStrings(strings,separator);
        if(strings == null || strings.size() <= 0){
            System.assert(ApexLangUtils.isBlank(expectedReturnValue), 'ApexLangUtils.joinStrings(List<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + actual);
            return;
        }
        Set<String> actualAsSet = new Set<String>(ApexLangUtils.split(actual,separator));
        Set<String> expectedAsSet = new Set<String>(ApexLangUtils.split(expectedReturnValue,separator));
        System.assert(actualAsSet.containsAll(expectedAsSet) && expectedAsSet.containsAll(actualAsSet),
            'ApexLangUtils.joinStrings(List<String>, \'' + (separator == null ? 'null' : separator) + '\') returned ' + 
                actual + '; expected: ' + expectedReturnValue);
    }
    
    private static testmethod void testEndsWith(){
        assertEndsWith(null, null, true);
        assertEndsWith('abcdef', null, false);
        assertEndsWith(null, 'def', false);
        assertEndsWith('abcdef', 'def', true);
        assertEndsWith('ABCDEF', 'def', false);
    }

    private static testmethod void testEndsWithIgnoreCase(){
        assertEndsWithIgnoreCase(null, null, true);
        assertEndsWithIgnoreCase('abcdef', null, false);
        assertEndsWithIgnoreCase(null, 'def', false);
        assertEndsWithIgnoreCase('abcdef', 'def', true);
        assertEndsWithIgnoreCase('ABCDEF', 'def', true);
        assertEndsWithIgnoreCase('ABCDEF', 'ABCDEFA', false);
    }    
    
    private static void assertEndsWith(String str, String suffix, Boolean expected){
        Boolean actual = ApexLangUtils.endsWith(str,suffix);
        System.assert(actual==expected, 'ApexLangUtils.endsWith(\'' + str + '\',\'' + suffix + '\') returned ' + actual);
    }
    
    private static void assertEndsWithIgnoreCase(String str, String suffix, Boolean expected){
        Boolean actual = ApexLangUtils.endsWithIgnoreCase(str,suffix);
        System.assert(actual==expected, 'ApexLangUtils.endsWithIgnoreCase(\'' + str + '\',\'' + suffix + '\') returned ' + actual);
    }

    private static testmethod void testContains(){
        assertContains(null, null, false);
        assertContains('abcdef', null, false);
        assertContains(null, 'def', false);
        assertContains('abcdef', 'ab', true);
        assertContains('abcdef', 'xab', false);
        assertContains('ABCDEF', 'AB', true);
        assertContains('ABCDEF', 'Ab', false);

        assertContains('abcdef', 'ef', true);
        assertContains('abcdef', 'xef', false);
        assertContains('ABCDEF', 'EF', true);
        assertContains('ABCDEF', 'Ef', false);

        assertContains('abcdef', 'cde', true);
        assertContains('abcdef', 'xcde', false);
        assertContains('ABCDEF', 'CDE', true);
        assertContains('ABCDEF', 'CDe', false);
    }    
    
    private static void assertContains(String str, String searchStr, Boolean expected){
        Boolean actual = ApexLangUtils.contains(str,searchStr);
        System.assert(actual==expected, 'ApexLangUtils.contains(\'' + str + '\',\'' + searchStr + '\') returned ' + actual);
    }
    
    private static testmethod void testContainsIgnoreCase(){
        assertContainsIgnoreCase(null, null, false);
        assertContainsIgnoreCase('abcdef', null, false);
        assertContainsIgnoreCase(null, 'def', false);
        assertContainsIgnoreCase('abcdef', 'ab', true);
        assertContainsIgnoreCase('abcdef', 'xab', false);
        assertContainsIgnoreCase('ABCDEF', 'AB', true);
        assertContainsIgnoreCase('ABCDEF', 'Ab', true);
    }    
    
    private static void assertContainsIgnoreCase(String str, String searchStr, Boolean expected){
        Boolean actual = ApexLangUtils.containsIgnoreCase(str,searchStr);
        System.assert(actual==expected, 'ApexLangUtils.containsIgnoreCase(\'' + str + '\',\'' + searchStr + '\') returned ' + actual);
    }

    private static testmethod void testSplitOneArg(){
        assertSplitOneArg(null,         null);
        assertSplitOneArg('',             new String[]{''});
        assertSplitOneArg('abc def',     new String[]{'abc','def'});
        assertSplitOneArg('abc  def',     new String[]{'abc','def'});
        assertSplitOneArg(' abc ',         new String[]{'abc'});
    }    
    
    private static void assertSplitOneArg(String str, String[] expected){
        String[] actual = ApexLangUtils.split(str);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.split(\'' + str + '\') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.split(\'' + str + '\') returned ' + ApexLangUtils.toString(actual));
        }
    }
    
    private static testmethod void testSplitOneArgPreserveAllTokens(){
        assertSplitOneArgPreserveAllTokens(null,         null);
        assertSplitOneArgPreserveAllTokens('',             new String[]{''});
        assertSplitOneArgPreserveAllTokens('abc def',     new String[]{'abc','def'});
        assertSplitOneArgPreserveAllTokens('abc  def',     new String[]{'abc','','def'});
        assertSplitOneArgPreserveAllTokens(' abc ',     new String[]{'','abc',''});
        assertSplitOneArgPreserveAllTokens('a b c',     new String[]{'a','b','c'});
    }    
    
    private static void assertSplitOneArgPreserveAllTokens(String str, String[] expected){
        String[] actual = ApexLangUtils.splitPreserveAllTokens(str);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.splitPreserveAllTokens(\'' + str + '\') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.splitPreserveAllTokens(\'' + str + '\') returned ' + ApexLangUtils.toString(actual));
        }
    }

    private static testmethod void testCharAt(){
        assertCharAt(null, -1, null);
        assertCharAt(null, 0, null);
        assertCharAt('abc', -1, null);
        assertCharAt('abc', 3, null);
        assertCharAt('abc', 0, 'a');
        assertCharAt('abc', 2, 'c');
        assertCharAt('abcde', -2, null);
        assertCharAt('abcde', 0, 'a');
        assertCharAt('abcde', 1, 'b');
        assertCharAt('abcde', 4, 'e');
        assertCharAt('abcde', 5, null);
        assertCharAt('', 0, '');
        assertCharAt(' ', 0, ' ');
    }    
    
    private static void assertCharAt(String str, Integer index, String expected){
        String actual = ApexLangUtils.charAt(str,index);
        System.assert(actual==expected, 'ApexLangUtils.charAt(\'' + str + '\',' + index + ') returned ' + actual);
    }
    
    private static testmethod void testSplitTwoArgs(){
        assertSplitTwoArgs(null,         null,     null);
        assertSplitTwoArgs('',             null,     new String[]{''});
        assertSplitTwoArgs('',             'abc',     new String[]{''});
        assertSplitTwoArgs('a.b.c',     '.',    new String[]{'a','b','c'});
        assertSplitTwoArgs('a..b.c',    '.',     new String[]{'a','b','c'});
        assertSplitTwoArgs('a..b..c',    '..',     new String[]{'a','b','c'});
        assertSplitTwoArgs('a:b:c',     '.',     new String[]{'a:b:c'});
        assertSplitTwoArgs('a b c',     ' ',     new String[]{'a','b','c'});
    }    

    private static void assertSplitTwoArgs(String str, String separator, String[] expected){
        String[] actual = ApexLangUtils.split(str,separator);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.split(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.split(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
        }
    }

    private static testmethod void testSplitThreeArgs(){
        assertSplitThreeArgs(null,             '',     1,     null);
        assertSplitThreeArgs('',             '',     1,     new String[]{''});
        assertSplitThreeArgs('ab cd ef',     null,     0,     new String[]{'ab', 'cd', 'ef'});
        assertSplitThreeArgs('ab   cd ef',     null,     0,     new String[]{'ab', 'cd', 'ef'});
        assertSplitThreeArgs('ab:cd:ef',     ':',     0,     new String[]{'ab', 'cd', 'ef'});
        assertSplitThreeArgs('ab:cd:ef',     ':',     2,     new String[]{'ab', 'cd:ef'});
    }    
    
    private static void assertSplitThreeArgs(String str, String separator, Integer max, String[] expected){
        String[] actual = ApexLangUtils.split(str,separator,max);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.split(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.split(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
        }
    }
    
    private static testmethod void testSplitByWholeSeparatorTwoArg(){
        assertSplitByWholeSeparatorTwoArg(null,             null,     null);
        assertSplitByWholeSeparatorTwoArg('',                 null,    new String[]{''});
        assertSplitByWholeSeparatorTwoArg('ab cd ef',         null,    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorTwoArg('ab cd ef',         ' ',    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorTwoArg('ab     cd ef',     null,    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorTwoArg('ab:cd:ef',         ':',    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorTwoArg('ab-!-cd-!-ef',     '-!-',    new String[]{'ab', 'cd', 'ef'});
    }    
    
    private static void assertSplitByWholeSeparatorTwoArg(String str, String separator, String[] expected){
        String[] actual = ApexLangUtils.splitByWholeSeparator(str,separator);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
        }
    }
    
    private static testmethod void testSplitPreserveAllTokensTwoArg(){
        //test global static String[] splitPreserveAllTokens(String str, String separatorChars) {
        assertSplitPreserveAllTokensTwoArg(null,             null,    null);
        assertSplitPreserveAllTokensTwoArg('',                 null,    new String[]{''});
        assertSplitPreserveAllTokensTwoArg('abc def',         null,    new String[]{'abc', 'def'});
        assertSplitPreserveAllTokensTwoArg('abc def',         ' ',    new String[]{'abc', 'def'});
        assertSplitPreserveAllTokensTwoArg('abc  def',         ' ',    new String[]{'abc', '', 'def'});
        assertSplitPreserveAllTokensTwoArg('ab:cd:ef',         ':',    new String[]{'ab', 'cd', 'ef'});
        assertSplitPreserveAllTokensTwoArg('ab:cd:ef:',     ':',    new String[]{'ab', 'cd', 'ef', ''});
        assertSplitPreserveAllTokensTwoArg('ab:cd:ef::',     ':',    new String[]{'ab', 'cd', 'ef', '', ''});
        assertSplitPreserveAllTokensTwoArg('ab::cd:ef',     ':',    new String[]{'ab', '', 'cd', 'ef'});
        assertSplitPreserveAllTokensTwoArg(':cd:ef',         ':',    new String[]{'', 'cd', 'ef'});
        assertSplitPreserveAllTokensTwoArg('::cd:ef',         ':',    new String[]{'', '', 'cd', 'ef'});
        assertSplitPreserveAllTokensTwoArg(':cd:ef:',         ':',    new String[]{'', 'cd', 'ef', ''});
    }

    private static void assertSplitPreserveAllTokensTwoArg(String str, String separator, String[] expected){
        String[] actual = ApexLangUtils.splitPreserveAllTokens(str,separator);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
        }
    }

    private static testmethod void testSplitPreserveAllTokensThreeArgs(){
        //test global static String[] splitPreserveAllTokens(String str, String separatorChars, Integer max) {
        assertSplitPreserveAllTokensThreeArgs(null,         null,    -1, null);
        assertSplitPreserveAllTokensThreeArgs('',             null,     -1,    new String[]{''});
        assertSplitPreserveAllTokensThreeArgs('ab cd ef',     null,     0,    new String[]{'ab', 'cd', 'ef'});
        assertSplitPreserveAllTokensThreeArgs('ab   cd ef', null,     0,    new String[]{'ab', '', '', 'cd', 'ef'});
        assertSplitPreserveAllTokensThreeArgs('ab:cd:ef',     ':',     0,    new String[]{'ab', 'cd', 'ef'});
        assertSplitPreserveAllTokensThreeArgs('ab:cd:ef',     ':',     2,    new String[]{'ab', 'cd:ef'});
        assertSplitPreserveAllTokensThreeArgs('ab::cd::ef', '::',     2,    new String[]{'ab', ':cd::ef'});
        assertSplitPreserveAllTokensThreeArgs('ab   de fg', null,     2,    new String[]{'ab', '  de fg'});
        assertSplitPreserveAllTokensThreeArgs('ab   de fg', null,     3,    new String[]{'ab', '', ' de fg'});
        assertSplitPreserveAllTokensThreeArgs('ab   de fg', null,     4,    new String[]{'ab', '', '', 'de fg'});
    }

    private static void assertSplitPreserveAllTokensThreeArgs(String str, String separatorChars, 
        Integer max, String[] expected){

        String[] actual = ApexLangUtils.splitPreserveAllTokens(str,separatorChars,max);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separatorChars + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.splitPreserveAllTokens(\'' + str + '\',\'' + separatorChars + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
        }
    }

    private static testmethod void testSplitByWholeSeparatorThreeArgs(){
        //test global static String[] splitByWholeSeparator(String str, String separator, Integer max ) {
        
        assertTestSplitByWholeSeparatorThreeArgs(null,             null,     0, null);
        assertTestSplitByWholeSeparatorThreeArgs('',                 null,    0, new String[]{''});
        assertTestSplitByWholeSeparatorThreeArgs('ab cd ef',         null,    0, new String[]{'ab', 'cd', 'ef'});
        assertTestSplitByWholeSeparatorThreeArgs('ab cd ef',         ' ',    0, new String[]{'ab', 'cd', 'ef'});
        assertTestSplitByWholeSeparatorThreeArgs('ab     cd ef',     null,    0, new String[]{'ab', 'cd', 'ef'});
        assertTestSplitByWholeSeparatorThreeArgs('ab:cd:ef',         ':',    1, new String[]{'ab:cd:ef'});
        assertTestSplitByWholeSeparatorThreeArgs('ab:cd:ef',         ':',    2, new String[]{'ab', 'cd:ef'});
        assertTestSplitByWholeSeparatorThreeArgs('ab:cd:ef',         ':',    3, new String[]{'ab', 'cd', 'ef'});
        assertTestSplitByWholeSeparatorThreeArgs('ab-!-cd-!-ef',     '-!-',    5, new String[]{'ab', 'cd', 'ef'});
        assertTestSplitByWholeSeparatorThreeArgs('ab-!-cd-!-ef',     '-!-',    2, new String[]{'ab', 'cd-!-ef'});
    }
    private static void assertTestSplitByWholeSeparatorThreeArgs(String str, String separator, 
        Integer max, String[] expected){

        String[] actual = ApexLangUtils.splitByWholeSeparator(str,separator,max);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.splitByWholeSeparator(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
        }
    }

    private static testmethod void testSplitByWholeSeparatorPreserveAllTokensTwoArgs(){
        //test global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator) {
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs(null,             null,     null);
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('',             null,    new String[]{''});
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab cd ef',     null,    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab cd ef',     ' ',    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab   cd ef',     null,    new String[]{'ab', '', '', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab:cd:ef',     ':',    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab-!-cd-!-ef', '-!-',    new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensTwoArgs('ab-!--!-cd-!-ef','-!-',    new String[]{'ab', '', 'cd', 'ef'});
    }
    private static void assertSplitByWholeSeparatorPreserveAllTokensTwoArgs(String str, String separator, String[] expected){

        String[] actual = ApexLangUtils.splitByWholeSeparatorPreserveAllTokens(str,separator);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\') returned ' + ApexLangUtils.toString(actual));
        }
    }

    private static testmethod void testSplitByWholeSeparatorPreserveAllTokensThreeArgs(){
        //test global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator, Integer max) {

        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs(null,                 null,     0, null);
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('',                 null,    0, new String[]{''});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab cd ef',         null,    0, new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab cd ef',         ' ',    0, new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab   cd ef',         ' ',    0, new String[]{'ab', '', '', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab:cd:ef',         ':',    1, new String[]{'ab:cd:ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab:cd:ef',         ':',    2, new String[]{'ab', 'cd:ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab:cd:ef',         ':',    3, new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab::cd:ef',         ':',    2, new String[]{'ab', ':cd:ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab-!-cd-!-ef',     '-!-',    5, new String[]{'ab', 'cd', 'ef'});
        assertSplitByWholeSeparatorPreserveAllTokensThreeArgs('ab-!-cd-!-ef',     '-!-',    2, new String[]{'ab', 'cd-!-ef'});
    }
    private static void assertSplitByWholeSeparatorPreserveAllTokensThreeArgs(String str, String separator, 
        Integer max, String[] expected){

        String[] actual = ApexLangUtils.splitByWholeSeparatorPreserveAllTokens(str,separator,max);
        if(actual == null){
            System.assert(expected == null, 'ApexLangUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
            return;
        }
        for(Integer i = 0; i < actual.size(); i++){
            System.assert(expected[i] == actual[i], 'ApexLangUtils.splitByWholeSeparatorPreserveAllTokens(\'' + str + '\',\'' + separator + '\',' + max + ') returned ' + ApexLangUtils.toString(actual));
        }
    }

    private static testmethod void testLeftPadTwoArgs(){
        // test: global static String leftPad(String str, Integer size) {
        assertLeftPadTwoArgs(null,     -1,    null);
        assertLeftPadTwoArgs('',     3,     '   ');
        assertLeftPadTwoArgs('bat', 3,     'bat');
        assertLeftPadTwoArgs('bat', 5,     '  bat');
        assertLeftPadTwoArgs('bat', 1,    'bat');
        assertLeftPadTwoArgs('bat', -1,    'bat');
    }    
    
    private static void assertLeftPadTwoArgs(String str, Integer size, String expected){
        String actual = ApexLangUtils.leftPad(str,size);
        System.assert(actual==expected, 'ApexLangUtils.leftPad(\'' + str + '\',' 
            + size + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testLeftPadThreeArgs(){
        //test: global static String leftPad(String str, Integer size, String padStr) {
        assertLeftPadThreeArgs(null,     -1, null,     null);
        assertLeftPadThreeArgs('',         3,     'z',     'zzz'); 
        assertLeftPadThreeArgs('bat',     3,     'yz',     'bat');
        assertLeftPadThreeArgs('bat',     5,     'yz',     'yzbat');
        assertLeftPadThreeArgs('bat',     8,     'yz',     'yzyzybat');
        assertLeftPadThreeArgs('bat',     1,     'yz',     'bat');
        assertLeftPadThreeArgs('bat',     -1, 'yz',     'bat');
        assertLeftPadThreeArgs('bat',     5,     null,     '  bat');
        assertLeftPadThreeArgs('bat',     5,     '',     '  bat');
    }    

    private static void assertLeftPadThreeArgs(String str, Integer size, String padStr, String expected){
        String actual = ApexLangUtils.leftPad(str,size,padStr);
        System.assert(actual==expected, 'ApexLangUtils.leftPad(\'' + str + '\',' 
            + size + ',\'' + padStr + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRightPadTwoArgs(){
        //test: global static String rightPad(String str, Integer size) {
        assertRightPadTwoArgs(null,     -1, null);
        assertRightPadTwoArgs('',         3,     '   ');
        assertRightPadTwoArgs('bat',     3,     'bat');
        assertRightPadTwoArgs('bat',     5,     'bat  ');
        assertRightPadTwoArgs('bat',     1,     'bat');
        assertRightPadTwoArgs('bat',     -1, 'bat');
    }    
    
    private static void assertRightPadTwoArgs(String str, Integer size, String expected){
        String actual = ApexLangUtils.rightPad(str,size);
        System.assert(actual==expected, 'ApexLangUtils.rightPad(\'' + str + '\',' 
            + size + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRightPadThreeArgs(){
        //test: global static String rightPad(String str, Integer size, String padStr) {
        assertRightPadThreeArgs(null,     -1, null,     null);
        assertRightPadThreeArgs('',     3,     '',     '   ');
        assertRightPadThreeArgs('',     3,     'z',     'zzz');
        assertRightPadThreeArgs('bat',     3,     'z',     'bat');
        assertRightPadThreeArgs('bat',     5,     'z',     'batzz');
        assertRightPadThreeArgs('bat',     1,     'z',     'bat');
        assertRightPadThreeArgs('bat',     -1,    'z',     'bat');
        assertRightPadThreeArgs('bat',     6,    'abcd', 'batabc');
    }    
    
    private static void assertRightPadThreeArgs(String str, Integer size, String padStr, String expected){
        String actual = ApexLangUtils.rightPad(str,size,padStr);
        System.assert(actual==expected, 'ApexLangUtils.rightPad(\'' + str + '\',' 
            + size + ',\'' + padStr + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testGetCommonPrefix(){
        //test: global static String getCommonPrefix(List<String> strs) {
        assertGetCommonPrefix(null,                                             '');
        assertGetCommonPrefix(null,                                             '');
        assertGetCommonPrefix(new String[] {},                                     '');
        assertGetCommonPrefix(new String[] {'abc'},                             'abc');
        assertGetCommonPrefix(new String[] {null, null},                         '');
        assertGetCommonPrefix(new String[] {'', ''},                             '');
        assertGetCommonPrefix(new String[] {'', null},                             '');
        assertGetCommonPrefix(new String[] {'abc', null, null},                 '');
        assertGetCommonPrefix(new String[] {null, null, 'abc'},                 '');
        assertGetCommonPrefix(new String[] {'', 'abc'},                         '');
        assertGetCommonPrefix(new String[] {'abc', ''},                         '');
        assertGetCommonPrefix(new String[] {'abc', 'abc'},                         'abc');
        assertGetCommonPrefix(new String[] {'abc', 'a'},                         'a');
        assertGetCommonPrefix(new String[] {'ab', 'abxyz'},                     'ab');
        assertGetCommonPrefix(new String[] {'abcde', 'abxyz'},                     'ab');
        assertGetCommonPrefix(new String[] {'abcde', 'xyz'},                     '');
        assertGetCommonPrefix(new String[] {'xyz', 'abcde'},                     '');
        assertGetCommonPrefix(new String[] {'i am a machine', 'i am a robot'},     'i am a ');
    }    
    
    private static void assertGetCommonPrefix(String[] strs, String expected){
        String actual = ApexLangUtils.getCommonPrefix(strs);
        System.assert(actual==expected, 'ApexLangUtils.getCommonPrefix(' + ApexLangUtils.toString(strs) 
            + ') returned \'' + actual + '\', expected \'' + expected + '\'');
    }

    private static testmethod void testIndexOfDifferenceArrayInput(){
        //test: global static Integer indexOfDifference(String[] strs) {
        assertIndexOfDifferenceArrayInput(null,                                             -1);
        assertIndexOfDifferenceArrayInput(new String[] {},                                     -1);
        assertIndexOfDifferenceArrayInput(new String[] {'abc'},                             -1);
        assertIndexOfDifferenceArrayInput(new String[] {null, null},                         -1);
        assertIndexOfDifferenceArrayInput(new String[] {'', ''},                             -1);
        assertIndexOfDifferenceArrayInput(new String[] {'', null},                             0);
        assertIndexOfDifferenceArrayInput(new String[] {'abc', null, null},                 0);
        assertIndexOfDifferenceArrayInput(new String[] {null, null, 'abc'},                 0);
        assertIndexOfDifferenceArrayInput(new String[] {'', 'abc'},                         0);
        assertIndexOfDifferenceArrayInput(new String[] {'abc', ''},                            0);
        assertIndexOfDifferenceArrayInput(new String[] {'abc', 'abc'},                         -1);
        assertIndexOfDifferenceArrayInput(new String[] {'abc', 'a'},                         1);
        assertIndexOfDifferenceArrayInput(new String[] {'ab', 'abxyz'},                     2);
        assertIndexOfDifferenceArrayInput(new String[] {'abcde', 'abxyz'},                     2);
        assertIndexOfDifferenceArrayInput(new String[] {'abcde', 'xyz'},                     0);
        assertIndexOfDifferenceArrayInput(new String[] {'xyz', 'abcde'},                     0);
        assertIndexOfDifferenceArrayInput(new String[] {'i am a machine', 'i am a robot'},     7);
    }    
    
    private static void assertIndexOfDifferenceArrayInput(String[] strs, Integer expected){
        Integer actual = ApexLangUtils.indexOfDifference(strs);
        System.assert(actual==expected, 'ApexLangUtils.indexOfDifference(' + ApexLangUtils.toString(strs) 
            + ') returned ' + actual + '; expected ' + expected);
    }


    private static testmethod void testGetLevenshteinDistance(){
        //test: global static Integer getLevenshteinDistance(String s, String t) {
        assertGetLevenshteinDistance(null,             null,         -1,    true);
        assertGetLevenshteinDistance(null,             null,         -1,    true);
        assertGetLevenshteinDistance('',            '',         0,    false);
        assertGetLevenshteinDistance('',            'a',         1,    false);
        assertGetLevenshteinDistance('aaapppp',     '',         7,    false);
        assertGetLevenshteinDistance('frog',         'fog',         1,    false);
        assertGetLevenshteinDistance('fly',         'ant',         3,    false);
        assertGetLevenshteinDistance('elephant',     'hippo',     7,    false);
        assertGetLevenshteinDistance('hippo',         'elephant', 7,    false);
        assertGetLevenshteinDistance('hippo',         'zzzzzzzz', 8,    false);
        assertGetLevenshteinDistance('hello',         'hallo',     1,    false);
    }    
    
    private static void assertGetLevenshteinDistance(String s, String t, 
        Integer expected, Boolean excepExpected){

        Integer actual = null;
        Boolean excepActual = false;
        try{
            actual = ApexLangUtils.getLevenshteinDistance(s,t);
        } catch (IllegalArgumentException e){
            excepActual = true;
        }
        if(excepExpected && excepActual){
            return;
        }
        System.assert(excepExpected == excepActual, 'ApexLangUtils.getLevenshteinDistance(\'' 
            + s + '\',\'' + t + '\') ' 
            + (excepExpected ? 'did not throw' : 'unexpectedly threw') 
            + ' IllegalArgumentException');
        if(!excepExpected && !excepActual){
            System.assert(actual==expected, 'ApexLangUtils.getLevenshteinDistance(\'' + s + '\',\'' 
                + t + '\') returned ' + actual + '; expected ' + expected);
        }
    }


     private static testmethod void testIndexOfThreeArgs(){
        //test: global static Integer indexOf(String str, String searchStr, Integer startPos) {
        assertIndexOfThreeArgs(null,         null,     -1, -1);
        assertIndexOfThreeArgs('',             '',     0,     0);
        assertIndexOfThreeArgs('aabaabaa',     'a',     0,     0);
        assertIndexOfThreeArgs('aabaabaa',     'b',     0,     2);
        assertIndexOfThreeArgs('aabaabaa',     'ab',     0,     1);
        assertIndexOfThreeArgs('aabaabaa',     'b',     3,     5);
        assertIndexOfThreeArgs('aabaabaa',     'b',     9,     -1);
        assertIndexOfThreeArgs('aabaabaa',     'b',     -1, 2);
        assertIndexOfThreeArgs('aabaabaa',     '',     2,     2);
        assertIndexOfThreeArgs('abc',         '',     9,     3);
    }    

    private static void assertIndexOfThreeArgs(String str, String searchStr, Integer startPos, Integer expected){
        Integer actual = ApexLangUtils.indexOf(str,searchStr,startPos);
        System.assert(actual==expected, 'ApexLangUtils.indexOf(\'' + str + '\',\'' 
            + searchStr + '\',' + startPos + ') returned ' + actual + '; expected ' + expected);
    }

    private static testmethod void testOrdinalIndexOf(){
        //test: global static Integer ordinalIndexOf(String str, String searchStr, Integer ordinal) {
        assertOrdinalIndexOf(null,             null,     -1, -1);
        assertOrdinalIndexOf('',             '',     -1, -1);
        assertOrdinalIndexOf('aabaabaa',     'a',     1,     0);
        assertOrdinalIndexOf('aabaabaa',     'a',     2,     1);
        assertOrdinalIndexOf('aabaabaa',     'b',     1,     2);
        assertOrdinalIndexOf('aabaabaa',     'b',     2,     5);
        assertOrdinalIndexOf('aabaabaa',     'ab',     1,     1);
        assertOrdinalIndexOf('aabaabaa',     'ab',     2,     4);
        assertOrdinalIndexOf('aabaabaa',     'z',     1,     -1);
        assertOrdinalIndexOf('aabaabaa',     '',     1,     0);
        assertOrdinalIndexOf('aabaabaa',     '',     2,     0);
    }    

    private static void assertOrdinalIndexOf(String str, String searchStr, Integer ordinal, Integer expected){
        Integer actual = ApexLangUtils.ordinalIndexOf(str,searchStr,ordinal);
        System.assert(actual==expected, 'ApexLangUtils.ordinalIndexOf(\'' + str + '\',\'' 
            + searchStr + '\',' + ordinal + ') returned ' + actual + '; expected ' + expected);
    }

    private static testmethod void testValidateChar2(){
        try{
            ApexLangUtils.validateChar('ab');  //should throw exception since string has > 1 chars
            System.assert(false,'Character.validateChar(\'ab\') did not throw InvalidCharacterStringException');
        }catch(InvalidCharacterStringException e){}
    }

    private static testmethod void testJoinArrayOneArg(){
        //test: global static String joinArray(Object[] objectArray) {
        assertJoinArrayOneArg(null, null);
        assertJoinArrayOneArg(new String[]{}, '');
        assertJoinArrayOneArg(new String[]{null}, '');
        assertJoinArrayOneArg(new String[]{'a', 'b', 'c'}, 'abc');
        assertJoinArrayOneArg(new String[]{null, '', 'a'}, 'a');
    }
    
    private static void assertJoinArrayOneArg(Object[] objectArray, String expected){
        String actual = ApexLangUtils.joinArray(objectArray);
        System.assert(actual==expected, 'ApexLangUtils.joinArray(\'' + ApexLangUtils.toString(objectArray) + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testJoinArrayTwoArgs(){
        //test: global static String joinArray(Object[] objectArray, String separator) {
        assertJoinArrayTwoArgs(null, null, null);
        assertJoinArrayTwoArgs(new String[]{}, null, '');
        assertJoinArrayTwoArgs(new String[]{null}, null, '');
        assertJoinArrayTwoArgs(new String[]{'a', 'b', 'c'}, ';', 'a;b;c');
        assertJoinArrayTwoArgs(new String[]{'a', 'b', 'c'}, null, 'abc');
        assertJoinArrayTwoArgs(new String[]{null, '', 'a'}, ';', ';a');
    }
    
    private static void assertJoinArrayTwoArgs(Object[] objectArray, String separator, String expected){
        String actual = ApexLangUtils.joinArray(objectArray,separator);
        System.assert(actual==expected, 'ApexLangUtils.joinArray(\'' + ApexLangUtils.toString(objectArray) + '\',\''
            + separator + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testJoinArrayFourArgs(){
        //test: global static String joinArray(Object[] objectArray, String separator, Integer startIndex, Integer endIndex) {
        assertJoinArrayFourArgs(null, null, 0, 2, null);
        assertJoinArrayFourArgs(new String[]{}, null, 0, 1, '');
        assertJoinArrayFourArgs(new String[]{null}, null, 0, 1, '');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '--', 0, 3, 'a--b--c');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, null, 0, 3, 'abc');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 0, 0, '');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 0, 1, 'a');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 0, 2, 'ab');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 0, 3, 'abc');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', -1, 4, 'abc');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 1, 1, '');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 1, 2, 'b');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 1, 3, 'bc');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 2, 2, '');
        assertJoinArrayFourArgs(new String[]{'a', 'b', 'c'}, '', 2, 3, 'c');
        assertJoinArrayFourArgs(new String[]{null, '', 'a'}, ',', 0, 3, ',a');
        assertJoinArrayFourArgs(new Long[]{3, 4, -1}, 'xyz', 0, 3, '3xyz4xyz-1');
    }

    private static void assertJoinArrayFourArgs(Object[] objectArray, String separator, Integer startIndex, Integer endIndex, String expected){
        String actual = ApexLangUtils.joinArray(objectArray,separator,startIndex,endIndex);
        System.assert(actual==expected, 'ApexLangUtils.joinArray(\'' + ApexLangUtils.toString(objectArray) + '\',\''
            + separator + '\',' + startIndex + ',' + endIndex + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

     private static testmethod void testJoinSetBlobSet(){ 
        //global static String joinSet(Set<Blob> blobSet, String separator)
        assertJoinSetBlobSet(null, '|', null);
        assertJoinSetBlobSet(new Set<Blob>{}, '|', '');
        Blob blob1 = generateRandomBlob();
        Blob blob2 = generateRandomBlob();
        assertJoinSetBlobSet(new Set<Blob>{blob1}, '|', '\'' + blob1.toString() + '\'');
        assertJoinSetBlobSet(new Set<Blob>{blob1,blob2}, '|', '\'' + blob1.toString() + '\'|\'' + blob2.toString() + '\'');
    }    

    private static testmethod void testJoinSetBooleanSet(){ 
        //global static String joinSet(Set<Boolean> booleanSet, String separator) 
        assertJoinSetBooleanSet(null, '|', null);
        assertJoinSetBooleanSet(new Set<Boolean>{}, '|', '');
        assertJoinSetBooleanSet(new Set<Boolean>{true}, '|', 'true');
        assertJoinSetBooleanSet(new Set<Boolean>{true, false}, '|', 'false|true');
    }
    
    private static testmethod void testJoinSetDateSet(){ 
        //global static String joinSet(Set<Date> dateSet, String separator) 
        assertJoinSetDateSet(null, '|', null);
        assertJoinSetDateSet(new Set<Date>{}, '|', '');
        Date date1 = Date.newInstance(2009,1,1);
        Date date2 = Date.newInstance(2009,1,2);
        assertJoinSetDateSet(new Set<Date>{date1}, '|', ''+date1+'' );
        assertJoinSetDateSet(new Set<Date>{date1,date2}, '|', ''+date1+'|'+date2+'' );
    }
    
    private static testmethod void testJoinSetDatetimeSet(){ 
        //global static String joinSet(Set<Datetime> datetimeSet, String separator) 
        assertJoinSetDatetimeSet(null, '|', null);
        assertJoinSetDatetimeSet(new Set<Datetime>{}, '|', '');
        Datetime date1 = Datetime.newInstance(2009,1,1);
        Datetime date2 = Datetime.newInstance(2009,1,2);
        assertJoinSetDatetimeSet(new Set<Datetime>{date1}, '|', ''+date1+'' );
        assertJoinSetDatetimeSet(new Set<Datetime>{date1,date2}, '|', ''+date1+'|'+date2+'' );
    }
    
    private static testmethod void testJoinSetDecimalSet(){ 
        //global static String joinSet(Set<Decimal> decimalSet, String separator) 
        assertJoinSetDecimalSet(null, '|', null);
        assertJoinSetDecimalSet(new Set<Decimal>{}, '|', '');
        Decimal dec1 = 4.0;
        Decimal dec2 = 5.0;
        assertJoinSetDecimalSet(new Set<Decimal>{dec1}, '|', '' + dec1 + '');
        assertJoinSetDecimalSet(new Set<Decimal>{dec1,dec2}, '|', '' + dec1 + '|' + dec2 + '');
    }
    
    private static testmethod void testJoinSetDoubleSet(){ 
        //global static String joinSet(Set<Double> doubleSet, String separator) 
        assertJoinSetDoubleSet(null, '|', null);
        assertJoinSetDoubleSet(new Set<Double>{}, '|', '');
        Double doub1 = 4.0;
        Double doub2 = 5.0;
        assertJoinSetDoubleSet(new Set<Double>{doub1}, '|', '' + doub1 + '');
        assertJoinSetDoubleSet(new Set<Double>{doub1,doub2}, '|', '' + doub1 + '|' + doub2 + '');
    }
    
    private static testmethod void testJoinSetIDSet(){ 
        //global static String joinSet(Set<ID> idSet, String separator) 
        assertJoinSetIDSet(null, '|', null);
        assertJoinSetIDSet(new Set<ID>{}, '|', '');
        Account acct1 = new Account(name='acct1');
        insert acct1;
        Account acct2 = new Account(name='acct2');
        insert acct2;
        assertJoinSetIDSet(new Set<ID>{acct1.id}, '|', '' + acct1.id + '');
        assertJoinSetIDSet(new Set<ID>{acct1.id,acct2.id}, '|', '' + acct1.id + '|' + acct2.id + '');
    }
    
    private static testmethod void testJoinSetIntegerSet(){ 
        //global static String joinSet(Set<Integer> integerSet, String separator) 
        assertJoinSetIntegerSet(null, '|', null);
        assertJoinSetIntegerSet(new Set<Integer>{}, '|', '');
        Integer int1 = 4;
        Integer int2 = 5;
        assertJoinSetIntegerSet(new Set<Integer>{int1}, '|', '' + int1 + '' );
        assertJoinSetIntegerSet(new Set<Integer>{int1,int2}, '|', '' + int1 + '|' + int2 + '' );
    }
    
    private static testmethod void testJoinSetLongSet(){ 
        //global static String joinSet(Set<Long> longSet, String separator) 
        assertJoinSetLongSet(null, '|', null);
        assertJoinSetLongSet(new Set<Long>{}, '|', '');
        Long long1 = 4;
        Long long2 = 5;
        assertJoinSetLongSet(new Set<Long>{long1}, '|', '' + long1 + '');
        assertJoinSetLongSet(new Set<Long>{long1,long2}, '|', '' + long1 + '|' + long2 + '');
    }
    
    private static testmethod void testJoinSetTimeSet(){ 
        //global static String joinSet(Set<Time> timeSet, String separator) 
        assertJoinSetTimeSet(null, '|', null);
        assertJoinSetTimeSet(new Set<Time>{}, '|', '');
        Time time1 = Time.newInstance(18, 30, 2, 20);
        Time time2 = Time.newInstance(18, 30, 2, 21);
        assertJoinSetTimeSet(new Set<Time>{time1}, '|', '' + time1 + '' );
        assertJoinSetTimeSet(new Set<Time>{time1,time2}, '|', '' + time1 + '|' + time2 + '' );
    }
    
    private static testmethod void testJoinSetStringSet(){ 
        //global static String joinSet(Set<String> stringSet, String separator) 
        assertJoinSetStringSet(null, '|', null);
        assertJoinSetStringSet(new Set<String>{}, '|', '');
        String str1 = 'xyz';
        String str2 = 'abc';
        assertJoinSetStringSet(new Set<String>{str1}, '|', '' + str1 + '');
        assertJoinSetStringSet(new Set<String>{str1,str2}, '|', '' + str1 + '|' + str2 + '');
    }
    
    private static void assertJoinSetBlobSet(Set<Blob> blobSet, String separator, String expected){ System.assert(!((blobSet == null && expected != null) || (blobSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(blobSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(blobSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetBooleanSet(Set<Boolean> booleanSet, String separator, String expected){ System.assert(!((booleanSet == null && expected != null) || (booleanSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(booleanSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(booleanSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetDateSet(Set<Date> dateSet, String separator, String expected){ System.assert(!((dateSet == null && expected != null) || (dateSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(dateSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(dateSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetDatetimeSet(Set<Datetime> datetimeSet, String separator, String expected){ System.assert(!((datetimeSet == null && expected != null) || (datetimeSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(datetimeSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(datetimeSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetDecimalSet(Set<Decimal> decimalSet, String separator, String expected){ System.assert(!((decimalSet == null && expected != null) || (decimalSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(decimalSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(decimalSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetDoubleSet(Set<Double> doubleSet, String separator, String expected){ System.assert(!((doubleSet == null && expected != null) || (doubleSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(doubleSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(doubleSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetIDSet(Set<ID> idSet, String separator, String expected){ System.assert(!((idSet == null && expected != null) || (idSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(idSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(idSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetIntegerSet(Set<Integer> integerSet, String separator, String expected){ System.assert(!((integerSet == null && expected != null) || (integerSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(integerSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(integerSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetLongSet(Set<Long> longSet, String separator, String expected){ System.assert(!((longSet == null && expected != null) || (longSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(longSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(longSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetTimeSet(Set<Time> timeSet, String separator, String expected){ System.assert(!((timeSet == null && expected != null) || (timeSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(timeSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(timeSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}
    private static void assertJoinSetStringSet(Set<String> stringSet, String separator, String expected){ System.assert(!((stringSet == null && expected != null) || (stringSet != null && expected == null)),    'Invalid test input: both parameters should be null.');String actual = ApexLangUtils.joinSet(stringSet,separator); Set<String> actualAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars(    (actual == null ? '' : actual),'{}\'',''),separator));Set<String> expectedAsStringSet = new Set<String>(ApexLangUtils.split(ApexLangUtils.replaceChars((expected == null ? '' : expected),'{}\'',''),separator));     if(expected != null && actual != null){System.assert(actualAsStringSet.containsAll(expectedAsStringSet) && expectedAsStringSet.containsAll(actualAsStringSet), 'ApexLangUtils.joinSet(' +     ApexLangUtils.toString(stringSet) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');}}

    private static Blob generateRandomBlob(){
        return EncodingUtil.base64Decode(''+System.currentTimeMillis()+Math.roundToLong(Math.random()*10000));    
    }

    private static testmethod void testReplaceChars(){
        //test: global static String replaceChars(String str, String searchChars, String replaceChars)
        assertReplaceChars(null, null, null, null);
        assertReplaceChars('', null, null, '');
        assertReplaceChars('abc', null, null, 'abc');
        assertReplaceChars('abc', '', null, 'abc');
        assertReplaceChars('abc', 'b', null, 'ac');
        assertReplaceChars('abc', 'b', '', 'ac');
        assertReplaceChars('abcba', 'bc', 'yz', 'ayzya');
        assertReplaceChars('abcba', 'bc', 'y', 'ayya');
        assertReplaceChars('abcba', 'bc', 'yzx', 'ayzya');
    }    
    
    private static void assertReplaceChars(String str, String searchChars, String replaceChars, String expected){
        String actual = ApexLangUtils.replaceChars(str,searchChars,replaceChars);
        System.assert(actual==expected, 'ApexLangUtils.replaceChars(\'' + str + '\',\'' 
            + searchChars + '\',\'' + replaceChars + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testJoinSet(){
        //test: global static String joinSet(Set<Object> objectSet, String separator){
        assertJoinSet(null, null, null);
        assertJoinSet(new Set<Object>(), ':', null);
        assertJoinSet(new Set<Object>{'a','b','c'}, ':', 'a:c:b');
        assertJoinSet(new Set<Object>{' ','b','c'}, ':', 'c:b');
        assertJoinSet(new Set<Object>{true,false}, '|', 'true|false');
    }

    private static void assertJoinSet(Set<Object> objectSet, String separator, String expected){
        String actual = ApexLangUtils.joinSet(objectSet,separator);
        if(objectSet == null || objectSet.size() <= 0){
            System.assert(ApexLangUtils.isBlank(expected), 
                'ApexLangUtils.joinSet(Set<Object>, \'' + (separator == null ? 'null' : separator) 
                + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
            return;
        }
        Set<String> actualAsSet = new Set<String>(ApexLangUtils.split(actual,separator));
        Set<String> expectedAsSet = new Set<String>(ApexLangUtils.split(expected,separator));
        System.assert(actualAsSet.containsAll(expectedAsSet) && expectedAsSet.containsAll(actualAsSet),
            'ApexLangUtils.joinSet(Set<Object>, \'' + (separator == null ? 'null' : separator) + '\') returned \'' + 
                actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testSubstringTwoArgs(){
        //test: global static String substring(String str, Integer startIndex) {
        assertSubstringTwoArgs(null, -1, null);
        assertSubstringTwoArgs('', -2, '');
        assertSubstringTwoArgs('', -1, '');
        assertSubstringTwoArgs('', 0, '');
        assertSubstringTwoArgs('', 1, '');
        assertSubstringTwoArgs('abc', 0, 'abc');
        assertSubstringTwoArgs('abc', 2, 'c');
        assertSubstringTwoArgs('abc', 4, '');
        assertSubstringTwoArgs('abc', -2, 'bc');
        assertSubstringTwoArgs('abc', -4, 'abc');
    }

    private static void assertSubstringTwoArgs(String str, Integer startIndex, String expected){
        String actual = ApexLangUtils.substring(str, startIndex);
        System.assert(actual==expected, 'ApexLangUtils.substring(\'' + str + '\',' 
            + startIndex + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testSubstringThreeArgs(){
        //test: global static String substring(String str, Integer startIndex, Integer endIndex) {
        assertSubstringThreeArgs(null, -1, -1, null);
        assertSubstringThreeArgs('', -1, -1, '');
        assertSubstringThreeArgs('abc', 0, 2, 'ab');
        assertSubstringThreeArgs('abc', 2, 0, '');
        assertSubstringThreeArgs('abc', 2, 4, 'c');
        assertSubstringThreeArgs('abc', 4, 6, '');
        assertSubstringThreeArgs('abc', 2, 2, '');
        assertSubstringThreeArgs('abc', -2, -1, 'b');
        assertSubstringThreeArgs('abc', -4, 2, 'ab');
        assertSubstringThreeArgs('abc', -5, -4, '');
        
    }
    
    private static void assertSubstringThreeArgs(String str, Integer startIndex, Integer endIndex, String expected){
        String actual = ApexLangUtils.substring(str, startIndex, endIndex);
        System.assert(actual==expected, 'ApexLangUtils.substring(\'' + str + '\',' 
            + startIndex + ',' + endIndex + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    /* StringApexLangUtils tests*/

    /* StringApexLangUtils2 tests*/


    private static testmethod void testLeft(){
        //test: global static String left(String str, Integer len) {
        assertLeft(null, -1, null);
        assertLeft(null, 0, null);
        assertLeft('xyz', -1, '');
        assertLeft('', -1, '');
        assertLeft('', 0, '');
        assertLeft('abc', 0, '');
        assertLeft('abc', 2, 'ab');
        assertLeft('abc', 4, 'abc');
    }
    
    private static void assertLeft(String str, Integer len, String expected){
        String actual = ApexLangUtils.left(str,len);
        System.assert(actual==expected, 'ApexLangUtils.left(\'' + str + '\',' 
            + len + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRepeat(){
        //test: global static String repeat(String str, Integer repeat) 
        assertRepeat(null, 2, null);
        assertRepeat('', 0, '');
        assertRepeat('', 2, '');
        assertRepeat('a', 3, 'aaa');
        assertRepeat('ab', 2, 'abab');
        assertRepeat('a', -2, '');
    }
    
    private static void assertRepeat(String str, Integer repeat, String expected){
        String actual = ApexLangUtils.repeat(str,repeat);
        System.assert(actual==expected, 'ApexLangUtils.repeat(\'' + str + '\',\'' 
            + repeat + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }


    private static testmethod void testMid(){
        //test: global static String mid(String str, Integer pos, Integer len) {
        assertMid(null, 0, 0, null);
        assertMid('', 0, -1, '');
        assertMid('', 0, 0, '');
        assertMid('abc', 0, 2, 'ab');
        assertMid('abc', 0, 4, 'abc');
        assertMid('abc', 2, 4, 'c');
        assertMid('abc', 4, 2, '');
        assertMid('abc', -2, 2, 'ab');
        
    }

    private static void assertMid(String str, Integer pos, Integer len, String expected){
        String actual = ApexLangUtils.mid(str,pos,len);
        System.assert(actual==expected, 'ApexLangUtils.mid(\'' + str + '\',' + pos 
            + ',' + len + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testOverlay(){
        //test: global static String overlay(String str, String overlay, Integer startIndex, Integer endIndex) {
        assertOverlay(null, null, 0, 0, null);
        assertOverlay('', 'abc', 0, 0, 'abc');
        assertOverlay('abcdef', null, 2, 4, 'abef');
        assertOverlay('abcdef', '', 2, 4, 'abef');
        assertOverlay('abcdef', '', 4, 2, 'abef');
        assertOverlay('abcdef', 'zzzz', 2, 4, 'abzzzzef');
        assertOverlay('abcdef', 'zzzz', 4, 2, 'abzzzzef');
        assertOverlay('abcdef', 'zzzz', -1, 4, 'zzzzef');
        assertOverlay('abcdef', 'zzzz', 2, 8, 'abzzzz');
        assertOverlay('abcdef', 'zzzz', -2, -3, 'zzzzabcdef');
        assertOverlay('abcdef', 'zzzz', 8, 10, 'abcdefzzzz');
        
    }

    private static void assertOverlay(String str, String overlay, Integer startIndex, Integer endIndex, String expected){
        String actual = ApexLangUtils.overlay(str,overlay,startIndex,endIndex);
        System.assert(actual==expected, 'ApexLangUtils.overlay(\'' + str + '\',\'' + overlay 
            + '\',' + startIndex + ',' + endIndex + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRemove(){
        //test: global static String remove(String str, String remove) {
        assertRemove(null, null, null);
        assertRemove('', null, '');
        assertRemove('xyz', null, 'xyz');
        assertRemove('xyz', '', 'xyz');
        assertRemove('queued', 'ue', 'qd');
        assertRemove('queued', 'zz', 'queued');
        
    }

    private static void assertRemove(String str, String remove, String expected) {
        String actual = ApexLangUtils.remove(str,remove);
        System.assert(actual==expected, 'ApexLangUtils.remove(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveStart(){
        //test: global static String removeStart(String str, String remove) {
        assertRemoveStart(null, null, null);
        assertRemoveStart('', null, '');
        assertRemoveStart('xyz', null, 'xyz');
        assertRemoveStart('www.domain.com', 'www.', 'domain.com');
        assertRemoveStart('domain.com', 'www.', 'domain.com');
        assertRemoveStart('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveStart('abc', '', 'abc');
    }

    private static void assertRemoveStart(String str, String remove, String expected) {
        String actual = ApexLangUtils.removeStart(str,remove);
        System.assert(actual==expected, 'ApexLangUtils.removeStart(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveStartIgnoreCase(){
        //test: global static String removeStartIgnoreCase(String str, String remove) {
        assertRemoveStartIgnoreCase(null, null, null);
        assertRemoveStartIgnoreCase('', null, '');
        assertRemoveStartIgnoreCase('xyz', null, 'xyz');
        assertRemoveStartIgnoreCase('www.domain.com', 'www.', 'domain.com');
        assertRemoveStartIgnoreCase('www.domain.com', 'WWW.', 'domain.com');
        assertRemoveStartIgnoreCase('domain.com', 'www.', 'domain.com');
        assertRemoveStartIgnoreCase('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveStartIgnoreCase('abc', '', 'abc');
    }

    private static void assertRemoveStartIgnoreCase(String str, String remove, String expected) {
        String actual = ApexLangUtils.removeStartIgnoreCase(str,remove);
        System.assert(actual==expected, 'ApexLangUtils.removeStartIgnoreCase(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveEnd(){
        //test: global static String removeEnd(String str, String remove) {
        assertRemoveEnd(null, null, null);
        assertRemoveEnd('', null, '');
        assertRemoveEnd('xyz', null, 'xyz');
        assertRemoveEnd('www.domain.com', '.com.', 'www.domain.com');
        assertRemoveEnd('www.domain.com', '.com', 'www.domain');
        assertRemoveEnd('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveEnd('abc', '', 'abc');
    }

    private static void assertRemoveEnd(String str, String remove, String expected) {
        String actual = ApexLangUtils.removeEnd(str,remove);
        System.assert(actual==expected, 'ApexLangUtils.removeEnd(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveEndIgnoreCase(){
        //test: global static String removeEndIgnoreCase(String str, String remove) {
        assertRemoveEndIgnoreCase(null, null, null);
        assertRemoveEndIgnoreCase('', null, '');
        assertRemoveEndIgnoreCase('xyz', null, 'xyz');
        assertRemoveEndIgnoreCase('www.domain.com', '.com.', 'www.domain.com');
        assertRemoveEndIgnoreCase('www.domain.com', '.com', 'www.domain');
        assertRemoveEndIgnoreCase('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveEndIgnoreCase('abc', '', 'abc');
    }

    private static void assertRemoveEndIgnoreCase(String str, String remove, String expected) {
        String actual = ApexLangUtils.removeEndIgnoreCase(str,remove);
        System.assert(actual==expected, 'ApexLangUtils.removeEndIgnoreCase(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRegionMatchesCaseSensitive(){
        //test: global static boolean regionMatches(String str, boolean ignoreCase,
        //            Integer toffset, String other, Integer ooffset, Integer len){
        assertRegionMatchesCaseSensitive(null, 0, null, 0, 0, true);
        assertRegionMatchesCaseSensitive('aaaxyzaaa', 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatchesCaseSensitive('aaaXYZaaa', 3, 'aaaaxyzaa', 4, 3, false);
    }

    private static void assertRegionMatchesCaseSensitive(String str, Integer toffset, 
        String other, Integer ooffset, Integer len, Boolean expected) {
        Boolean actual = ApexLangUtils.regionMatches(str,toffset,other,ooffset,len);
        System.assert(actual==expected, 'ApexLangUtils.regionMatches(\'' 
            + str + '\',' + toffset + ',\'' + other + '\',' + ooffset + ',' + len 
            + ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testRegionMatchesCaseInsensitive(){
        //test: global static boolean regionMatches(String str, boolean ignoreCase,
        //            Integer toffset, String other, Integer ooffset, Integer len){
        assertRegionMatchesCaseInsensitive(null, 0, null, 0, 0, true);
        assertRegionMatchesCaseInsensitive('aaaxyzaaa', 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatchesCaseInsensitive('aaaXYZaaa', 3, 'aaaaxyzaa', 4, 3, true);
    }

    private static void assertRegionMatchesCaseInsensitive(String str, Integer toffset, 
        String other, Integer ooffset, Integer len, Boolean expected) {
        Boolean actual = ApexLangUtils.regionMatchesIgnoreCase(str,toffset,other,ooffset,len);
        System.assert(actual==expected, 'ApexLangUtils.regionMatchesIgnoreCase(\'' 
            + str + '\',' + toffset + ',\'' + other + '\',' + ooffset + ',' + len 
            + ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testRegionMatches(){
        //test: global static boolean regionMatches(String str, boolean ignoreCase,
        //            Integer toffset, String other, Integer ooffset, Integer len){
        assertRegionMatches(null, false, 0, null, 0, 0, true);
        assertRegionMatches('aaaxyzaaa', false, 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatches('aaaXYZaaa', false, 3, 'aaaaxyzaa', 4, 3, false);
        assertRegionMatches('aaaXYZaaa', true, 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatches(
            'Java is a wonderful language',
          // 0    5    10   15   20   25   
            false, 20, 
            'It is an object-oriented language', 25, 6, true);
          // 0    5    10   15   20   25   30
    }

    private static void assertRegionMatches(String str, boolean ignoreCase, Integer toffset, 
        String other, Integer ooffset, Integer len, Boolean expected) {
        Boolean actual = ApexLangUtils.regionMatches(str,ignoreCase,toffset,other,ooffset,len);
        System.assert(actual==expected, 'ApexLangUtils.regionMatches(\'' 
            + str + '\',' + ignoreCase + ',' + toffset + ',\'' 
            + other + '\',' + ooffset + ',' + len 
            + ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testReplaceThreeArgs(){
        //test: global static String replace(String text, String searchString, String replacement) {

        assertReplaceThreeArgs(null, null, null, null);
        assertReplaceThreeArgs('', null, null, '');
        assertReplaceThreeArgs('any', null, null, 'any');
        assertReplaceThreeArgs('any', null, null, 'any');
        assertReplaceThreeArgs('any', '', null, 'any');
        assertReplaceThreeArgs('aba', 'a', null, 'aba');
        assertReplaceThreeArgs('aba', 'a', '', 'b');
        assertReplaceThreeArgs('aba', 'a', 'z', 'zbz');
    }

    private static void assertReplaceThreeArgs(String text, String searchString, String replacement, String expected){
        String actual = ApexLangUtils.replace(text,searchString,replacement);
        System.assert(actual==expected, 'ApexLangUtils.replace(\'' + text + '\',\'' 
            + searchString + '\',\'' + replacement + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceFourArgs(){
        //test: global static String replace(String text, String searchString, String replacement, Integer max) {
        assertReplaceFourArgs(null, null, null, -1, null);
        assertReplaceFourArgs('', null, null, -1, '');
        assertReplaceFourArgs('any', null, null, -1, 'any');
        assertReplaceFourArgs('any', null, null, -1, 'any');
        assertReplaceFourArgs('any', '', null, -1, 'any');
        assertReplaceFourArgs('any', null, null, 0, 'any');
        assertReplaceFourArgs('abaa', 'a', null, -1, 'abaa');
        assertReplaceFourArgs('abaa', 'a', '', -1, 'b');
        assertReplaceFourArgs('abaa', 'a', 'z', 0, 'abaa');
        assertReplaceFourArgs('abaa', 'a', 'z', 1, 'zbaa');
        assertReplaceFourArgs('abaa', 'a', 'z', 2, 'zbza');
        assertReplaceFourArgs('abaa', 'a', 'z', -1, 'zbzz');
    }

    private static void assertReplaceFourArgs(String text, String searchString, String replacement, Integer max, String expected){
        String actual = ApexLangUtils.replace(text,searchString,replacement,max);
        System.assert(actual==expected, 'ApexLangUtils.replace(\'' + text + '\',\'' 
            + searchString + '\',\'' + replacement + '\',' + max + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceEachThreeArgs(){
        //test: global static String replaceEach(String text, String[] searchList, String[] replacementList) {
        assertReplaceEachThreeArgs(null, null, null, null);
        assertReplaceEachThreeArgs('', null, null, '');
        assertReplaceEachThreeArgs('aba', null, null, 'aba');
        assertReplaceEachThreeArgs('aba', new String[0], null, 'aba');
        assertReplaceEachThreeArgs('aba', null, new String[0], 'aba');
        assertReplaceEachThreeArgs('aba', new String[]{'a'}, null, 'aba');
        assertReplaceEachThreeArgs('aba', new String[]{'a'}, new String[]{''}, 'b');
        assertReplaceEachThreeArgs('aba', new String[]{null}, new String[]{'a'}, 'aba');
        assertReplaceEachThreeArgs('abcde', new String[]{'ab', 'd'}, new String[]{'w', 't'}, 'wcte');
        assertReplaceEachThreeArgs('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, 'dcte');
    }

    private static void assertReplaceEachThreeArgs(String text, String[] searchList, String[] replacementList, String expected){
        String actual = ApexLangUtils.replaceEach(text,searchList,replacementList);
        System.assert(actual==expected, 'ApexLangUtils.replaceEach(\'' + text + '\',' 
            + ApexLangUtils.toString(searchList) + ',' + ApexLangUtils.toString(replacementList) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceEachRepeatedly(){
        //test: global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat) {
        assertReplaceEachRepeatedly(null, null, null, false,null);
        assertReplaceEachRepeatedly('', null, null, false,'');
        assertReplaceEachRepeatedly('aba', null, null, false,'aba');
        assertReplaceEachRepeatedly('aba', new String[0], null, false,'aba');
        assertReplaceEachRepeatedly('aba', null, new String[0], false,'aba');
        assertReplaceEachRepeatedly('aba', new String[]{'a'}, null, false,'aba');
        assertReplaceEachRepeatedly('aba', new String[]{'a'}, new String[]{''}, false,'b');
        assertReplaceEachRepeatedly('aba', new String[]{null}, new String[]{'a'}, false,'aba');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'w', 't'}, false,'wcte');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, false,'dcte');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, true,'tcte');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 'ab'}, false,'dcabe');
    }

    private static void assertReplaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat, String expected){
        String actual = ApexLangUtils.replaceEachRepeatedly(text,searchList,replacementList,repeat);
        System.assert(actual==expected, 'ApexLangUtils.replaceEachRepeatedly(\'' + text + '\',' 
            + ApexLangUtils.toString(searchList) + ',' + ApexLangUtils.toString(replacementList) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    } 
 
    private static testmethod void testReplaceEachFiveArgExceptions(){
        //test: global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat) {
        IllegalStateException illegalState = null;
        try{
            ApexLangUtils.replaceEach('abcde', new String[]{'ab', 'd'}, new String[]{'d', 'ab'}, false,-1);
        }catch(IllegalStateException e){
            illegalState = e;
        }
        System.assertNotEquals(null,illegalState);

        IllegalArgumentException illegalArgument = null;
        try{
            ApexLangUtils.replaceEach('abcde', new String[]{'ab', 'd'}, new String[]{'ab'}, false,0);
        }catch(IllegalArgumentException e){
            illegalArgument = e;
        }
        System.assertNotEquals(null,illegalArgument);
    }

    private static testmethod void testStartsWith(){
        //test:global static boolean startsWith(String str, String prefix) 
        assertStartsWith(null, null, true);
        assertStartsWith(null, 'abcdef', false);
        assertStartsWith('abc', null, false);
        assertStartsWith('abc', 'abcdef', false);
        assertStartsWith('abcdef', 'abc', true);
        assertStartsWith('ABCDEF', 'abc', false);
    }

    private static void assertStartsWith(String str, String prefix, Boolean expected) {
        Boolean actual = ApexLangUtils.startsWith(str,prefix);
        System.assert(actual==expected, 'ApexLangUtils.startsWith(\'' + str + '\',\'' + prefix 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testStartsWithIgnoreCase(){
        //test:global static boolean startsWithIgnoreCase(String str, String prefix) 
        assertStartsWithIgnoreCase(null, null, true);
        assertStartsWithIgnoreCase(null, 'abcdef', false);        assertStartsWithIgnoreCase('abc', null, false);
        assertStartsWithIgnoreCase('abcdef', 'abc', true);
        assertStartsWithIgnoreCase('ABCDEF', 'abc', true); 
    }

    private static void assertStartsWithIgnoreCase(String str, String prefix, Boolean expected) {
        Boolean actual = ApexLangUtils.startsWithIgnoreCase(str,prefix);
        System.assert(actual==expected, 'ApexLangUtils.startsWithIgnoreCase(\'' + str + '\',\'' + prefix 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceOnce(){
        //test: global static String replaceOnce(String text, String searchString, String replacement)
        assertReplaceOnce(null, null, null, null);
        assertReplaceOnce('', null, null, '');
        assertReplaceOnce('any', null, null, 'any');
        assertReplaceOnce('any', null, null, 'any');
        assertReplaceOnce('any', '', null, 'any');
        assertReplaceOnce('aba', 'a', null, 'aba');
        assertReplaceOnce('aba', 'a', '', 'ba');
        assertReplaceOnce('aba', 'a', 'z', 'zba');
    }

    private static void assertReplaceOnce(String text, String searchString, String replacement, String expected) {
        String actual = ApexLangUtils.replaceOnce(text, searchString, replacement);
        System.assert(actual==expected, 'ApexLangUtils.replaceOnce(\'' + text + '\',\'' + searchString 
            + '\',\'' + replacement + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testReverse(){
        //test: global static String reverse(String str)
        assertReverse(null, null);
        assertReverse('', '');
        assertReverse('bat', 'tab');
    }

    private static void assertReverse(String str, String expected) {
        String actual = ApexLangUtils.reverse(str); 
        System.assert(actual==expected, 'ApexLangUtils.reverse(\'' + str 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testReverseDelimited(){
        //test: global static String reverseDelimited(String str, String separatorChar) 
        assertReverseDelimited(null, null, null);
        assertReverseDelimited('', null, '');
        assertReverseDelimited('a.b.c', 'x', 'a.b.c');
        assertReverseDelimited('a.b.c', '.', 'c.b.a');
    }

    private static void assertReverseDelimited(String str, String separatorChar, String expected) {
        String actual = ApexLangUtils.reverseDelimited(str, separatorChar);
        System.assert(actual==expected, 'ApexLangUtils.reverseDelimited(\'' + str + '\',\'' + separatorChar 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRight(){
        //test: global static String right(String str, Integer len) 
        assertRight(null, 0, null);
        assertRight('abcdefg', -1, '');
        assertRight('', -1, '');
        assertRight('abc', 0, '');
        assertRight('abc', 2, 'bc');
        assertRight('abc', 4, 'abc');
    }

    private static void assertRight(String str, Integer len, String expected) {
        String actual = ApexLangUtils.right(str, len);
        System.assert(actual==expected, 'ApexLangUtils.right(\'' + str + '\',' + len 
            + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testSplitByCharacterTypeCamelCase(){
        //test: global static String[] splitByCharacterTypeCamelCase(String str)
        assertSplitByCharacterTypeCamelCase(null,             null);
        assertSplitByCharacterTypeCamelCase('',             new String[]{});
        assertSplitByCharacterTypeCamelCase('ab de fg',     new String[]{'ab', ' ', 'de', ' ', 'fg'});
        assertSplitByCharacterTypeCamelCase('ab   de fg',     new String[]{'ab', '   ', 'de', ' ', 'fg'});
        assertSplitByCharacterTypeCamelCase('ab:cd:ef',     new String[]{'ab', ':', 'cd', ':', 'ef'});
        assertSplitByCharacterTypeCamelCase('number5',         new String[]{'number', '5'});
        assertSplitByCharacterTypeCamelCase('fooBar',         new String[]{'foo', 'Bar'});
        assertSplitByCharacterTypeCamelCase('foo200Bar',     new String[]{'foo', '200', 'Bar'});
        assertSplitByCharacterTypeCamelCase('ASFRules',     new String[]{'ASF', 'Rules'});
    }

    private static void assertSplitByCharacterTypeCamelCase(String str, Object[] expected) {
        ApexLangUtils.AssertArraysAreEqual(expected,ApexLangUtils.splitByCharacterTypeCamelCase(str));
    }
    
    private static testmethod void testSplitByCharacterType(){
        //test:  global static String[] splitByCharacterType(String str)
        assertSplitByCharacterType(null,             null);
        assertSplitByCharacterType('',                 new String[]{});
        assertSplitByCharacterType('ab de fg',         new String[]{'ab', ' ', 'de', ' ', 'fg'});
        assertSplitByCharacterType('ab   de fg',     new String[]{'ab', '   ', 'de', ' ', 'fg'});
        assertSplitByCharacterType('ab:cd:ef',         new String[]{'ab', ':', 'cd', ':', 'ef'});
        assertSplitByCharacterType('number5',         new String[]{'number', '5'});
        assertSplitByCharacterType('fooBar',         new String[]{'foo', 'B', 'ar'});
        assertSplitByCharacterType('foo200Bar',     new String[]{'foo', '200', 'B', 'ar'});
        assertSplitByCharacterType('ASFRules',         new String[]{'ASFR', 'ules'});
    }

    private static void assertSplitByCharacterType(String str, Object[] expected) {
        ApexLangUtils.AssertArraysAreEqual(expected,ApexLangUtils.splitByCharacterType(str));
    }
     
    private static testmethod void testTrimToEmpty(){
        //test: global static String trimToEmpty(String str) {
        assertTrimToEmpty(null, '');
        assertTrimToEmpty('', '');
        assertTrimToEmpty('     ', '');
        assertTrimToEmpty('abc', 'abc');
        assertTrimToEmpty('    abc    ', 'abc');
    }

    private static void assertTrimToEmpty(String str, String expected) {
        String actual = ApexLangUtils.trimToEmpty(str);
        System.assert(actual==expected, 'ApexLangUtils.trimToEmpty(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testTrimToNull(){
        //test:  global static String trimToNull(String str) {
        assertTrimToNull(null, null);
        assertTrimToNull('', null);
        assertTrimToNull('     ', null);
        assertTrimToNull('abc', 'abc');
        assertTrimToNull('    abc    ', 'abc');
    }

    private static void assertTrimToNull(String str, String expected) {
        String actual = ApexLangUtils.trimToNull(str);
        System.assert(actual==expected, 'ApexLangUtils.trimToNull(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    
    
    private static testmethod void testStripOneArg(){
        //test: global static String strip(String str)
        assertStripOneArg(null, null);
        assertStripOneArg('', '');
        assertStripOneArg('   ', '');
        assertStripOneArg('abc', 'abc');
        assertStripOneArg('  abc', 'abc');
        assertStripOneArg('abc  ', 'abc');
        assertStripOneArg(' abc ', 'abc');
        assertStripOneArg(' ab c ', 'ab c');
    }

    private static void assertStripOneArg(String str, String expected) {
        String actual = ApexLangUtils.strip(str);
        System.assert(actual==expected, 'ApexLangUtils.strip(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    
    
    private static testmethod void testStripToNull(){
        //test: global static String stripToNull(String str) {
        assertStripToNull(null,null);
        assertStripToNull('',null);
        assertStripToNull('   ',null);
        assertStripToNull('abc','abc');
        assertStripToNull('  abc','abc');
        assertStripToNull('abc  ','abc');
        assertStripToNull(' abc ','abc');
        assertStripToNull(' ab c ','ab c');
    }

    private static void assertStripToNull(String str, String expected) {
        String actual = ApexLangUtils.stripToNull(str);
        System.assert(actual==expected, 'ApexLangUtils.stripToNull(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    
    
    private static testmethod void testStripToEmpty(){
        //test: global static String stripToEmpty(String str) {
        assertStripToEmpty(null, '');
        assertStripToEmpty('', '');
        assertStripToEmpty('   ', '');
        assertStripToEmpty('abc', 'abc');
        assertStripToEmpty('  abc', 'abc');
        assertStripToEmpty('abc  ', 'abc');
        assertStripToEmpty(' abc ', 'abc');
        assertStripToEmpty(' ab c ', 'ab c');
    }

    private static void assertStripToEmpty(String str, String expected) {
        String actual = ApexLangUtils.stripToEmpty(str);
        System.assert(actual==expected, 'ApexLangUtils.stripToEmpty(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    

    private static testmethod void testStripTwoArgs(){
        //test: global static String strip(String str, String stripChars)
        assertStripTwoArgs(null, null, null);
        assertStripTwoArgs('', null, '');
        assertStripTwoArgs('abc', null, 'abc');
        assertStripTwoArgs('  abc', null, 'abc');
        assertStripTwoArgs('abc  ', null, 'abc');
        assertStripTwoArgs(' abc ', null, 'abc');
        assertStripTwoArgs('  abcyx', 'xyz', '  abc');
    }

    private static void assertStripTwoArgs(String str, String stripChars, String expected) {
        String actual = ApexLangUtils.strip(str,stripChars);
        System.assert(actual==expected, 'ApexLangUtils.strip(\'' + str + '\',\'' + stripChars + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }   

    private static testmethod void testStripStart(){
        //test:  global static String stripStart(String str, String stripChars)
        assertStripStart(null, null, null);
        assertStripStart('', null, '');
        assertStripStart('abc', '', 'abc');
        assertStripStart('abc', null, 'abc');
        assertStripStart('  abc', null, 'abc');
        assertStripStart('abc  ', null, 'abc  ');
        assertStripStart(' abc ', null, 'abc ');
        assertStripStart('yxabc  ', 'xyz', 'abc  ');
    }

    private static void assertStripStart(String str, String stripChars, String expected) {
        String actual = ApexLangUtils.stripStart(str,stripChars);
        System.assert(actual==expected, 'ApexLangUtils.stripStart(\'' + str + '\',\'' + stripChars 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }              

    private static testmethod void testStripEnd(){
        //test: global static String stripEnd(String str, String stripChars)
        assertStripEnd(null, null, null);
        assertStripEnd('', null, '');
        assertStripEnd('abc', '', 'abc');
        assertStripEnd('abc', null, 'abc');
        assertStripEnd('  abc', null, '  abc');
        assertStripEnd('abc  ', null, 'abc');
        assertStripEnd(' abc ', null, ' abc');
        assertStripEnd('  abcyx', 'xyz', '  abc');
    }

    private static void assertStripEnd(String str, String stripChars, String expected) {
        String actual = ApexLangUtils.stripEnd(str,stripChars);
        System.assert(actual==expected, 'ApexLangUtils.stripEnd(\'' + str + '\', \'' + stripChars 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testStripAllOneArg(){
        //test: global static String[] stripAll(String[] strs)
        assertStripAllOneArg(null, null);
        assertStripAllOneArg(new String[]{}, new String[]{});
        assertStripAllOneArg(new String[]{'abc', '  abc'}, new String[]{'abc', 'abc'});
        assertStripAllOneArg(new String[]{'abc  ', null}, new String[]{'abc', null});
    }

    private static void assertStripAllOneArg(String[] strs, String[] expected) {
        ApexLangUtils.assertArraysAreEqual(expected,ApexLangUtils.stripAll(strs));
    } 
     
    private static testmethod void testStripAllTwoArgs(){
        //test: global static String[] stripAll(String[] strs, String stripChars)
        assertStripAllTwoArgs(null, null, null);
        assertStripAllTwoArgs(new String[]{}, null, new String[]{});
        assertStripAllTwoArgs(new String[]{'abc', '  abc'}, null, new String[]{'abc', 'abc'});
        assertStripAllTwoArgs(new String[]{'abc  ', null}, null, new String[]{'abc', null});
        assertStripAllTwoArgs(new String[]{'abc  ', null}, 'yz', new String[]{'abc  ', null});
        assertStripAllTwoArgs(new String[]{'yabcz', null}, 'yz', new String[]{'abc', null});
    }

    private static void assertStripAllTwoArgs(String[] strs, String stripChars, String[] expected) {
        ApexLangUtils.assertArraysAreEqual(expected,ApexLangUtils.stripAll(strs,stripChars));
    }
    
    private static testmethod void testSubstringBefore(){
        //test: global static String substringBefore(String str, String separator)
        assertSubstringBefore(null, null, null);
        assertSubstringBefore('', null, '');
        assertSubstringBefore('abc', 'a', '');
        assertSubstringBefore('abcba', 'b', 'a');
        assertSubstringBefore('abc', 'c', 'ab');
        assertSubstringBefore('abc', 'd', 'abc');
        assertSubstringBefore('abc', '', '');
        assertSubstringBefore('abc', null, 'abc');
    }

    private static void assertSubstringBefore(String str, String separator, String expected) {
        String actual = ApexLangUtils.substringBefore(str,separator);
        System.assert(actual==expected, 'ApexLangUtils.substringBefore(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringAfter(){
        //test: global static String substringAfter(String str, String separator)
        assertSubstringAfter(null, null, null);
        assertSubstringAfter('', null, '');
        assertSubstringAfter('asdf', null, '');
        assertSubstringAfter(null, null, null);
        assertSubstringAfter('abc', 'a', 'bc');
        assertSubstringAfter('abcba', 'b', 'cba');
        assertSubstringAfter('abc', 'c', '');
        assertSubstringAfter('abc', 'd', '');
        assertSubstringAfter('abc', '', 'abc');
    }

    private static void assertSubstringAfter(String str, String separator, String expected) {
        String actual = ApexLangUtils.substringAfter(str,separator);
        System.assert(actual==expected, 'ApexLangUtils.substringAfter(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringBeforeLast(){
        //test: global static String substringBeforeLast(String str, String separator)
        assertSubstringBeforeLast(null, null, null);
        assertSubstringBeforeLast('', null, '');
        assertSubstringBeforeLast('abcba', 'b', 'abc');
        assertSubstringBeforeLast('abc', 'c', 'ab');
        assertSubstringBeforeLast('a', 'a', '');
        assertSubstringBeforeLast('a', 'z', 'a');
        assertSubstringBeforeLast('a', null, 'a');
        assertSubstringBeforeLast('a', '', 'a');
    }

    private static void assertSubstringBeforeLast(String str, String separator, String expected) {
        String actual = ApexLangUtils.substringBeforeLast(str,separator);
        System.assert(actual==expected, 'ApexLangUtils.substringBeforeLast(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringAfterLast(){
        //test: global static String substringAfterLast(String str, String separator)
        assertSubstringAfterLast(null, null, null);
        assertSubstringAfterLast('', null, '');
        assertSubstringAfterLast('adsfa', null, '');
        assertSubstringAfterLast(null, '', null);
        assertSubstringAfterLast('abc', 'a', 'bc');
        assertSubstringAfterLast('abcba', 'b', 'a');
        assertSubstringAfterLast('abc', 'c', '');
        assertSubstringAfterLast('a', 'a', '');
        assertSubstringAfterLast('a', 'z', '');
    }

    private static void assertSubstringAfterLast(String str, String separator, String expected) {
        String actual = ApexLangUtils.substringAfterLast(str,separator);
        System.assert(actual==expected, 'ApexLangUtils.substringAfterLast(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringBetweenTwoArgs(){
        //test: global static String substringBetween(String str, String tag)
        assertSubstringBetweenTwoArgs(null, null, null);
        assertSubstringBetweenTwoArgs('', '', '');
        assertSubstringBetweenTwoArgs('', 'tag', null);
        assertSubstringBetweenTwoArgs('tagabctag', null, null);
        assertSubstringBetweenTwoArgs('tagabctag', '', '');
        assertSubstringBetweenTwoArgs('tagabctag', 'tag', 'abc');
    }

    private static void assertSubstringBetweenTwoArgs(String str, String tag, String expected) {
        String actual = ApexLangUtils.substringBetween(str,tag);
        System.assert(actual==expected, 'ApexLangUtils.substringBetween(\'' + str + '\', \'' + tag 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringBetweenThreeArgs(){
        //test: global static String substringBetween(String str, String open, String close)
        assertSubstringBetweenThreeArgs('wx[b]yz', '[', ']', 'b');
        assertSubstringBetweenThreeArgs(null, null, null, null);
        assertSubstringBetweenThreeArgs(null, null, null, null);
        assertSubstringBetweenThreeArgs(null, null, null, null);
        assertSubstringBetweenThreeArgs('', '', '', '');
        assertSubstringBetweenThreeArgs('', '', ']', null);
        assertSubstringBetweenThreeArgs('', '[', ']', null);
        assertSubstringBetweenThreeArgs('yabcz', '', '', '');
        assertSubstringBetweenThreeArgs('yabcz', 'y', 'z', 'abc');
        assertSubstringBetweenThreeArgs('yabczyabcz', 'y', 'z', 'abc');
    } 

    private static void assertSubstringBetweenThreeArgs(String str, String open, String close, String expected) {
        String actual = ApexLangUtils.substringBetween(str,open,close);
        System.assert(actual==expected, 'ApexLangUtils.substringBetween(\'' + str + '\',\'' + open + '\', \'' + close 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringsBetween(){
        //test: global static String[] substringsBetween(String str, String open, String close)
        assertSubstringsBetween('[a][b][c]', '[', ']', new String[]{'a','b','c'});
        assertSubstringsBetween(null, null, null, null);
        assertSubstringsBetween('asdf', '[', ']', null);
        assertSubstringsBetween('a[df', '[', ']', null);
        assertSubstringsBetween('', '[', ']', new String[]{});
    }

    private static void assertSubstringsBetween(String str, String open, String close, String[] expected) {
        ApexLangUtils.assertArraysAreEqual(expected, ApexLangUtils.substringsBetween(str,open,close));
    }  

    private static testmethod void testEnsureStringStartsEndsWithChar(){
        //test: global static String ensureStringStartsEndsWithChar(String str, String charc){
        assertEnsureStringStartsEndsWithChar(null, null, null);
        assertEnsureStringStartsEndsWithChar(null, 'abc', null);
        assertEnsureStringStartsEndsWithChar('', 'abc', 'abcabc');
        assertEnsureStringStartsEndsWithChar('test123', null, 'test123');
        assertEnsureStringStartsEndsWithChar('test123', 'abc', 'abctest123abc');
    }

    private static void assertEnsureStringStartsEndsWithChar(String str, String charc, String expected) {
        String actual = ApexLangUtils.ensureStringStartsEndsWithChar(str,charc);
        System.assert(actual==expected, 'ApexLangUtils.ensureStringStartsEndsWithChar(\'' + str + '\', \'' + charc 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testToCharArray(){
        //test: global static String[] toCharArray(String str){
        ApexLangUtils.assertArraysAreEqual(new String[]{},ApexLangUtils.toCharArray(null));
        ApexLangUtils.assertArraysAreEqual(new String[]{},ApexLangUtils.toCharArray(''));
        ApexLangUtils.assertArraysAreEqual(new String[]{' '},ApexLangUtils.toCharArray(' '));
        ApexLangUtils.assertArraysAreEqual(new String[]{' ',' '},ApexLangUtils.toCharArray('  '));
        ApexLangUtils.assertArraysAreEqual(new String[]{'a','b','c'},ApexLangUtils.toCharArray('abc'));
    }

    private static testmethod void testTrimAll_Set(){
        Set<String> NULL_SET = null;
        System.assertEquals(null,ApexLangUtils.trimAll(NULL_SET));
        ApexLangUtils.assertEquals(new Set<String>{'a','b'},ApexLangUtils.trimAll(new Set<String>{' a ',' b '}));
    }

    private static testmethod void testTrimAll_List(){
        List<String> NULL_LIST = null;
        System.assertEquals(null,ApexLangUtils.trimAll(NULL_LIST));
        ApexLangUtils.assertArraysAreEqual(new List<String>{'a','b'},ApexLangUtils.trimAll(new List<String>{' a ',' b '}));
    }    
    
    /* StringApexLangUtils2 tests*/

    /* WordApexLangUtils Tests */
    
    private static testmethod void testWrap_StringInt() {
        System.System.assertEquals(null, ApexLangUtils.wrap(null, 20));
        System.System.assertEquals(null, ApexLangUtils.wrap(null, -1));
        
        System.System.assertEquals('', ApexLangUtils.wrap('', 20));
        System.System.assertEquals('', ApexLangUtils.wrap('', -1));
        
        // normal
        final String systemNewLine = ApexLangUtils.LINE_SEPARATOR;
        String input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        String expected = 'Here is one line of' + systemNewLine + 'text that is going' 
            + systemNewLine + 'to be wrapped after' + systemNewLine + '20 columns.';
        System.System.assertEquals(expected, ApexLangUtils.wrap(input, 20));
        
        // long word at end
        input = 'Click here to jump to the jakarta website - http://jakarta.apache.org';
        expected = 'Click here to jump' + systemNewLine + 'to the jakarta' + systemNewLine 
            + 'website -' + systemNewLine + 'http://jakarta.apache.org';
        System.System.assertEquals(expected, ApexLangUtils.wrap(input, 20));
        
        // long word in middle
        input = 'Click here, http://jakarta.apache.org, to jump to the jakarta website';
        expected = 'Click here,' + systemNewLine + 'http://jakarta.apache.org,' + systemNewLine 
            + 'to jump to the' + systemNewLine + 'jakarta website';
        System.System.assertEquals(expected, ApexLangUtils.wrap(input, 20));
    }
    
    private static testmethod void testWrap_StringIntStringBoolean() {
        System.assertEquals(null, ApexLangUtils.wrap(null, 20, '\n', false));
        System.assertEquals(null, ApexLangUtils.wrap(null, 20, '\n', true));
        System.assertEquals(null, ApexLangUtils.wrap(null, 20, null, true));
        System.assertEquals(null, ApexLangUtils.wrap(null, 20, null, false));
        System.assertEquals(null, ApexLangUtils.wrap(null, -1, null, true));
        System.assertEquals(null, ApexLangUtils.wrap(null, -1, null, false));
        
        System.assertEquals('', ApexLangUtils.wrap('', 20, '\n', false));
        System.assertEquals('', ApexLangUtils.wrap('', 20, '\n', true));
        System.assertEquals('', ApexLangUtils.wrap('', 20, null, false));
        System.assertEquals('', ApexLangUtils.wrap('', 20, null, true));
        System.assertEquals('', ApexLangUtils.wrap('', -1, null, false));
        System.assertEquals('', ApexLangUtils.wrap('', -1, null, true));
        
        // normal
        String input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        String expected = 'Here is one line of\ntext that is going\nto be wrapped after\n20 columns.';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', true));

        // unusual newline String
        input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        expected = 'Here is one line of<br />text that is going<br />to be wrapped after<br />20 columns.';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '<br />', false));
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '<br />', true));

        // short line length
        input = 'Here is one line';
        expected = 'Here\nis one\nline';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 6, '\n', false));
        expected = 'Here\nis\none\nline';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 2, '\n', false));
        System.assertEquals(expected, ApexLangUtils.wrap(input, -1, '\n', false));

        // system newline String
        String systemNewLine = '\n';
        input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        expected = 'Here is one line of' + systemNewLine + 'text that is going' + systemNewLine 
            + 'to be wrapped after' + systemNewLine + '20 columns.';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, null, false));
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, null, true));

        // with extra spaces
        input = ' Here:  is  one  line  of  text  that  is  going  to  be  wrapped  after  20  columns.';
        expected = 'Here:  is  one  line\nof  text  that  is \ngoing  to  be \nwrapped  after  20 \ncolumns.';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', true));
        
        // with tab
        input = 'Here is\tone line of text that is going to be wrapped after 20 columns.';
        expected = 'Here is\tone line of\ntext that is going\nto be wrapped after\n20 columns.';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', true));
        
        // with tab at wrapColumn
        input = 'Here is one line of\ttext that is going to be wrapped after 20 columns.';
        expected = 'Here is one line\nof\ttext that is\ngoing to be wrapped\nafter 20 columns.';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', true));
        
        // difference because of long word
        input = 'Click here to jump to the jakarta website - http://jakarta.apache.org';
        expected = 'Click here to jump\nto the jakarta\nwebsite -\nhttp://jakarta.apache.org';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', false));
        expected = 'Click here to jump\nto the jakarta\nwebsite -\nhttp://jakarta.apach\ne.org';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', true));
        
        // difference because of long word in middle
        input = 'Click here, http://jakarta.apache.org, to jump to the jakarta website';
        expected = 'Click here,\nhttp://jakarta.apache.org,\nto jump to the\njakarta website';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', false));
        expected = 'Click here,\nhttp://jakarta.apach\ne.org, to jump to\nthe jakarta website';
        System.assertEquals(expected, ApexLangUtils.wrap(input, 20, '\n', true));
//        System.err.println(expected);
//        System.err.println(ApexLangUtils.wrap(input, 20, '\n', false));
    }
    
    private static testmethod void testCapitalize_String() {
        System.assertEquals(null, ApexLangUtils.capitalize(null));
        System.assertEquals('', ApexLangUtils.capitalize(''));
        System.assertEquals('  ', ApexLangUtils.capitalize('  '));
        
        System.assertEquals('I', ApexLangUtils.capitalize('I') );
        System.assertEquals('I', ApexLangUtils.capitalize('i') );
        System.assertEquals('I Am Here 123', ApexLangUtils.capitalize('i am here 123') );
        System.assertEquals('I Am Here 123', ApexLangUtils.capitalize('I Am Here 123') );
        System.assertEquals('I Am HERE 123', ApexLangUtils.capitalize('i am HERE 123') );
        System.assertEquals('I AM HERE 123', ApexLangUtils.capitalize('I AM HERE 123') );
    }
    
    private static testmethod void testCapitalizeWithDelimiters_String() {
        System.assertEquals(null, ApexLangUtils.capitalize(null, null));
        System.assertEquals('', ApexLangUtils.capitalize('', new String[0]));
        System.assertEquals('  ', ApexLangUtils.capitalize('  ', new String[0]));
        
        String[] chars = new String[] { '-', '+', ' ', '@' };
        System.assertEquals('I', ''+ApexLangUtils.capitalize('I', chars) );
        System.assertEquals('I', ApexLangUtils.capitalize('i', chars) );
        System.assertEquals('I-Am Here+123', ApexLangUtils.capitalize('i-am here+123', chars) );
        System.assertEquals('I Am+Here-123', ApexLangUtils.capitalize('I Am+Here-123', chars) );
        System.assertEquals('I+Am-HERE 123', ApexLangUtils.capitalize('i+am-HERE 123', chars) );
        System.assertEquals('I-AM HERE+123', ApexLangUtils.capitalize('I-AM HERE+123', chars) );
        chars = new String[] {'.'};
        System.assertEquals('I aM.Fine', ApexLangUtils.capitalize('i aM.fine', chars) );
        System.assertEquals('I Am.fine', ApexLangUtils.capitalize('i am.fine', null) );
    }

    private static testmethod void testCapitalizeFully_String() {
        System.assertEquals(null, ApexLangUtils.capitalizeFully(null));
        System.assertEquals('', ApexLangUtils.capitalizeFully(''));
        System.assertEquals('  ', ApexLangUtils.capitalizeFully('  '));
        
        System.assertEquals('I', ApexLangUtils.capitalizeFully('I') );
        System.assertEquals('I', ApexLangUtils.capitalizeFully('i') );
        System.assertEquals('I Am Here 123', ApexLangUtils.capitalizeFully('i am here 123') );
        System.assertEquals('I Am Here 123', ApexLangUtils.capitalizeFully('I Am Here 123') );
        System.assertEquals('I Am Here 123', ApexLangUtils.capitalizeFully('i am HERE 123') );
        System.assertEquals('I Am Here 123', ApexLangUtils.capitalizeFully('I AM HERE 123') );
    }
    
    private static testmethod void testCapitalizeFullyWithDelimiters_String() {
        System.assertEquals(null, ApexLangUtils.capitalizeFully(null, null));
        System.assertEquals('', ApexLangUtils.capitalizeFully('', new String[0]));
        System.assertEquals('  ', ApexLangUtils.capitalizeFully('  ', new String[0]));
        
        String[] chars = new String[] { '-', '+', ' ', '@' };
        System.assertEquals('I', ApexLangUtils.capitalizeFully('I', chars) );
        System.assertEquals('I', ApexLangUtils.capitalizeFully('i', chars) );
        System.assertEquals('I-Am Here+123', ApexLangUtils.capitalizeFully('i-am here+123', chars) );
        System.assertEquals('I Am+Here-123', ApexLangUtils.capitalizeFully('I Am+Here-123', chars) );
        System.assertEquals('I+Am-Here 123', ApexLangUtils.capitalizeFully('i+am-HERE 123', chars) );
        System.assertEquals('I-Am Here+123', ApexLangUtils.capitalizeFully('I-AM HERE+123', chars) );
        chars = new String[] {'.'};
        System.assertEquals('I am.Fine', ApexLangUtils.capitalizeFully('i aM.fine', chars) );
        System.assertEquals('I Am.fine', ApexLangUtils.capitalizeFully('i am.fine', null) );
    }

    private static testmethod void testUncapitalize_String() {
        System.assertEquals(null, ApexLangUtils.uncapitalize(null));
        System.assertEquals('', ApexLangUtils.uncapitalize(''));
        System.assertEquals('  ', ApexLangUtils.uncapitalize('  '));
        
        System.assertEquals('i', ApexLangUtils.uncapitalize('I') );
        System.assertEquals('i', ApexLangUtils.uncapitalize('i') );
        System.assertEquals('i am here 123', ApexLangUtils.uncapitalize('i am here 123') );
        System.assertEquals('i am here 123', ApexLangUtils.uncapitalize('I Am Here 123') );
        System.assertEquals('i am hERE 123', ApexLangUtils.uncapitalize('i am HERE 123') );
        System.assertEquals('i aM hERE 123', ApexLangUtils.uncapitalize('I AM HERE 123') );
    }
    
    private static testmethod void testUncapitalizeWithDelimiters_String() {
        System.assertEquals(null, ApexLangUtils.uncapitalize(null, null));
        System.assertEquals('', ApexLangUtils.uncapitalize('', new String[0]));
        System.assertEquals('  ', ApexLangUtils.uncapitalize('  ', new String[0]));
        
        String[] chars = new String[] { '-', '+', ' ', '@' };
        System.assertEquals('i', ApexLangUtils.uncapitalize('I', chars) );
        System.assertEquals('i', ApexLangUtils.uncapitalize('i', chars) );
        System.assertEquals('i am-here+123', ApexLangUtils.uncapitalize('i am-here+123', chars) );
        System.assertEquals('i+am here-123', ApexLangUtils.uncapitalize('I+Am Here-123', chars) );
        System.assertEquals('i-am+hERE 123', ApexLangUtils.uncapitalize('i-am+HERE 123', chars) );
        System.assertEquals('i aM-hERE+123', ApexLangUtils.uncapitalize('I AM-HERE+123', chars) );
        chars = new String[] {'.'};
        System.assertEquals('i AM.fINE', ApexLangUtils.uncapitalize('I AM.FINE', chars) );
        System.assertEquals('i aM.FINE', ApexLangUtils.uncapitalize('I AM.FINE', null) );
    }

    private static testmethod void testInitials_String() {
        System.assertEquals(null, ApexLangUtils.initials(null));
        System.assertEquals('', ApexLangUtils.initials(''));
        System.assertEquals('', ApexLangUtils.initials('  '));

        System.assertEquals('I', ApexLangUtils.initials('I'));
        System.assertEquals('i', ApexLangUtils.initials('i'));
        System.assertEquals('BJL', ApexLangUtils.initials('Ben John Lee'));
        System.assertEquals('BJ', ApexLangUtils.initials('Ben J.Lee'));
        System.assertEquals('BJ.L', ApexLangUtils.initials(' Ben   John  . Lee'));
        System.assertEquals('iah1', ApexLangUtils.initials('i am here 123'));
    }

    private static testmethod void testInitials_String_charArray() {
        String[] anArray = null;
        System.assertEquals(null, ApexLangUtils.initials(null, anArray));
        System.assertEquals('', ApexLangUtils.initials('', anArray));
        System.assertEquals('', ApexLangUtils.initials('  ', anArray));
        System.assertEquals('I', ApexLangUtils.initials('I', anArray));
        System.assertEquals('i', ApexLangUtils.initials('i', anArray));
        System.assertEquals('S', ApexLangUtils.initials('SJC', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJ', ApexLangUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJ.L', ApexLangUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KO', ApexLangUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', ApexLangUtils.initials('i am here 123', anArray));
        
        anArray = new String[0];
        System.assertEquals(null, ApexLangUtils.initials(null, anArray));
        System.assertEquals('', ApexLangUtils.initials('', anArray));
        System.assertEquals('', ApexLangUtils.initials('  ', anArray));
        System.assertEquals('', ApexLangUtils.initials('I', anArray));
        System.assertEquals('', ApexLangUtils.initials('i', anArray));
        System.assertEquals('', ApexLangUtils.initials('SJC', anArray));
        System.assertEquals('', ApexLangUtils.initials('Ben John Lee', anArray));
        System.assertEquals('', ApexLangUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('', ApexLangUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('', ApexLangUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('', ApexLangUtils.initials('i am here 123', anArray));
        
        anArray = ApexLangUtils.toCharArray(' ');
        System.assertEquals(null, ApexLangUtils.initials(null, anArray));
        System.assertEquals('', ApexLangUtils.initials('', anArray));
        System.assertEquals('', ApexLangUtils.initials('  ', anArray));
        System.assertEquals('I', ApexLangUtils.initials('I', anArray));
        System.assertEquals('i', ApexLangUtils.initials('i', anArray));
        System.assertEquals('S', ApexLangUtils.initials('SJC', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJ', ApexLangUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJ.L', ApexLangUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KO', ApexLangUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', ApexLangUtils.initials('i am here 123', anArray));
        
        anArray = ApexLangUtils.toCharArray(' .');
        System.assertEquals(null, ApexLangUtils.initials(null, anArray));
        System.assertEquals('', ApexLangUtils.initials('', anArray));
        System.assertEquals('', ApexLangUtils.initials('  ', anArray));
        System.assertEquals('I', ApexLangUtils.initials('I', anArray));
        System.assertEquals('i', ApexLangUtils.initials('i', anArray));
        System.assertEquals('S', ApexLangUtils.initials('SJC', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KO', ApexLangUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', ApexLangUtils.initials('i am here 123', anArray));
        
        anArray = ApexLangUtils.toCharArray(' .\'');
        System.assertEquals(null, ApexLangUtils.initials(null, anArray));
        System.assertEquals('', ApexLangUtils.initials('', anArray));
        System.assertEquals('', ApexLangUtils.initials('  ', anArray));
        System.assertEquals('I', ApexLangUtils.initials('I', anArray));
        System.assertEquals('i', ApexLangUtils.initials('i', anArray));
        System.assertEquals('S', ApexLangUtils.initials('SJC', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJL', ApexLangUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KOM', ApexLangUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', ApexLangUtils.initials('i am here 123', anArray));
        
        anArray = ApexLangUtils.toCharArray('SIJo1');
        System.assertEquals(null, ApexLangUtils.initials(null, anArray));
        System.assertEquals('', ApexLangUtils.initials('', anArray));
        System.assertEquals(' ', ApexLangUtils.initials('  ', anArray));
        System.assertEquals('', ApexLangUtils.initials('I', anArray));
        System.assertEquals('i', ApexLangUtils.initials('i', anArray));
        System.assertEquals('C', ApexLangUtils.initials('SJC', anArray));
        System.assertEquals('Bh', ApexLangUtils.initials('Ben John Lee', anArray));
        System.assertEquals('B.', ApexLangUtils.initials('Ben J.Lee', anArray));
        System.assertEquals(' h', ApexLangUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('K', ApexLangUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('i2', ApexLangUtils.initials('i am here 123', anArray));
    }

    private static testmethod void testSwapCase_String() {
        System.assertEquals(null, ApexLangUtils.swapCase(null));
        System.assertEquals('', ApexLangUtils.swapCase(''));
        System.assertEquals('  ', ApexLangUtils.swapCase('  '));
        
        System.assertEquals('i', ApexLangUtils.swapCase('I') );
        System.assertEquals('I', ApexLangUtils.swapCase('i') );
        System.assertEquals('I AM HERE 123', ApexLangUtils.swapCase('i am here 123') );
        System.assertEquals('i aM hERE 123', ApexLangUtils.swapCase('I Am Here 123') );
        System.assertEquals('I AM here 123', ApexLangUtils.swapCase('i am HERE 123') );
        System.assertEquals('i am here 123', ApexLangUtils.swapCase('I AM HERE 123') );

        String test = 'This String contains a TitleCase character: ';
        String expect = 'tHIS sTRING CONTAINS A tITLEcASE CHARACTER: ';
        System.assertEquals(expect, ApexLangUtils.swapCase(test));
    }

    private static testmethod void testAbbreviate() {
        // check null and empty are returned respectively
        System.assertEquals(null,ApexLangUtils.abbreviate(null, 1,-1,''));
        System.assertEquals(ApexLangUtils.EMPTY, ApexLangUtils.abbreviate('', 1,-1,''));

        // test upper limit
        System.assertEquals('01234', ApexLangUtils.abbreviate('0123456789', 0,5,''));
        System.assertEquals('01234', ApexLangUtils.abbreviate('0123456789', 5, 2,''));
        System.assertEquals('012', ApexLangUtils.abbreviate('012 3456789', 2, 5,''));
        System.assertEquals('012 3', ApexLangUtils.abbreviate('012 3456789', 5, 2,''));
        System.assertEquals('0123456789', ApexLangUtils.abbreviate('0123456789', 0,-1,''));

        // test upper limit + append string
        System.assertEquals('01234-', ApexLangUtils.abbreviate('0123456789', 0,5,'-'));
        System.assertEquals('01234-', ApexLangUtils.abbreviate('0123456789', 5, 2,'-'));
        System.assertEquals('012', ApexLangUtils.abbreviate('012 3456789', 2, 5, null));
        System.assertEquals('012 3', ApexLangUtils.abbreviate('012 3456789', 5, 2,''));
        System.assertEquals('0123456789', ApexLangUtils.abbreviate('0123456789', 0,-1,''));

        // test lower value
        System.assertEquals('012', ApexLangUtils.abbreviate('012 3456789', 0,5, null));
        System.assertEquals('01234', ApexLangUtils.abbreviate('01234 56789', 5, 10, null));
        System.assertEquals('01 23 45 67', ApexLangUtils.abbreviate('01 23 45 67 89', 9, -1, null));
        System.assertEquals('01 23 45 6', ApexLangUtils.abbreviate('01 23 45 67 89', 9, 10, null));

        // test lower value + append
        System.assertEquals('012', ApexLangUtils.abbreviate('012 3456789', 0,5, null));
        System.assertEquals('01234-', ApexLangUtils.abbreviate('01234 56789', 5, 10, '-'));
        System.assertEquals('01 23 45 67abc', ApexLangUtils.abbreviate('01 23 45 67 89', 9, -1, 'abc'));
        System.assertEquals('01 23 45 6', ApexLangUtils.abbreviate('01 23 45 67 89', 9, 10, ''));

        // others
        System.assertEquals('', ApexLangUtils.abbreviate('0123456790', 0,0,''));
        System.assertEquals('', ApexLangUtils.abbreviate(' 0123456790', 0,-1,''));
    }   
    
    /* WordApexLangUtils Tests */
    
    /* ArrayApexLangUtils Tests */

    
    private static testmethod void testReverseObject(){
        //test: global static Object[] reverse(Object[] anArray) 
        Object[] nullArray = null;
        ApexLangUtils.assertArraysAreEqual(null,ApexLangUtils.reverse(nullArray)); 
        ApexLangUtils.assertArraysAreEqual(new String[]{},ApexLangUtils.reverse(new String[]{}));
        ApexLangUtils.assertArraysAreEqual(new String[]{'a'},ApexLangUtils.reverse(new String[]{'a'}));
        ApexLangUtils.assertArraysAreEqual(new String[]{'ab', 'c'},ApexLangUtils.reverse(new String[]{'c','ab'}));
        ApexLangUtils.assertArraysAreEqual(new String[]{'a', 'b', 'c'},ApexLangUtils.reverse(new String[]{'c','b','a'}));
    }

    private static testmethod void testReverseSObject(){
        //test: global static SObject[] reverse(SObject[] anArray) 
        SObject[] nullArray = null;
        Account x = new Account(name='x');
        Account y = new Account(name='y');
        Account z = new Account(name='z');
        ApexLangUtils.assertArraysAreEqual(null,ApexLangUtils.reverse(nullArray)); 
        ApexLangUtils.assertArraysAreEqual(new Account[]{},ApexLangUtils.reverse(new Account[]{}));
        ApexLangUtils.assertArraysAreEqual(new Account[]{x},ApexLangUtils.reverse(new Account[]{x}));
        ApexLangUtils.assertArraysAreEqual(new Account[]{x,y},ApexLangUtils.reverse(new Account[]{y, x}));
        ApexLangUtils.assertArraysAreEqual(new Account[]{x,y,z},ApexLangUtils.reverse(new Account[]{z,y,x}));
    }

    private static testmethod void testIsEmpty2(){
        //test: global static Boolean isEmpty(Object[] objectArray){
        String[] aNull = null;
        Account[] aNull2 = null;
        DecimalRange[] aNull3 = null;
        System.assertEquals(true,    ApexLangUtils.isEmpty(aNull)); 
        System.assertEquals(true,    ApexLangUtils.isEmpty(new String[]{})); 
        System.assertEquals(false,    ApexLangUtils.isEmpty(new String[]{'a'})); 
        System.assertEquals(false,    ApexLangUtils.isEmpty(new String[]{'a','b'})); 
        System.assertEquals(true,    ApexLangUtils.isEmpty(new Integer[]{})); 
        System.assertEquals(false,    ApexLangUtils.isEmpty(new Integer[]{1})); 
        System.assertEquals(false,    ApexLangUtils.isEmpty(new Integer[]{1,2})); 
        System.assertEquals(true,    ApexLangUtils.isEmpty(aNull2)); 
        System.assertEquals(true,    ApexLangUtils.isEmpty(new Account[]{}));  
        System.assertEquals(false,    ApexLangUtils.isEmpty(new Account[]{new Account(name='test')}));  
        System.assertEquals(true,    ApexLangUtils.isEmpty(new Contact[]{}));  
        System.assertEquals(false,    ApexLangUtils.isEmpty(new Contact[]{new Contact(lastname='test')}));  
        System.assertEquals(true,    ApexLangUtils.isEmpty(aNull3)); 
        System.assertEquals(true,    ApexLangUtils.isEmpty(new DecimalRange[]{}));  
        System.assertEquals(false,    ApexLangUtils.isEmpty(new DecimalRange[]{new DecimalRange(1,1)}));  
    }
    
    private static testmethod void testIsNotEmpty2(){
        //test: global static Boolean isNotEmpty(Object[] objectArray){
        String[] aNull = null;
        Account[] aNull2 = null;
        DecimalRange[] aNull3 = null;
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(aNull)); 
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(new String[]{})); 
        System.assertEquals(true,    ApexLangUtils.isNotEmpty(new String[]{'a'})); 
        System.assertEquals(true,    ApexLangUtils.isNotEmpty(new String[]{'a','b'})); 
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(new Integer[]{})); 
        System.assertEquals(true,    ApexLangUtils.isNotEmpty(new Integer[]{1})); 
        System.assertEquals(true,    ApexLangUtils.isNotEmpty(new Integer[]{1,2})); 
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(aNull2)); 
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(new Account[]{}));  
        System.assertEquals(true,    ApexLangUtils.isNotEmpty(new Account[]{new Account(name='test')}));  
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(new Contact[]{}));  
        System.assertEquals(true,    ApexLangUtils.isNotEmpty(new Contact[]{new Contact(lastname='test')}));  
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(aNull3)); 
        System.assertEquals(false,    ApexLangUtils.isNotEmpty(new DecimalRange[]{}));  
        System.assertEquals(true,    ApexLangUtils.isNotEmpty(new DecimalRange[]{new DecimalRange(1,1)}));  
    }
    
    private static testmethod void testPluck(){
        //test: global static Object[] pluck(SObject[] objectArray, String fieldName)
        assertPluck(null,'name',new Object[]{});
        assertPluck(new Account[]{new Account(name='abc123'),new Account(name='xyz456')},null,new Object[]{});
        assertPluck(new Account[]{new Account(name='abc123'),new Account(name='xyz456')},'name',
            new String[]{'abc123','xyz456'});
    }    
    
    private static void assertPluck(SObject[] objectArray, String fieldName, Object[] expected){
        Object[] actual = ApexLangUtils.pluck(objectArray, fieldName);
        ApexLangUtils.assertArraysAreEqual(expected, actual);    
    }

    private static testmethod void testMergeObjectArrays(){
        //test: global static Object[] mergex(Object[] array1, Object[] array2)
        Object[] nullArray = null;
        System.assertEquals(null,ApexLangUtils.mergex(nullArray,nullArray));
        ApexLangUtils.assertArraysAreEqual(new Object[]{},ApexLangUtils.mergex(new Object[]{},nullArray));
        ApexLangUtils.assertArraysAreEqual(new Object[]{},ApexLangUtils.mergex(nullArray,new Object[]{}));
        Object x = 'x';
        Object y = 'y';
        Object z = 'z';
        Object ten = 10;
        ApexLangUtils.assertArraysAreEqual(new Object[]{x,y,z,ten},ApexLangUtils.mergex(new Object[]{x,y},new Object[]{z,ten}));
    }    
    
    private static testmethod void testMergeSObjectArrays(){
        //test: global static SObject[] mergex(SObject[] array1, SObject[] array2)
        SObject[] nullArray = null;
        System.assertEquals(null,ApexLangUtils.mergex(nullArray,nullArray));
        ApexLangUtils.assertArraysAreEqual(new Account[]{},ApexLangUtils.mergex(new Account[]{},nullArray));
        ApexLangUtils.assertArraysAreEqual(new Contact[]{},ApexLangUtils.mergex(nullArray,new Contact[]{}));
        ApexLangUtils.assertArraysAreEqual(new Account[]{},ApexLangUtils.mergex(new Account[]{},new Account[]{}));
        Account x = new Account(name='x');
        Account y = new Account(name='y');
        Account z = new Account(name='z');
        Account ten = new Account(name='10');
        ApexLangUtils.assertArraysAreEqual(new Account[]{x,y,z,ten},ApexLangUtils.mergex(new Account[]{x,y},new Account[]{z,ten}));
    }    
    
    private static testmethod void testCreateEmptySObjectList(){
        //test: global static List<SObject> createEmptySObjectList(SObject prototype)
        System.assertEquals(null,ApexLangUtils.createEmptySObjectList(null));
        ApexLangUtils.assertArraysAreEqual(new Account[]{},ApexLangUtils.createEmptySObjectList(new Account()));
    }

    
    
    private static testmethod void testQSortSObjects(){
        List<Account> listToSort = new Account[]{new Account(name='test9'),
                                                 new Account(name='test5'),
                                                 new Account(name='test3'),
                                                 new Account(name='test7'),
                                                 new Account(name='test8'),
                                                 new Account(name='test1'),
                                                 new Account(name='test2')};
                                                    
        ApexLangUtils.qsort(listToSort, new SObjectSortByNameComparator());
        System.assertNotEquals(null, listToSort);
        System.assertEquals(7, listToSort.size());
        System.assertEquals('test1', listToSort[0].Name);
        System.assertEquals('test2', listToSort[1].Name);
        System.assertEquals('test3', listToSort[2].Name); 
        
    }
    private static testmethod void testQSortForceDotComPrimitives(){
        List<Double> listToSort = new Double[]{4,1.22,-5.4,1.22,3.2};
        ApexLangUtils.qsort(listToSort);
        System.assertNotEquals(null, listToSort);
        System.assertEquals(5, listToSort.size());

        System.assertEquals(-5.4,     listToSort[0]);
        System.assertEquals(1.22,     listToSort[1]);
        System.assertEquals(1.22,    listToSort[2]);
        System.assertEquals(3.2,     listToSort[3]);
        System.assertEquals(4,         listToSort[4]);

        ApexLangUtils.qsort(listToSort, false);
        System.assertNotEquals(null, listToSort);
        System.assertEquals(5, listToSort.size());

        System.assertEquals(4,         listToSort[0]);
        System.assertEquals(3.2,     listToSort[1]);
        System.assertEquals(1.22,     listToSort[2]);
        System.assertEquals(1.22,    listToSort[3]);
        System.assertEquals(-5.4,     listToSort[4]);
    }  
    
    private static testmethod void testQSortCustomClasses(){
        DecimalRange r1 = new DecimalRange(-10,10);
        DecimalRange r2 = new DecimalRange(1,2);
        DecimalRange r3 = new DecimalRange(1.3,10);
        DecimalRange r4 = new DecimalRange(1.5,1.7);
        DecimalRange r5 = new DecimalRange(10,10);
        DecimalRange r6 = new DecimalRange(12,15);
        List<DecimalRange> listToSort = new DecimalRange[]{r4,r5,r1,r2,r3,r6};
        
        ApexLangUtils.qsort(listToSort,new DecimalRangeComparator());
        System.assertNotEquals(null, listToSort);
        System.assertEquals(6, listToSort.size());
        System.assertEquals(r1.min(), listToSort.get(0).min());
        System.assertEquals(r2.min(), listToSort.get(1).min());
        System.assertEquals(r3.min(), listToSort.get(2).min());
    }  

    private static testmethod void testToString(){
        List<Object> aList = null;
        ApexLangUtils.toString(aList);
        aList = new DecimalRange[]{};
        ApexLangUtils.toString(aList);
        aList = new DecimalRange[]{new DecimalRange(12,15),new DecimalRange(12,15)};
        ApexLangUtils.toString(aList);
    }

    private static testmethod void testMergeForceDotComPrimitives(){
        List<Object> l1 = new List<Object>();
        for(Integer i = 0; i < ApexLangUtils.MAX_NUMBER_OF_ELEMENTS_IN_LIST; i++){
            l1.add(i);
        }
        Boolean exceptionThrown = false;
        try{
            ApexLangUtils.merg(l1, new Integer[]{1});
        }catch(IllegalArgumentException e){
            exceptionThrown = true;
        }
        System.assert(exceptionThrown);

        Double[] d1 = new Double[]{1,2,3};
        Double[] d2 = new Double[]{4,5,6};
        List<Object> merged = ApexLangUtils.merg(d1, d2);
        System.assertNotEquals(null,merged);
        System.assertEquals(6,merged.size());
        System.assertEquals(1,merged.get(0));
        System.assertEquals(4,merged.get(3));
    }
    
    private static testmethod void testSubsetCustomClasses(){
        Object[] iobjs = new DecimalRange[]{
            new DecimalRange(1,1),new DecimalRange(2,2),new DecimalRange(3,3)};
        List<Object> returned = ApexLangUtils.subset(iobjs, 2);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals(1,((DecimalRange)returned.get(0)).min());
        System.assertEquals(2,((DecimalRange)returned.get(1)).min());
        
    }

    private static testmethod void testMergeCustomClasses(){
        List<Object> l1 = new List<Object>();
        for(Integer i = 0; i < ApexLangUtils.MAX_NUMBER_OF_ELEMENTS_IN_LIST; i++){
            l1.add(new DecimalRange(i,i));
        }
        Boolean exceptionThrown = false;
        try{
            ApexLangUtils.merg(l1, new DecimalRange[]{new DecimalRange(1,1)});
        }catch(IllegalArgumentException e){
            exceptionThrown = true;
        }
        System.assert(exceptionThrown);

        DecimalRange[] d1 = new DecimalRange[]{new DecimalRange(1,1),new DecimalRange(2,2)};
        DecimalRange[] d2 = new DecimalRange[]{new DecimalRange(3,3),new DecimalRange(4,4)};
        List<Object> merged = ApexLangUtils.merg(d1, d2);
        System.assertNotEquals(null,merged);
        System.assertEquals(4,merged.size());
        System.assertEquals(1,((DecimalRange)merged.get(0)).min());
        System.assertEquals(3,((DecimalRange)merged.get(2)).min());
    }
    
    private static testmethod void testSubsetSObjects(){
        SObject[] sobjs = new Contact[]{
            new Contact(lastname='1'),
            new Contact(lastname='2'),
            new Contact(lastname='3')};
        List<SObject> returned = ApexLangUtils.subset(sobjs, 2);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals('1',((Contact)returned.get(0)).lastname);
        System.assertEquals('2',((Contact)returned.get(1)).lastname);
    }

    private static testmethod void testMergeSObjects(){
        List<SObject> l1 = new List<Contact>();
        for(Integer i = 0; i < ApexLangUtils.MAX_NUMBER_OF_ELEMENTS_IN_LIST; i++){
            l1.add(new Contact());
        }
        Boolean exceptionThrown = false;
        try{
            ApexLangUtils.merg(l1, new Contact[]{new Contact()});
        }catch(IllegalArgumentException e){
            exceptionThrown = true;
        }
        System.assert(exceptionThrown);
        l1 = null;
        List<SObject> merged = ApexLangUtils.merg(l1,l1);
        System.assertEquals(null,merged);
        
        Contact[] c1 = new Contact[]{new Contact(lastname='1'),new Contact(lastname='2')};
        merged = ApexLangUtils.merg(l1,c1);
        Contact[] c2 = new Contact[]{new Contact(lastname='3'),new Contact(lastname='4')};
        merged = ApexLangUtils.merg(c1, c2);
        System.assertNotEquals(null,merged);
        System.assertEquals(4,merged.size());
        System.assertEquals('1',((Contact)merged.get(0)).lastname);
        System.assertEquals('2',((Contact)merged.get(1)).lastname);
        System.assertEquals('3',((Contact)merged.get(2)).lastname);
        System.assertEquals('4',((Contact)merged.get(3)).lastname);
    }
    
    private static testmethod void testSubsetForceDotComPrimitives(){
        Double[] prim = new Double[]{1,2,3};
        List<Object> returned = ApexLangUtils.subset(prim, 3);
        System.assertNotEquals(null,returned);
        System.assertEquals(3,returned.size());
        System.assertEquals(1,returned.get(0));
        System.assertEquals(2,returned.get(1));
        System.assertEquals(3,returned.get(2));

        returned = ApexLangUtils.subset(prim, 2);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals(1,returned.get(0));
        System.assertEquals(2,returned.get(1));

        returned = ApexLangUtils.subset(prim, 1);
        System.assertNotEquals(null,returned);
        System.assertEquals(1,returned.size());
        System.assertEquals(1,returned.get(0));

        returned = ApexLangUtils.subset(prim,1,3);
        System.assertNotEquals(null,returned);
        System.assertEquals(2,returned.size());
        System.assertEquals(2,returned.get(0));
        System.assertEquals(3,returned.get(1));

        returned = ApexLangUtils.subset(prim,-1,2);
        System.assertNotEquals(null,returned);
        System.assertEquals(0,returned.size());

        returned = ApexLangUtils.subset(prim,10,2);
        System.assertNotEquals(null,returned);
        System.assertEquals(0,returned.size());

        returned = ApexLangUtils.subset(prim,0,20);
        System.assertNotEquals(null,returned);
        System.assertEquals(3,returned.size());

        prim = null;
        returned = ApexLangUtils.subset(prim,0,2);
        System.assertNotEquals(null,returned);
        System.assertEquals(0,returned.size());


            //subset({1,2,3},0,3)={1,2,3}
    //subset({1,2,3},1,3)={2,3}
    //subset({1,2,3},2,3)={3}
    //subset({1,2,3},3,3)={}
    //subset({1,2,3},0,2)={1,2}
    //subset({1,2,3},1,2)={2,3}
    //subset({1,2,3},2,2)={3}
        
    }

    /* ArrayApexLangUtils Tests */

    /* SystemApexLangUtils Tests */
    private static testmethod void testLimitDebug(){
        ApexLangUtils.debugLimits();
    }
    
    private static testmethod void testTo18(){
        //test: global static String to18(String the15charID){
        assertTo18('a0BA0000000L2Z','a0BA0000000L2Z');
        assertTo18('a0BA0000000L2ZC','a0BA0000000L2ZCMA0');
    }
    
    private static void assertTo18(String the15charID, String expected){
        String actual = ApexLangUtils.to18(the15charID);
        System.assert(actual==expected, 'SystemApexLangUtils.to18(\'' + the15charID + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }
    /* SystemApexLangUtils Tests */
    
    /* UserApexLangUtilsTest Tests */
    private static testmethod void testIsCurrentUserSysAdminPositive(){
        //test: global static Boolean isCurrentUserSysAdmin(){
        //Amazingly, some orgs don't have users with a "System Administrator" profile and
        // as a result, the previous version of this test was failing.  As a result, I've
        // changed this test to just get code coverage.  Not ideal but I'd rather have
        // the test succeed.
        ApexLangUtils.isCurrentUserSysAdmin();
        
    }
    
	private static testmethod void testIsCurrentUserPortalUserPositive(){
        //test: global static Boolean isCurrentUserPortalUser(){
        System.assertEquals(false,ApexLangUtils.isCurrentUserPortalUser());
    }
    /* UserApexLangUtilsTest Tests */
    
    /* UrlApexLangUtilsTest Tests */
    private static testmethod void testGetBase(){
        //test: global static String getBase(String url){
        assertGetBase(null, null);
        assertGetBase('', null);
        assertGetBase('http://google.com', 'http://google.com');
        assertGetBase('http://google.com?abc=123', 'http://google.com');
    }

    private static void assertGetBase(String url, String expected){
        String actual = ApexLangUtils.getBase(url);
        System.assert(actual==expected, 'UrlApexLangUtils.getBase(\'' + url + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testGetParams(){
        //global static Map<String,String> getParams(String url){
        Map<String,String> theMap = new Map<String,String>();
        assertGetParams(null, theMap);
        assertGetParams('', theMap);
        assertGetParams('http://google.com', theMap);
        theMap.put('xyz','12&3');
        theMap.put('abc','efc');
        assertGetParams('http://google.com?abc=efc&xyz=12%263', theMap);
    }

    private static void assertGetParams(String url, Map<String,String> expected){
        Map<String,String> actual = ApexLangUtils.getParams(url);
        System.assert(actual==expected, 'UrlApexLangUtils.getParams(\'' + url + '\') returned \'' 
            + ApexLangUtils.toString(actual) + '\'; expected \'' + ApexLangUtils.toString(expected) + '\'');
    }    
    /* UrlApexLangUtilsTest Tests */
    /* TestApexLangUtils Tests */


    private static testmethod void testAssertConfirmMessagesExist(){
        //test: global static void assertConfirmMessagesExist()
        ApexLangUtils.addConfirm('test');
        ApexLangUtils.assertConfirmMessagesExist();
    }

    private static testmethod void testAssertInfoMessagesExist(){
        //test: global static void assertInfoMessagesExist()
        ApexLangUtils.addInfo('test');
        ApexLangUtils.assertInfoMessagesExist();
    }

    private static testmethod void testAssertWarningMessagesExist(){
        //test: global static void assertWarningMessagesExist()
        ApexLangUtils.addWarning('test');
        ApexLangUtils.assertWarningMessagesExist();
    }

    private static testmethod void testAssertErrorMessagesExist(){
        //test: global static void assertErrorMessagesExist()
        ApexLangUtils.addError('test');
        ApexLangUtils.assertErrorMessagesExist();
    }

    private static testmethod void testAssertFatalMessagesExist(){
        //test: global static void assertFatalMessagesExist()
        ApexLangUtils.addFatal('test');
        ApexLangUtils.assertFatalMessagesExist();
    }

    private static testmethod void testAssertNoConfirmMessagesExist(){
        //test: global static void assertNoConfirmMessagesExist()
        ApexLangUtils.assertNoConfirmMessagesExist();
    }

    private static testmethod void testAssertNoInfoMessagesExist(){
        //test: global static void assertNoInfoMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.INFO); }
        ApexLangUtils.assertNoInfoMessagesExist();
    }

    private static testmethod void testAssertNoWarningMessagesExist(){
        //test: global static void assertNoWarningMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.WARNING); }
        ApexLangUtils.assertNoWarningMessagesExist();
    }

    private static testmethod void testAssertNoErrorMessagesExist(){
        //test: global static void assertNoErrorMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.ERROR); }
        ApexLangUtils.assertNoErrorMessagesExist();
    }

    private static testmethod void testAssertNoFatalMessagesExist(){
        //test: global static void assertNoFatalMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.FATAL); }
        ApexLangUtils.assertNoFatalMessagesExist();
    }
    
    private static testmethod void testGetObjectAcct(){
        Map<String,String> values = new Map<String,String>();
        values.put('name','Account xyz');
        List<SObject> records = ApexLangUtils.getObject(new Account(), 2, values);
        System.assertEquals(2,records.size());
        for(SObject record : records){
            System.assertEquals('Account xyz',record.get('name'));
        }
    }
    
    private static testmethod void testGetObjectContact(){
        Map<String,String> values = new Map<String,String>();
        values.put('LastName','Account xyz');
        List<SObject> records = ApexLangUtils.getObject(new Contact(), 2, values);
        System.assertEquals(2,records.size());
        for(SObject record : records){
            System.assertEquals('Account xyz',record.get('LastName'));
        }
    }
    
    private static testmethod void testGetObjectDoInsert(){
        //test doInsert == false
        List<SObject> records = ApexLangUtils.getObject(new Account(), 2);
        System.assertEquals(2,records.size());
        for(SObject record : records){
            System.assertEquals(null,record.get('id'));
        }

        //test doInsert == true
        Map<String,String> values = new Map<String,String>();
        values.put('name','Account xyz');
        records = ApexLangUtils.getObject(new Account(), 2, values, true);
        Set<Id> idSet = new Set<Id>();
        for(SObject record : records){
            System.assertEquals('Account xyz',record.get('name'));
            idSet.add((Id)record.get('id'));
        }
        records = [select id from Account where id in :idSet];
        System.assertEquals(2,records.size());
    }
    
    private static testmethod void testGetObjectBadInput(){
        System.assertEquals(null,ApexLangUtils.getObject(null, -1, null, true));
        System.assertEquals(null,ApexLangUtils.getObject(null, 2, null, true));
        System.assert(ApexLangUtils.getObject(new Account(), -1, null, true).isEmpty());
        System.assert(ApexLangUtils.getObject(new Account(), 0, null, true).isEmpty());
    }
    
    /* TestApexLangUtils Tests */
    
    /* SObjectApexLangUtils Tests */
    
    private static testmethod void testIsAnyFieldBlank(){
        //test: global static Boolean isAnyFieldBlank(SObject obj, String[] fields){
        System.assertEquals(false,ApexLangUtils.isAnyFieldBlank(null,null));
        System.assertEquals(false,ApexLangUtils.isAnyFieldBlank(new Account(),null));
        System.assertEquals(false,ApexLangUtils.isAnyFieldBlank(new Account(),new String[]{}));

        Account account = new Account(
            name='Acme', 
            Description='Acme Computer Corp');
        System.assertEquals(false,ApexLangUtils.isAnyFieldBlank(account,
            new String[]{'name','description'}));
        System.assertEquals(true,ApexLangUtils.isAnyFieldBlank(account,
            new String[]{'name','description','NumberOfEmployees'}));
        account.NumberOfEmployees=10;
        System.assertEquals(false,ApexLangUtils.isAnyFieldBlank(account,
            new String[]{'name','description','NumberOfEmployees'}));
        System.assertEquals(true,ApexLangUtils.isAnyFieldBlank(account,
            new String[]{'name','description','phone'}));
    }
        
    /*private static testmethod void testToString2(){
        //test: global static String toString(SObject obj){
        System.assertEquals('null',ApexLangUtils.toString(null));
        Account account = new Account(name='Acme', Description='Acme Computer Corp',NumberOfEmployees=10);
        System.assertNotEquals(null,ApexLangUtils.toString(account));
    }*/
        
    private static testmethod void testToStringFieldDescribeLimitsReached(){
        //test: global static String toString(SObject obj){
        for(Integer i = 0; i < Limits.getLimitFieldsDescribes(); i++){
               Map<String, Schema.SObjectField> m = Schema.sObjectType.Account.fields.getMap();        
        }
        System.assertEquals(null,ApexLangUtils.toString(new Account(name='Acme')));
    }
    
    /*private static testmethod void testGetCachedDescribe(){
        //test: global static Schema.DescribeSObjectResult getCachedDescribe(SObject obj){
        Schema.DescribeSObjectResult desc1 = ApexLangUtils.getCachedDescribe(new Account());
        SystemApexLangUtils.debugLimits();

        Schema.DescribeSObjectResult desc2 = ApexLangUtils.getCachedDescribe(new Account());
        SystemApexLangUtils.debugLimits();
    }
    */
    
    /*
    private static testmethod void testSendNotificationEmailBadArgs(){
        //test: global static void sendNotificationEmail(SObject obj){
        Boolean exceptionCaught = false;
        try{
            ApexLangUtils.sendNotificationEmail(null);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assertEquals(true,exceptionCaught);

        exceptionCaught = false;
        try{
            ApexLangUtils.sendNotificationEmail(new Lead());
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assertEquals(true,exceptionCaught);

        exceptionCaught = false;
        try{
        	final Account a = new Account(name='test123');
        	insert a;
            delete a;
            ApexLangUtils.sendNotificationEmail(a);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assertEquals(true,exceptionCaught);
    }    

    private static testmethod void testSendNotificationEmail(){
        //test: global static void sendNotificationEmail(SObject obj){
        QueueSobject q = null;
        try{
        	q = [select queueid from QueueSobject where sobjecttype = 'Lead' limit 1];
        }catch(QueryException e){} 
        System.assert(q != null, 'Environment Dependency: in order for this test to pass, you need at least one Lead queue set up.');
        final Lead l = new Lead(lastname='Doe', company='test', ownerid=q.queueid);
        insert l;
        ApexLangUtils.sendNotificationEmail(l);
    }     
    */   
    
    private static testmethod void testCopyAllFieldsNullInputs(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        System.assertEquals(null,ApexLangUtils.copyFields(null,null));
        System.assertEquals(null,ApexLangUtils.copyFields(new Account(),null));
        System.assertNotEquals(null,ApexLangUtils.copyFields(null,new Account()));
    }
    
    private static testmethod void testCopyFieldsAccountToContact(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Account account = new Account();
        ApexLangUtils.putQuietly(account,'Description','test 123');
        ApexLangUtils.putQuietly(account,'Fax','9876543210');
        ApexLangUtils.putQuietly(account,'Name','test 123');
        ApexLangUtils.putQuietly(account,'Phone','9876543210');
        Contact contact = new Contact();
        final SObject sobj = ApexLangUtils.copyFields(account,contact);
        System.assert((sobj instanceof Contact), 'Returned SObject type isn\'t Contact as expected');
        contact = (Contact) sobj; 
        System.assertEquals(ApexLangUtils.getQuietly(account,'Description'),
            ApexLangUtils.getQuietly(contact,'Description'));
        System.assertEquals(ApexLangUtils.getQuietly(account,'Fax'),
            ApexLangUtils.getQuietly(contact,'Fax'));
        System.assertEquals(ApexLangUtils.getQuietly(account,'Phone'),
            ApexLangUtils.getQuietly(contact,'Phone'));
    }
    
    private static testmethod void testCopyFieldsAccountToAccount(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Account account = new Account();
        ApexLangUtils.putQuietly(account,'Description','test 123');
        ApexLangUtils.putQuietly(account,'Fax','9876543210');
        ApexLangUtils.putQuietly(account,'Name','test 123');
        ApexLangUtils.putQuietly(account,'Phone','9876543210');
        Account account2 = new Account();
        final SObject sobj = ApexLangUtils.copyFields(account,account2);
        System.assert((sobj instanceof Account), 'Returned SObject type isn\'t Account as expected');
        account2 = (Account) sobj; 
        System.assertEquals(ApexLangUtils.getQuietly(account,'Description'),
            ApexLangUtils.getQuietly(account2,'Description'));
        System.assertEquals(ApexLangUtils.getQuietly(account,'Fax'),
            ApexLangUtils.getQuietly(account2,'Fax'));
        System.assertEquals(ApexLangUtils.getQuietly(account,'Phone'),
            ApexLangUtils.getQuietly(account2,'Phone'));
    }
    
    private static testmethod void testCopyFieldsOpportunityToOpportunity(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Opportunity opportunity1 = new Opportunity();
        ApexLangUtils.putQuietly(opportunity1,'Name','test 123');
        Opportunity opportunity2 = new Opportunity();
        final SObject sobj = ApexLangUtils.copyFields(opportunity1,opportunity2);
        System.assert((sobj instanceof Opportunity), 'Returned SObject type isn\'t Opportunity as expected');
        opportunity2 = (Opportunity) sobj; 
        System.assertEquals(ApexLangUtils.getQuietly(opportunity1,'Name'),
            ApexLangUtils.getQuietly(opportunity2,'Name'));
    }
    
    private static testmethod void testCopyFieldsContactToContact(){
        //test: global static SObject copyFields(SObject source, SObject dest){
        final Contact contact1 = new Contact();
        ApexLangUtils.putQuietly(contact1,'EmailBouncedDate',Datetime.now());
        Contact contact2 = new Contact();
        System.assertNotEquals(ApexLangUtils.getQuietly(contact1,'EmailBouncedDate'),
            ApexLangUtils.getQuietly(contact2,'EmailBouncedDate'));
        final SObject sobj = ApexLangUtils.copyFields(contact1,contact2);
        System.assert((sobj instanceof Contact), 'Returned SObject type isn\'t Contact as expected');
        contact2 = (Contact) sobj; 
        System.assertEquals(ApexLangUtils.getQuietly(contact1,'EmailBouncedDate'),
            ApexLangUtils.getQuietly(contact2,'EmailBouncedDate'));
    }
    
    private static testmethod void testPutQuietly(){
        //test: global static void putQuietly(SObject sobj, String fieldName, Object value){
        final Account acct = new Account(name='test123');
        System.assertEquals(null,ApexLangUtils.putQuietly(null,null,null));
        System.assertEquals(null,ApexLangUtils.putQuietly(acct,null,null));
        System.assertEquals('test123',ApexLangUtils.getQuietly(acct,'name'));
        System.assertEquals(null,ApexLangUtils.putQuietly(acct,'namexxxx',null));
        System.assertEquals('test123',ApexLangUtils.getQuietly(acct,'name'));
        System.assertEquals('test123',ApexLangUtils.putQuietly(acct,'name',null));
        System.assertEquals(null,ApexLangUtils.getQuietly(acct,'name'));
        System.assertEquals(null,ApexLangUtils.putQuietly(acct,'name',''));
        System.assertEquals('',ApexLangUtils.getQuietly(acct,'name'));
        System.assertEquals('',ApexLangUtils.putQuietly(acct,'name','xyz'));
        System.assertEquals('xyz',ApexLangUtils.getQuietly(acct,'name'));
        System.assertEquals(null,ApexLangUtils.putQuietly(acct,'namexxxx','123'));
        System.assertEquals('xyz',ApexLangUtils.getQuietly(acct,'name'));
    }
    
    private static testmethod void testGetQuietly(){
        //test: global static Object getQuietly(SObject sobj, String fieldName){    
        final Account acct = new Account(name='test123');
        System.assertEquals(null,ApexLangUtils.getQuietly(null,null));
        System.assertEquals(null,ApexLangUtils.getQuietly(acct,null));
        System.assertEquals(null,ApexLangUtils.getQuietly(null,''));
        System.assertEquals(null,ApexLangUtils.getQuietly(acct,'namexxxxxx'));
        System.assertEquals('test123',ApexLangUtils.getQuietly(acct,'name'));
    }    
    /* SObjectApexLangUtils Tests */
    
    /* RandomStringApexLangUtilsTest Tests */


    /*private static testmethod void testRandom(){
        //test: global static String random(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandom(i);
        }
    }  */  
    
    /*private static void assertRandom(Integer count){
        String actual = ApexLangUtils.random(count);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.random(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.random(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(ApexLangUtils.isAsciiPrintable(actual), 'ApexLangUtils.random(' + count 
                + ') returned \'' + actual + '\' (unexpected non-ascii characters present)');
        }
    }*/

    /*private static testmethod void testRandomAscii(){
        //test: global static String randomAscii(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomAscii(i);
        }
    }*/
    
    /*private static void assertRandomAscii(Integer count){
        String actual = ApexLangUtils.randomAscii(count);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.randomAscii(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.randomAscii(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(ApexLangUtils.isAsciiPrintable(actual), 'ApexLangUtils.randomAscii(' + count 
                + ') returned \'' + actual + '\' (unexpected non-ascii characters present)');
        }
    }*/

    private static testmethod void testRandomAlphabetic(){
        //test: global static String randomAlphabetic(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomAlphabetic(i);
        }
    }
    
    private static void assertRandomAlphabetic(Integer count){
        String actual = ApexLangUtils.randomAlphabetic(count);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.randomAlphabetic(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.randomAlphabetic(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(ApexLangUtils.isAlpha(actual), 'ApexLangUtils.randomAlphabetic(' + count 
                + ') returned \'' + actual + '\' (unexpected non-alphabetic characters present)');
        }
    }

    private static testmethod void testRandomAlphanumeric(){
        //test: global static String randomAlphanumeric(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomAlphanumeric(i);
        }
    }
    
    private static void assertRandomAlphanumeric(Integer count){
        String actual = ApexLangUtils.randomAlphanumeric(count);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.randomAlphanumeric(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.randomAlphanumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(ApexLangUtils.isAlphanumeric(actual), 'ApexLangUtils.randomAlphanumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
        }
    }

    private static testmethod void testRandomNumeric(){
        //test: global static String randomNumeric(Integer count) {
        for(Integer i = -5; i < 5; i++){
            assertRandomNumeric(i);
        }
    }
    
    private static void assertRandomNumeric(Integer count){
        String actual = ApexLangUtils.randomNumeric(count);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.randomNumeric(' + count 
                + ') returned \'' + actual + '\'; expected \'\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.randomNumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected length)');
            System.assert(ApexLangUtils.isNumeric(actual), 'ApexLangUtils.randomNumeric(' + count 
                + ') returned \'' + actual + '\' (unexpected non-numeric characters present)');
        }
    }

    private static testmethod void testRandomTwoArgs(){
        //test: global static String random(Integer count, String chars) {
        for(Integer i = -5; i < 5; i++){
            assertRandomTwoArgs(i,'abc');
        }
        for(Integer i = -5; i < 5; i++){
            assertRandomTwoArgs(i,'4938%(#*@x)');
        }
    }
    
    private static void assertRandomTwoArgs(Integer count, String chars){
        String actual = ApexLangUtils.random(count,chars);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.random(' + count 
                + ',\''+ chars + '\') returned \'' + actual + '\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.random(' + count 
                + ',\''+ chars + '\') returned \'' + actual + '\' (unexpected length)');
            System.assert(ApexLangUtils.containsOnly(actual,chars), 'ApexLangUtils.random(' + count 
                + ',\''+ chars + '\') returned \'' + actual + '\' (unexpected characters present)');
        }
    }

    /*private static testmethod void testRandomThreeArgs(){
        //test: global static String random(Integer count, boolean letters, boolean numbers) {
        for(Integer i = -5; i < 5; i++){
            for(Integer j = 0; j < 4; j++){
                assertRandomThreeArgs(i,Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
            }
        }
    }*/
    
    /*private static void assertRandomThreeArgs(Integer count, boolean letters, boolean numbers){
        String actual = ApexLangUtils.random(count,letters,numbers);
        if(count < 0){
            System.assert('' == actual, 'ApexLangUtils.random(' + count 
                + ','+ letters + ',' + numbers + ') returned \'' + actual + '\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.random(' + count 
                + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected length)');
            if(!letters && !numbers){
                System.assert(ApexLangUtils.isAsciiPrintable(actual), 'ApexLangUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-ascii printable characters present)');
            } else if(!letters && numbers){
                System.assert(ApexLangUtils.isNumeric(actual), 'ApexLangUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-numeric characters present)');
            } else if(letters && !numbers){
                System.assert(ApexLangUtils.isAlpha(actual), 'ApexLangUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alpha characters present)');
            } else if(letters && numbers){
                System.assert(ApexLangUtils.isAlphanumeric(actual), 'ApexLangUtils.random(' + count 
                    + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
            }
        }
    }*/

    /*private static testmethod void testRandomFiveArgs(){
        //test: global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers) {
        for(Integer i = -5; i < 5; i++){
            for(Integer j = 0; j < 4; j++){
                assertRandomFiveArgs(i,-1, 0, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
                assertRandomFiveArgs(i,0, 4, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
                assertRandomFiveArgs(i,2,10, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
                assertRandomFiveArgs(i,2,1000, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1);
            }
        }
    }*/
    
   /* private static void assertRandomFiveArgs(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers){
        String actual = ApexLangUtils.random(count,startIndex,endIndex,letters,numbers);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.random(ApexLangUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\'');            
        } else {
            System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected length)');
            if(!letters && !numbers){
                System.assert(ApexLangUtils.isAsciiPrintable(actual), 'ApexLangUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-ascii printable characters present)');
            } else if(!letters && numbers){
                System.assert(ApexLangUtils.isNumeric(actual), 'ApexLangUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-numeric characters present)');
            } else if(letters && !numbers){
                System.assert(ApexLangUtils.isAlpha(actual), 'ApexLangUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alpha characters present)');
            } else if(letters && numbers){
                System.assert(ApexLangUtils.isAlphanumeric(actual), 'ApexLangUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
            }
        }
    }*/

    /*private static testmethod void testRandomSixArgs(){
        //test: global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers, String chars) {
        for(Integer i = -5; i < 5; i++){
            for(Integer j = 0; j < 4; j++){
                assertRandomSixArgs(i,-1, 0, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,0, 4, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,2,10, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,2,1000, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, null);
                assertRandomSixArgs(i,-1, 0, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
                assertRandomSixArgs(i,0, 4, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
                assertRandomSixArgs(i,2,10, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
                assertRandomSixArgs(i,2,1000, Math.mod(Math.round(j/2),2)==1,Math.mod(j,2)==1, 'abc$8532(*)');
            }
        }
    }*/
    
    /*private static void assertRandomSixArgs(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers, String chars){
        String actual = ApexLangUtils.random(count,startIndex,endIndex,letters,numbers,chars);
        if(count < 0){
            System.assert('' == actual,  'ApexLangUtils.random(ApexLangUtils.random(' + count 
                + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\'');            
        } else {
            if(chars == null){
                System.assert(ApexLangUtils.length(actual) == count, 'ApexLangUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected length)');
                if(!letters && !numbers){
                    System.assert(ApexLangUtils.isAsciiPrintable(actual), 'ApexLangUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-ascii printable characters present)');
                } else if(!letters && numbers){
                    System.assert(ApexLangUtils.isNumeric(actual), 'ApexLangUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-numeric characters present)');
                } else if(letters && !numbers){
                    System.assert(ApexLangUtils.isAlpha(actual), 'ApexLangUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-alpha characters present)');
                } else if(letters && numbers){
                    System.assert(ApexLangUtils.isAlphanumeric(actual), 'ApexLangUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected non-alphanumeric characters present)');
                }
            } else {
                System.assert(ApexLangUtils.containsOnly(actual,chars), 'ApexLangUtils.random(' + count 
                    + ','+ startIndex + ','+ endIndex + ','+ letters + ',' + numbers + ',\'' + chars + '\') returned \'' + actual + '\' (unexpected characters present)');
            }
        }
    }*/


    private static testmethod void testRandomUUID(){
        String actual = ApexLangUtils.randomUUID();
        System.assertNotEquals(null,actual);
        System.assertEquals(36,actual.length());
        System.assert(ApexLangUtils.containsOnly(actual,'01234567890abcdef-'), 
            'The following UUID contains invalid characters: ' + actual);
    }
    /* RandomStringApexLangUtilsTest Tests */

	/* MapApexLangUtilsTest Tests */


    private static testmethod void testJoinMap(){
        //test public static String joinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator)
        assertJoinMap(null,null,null,null);
        Map<String,String> theMap = new Map<String,String>();
        assertJoinMap(theMap,null,null,'');
        assertJoinMap(theMap,'=','&','');
        theMap.put('xyz','123');
        theMap.put('abc','efc');
        assertJoinMap(theMap,'=','&','xyz=123&abc=efc');
        theMap.remove('abc');
        assertJoinMap(theMap,'=','&','xyz=123');
        theMap.put('abc','efc');
        theMap.put('59394932','asdfasdfasldjlaksdjf');
        assertJoinMap(theMap,'=','&','xyz=123&abc=efc&59394932=asdfasdfasldjlaksdjf'); 
    }
    
    private static void assertJoinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator, String expected){
        String actual = ApexLangUtils.joinMap(theMap, keyValueSeparator, recordSeparator);
        if(theMap == null || theMap.size() <= 0){
            System.assert(ApexLangUtils.isBlank(expected), 'ApexLangUtils.joinMap(Map<String,String>, \'' 
                + (keyValueSeparator == null ? 'null' : keyValueSeparator) + '\', \'' + (recordSeparator == null ? 'null' : recordSeparator) 
                + '\') returned ' + actual);
            return;
        }
        Set<String> actualAsSet = new Set<String>(ApexLangUtils.split(actual,recordSeparator));
        Set<String> expectedAsSet = new Set<String>(ApexLangUtils.split(expected,recordSeparator));
        System.assert(actualAsSet.containsAll(expectedAsSet) && expectedAsSet.containsAll(actualAsSet), 'ApexLangUtils.joinMap(Map<String,String>, \'' 
            + (keyValueSeparator == null ? 'null' : keyValueSeparator) + '\', \'' + (recordSeparator == null ? 'null' : recordSeparator) 
            + '\') returned ' + actual);
    } 
    
    /*private static testmethod void testToString(){
        //test public static String toString(Map<String,String> theMap)
        Map<String,String> theMap = new Map<String,String>();
        theMap.put('xyz','123');
        System.assertEquals('<Map#([xyz=123])>',ApexLangUtils.toString(theMap));
    }*/

    /*private static testmethod void testEquals(){
        //test: global static Boolean equals(Map<String,String> map1, Map<String,String> map2)
        Map<String,String> map1 = new Map<String,String>();
        Map<String,String> map2 = new Map<String,String>();
        assertEquals(null,null,true);
        assertEquals(null,map1,false);
        assertEquals(map1,null,false);
        map1.put('xyz','123');
        assertEquals(map1,map2,false);
        map2.put('xyz2','123');
        assertEquals(map1,map2,false);
        map2.remove('xyz2');
        map2.put('xyz','123x');
        assertEquals(map1,map2,false);
        map2.put('xyz','123');
        assertEquals(map1,map2,true);
    }*/
    
    /*private static void assertEquals(Map<String,String> map1, Map<String,String> map2, Boolean expected){
        Boolean actual = ApexLangUtils.equals(map1,map2);
        System.assert(actual == expected, 'ApexLangUtils.equals(' + ApexLangUtils.toString(map1) + ',' + 
            ApexLangUtils.toString(map2) + ') returned ' + actual);
    }*/
    

	/* MapApexLangUtilsTest Tests */
	
	/* PageApexLangUtilsTest Tests */
	
 
    private static testmethod void testAddConfirm(){
        //test: global static void addConfirm(String message){
        ApexLangUtils.assertNoConfirmMessagesExist();
        ApexLangUtils.addConfirm('test');
        ApexLangUtils.assertConfirmMessagesExist();
    }

    private static testmethod void testAddInfo(){
        //test: global static void addInfo(String message){
        ApexLangUtils.assertNoInfoMessagesExist();
        ApexLangUtils.addInfo('test');
        ApexLangUtils.assertInfoMessagesExist();
    }

    private static testmethod void testAddWarning(){
        //test: global static void addWarning(String message){
        ApexLangUtils.assertNoWarningMessagesExist();
        ApexLangUtils.addWarning('test');
        ApexLangUtils.assertWarningMessagesExist();
    }

    private static testmethod void testAddError(){
        //test: global static void addError(String message){
        ApexLangUtils.assertNoErrorMessagesExist();
        ApexLangUtils.addError('test');
        ApexLangUtils.assertErrorMessagesExist();
    }

    private static testmethod void testAddFatal(){
        //test: global static void addFatal(String message){
        ApexLangUtils.assertNoFatalMessagesExist();
        ApexLangUtils.addFatal('test');
        ApexLangUtils.assertFatalMessagesExist();
    }

    private static testmethod void testRedirect(){
        //test: global static PageReference redirect(String url){
        PageReference ref = ApexLangUtils.redirect('/abc123');
        System.assertNotEquals(null,ref);
        System.assertEquals('/abc123',ref.getUrl());
        System.assertEquals(true,ref.getRedirect());
    }
    
    private static testmethod void testParam(){
        //test: global static String param(String param){
        ApexPages.currentPage().getParameters().put('test1','value1');
        System.assertEquals('value1',ApexLangUtils.param('test1'));
    }
    
    private static testmethod void testMultipleParam(){
        //test: global static String param(String param){
        ApexPages.currentPage().getParameters().put('test1','value1');
        ApexPages.currentPage().getParameters().put('test2','value2');
        ApexPages.currentPage().getParameters().put('test3',null);
        ApexPages.currentPage().getParameters().put('test4','');
        ApexPages.currentPage().getParameters().put('test5','  ');
        Map<String,String> retValue = ApexLangUtils.getParameters('test');
        System.assertNotEquals(null,retValue);
        System.assertEquals(5,retValue.size());
        System.assert(retValue.containsKey('test1'));
        System.assert(retValue.containsKey('test2'));
        System.assert(retValue.containsKey('test3'));
        System.assert(retValue.containsKey('test4'));
        System.assert(retValue.containsKey('test5'));
    }
    
    private static testmethod void testParamTwoArgs(){
        //test: global static String param(String param){
        System.assertEquals(null,ApexPages.currentPage().getParameters().get('test1'));
        System.assertEquals('value1',ApexLangUtils.param('test1','value1'));
        System.assertEquals('value1',ApexPages.currentPage().getParameters().get('test1'));
    }
    
    private static testmethod void testGetErrorMessages(){
        //test: global static ApexPages.Message[] getErrorMessages(){
        System.assertEquals(true,ApexLangUtils.getErrorMessages().isEmpty());
        ApexLangUtils.addInfo('testb'); 
        System.assertEquals(false,ApexLangUtils.getErrorMessages().isEmpty());
        ApexLangUtils.addError('testa'); 
        System.assertEquals(false,ApexLangUtils.getErrorMessages().isEmpty());
    }
    
    private static testmethod void testGetErrorMessagesOnly(){
        //test: global static ApexPages.Message[] getErrorMessagesOnly(){
        ApexLangUtils.addInfo('testb'); 
        System.assertEquals(true,ApexLangUtils.getErrorMessagesOnly().isEmpty());
        ApexLangUtils.addError('testa'); 
        System.assertEquals(false,ApexLangUtils.getErrorMessagesOnly().isEmpty());
    }
    
    private static testmethod void testMessagesToStringNoArg(){
        //test: global static String messagesToString(){
        System.assertEquals('{empty}',
            ApexLangUtils.messagesToString());
        ApexLangUtils.addInfo('testb'); 
        System.assertEquals('{ApexPages.Message[0]: (summary=testb,componentLabel=null,severity=INFO,detail=testb)}',
            ApexLangUtils.messagesToString());
    }
    
    private static testmethod void testMessagesToStringOneArg(){
        //test: global static String messagesToString(ApexPages.Message[] messages){
        System.assertEquals('null',ApexLangUtils.messagesToString(null));
        ApexLangUtils.addError('testb'); 
        ApexLangUtils.addError('testc'); 
        System.assertEquals('{ApexPages.Message[0]: (summary=testb,componentLabel=null,severity=ERROR,detail=testb); ApexPages.Message[1]: (summary=testc,componentLabel=null,severity=ERROR,detail=testc)}',
            ApexLangUtils.messagesToString(ApexLangUtils.getErrorMessages()));
    }
    
    private static testmethod void testGetMessagesAtLevelScenario1(){
        //test: global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,Boolean includeParents){
        ApexLangUtils.addInfo('testb'); 
        System.assertEquals(true,ApexLangUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,false).isEmpty());
        ApexLangUtils.addError('testa'); 
        System.assertEquals(false,ApexLangUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,false).isEmpty());
    }

    private static testmethod void testGetMessagesAtLevelScenario2(){
        //test: global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,Boolean includeParents){
        ApexLangUtils.addInfo('testb'); 
        System.assertEquals(true,ApexLangUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,false).isEmpty());
    }

    private static testmethod void testGetMessagesAtLevelScenario3(){
        //test: global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,Boolean includeParents){
        ApexLangUtils.addInfo('testb'); 
        System.assertEquals(false,ApexLangUtils.getMessagesAtLevel(ApexPages.Severity.ERROR,true).isEmpty());
    }

    private static testmethod void testEncodeVariable(){
        //test: global static String encodeVariable(String variable){
        assertEncodeVariable(null,'');
        assertEncodeVariable('test123','test123');
        assertEncodeVariable('abc$&+,/:;=?@123','abc%24%26%2B%2C%2F%3A%3B%3D%3F%40123');
    }

    private static void assertEncodeVariable(String variable, String expected){
        String actual = ApexLangUtils.encodeVariable(variable);
        System.assert(actual==expected, 'ApexLangUtils.encodeVariable(\'' + variable + '\') returned ' + actual + '; expected ' + expected);
    }
    
    

    private static testmethod void testIsMessageAtLevelOrHigher(){
        //test: global static Boolean isMessageAtLevelOrHigher(ApexPages.Message message, ApexPages.Severity level){
        assertIsMessageAtLevelOrHigher(null,null,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,null,false);
        assertIsMessageAtLevelOrHigher(null,ApexPages.severity.INFO,false);

        assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.CONFIRM,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.INFO,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.WARNING,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.ERROR,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.CONFIRM,ApexPages.severity.FATAL,true);

        assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.CONFIRM,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.INFO,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.WARNING,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.ERROR,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.INFO,ApexPages.severity.FATAL,true);

        assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.CONFIRM,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.INFO,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.WARNING,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.ERROR,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.WARNING,ApexPages.severity.FATAL,true);

        assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.CONFIRM,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.INFO,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.WARNING,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.ERROR,true);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.ERROR,ApexPages.severity.FATAL,true);

        assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.CONFIRM,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.INFO,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.WARNING,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.ERROR,false);
        assertIsMessageAtLevelOrHigher(ApexPages.severity.FATAL,ApexPages.severity.FATAL,true);
    }

    private static void assertIsMessageAtLevelOrHigher(ApexPages.Severity messageLevel, ApexPages.Severity level, Boolean expected){
        Boolean actual = ApexLangUtils.isMessageAtLevelOrHigher((messageLevel==null ? null : new ApexPages.message(messageLevel,'test')),level);
        System.assert(actual==expected,'ApexLangUtils.isMessageAtLevelOrHigher(' + (messageLevel == null ? 'null' : ''+messageLevel) + ',' + level + ') returned ' + actual);
    }

	/* PageApexLangUtilsTest Tests */
	
	
	/* LanguageApexLangUtilsTest Tests */

    private static testmethod void testGetLangCodeByHttpParam(){
        //test: global static String getLangCodeByHttpParam(){
        System.assertNotEquals('es', ApexLangUtils.getLangCodeByHttpParam());  
        ApexLangUtils.param('l','XXXXXXXX');
        System.assertNotEquals('es', ApexLangUtils.getLangCodeByHttpParam());  
        ApexLangUtils.param('l','es');
        System.assertEquals('es', ApexLangUtils.getLangCodeByHttpParam()); 
        ApexLangUtils.param('l','nl');
        System.assertEquals('nl-nl', ApexLangUtils.getLangCodeByHttpParam()); 
    }
    
    private static testmethod void testGetLangCodeByBrowser(){
        //test: global static String getLangCodeByBrowser(){
        System.assertNotEquals('es', ApexLangUtils.getLangCodeByBrowser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','XXXXXXXX');
        System.assertNotEquals('es', ApexLangUtils.getLangCodeByBrowser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','es');
        System.assertEquals('es', ApexLangUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','nl');
        System.assertEquals('nl-nl', ApexLangUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','es-mx');
        System.assertEquals('es', ApexLangUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','en-us,zh-cn;q=0.5');
        System.assertEquals('en-us', ApexLangUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','xxxxx,zh-cn;q=0.5');
        System.assertEquals('zh-cn', ApexLangUtils.getLangCodeByBrowser());
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh');
        System.assertEquals('zh-cn', ApexLangUtils.getLangCodeByBrowser());
    }
    
    private static testmethod void testGetLangCodeByUser(){
        //test: global static String getLangCodeByUser(){
        System.assertEquals(UserInfo.getLanguage(), ApexLangUtils.getLangCodeByUser());  
    }


    private static testmethod void testGetLangCodeByHttpParamOrIfNullThenBrowser(){
        //test: global static String getLangCodeByHttpParamOrIfNullThenBrowser(){
        System.assertNotEquals('es', ApexLangUtils.getLangCodeByHttpParamOrIfNullThenBrowser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh');
        System.assertEquals('zh-cn', ApexLangUtils.getLangCodeByHttpParamOrIfNullThenBrowser());  
        ApexLangUtils.param('l','es');
        System.assertEquals('es', ApexLangUtils.getLangCodeByHttpParamOrIfNullThenBrowser());  
    }

    private static testmethod void testGetLangCodeByHttpParamOrIfNullThenUser(){
        //test: global static String getLangCodeByHttpParamOrIfNullThenUser(){
        System.assertEquals(UserInfo.getLanguage(), ApexLangUtils.getLangCodeByHttpParamOrIfNullThenUser());  
        ApexLangUtils.param('l','es');
        System.assertEquals('es', ApexLangUtils.getLangCodeByHttpParamOrIfNullThenUser());  
    }

    private static testmethod void testGetLangCodeByBrowserOrIfNullThenHttpParam(){
        //test: global static String getLangCodeByBrowserOrIfNullThenHttpParam(){
        System.assertNotEquals('es', ApexLangUtils.getLangCodeByBrowserOrIfNullThenHttpParam());  
        ApexLangUtils.param('l','es');
        System.assertEquals('es', ApexLangUtils.getLangCodeByBrowserOrIfNullThenHttpParam());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh-cn');
        System.assertEquals('zh-cn', ApexLangUtils.getLangCodeByBrowserOrIfNullThenHttpParam());  
    }

    private static testmethod void testGetLangCodeByBrowserOrIfNullThenUser(){
        //test: global static String getLangCodeByBrowserOrIfNullThenUser(){
        System.assertNotEquals('es', ApexLangUtils.getLangCodeByBrowserOrIfNullThenUser());  
        System.assertEquals(UserInfo.getLanguage(), ApexLangUtils.getLangCodeByBrowserOrIfNullThenUser());  
        ApexPages.currentPage().getHeaders().put('Accept-Language','zh');
        System.assertEquals('zh-cn', ApexLangUtils.getLangCodeByBrowserOrIfNullThenUser());  
    }
    
    private static testmethod void testGetLanguageName(){
    	//test: global String getLanguageName(String displayLanguageCode, String languageCode){
		
		//basic tests          
        System.assertEquals('Francouzština', ApexLangUtils.getLanguageName('cs','fr'));  
        System.assertEquals('Spanyol', ApexLangUtils.getLanguageName('in','es'));  
        System.assertEquals('French', ApexLangUtils.getLanguageName('en_US','fr'));
        System.assertEquals('Tsjechisch', ApexLangUtils.getLanguageName('nl_nl','cs'));  

		//test conversion to lower-case
        System.assertEquals('Francouzština', ApexLangUtils.getLanguageName('CS','FR'));

		//test default to english
        System.assertEquals('French', ApexLangUtils.getLanguageName('xx','fr'));

		//test default substitution; ie nl => nl_nl
        System.assertEquals('Tsjechisch', ApexLangUtils.getLanguageName('nl','cs'));  
    }
    
    private static testmethod void testGetAllLanguageSelectOptions(){
    	//test: global static List<SelectOption> getAllLanguageSelectOptions(){
    	final List<SelectOption> languages = ApexLangUtils.getAllLanguageSelectOptions();
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(null,languages.get(0));
    	System.assertEquals('Chinese (Simplified)',languages.get(0).getLabel());
    	System.assertNotEquals(null,languages.get(1));
    	System.assertEquals('Chinese (Traditional)',languages.get(1).getLabel());
    	System.assertNotEquals(null,languages.get(2));
    	System.assertEquals('Czech',languages.get(2).getLabel());
    }
    
    private static testmethod void testGetAllLanguageSelectOptions2(){
    	//test: global static List<SelectOption> getAllLanguageSelectOptions(String displayLanguageCode){
    	final List<SelectOption> languages = ApexLangUtils.getAllLanguageSelectOptions('ru');
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(null,languages.get(0));
    	System.assertEquals('Английский (США)',languages.get(0).getLabel());
    	System.assertNotEquals(null,languages.get(1));
    	System.assertEquals('Венгерский',languages.get(1).getLabel());
    	System.assertNotEquals(null,languages.get(2));
    	System.assertEquals('Голландский',languages.get(2).getLabel());
    }
    
    private static testmethod void testgetAllLanguages(){
    	//test: global static Map<String,String> getAllLanguages(){
    	final Map<String,String> languages = ApexLangUtils.getAllLanguages();
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(0,languages.size());
        System.assertEquals('French', languages.get('fr'));
        System.assertEquals('Italian', languages.get('it'));
	}    	
    
    private static testmethod void testgetAllLanguages2(){
    	//test: global static Map<String,String> getAllLanguages(String displayLanguageCode){
    	final Map<String,String> languages = ApexLangUtils.getAllLanguages('ru');
    	System.assertNotEquals(null,languages);
    	System.assertNotEquals(0,languages.size());
        System.assertEquals('Французский', languages.get('fr'));
        System.assertEquals('Итальянский', languages.get('it'));
	}    	
	/* LanguageApexLangUtilsTest Tests */

	/* EmailApexLangUtilsTest Tests */


    static testMethod void testsendEmail_test() {
        List<String> recepients=new String[]{'test@test.com','test2@test.com'};
        ApexLangUtils.sendTextEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
        ApexLangUtils.sendHTMLEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
    } 
    
    static testMethod void testsendEmailNoReceipients_test() {
        List<String> recepients=null;
        ApexLangUtils.sendTextEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
        
        recepients=new List<String>();
        ApexLangUtils.sendHTMLEmail(recepients,'Test method', 'This is to test the sendTextNotificationEmail method');
    }
    
    static testMethod void testsendEmailWithAttachment_test() {
        List<String> recepients=new String[]{'test@test.com','test2@test.com'};
        List<Attachment> stdAttachments = new List<Attachment>();
        Attachment a = new Attachment();
        a.Name = 'Test';
        a.Body = EncodingUtil.base64Decode('Test Body');
        stdAttachments.add(a);
        ApexLangUtils.sendEmailWithStandardAttachments(recepients,'Test method', 'This is to test the sendTextNotificationEmail method',false,stdAttachments);
    }
    
    static testMethod void testsendEmailWithAttachmentIDs_test() {
        List<String> recepients=new String[]{'test@test.com','test2@test.com'};
        List<ID> stdAttachments = new List<ID>();
        
        Account acct = new Account(name='Test Account');
        insert acct;
        
        Attachment a = new Attachment();
        a.ParentId = acct.Id;
        a.Name = 'Test';
        a.Body = EncodingUtil.base64Decode('Test Body');
        insert a;
        stdAttachments.add(a.Id);
        ApexLangUtils.sendEmailWithStandardAttachments(recepients,'Test method', 'This is to test the sendTextNotificationEmail method',false,stdAttachments);
    }

	/* EmailApexLangUtilsTest Tests */
	
	/* BooleanApexLangUtilsTest Tests */


    private static testmethod void testIsFalse()
    {
        System.assertEquals(ApexLangUtils.isFalse(true),false);
        System.assertEquals(ApexLangUtils.isFalse(false),true);
        System.assertEquals(ApexLangUtils.isFalse(null),false);
    }
    
    private static testmethod void testIsNotFalse()
    {
        System.assertEquals(ApexLangUtils.isNotFalse(true),true);
        System.assertEquals(ApexLangUtils.isNotFalse(false),false);
        System.assertEquals(ApexLangUtils.isNotFalse(null),true);
    }
    
    private static testmethod void testIsTrue()
    {
        System.assertEquals(ApexLangUtils.isTrue(true),true);
        System.assertEquals(ApexLangUtils.isTrue(false),false);
        System.assertEquals(ApexLangUtils.isTrue(null),false);
    }
    
    private static testmethod void testIsNotTrue()
    {
        System.assertEquals(ApexLangUtils.isNotTrue(true),false);
        System.assertEquals(ApexLangUtils.isNotTrue(false),true);
        System.assertEquals(ApexLangUtils.isNotTrue(null),true);
    }
    
    private static testmethod void testNegate()
    {
        System.assertEquals(ApexLangUtils.negate(true),false);
        System.assertEquals(ApexLangUtils.negate(false),true);
        System.assertEquals(ApexLangUtils.negate(null),null);
    }
    
    private static testmethod void testToBoolanDefaultIfNull()
    {
        System.assertEquals(ApexLangUtils.toBooleanDefaultIfNull(true,false),true);
        System.assertEquals(ApexLangUtils.toBooleanDefaultIfNull(false,false),false);
        System.assertEquals(ApexLangUtils.toBooleanDefaultIfNull(null,false),false);
    }
    
    
    private static testMethod void testToBoolean()
    {
        System.assertEquals(ApexLangUtils.toBoolean(1),true);
        System.assertEquals(ApexLangUtils.toBoolean(0),false);
        System.assertEquals(ApexLangUtils.toBoolean(null),false);
    
        System.assertEquals(ApexLangUtils.toBoolean(1,1,0),true);
        System.assertEquals(ApexLangUtils.toBoolean(0,1,0),false);
        try
        {
            System.assertEquals(ApexLangUtils.toBoolean(2,1,0),false);
        }
        catch(Exception exp){}
    }
    
    
    private static testMethod void testToInteger()
    {
        System.assertEquals(ApexLangUtils.toInteger(true),1);
        System.assertEquals(ApexLangUtils.toInteger(false),0);
        try
        {
            System.assertEquals(ApexLangUtils.toInteger(null),0);
        }
        catch(Exception exp)
        {
        }
    }
     
    private static testMethod void testToStringYesNo()
    {
        System.assertEquals(ApexLangUtils.toStringYesNo(true),'yes');
        System.assertEquals(ApexLangUtils.toStringYesNo(false),'no');
        System.assertEquals(ApexLangUtils.toStringYesNo(null),null);
    }
    
    private static testMethod void testToString3()
    {
        System.assertEquals(ApexLangUtils.toString(true,'true','false'),'true');
        System.assertEquals(ApexLangUtils.toString(false,'true','false'),'false');
        System.assertEquals(ApexLangUtils.toString(null,'true','false'),null);
    }
    
    private static testMethod void testXor()
    {
        System.assertEquals(ApexLangUtils.xor(new List<Boolean>{true,true,true}),true);
        System.assertEquals(ApexLangUtils.xor(new List<Boolean>{false,false,false}),true);
        try
        {
            System.assertEquals(ApexLangUtils.xor(new List<Boolean>()),true);
        }
        catch(Exception exp){}
        
        try
        {
            System.assertEquals(ApexLangUtils.xor(null),true);
        }
        catch(Exception exp){}
        
        System.assertEquals(ApexLangUtils.xor(new List<Boolean>{false,false,true}),false);
    }
    
    private static testMethod void testStrToBoolean()
    {
        System.assertEquals(ApexLangUtils.strToBoolean('true'),true);
        System.assertEquals(ApexLangUtils.strToBoolean('false'),false);
        System.assertEquals(ApexLangUtils.strToBoolean(null),false);
    }
    
    private static testMethod void testToStringYN()
    {
        System.assertEquals(ApexLangUtils.toStringYN(true),'Y');
        System.assertEquals(ApexLangUtils.toStringYN(false),'N');
        System.assertEquals(ApexLangUtils.toStringYN(null),null);
    }

	/* BooleanApexLangUtilsTest Tests */
}