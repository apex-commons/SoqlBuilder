global class ApexLangUtils {

    /* WordUtils methods */
     
    global static String wrap(String str, Integer wrapLength) {
        return wrap(str, wrapLength, null, false);
    }
    
    global static String wrap(String str, Integer wrapLength, String newLineStr, boolean wrapLongWords) {
        if (str == null) {
            return null;
        }
        if (newLineStr == null) {
            newLineStr = LINE_SEPARATOR;
        }
        if (wrapLength < 1) {
            wrapLength = 1;
        }
        Integer inputLineLength = str.length();
        Integer offset = 0; 
        String wrappedLine = '';
        
        while ((inputLineLength - offset) > wrapLength) {
            if (' '.equals(charAt(str, offset))) {
                offset++;
                continue;
            }
            Integer spaceToWrapAt = lastIndexOf(str, ' ', wrapLength + offset);

            if (spaceToWrapAt >= offset) {
                // normal case
                wrappedLine += str.substring(offset, spaceToWrapAt);
                wrappedLine += newLineStr;
                offset = spaceToWrapAt + 1;
            } else {
                // really long word or URL
                if (wrapLongWords) {
                    // wrap really long word one line at a time
                    wrappedLine += str.substring(offset, wrapLength + offset);
                    wrappedLine += newLineStr;
                    offset += wrapLength;
                } else {
                    // do not wrap really long word, just extend beyond limit
                    spaceToWrapAt = str.indexOf(' ', wrapLength + offset);
                    if (spaceToWrapAt >= 0) {
                        wrappedLine += str.substring(offset, spaceToWrapAt);
                        wrappedLine += newLineStr;
                        offset = spaceToWrapAt + 1;
                    } else {
                        wrappedLine += str.substring(offset);
                        offset = inputLineLength;
                    }
                }
            }
        }

        // Whatever is left in line is short enough to just pass through
        wrappedLine += (str != null && str.length()>offset ? str.substring(offset) : '');

        return wrappedLine;
    }

    global static String capitalize(String str) {
        return capitalize(str, null);
    }

    global static String capitalize(String str, String[] delimiters) {
        Integer delimLen = (delimiters == null ? -1 : delimiters.size());
        if (str == null || str.length() == 0 || delimLen == 0) {
            return str;
        }
        Integer strLen = str.length();
        String buffer = '';
        boolean capitalizeNext = true;
        for (Integer i = 0; i < strLen; i++) {
            String ch = charAt(str, i);

            if (isDelimiter(ch, delimiters)) {
                buffer += ch;
                capitalizeNext = true;
            } else if (capitalizeNext) {
                buffer += toTitleCase(ch);
                capitalizeNext = false;
            } else {
                buffer += ch;
            }
        }
        return buffer;
    }

    global static String capitalizeFully(String str) {
        return capitalizeFully(str, null);
    }

    global static String capitalizeFully(String str, String[] delimiters) {
        Integer delimLen = (delimiters == null ? -1 : delimiters.size());
        if (str == null || str.length() == 0 || delimLen == 0) {
            return str;
        }
        str = str.toLowerCase();
        return capitalize(str, delimiters);
    }

    global static String uncapitalize(String str) {
        return uncapitalize(str, null);
    }

    global static String uncapitalize(String str, String[] delimiters) {
        Integer delimLen = (delimiters == null ? -1 : delimiters.size());
        if (str == null || str.length() == 0 || delimLen == 0) {
            return str;
        }
        Integer strLen = str.length();
        String buffer = '';
        boolean uncapitalizeNext = true;
        for (Integer i = 0; i < strLen; i++) {
            String ch = charAt(str, i);

            if (isDelimiter(ch, delimiters)) {
                buffer += ch;
                uncapitalizeNext = true;
            } else if (uncapitalizeNext) {
                buffer += toLowerCase(ch);
                uncapitalizeNext = false;
            } else {
                buffer += ch;
            }
        }
        return buffer;
    }

    // same method in Utils
    /*global static String swapCase(String str) {
        Integer strLen;
        if (str == null || (strLen = str.length()) == 0) {
            return str;
        }
        String buffer = '';

        boolean whitespace = true;
        String ch = null;
        String tmp = null;

        for (Integer i = 0; i < strLen; i++) {
            ch = charAt(str, i);
            if (isUpperCase(ch)) {
                tmp = toLowerCase(ch);
            } else if (isLowerCase(ch)) {
                if (whitespace) {
                    tmp = toTitleCase(ch);
                } else {
                    tmp = toUpperCase(ch);
                }
            } else {
                tmp = ch;
            }
            buffer += tmp;
            whitespace = isWhitespace(ch);
        }
        return buffer;
    }*/

    global static String initials(String str) {
        return initials(str, null);
    }

    global static String initials(String str, String[] delimiters) {
        //('i',{'S','I','J','o','1'})
        //str='i'
        //delimiters={'S','I','J','o','1'}
        if (str == null || str.length() == 0) {
            return str;
        }
        if (delimiters != null && delimiters.size() == 0) {
            return '';
        }
        Integer strLen = str.length();
        //strLen=1
        String buf = '';
        Integer count = 0;
        boolean lastWasGap = true;
        for (Integer i = 0; i < strLen; i++) {
            String ch = charAt(str, i);

            if (isDelimiter(ch, delimiters)) {
                lastWasGap = true;
            } else if (lastWasGap) {
                buf += ch;
                lastWasGap = false;
            } else {
                // ignore ch
            }
        }
        return buf;
    }

    private static boolean isDelimiter(String ch, String[] delimiters) {
        //ch='i'
        //delimiters={'S','I','J','o','1'}
        if (delimiters == null) {
            return isWhitespace(ch);
        }
        for (Integer i = 0, isize = delimiters.size(); i < isize; i++) {
            if ((ch == null && delimiters[i] == null) || (ch != null && ch.equals(delimiters[i]))) {
                return true;
            }
        }
        return false;
    }

    global static String abbreviate(String str, Integer lower, Integer upper, String appendToEnd) {
        // initial parameter checks
        if (str == null) {
            return null;
        }
        if (str.length() == 0) {
            return EMPTY;
        }

        // if the upper value is -1 (i.e. no limit) or is greater
        // than the length of the string, set to the length of the string
        if (upper == -1 || upper > str.length()) {
            upper = str.length();
        }
        // if upper is less than lower, raise it to lower
        if (upper < lower) {
            upper = lower;
        }

        String result = '';
        Integer index = indexOf(str, ' ', lower);
        if (index == -1) {
            result += str.substring(0, upper);
            // only if abbreviation has occured do we append the appendToEnd value
            if (upper != str.length()) {
                result += defaultString(appendToEnd);
            }
        } else if (index > upper) {
            result += str.substring(0, upper);
            result += defaultString(appendToEnd);
        } else {
            result += str.substring(0, index);
            result += defaultString(appendToEnd);
        }
        return result;
    }   
     
    /* WordUtils methods*/
    
    /* SystemUtils methods */
    global static final String LINE_SEPARATOR = '\n';

    global static void debugLimits(){
        System.debug(
              LINE_SEPARATOR + '##################################################################'
            + LINE_SEPARATOR + 'Limits:'
            + LINE_SEPARATOR + '##################################################################'
            + LINE_SEPARATOR + 'AggregateQueries: ' + Limits.getAggregateQueries() + ' of ' + Limits.getLimitAggregateQueries()
            + LINE_SEPARATOR + 'Callouts: ' + Limits.getCallouts() + ' of ' + Limits.getLimitCallouts()
            + LINE_SEPARATOR + 'DMLRows: ' + Limits.getDMLRows() + ' of ' + Limits.getLimitDMLRows()
            + LINE_SEPARATOR + 'DMLStatements: ' + Limits.getDMLStatements() + ' of ' + Limits.getLimitDMLStatements()
            + LINE_SEPARATOR + 'EmailInvocations: ' + Limits.getEmailInvocations() + ' of ' + Limits.getLimitEmailInvocations()
            + LINE_SEPARATOR + 'FieldsDescribes: ' + Limits.getFieldsDescribes() + ' of ' + Limits.getLimitFieldsDescribes()
            + LINE_SEPARATOR + 'FindSimilarCalls: ' + Limits.getFindSimilarCalls() + ' of ' + Limits.getLimitFindSimilarCalls()
            + LINE_SEPARATOR + 'FutureCalls: ' + Limits.getFutureCalls() + ' of ' + Limits.getLimitFutureCalls()
            + LINE_SEPARATOR + 'HeapSize: ' + Limits.getHeapSize() + ' of ' + Limits.getLimitHeapSize()
            + LINE_SEPARATOR + 'Queries: ' + Limits.getQueries() + ' of ' + Limits.getLimitQueries()
            + LINE_SEPARATOR + 'PicklistDescribes: ' + Limits.getPicklistDescribes() + ' of ' + Limits.getLimitPicklistDescribes()
            + LINE_SEPARATOR + 'QueryRows: ' + Limits.getQueryRows() + ' of ' + Limits.getLimitQueryRows()
            + LINE_SEPARATOR + 'RunAs: ' + Limits.getRunAs() + ' of ' + Limits.getLimitRunAs()
            + LINE_SEPARATOR + 'SavepointRollbacks: ' + Limits.getSavepointRollbacks() + ' of ' + Limits.getLimitSavepointRollbacks()
            + LINE_SEPARATOR + 'Savepoints: ' + Limits.getSavepoints() + ' of ' + Limits.getLimitSavepoints()
            + LINE_SEPARATOR + 'ScriptStatements: ' + Limits.getScriptStatements() + ' of ' + Limits.getLimitScriptStatements()
            + LINE_SEPARATOR + 'SoslQueries: ' + Limits.getSoslQueries() + ' of ' + Limits.getLimitSoslQueries()
            );
    }
    
    global static String to18(String the15charID){
        //a0BA0000000L2ZC  => a0BA0000000L2ZCMA0
        //the15charID = 'a0BA0000000L2ZC'
        final String BASE ='ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456';

        the15charID = trim(the15charID);
        if(length(the15charID) != 15){
            return the15charID;
        }
        String result = '';
        List<String> chars = null;
        for(integer i = 0; i < 3; i++){
            chars = toCharArray(reverse(the15charID.substring(i*5,i*5+5)));
            String binary = '';
            for(String ch : chars){
                binary += isUpperCase(ch) ? '1' : '0';
            }
            result += charAt(BASE, parseInt(binary,2));
        }
        return the15charID + result;
    }
    /* SystemUtils methods */
    
    
    
    /* StringUtils methods */
    

    global static final String EMPTY = '';
    global static final String LF = '\n';
    global static final String CR = '\r';
    global static final Integer INDEX_NOT_FOUND = -1;

    private static final Integer PAD_LIMIT = 8192;

    global static String abbreviate(String str, Integer maxWidth) {
        return abbreviate(str, 0, maxWidth);
    }

    global static String abbreviate(String str, Integer offset, Integer maxWidth) {
        if (str == null) {
            return null;
        }
        if (maxWidth < 4) { 
            throw new IllegalArgumentException('Minimum abbreviation width is 4');
        }
        if (str.length() <= maxWidth) {
            return str;
        }
        if (offset > str.length()) {
            offset = str.length();
        }
        if ((str.length() - offset) < (maxWidth - 3)) {
            offset = str.length() - (maxWidth - 3);
        }
        if (offset <= 4) {
            return str.substring(0, maxWidth - 3) + '...';
        }
        if (maxWidth < 7) {
            throw new IllegalArgumentException('Minimum abbreviation width with offset is 7');
        }
        if ((offset + (maxWidth - 3)) < str.length()) {
            return '...' + abbreviate(str.substring(offset), maxWidth - 3);
        }
        return '...' + str.substring(str.length() - (maxWidth - 3));
    } 

    /* exsits in wordUtils */
    /*global static String capitalize(String str) {
        if(isBlank(str)){
            return str;
        }
        return upperCase(str.substring(0,1)) + str.substring(1);
    }*/
    
    global static String center(String str, Integer size) {
        return center(str, size, ' ');
    }

    global static String center(String str, Integer size, String padStr) {
        if (str == null || size <= 0) {
            return str;
        }
        if (isEmpty(padStr)) {
            padStr = ' ';
        }
        Integer strLen = str.length();
        Integer padCharCount = size - strLen;
        if (padCharCount <= 0) {
            return str;
        }
        str = leftPad(str, strLen + padCharCount / 2, padStr);
        str = rightPad(str, size, padStr);
        return str;
    }

    global static String charAt(String str, Integer index) {
        if(str == null){
            return null;
        }
        if(str.length() <= 0){
            return str;    
        }
        if(index < 0 || index >= str.length()){
            return null;    
        }
        return str.substring(index, index+1);
    }
    
    global static String chomp(String str) {
        if (isEmpty(str)) {
            return str;
        }

        if (str.length() == 1) {
            String ch = charAt(str,0);
            if (ch == CR || ch == LF) {
                return EMPTY;
            }
            return str;
        }

        Integer lastIdx = str.length() - 1;
        String last = charAt(str, lastIdx);

        if (LF.equals(last)) {
            if (CR.equals(charAt(str,lastIdx - 1))) {
                lastIdx--;
            }
        } else if (!CR.equals(last)) {
            lastIdx++;
        }
        return str.substring(0, lastIdx);
    }

    global static String chomp(String str, String separator) {
        if (isEmpty(str) || separator == null) {
            return str;
        }
        if (str.endsWith(separator)) {
            return str.substring(0, str.length() - separator.length());
        }
        return str;
    }

    global static String chop(String str) {
        if (str == null) {
            return null;
        }
        Integer strLen = str.length();
        if (strLen < 2) {
            return EMPTY;
        }
        Integer lastIdx = strLen - 1;
        String ret = str.substring(0, lastIdx);
        String last = charAt(str, lastIdx);
        if (LF.equals(last)) {
            if (CR.equals(charAt(ret,lastIdx - 1))) {
                return ret.substring(0, lastIdx - 1);
            }
        }
        return ret;
    }

    global static Boolean contains(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return false;
        }
        return str.indexOf(searchStr,0) >= 0;
    }
    
    global static boolean containsAny(String str, String searchChars) {
        if (str == null || str.length() == 0 || searchChars == null || searchChars.length() == 0) {
            return false;
        }
        for (Integer i = 0; i < str.length(); i++) {
            if(searchChars.contains(charAt(str, i))){
                return true;    
            }
        }
        return false;
    }

    global static Boolean containsIgnoreCase(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return false;
        }
        return contains(str.toUpperCase(), searchStr.toUpperCase());
    }
    
    global static boolean containsNone(String str, String invalidChars) {
        if (str == null || invalidChars == null) {
            return true;
        }
        Integer strSize = str.length();
        Integer invalidSize = invalidChars.length();
        for (Integer i = 0; i < strSize; i++) {
            String ch = charAt(str, i);
            if(invalidChars.contains(ch)){
                return false;
            }
        }
        return true;
    }

    global static boolean containsOnly(String str, String valid) {
        if ((valid == null) || (str == null)) {
            return false;
        }
        if (str.length() == 0) {
            return true;
        }
        if (valid.length() == 0) {
            return false;
        }
        return indexOfAnyBut(str, valid) == -1;
    }

    global static Integer countMatches(String str, String sub) {
        if (isEmpty(str) || isEmpty(sub)) {
            return 0;
        }
        Integer count = 0;
        Integer idx = 0;
        while ((idx = str.indexOf(sub, idx)) != -1) {
            count++;
            idx += sub.length();
        }
        return count;
    }

    global static String defaultIfEmpty(String str, String defaultStr) {
        return isEmpty(str) ? defaultStr : str;
    }
    
    global static String defaultString(String str) {
        return str == null ? EMPTY : str;
    }

    global static String defaultString(String str, String defaultStr) {
        return str == null ? defaultStr : str;
    }

    global static String deleteWhitespace(String str) {
        if (isEmpty(str)) {
            return str;
        }
        String returnString = '';
        String currentChar = null;
        for (Integer i = 0; i < str.length(); i++) {
            currentChar = charAt(str,i);
            if (!isWhitespace(currentChar)) {
                returnString += currentChar;
            }
        }
        return returnString;
    }

    global static String difference(String str1, String str2) {
        //'abc',''
        if (str1 == null) {
            return str2;
        }
        if (str2 == null) {
            return str1;
        }
        Integer at = indexOfDifference(str1, str2);
        if (at == -1) {
            return EMPTY;
        }
        if(at == 0){
            return str2;
        }
        return str2.substring(at);
    }

    global static Integer indexOfDifference(String str1, String str2) {
        if (str1 == str2) {
            return -1;
        }
        if (str1 == null || str2 == null) {
            return 0;
        }
        Integer i;
        for (i = 0; i < str1.length() && i < str2.length(); ++i) {
            if (charAt(str1,i) != charAt(str2,i)) {
                break;
            }
        }
        //if (i < str2.length() || i < str1.length()) {
            return i;
        //}
        //return -1;
    }
    
    global static Integer indexOfDifference(String[] strs) {
        if (strs == null || strs.size() <= 1) {
            return -1;
        }
        Boolean anyStringNull = false;
        Boolean allStringsNull = true;
        Integer listSize = strs.size();
        Integer shortestStrLen = MAX_INTEGER;
        Integer longestStrLen = 0;

        // find the min and max string lengths; this avoids checking to make
        // sure we are not exceeding the length of the string each time through
        // the bottom loop.
        for (Integer i = 0; i < listSize; i++) {
            if (strs.get(i) == null) {
                anyStringNull = true;
                shortestStrLen = 0;
            } else {
                allStringsNull = false;
                shortestStrLen = Math.min(strs.get(i).length(), shortestStrLen);
                longestStrLen = Math.max(strs.get(i).length(), longestStrLen);
            }
        }

        // handle lists containing all nulls or all empty strings
        if (allStringsNull || (longestStrLen == 0 && !anyStringNull)) {
            return -1;
        }

        // handle lists containing some nulls or some empty strings
        if (shortestStrLen == 0) {
            return 0;
        }

        // find the position with the first difference across all strings
        Integer firstDiff = -1;
        for (Integer stringPos = 0; stringPos < shortestStrLen; stringPos++) {
            String comparisonChar = charAt(strs.get(0), stringPos);
            for (Integer arrayPos = 1; arrayPos < listSize; arrayPos++) {
                if (charAt(strs.get(arrayPos),stringPos) != comparisonChar) {
                    firstDiff = stringPos;
                    break;
                }
            }
            if (firstDiff != -1) {
                break;
            }
        }

        if (firstDiff == -1 && shortestStrLen != longestStrLen) {
            // we compared all of the characters up to the length of the
            // shortest string and didn't find a match, but the string lengths
            // vary, so return the length of the shortest string.
            return shortestStrLen;
        }
        return firstDiff;
    }
    

    global static Boolean equals(String str1, String str2) {
        return str1 == null ? str2 == null : str1.equals(str2);
    }

    global static Boolean equalsIgnoreCase(String str1, String str2) {
        return str1 == null ? str2 == null : str1.equalsIgnoreCase(str2);
    }

    global static Integer indexOf(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return -1;
        }
        return str.indexOf(searchStr);
    }

    global static Integer indexOf(String str, String searchStr, Integer startPos) {
        if (str == null || searchStr == null) {
            return -1;
        }
        if (searchStr.length() == 0 && startPos >= str.length()) {
            return str.length();
        }
        return str.indexOf(searchStr, startPos);
    }

    global static Integer ordinalIndexOf(String str, String searchStr, Integer ordinal) {
        //'','',-1
        if (str == null || searchStr == null || ordinal <= 0) {
            return INDEX_NOT_FOUND;
        }
        if (searchStr.length() == 0) {
            return 0;
        }
        Integer found = 0;
        Integer index = INDEX_NOT_FOUND;
        do {
            index = str.indexOf(searchStr, index + 1);
            if (index < 0) {
                return index;
            }
            found++;
        } while (found < ordinal);
        return index;
    }

    global static String getCommonPrefix(String[] strs) {
        if (strs == null || strs.size() == 0) {
            return EMPTY;
        }
        Integer smallestIndexOfDiff = indexOfDifference(strs);
        if (smallestIndexOfDiff == -1) {
            // all strings were identical
            if (strs.get(0) == null) {
                return EMPTY;
            }
            return strs.get(0);
        } else if (smallestIndexOfDiff == 0) {
            // there were no common initial characters
            return EMPTY;
        } else {
            // we found a common initial character sequence
            return strs.get(0).substring(0, smallestIndexOfDiff);
        }
    }  
    
    global static Integer getLevenshteinDistance(String s, String t) {
        if (s == null || t == null) {
            throw new IllegalArgumentException('Strings must not be null');
        }

        /*
           The difference between this impl. and the previous is that, rather 
           than creating and retaining a matrix of size s.length()+1 by t.length()+1, 
           we maintain two single-dimensional arrays of length s.length()+1.  The first, d,
           is the 'current working' distance array that maintains the newest distance cost
           counts as we iterate through the characters of String s.  Each time we increment
           the index of String t we are comparing, d is copied to p, the second int[].  Doing so
           allows us to retain the previous cost counts as required by the algorithm (taking 
           the minimum of the cost count to the left, up one, and diagonally up and to the left
           of the current cost count being calculated).  (Note that the arrays aren't really 
           copied anymore, just switched...this is clearly much better than cloning an array 
           or doing a System.arraycopy() each time  through the outer loop.)

           Effectively, the difference between the two implementations is this one does not 
           cause an out of memory condition when calculating the LD over two very large strings.
         */

        Integer n = s.length(); // length of s
        Integer m = t.length(); // length of t

        if (n == 0) {
            return m;
        } else if (m == 0) {
            return n;
        }

        if (n > m) {
            // swap the input strings to consume less memory
            String tmp = s;
            s = t;
            t = tmp;
            n = m;
            m = t.length();
        }

        Integer[] p = new Integer[n+1]; //'previous' cost array, horizontally
        Integer[] d = new Integer[n+1]; // cost array, horizontally
        Integer[] dSwap; //placeholder to assist in swapping p and d

        // indexes into strings s and t
        Integer i; // iterates through s
        Integer j; // iterates through t

        String t_j; // jth character of t

        Integer cost; // cost

        for (i = 0; i<=n; i++) {
            p[i] = i;
        }

        for (j = 1; j<=m; j++) {
            t_j = charAt(t,j-1);
            d[0] = j;

            for (i=1; i<=n; i++) {
                cost = charAt(s,i-1)==t_j ? 0 : 1;
                // minimum of cell to the left+1, to the top+1, diagonally left and up +cost
                d[i] = Math.min(Math.min(d[i-1]+1, p[i]+1),  p[i-1]+cost);
            }

            // copy current distance counts to 'previous row' distance counts
            dSwap = p;
            p = d;
            d = dSwap;
        }

        // our last action in the above loop was to switch d and p, so p now 
        // actually has the most recent cost counts
        return p[n];
    }

    global static Integer indexOfAnyBut(String str, String searchChars) {
        if (isEmpty(str) || searchChars == null) {
            return -1;
        }
        for (Integer i = 0; i < str.length(); i++) {
            if(searchChars.contains(charAt(str,i))){
                continue;    
            }
            return i;
        }
        return -1;
    }

    global static Boolean endsWith(String str, String suffix) {
        return endsWith(str, suffix, false);
    }
    
    private static Boolean endsWith(String str, String suffix, Boolean ignoreCase) {
        if (str == null || suffix == null) {
            return (str == null && suffix == null);
        }
        if (suffix.length() > str.length()) {
            return false;
        }
        Integer strOffset = str.length() - suffix.length();
        String ending = str.substring(strOffset, str.length());
        if(ignoreCase){
            return suffix.equalsIgnoreCase(ending);
        }
        return suffix.equals(ending);
    }
    
    global static Boolean endsWithIgnoreCase(String str, String suffix) {
        return endsWith(str, suffix, true);
    }
    
    global static Integer indexOfAny(String str, String searchChars) {
        if (isEmpty(str) || searchChars == null) {
            return -1;
        }
        for (Integer i = 0; i < str.length(); i++) {
            String ch = charAt(str,i);
            for (Integer j = 0; j < searchChars.length(); j++) {
                if (charAt(searchChars,j) == ch) {
                    return i;
                }
            }
        }
        return -1;
    }

    global static Integer indexOfAny(String str, String[] searchStrs) {
        if (str == null || searchStrs == null || searchStrs.size() == 0) {
            return -1;
        }
        Integer returnIndexOf = MAX_INTEGER;

        Integer currentIndexOf = 0;
        for(String searchStr : searchStrs){
            if (searchStr == null) {
                continue;
            }
            currentIndexOf = str.indexOf(searchStr);
            if (currentIndexOf == -1) {
                continue;
            }

            if (currentIndexOf < returnIndexOf) {
                returnIndexOf = currentIndexOf;
            }
        }

        return (returnIndexOf == MAX_INTEGER) ? -1 : returnIndexOf;
    }
     
    global static boolean isAlpha(String str) {
        if (str == null) {
            return false;
        }
        Integer size = str.length();
        for (Integer i = 0; i < size; i++) {
            if (isLetter(charAt(str,i)) == false) {
                return false;
            }
        }
        return true;
    }

    global static boolean isAlphaSpace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((isLetter(charAt(str,i)) == false) && (charAt(str,i) != ' ')) {
                return false;
            }
        }
        return true;
    }

    global static boolean isAlphanumeric(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if (isLetterOrDigit(charAt(str,i)) == false) {
                return false;
            }
        } 
        return true;
    }

    global static boolean isAlphanumericSpace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((isLetterOrDigit(charAt(str,i)) == false) && (charAt(str,i) != ' ')) {
                return false;
            }
        }
        return true;
    }

    //exsists in Character methods
    /*global static boolean isAsciiPrintable(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if (Character.isAsciiPrintable(charAt(str,i)) == false) {
                return false;
            }
        }
        return true;
    }*/

    global static boolean isNumeric(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if (isDigit(charAt(str,i)) == false) {
                return false;
            }
        }
        return true;
    }

    global static boolean isNumericSpace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((isDigit(charAt(str,i)) == false) && (charAt(str,i) != ' ')) {
                return false;
            }
        }
        return true;
    }

    //exists in Character methods
    /*global static boolean isWhitespace(String str) {
        if (str == null) {
            return false;
        }
        Integer sz = str.length();
        for (Integer i = 0; i < sz; i++) {
            if ((Character.isWhitespace(charAt(str,i)) == false)) {
                return false;
            }
        }
        return true;
    }*/
    
    global static boolean isBlank(String str) {
        return str == null || str.trim() == null || str.trim().length() == 0;
    }
    
    global static boolean isNotBlank(String str) {
        return !isBlank(str);
    }
    
    global static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    global static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }

    global static String joinArray(Object[] objectArray) {
        return joinArray(objectArray, null);
    }
    
    global static String joinArray(Object[] objectArray, String separator) {
        if (objectArray == null) {
            return null;
        }
        return joinArray(objectArray, separator, 0, objectArray.size());
    }

    global static String joinArray(Object[] objectArray, String separator, Integer startIndex, Integer endIndex) {
        if (objectArray == null) {
            return null;
        }
        if (separator == null) {
            separator = EMPTY;
        }

        String buf = '';
        if(startIndex < 0){
            startIndex = 0;
        }
        Boolean isFirst = true;
        for (Integer i = startIndex; i < endIndex && i < objectArray.size(); i++) {
            if(objectArray[i] != null) {
                if(isFirst){
                    isFirst = false;
                } else {
                    buf += separator;
                }
                buf += objectArray[i];
            }
        }
        return buf;
    }

    global static String joinStrings(Set<String> strings, String separator){
        return joinSet(strings,separator);
    }

    global static String joinSet(Set<Blob> blobSet, String separator){ 
        return joinSet(blobToObject(blobSet),separator);
    }

    global static String joinSet(Set<Boolean> booleanSet, String separator){ 
        return joinSet(booleanToObject(booleanSet),separator);
    }

    global static String joinSet(Set<Date> dateSet, String separator){ 
        return joinSet(dateToObject(dateSet),separator);
    }

    global static String joinSet(Set<Datetime> datetimeSet, String separator){ 
        return joinSet(datetimeToObject(datetimeSet),separator);
    }

    global static String joinSet(Set<Decimal> decimalSet, String separator){ 
        return joinSet(decimalToObject(decimalSet),separator);
    }

    global static String joinSet(Set<Double> doubleSet, String separator){ 
        return joinSet(doubleToObject(doubleSet),separator);
    }

    global static String joinSet(Set<ID> idSet, String separator){ 
        return joinSet(idToObject(idSet),separator);
    }

    global static String joinSet(Set<Integer> integerSet, String separator){ 
        return joinSet(integerToObject(integerSet),separator);
    }

    global static String joinSet(Set<Long> longSet, String separator){ 
        return joinSet(longToObject(longSet),separator);
    }

    global static String joinSet(Set<Time> timeSet, String separator){ 
        return joinSet(timeToObject(timeSet),separator);
    }

    global static String joinSet(Set<String> stringSet, String separator){ 
        return joinSet(stringToObject(stringSet),separator);
    }

    global static String joinSet(Set<Object> objectSet, String separator){
        if(objectSet == null || objectSet.size() == 0){
            return null;
        }
        Boolean isFirst = true;
        String returnString = '';
        for(Object anObject : objectSet){
            if(isBlank(''+anObject)){
                continue;
            }
            if(isFirst){
                isFirst = false;
            }else{
                if(separator != null){
                    returnString += separator;
                }
            }
            if(anObject instanceof Blob){ returnString += '' + ((Blob)anObject).toString() + '';
            } else if(anObject instanceof Boolean){ returnString += ((Boolean)anObject);
            } else if(anObject instanceof Date){ returnString += '' + ((Date)anObject) + '';
            } else if(anObject instanceof Datetime){ returnString += '' + ((Datetime)anObject) + '';
            } else if(anObject instanceof Integer){ returnString += ((Integer)anObject);
            } else if(anObject instanceof Long){ returnString += ((Long)anObject);
            } else if(anObject instanceof Decimal){ returnString += ((Decimal)anObject);
            //} else if(anObject instanceof Double){ returnString += ((Double)anObject);
            } else if(anObject instanceof String){ returnString += '' + ((String)anObject) + '';
            //} else if(anObject instanceof ID){ returnString += '' + ((ID)anObject) + '';
            } else if(anObject instanceof Time){ returnString += '' + ((Time)anObject) + '';}
        }    
        return returnString;
    }
    
    global static String joinStrings(List<String> strings, String separator){
        if(strings == null || strings.size() == 0){
            return null;
        }
        Set<String> setToJoin = new Set<String>();
        for(String value : strings){
            setToJoin.add(value);    
        }
        return joinStrings(setToJoin,separator);
    }
    
    global static Integer lastIndexOf(String str, String searchStr) {
        if (str == null || searchStr == null) {
            return -1;
        }
        return str.lastIndexOf(searchStr);
    }

    global static Integer lastIndexOf(String str, String searchStr, Integer startPos) {
        if (str == null || searchStr == null || startPos < 0) {
            return -1;
        }
        return lastIndexOf(substring(str,0,startPos+1), searchStr);
    }

    global static Integer lastIndexOfAny(String str, String[] searchStrs) {
        if ((str == null) || (searchStrs == null)) {
            return -1;
        }
        Integer sz = searchStrs.size();
        Integer ret = -1;
        Integer tmp = 0;
        for (Integer i = 0; i < sz; i++) {
            String searchStr = searchStrs[i];
            if (searchStr == null) {
                continue;
            }
            tmp = str.lastIndexOf(searchStr);
            if (tmp > ret) {
                ret = tmp;
            }
        }
        return ret;
    }

    global static String left(String str, Integer len) {
        if (str == null) {
            return null;
        }
        if (len < 0) {
            return EMPTY;
        }
        if (str.length() <= len) {
            return str;
        }
        return str.substring(0, len);
    }

    global static String mid(String str, Integer pos, Integer len) {
        if (str == null) {
            return null;
        }
        if (len < 0 || pos >= str.length()) {
            return EMPTY;
        }
        if (pos < 0) {
            pos = 0;
        }
        if (str.length() <= (pos + len)) {
            return str.substring(pos);
        }
        return str.substring(pos, pos + len);
    }

    global static String overlay(String str, String overlay, Integer startIndex, Integer endIndex) {
        //'', 'abc', 0, 0
        if (str == null) {
            return null;
        }
        if (overlay == null) {
            overlay = EMPTY;
        }
        Integer len = str.length();
        if (startIndex < 0) {
            startIndex = 0;
        }
        if (startIndex > len) {
            startIndex = len;
        }
        if (endIndex < 0) {
            endIndex = 0;
        }
        if (endIndex > len) {
            endIndex = len;
        }
        if (startIndex > endIndex) {
            Integer temp = startIndex;
            startIndex = endIndex;
            endIndex = temp;
        }
        return new StringBuffer()
            .append(substring(str, 0, startIndex))
            .append(overlay)
            .append(substring(str, endIndex))
            .toStr();
    }
    
    global static String leftPad(String str, Integer size) {
        return leftPad(str, size, ' ');
    }

    global static String leftPad(String str, Integer size, String padStr) {
        if (str == null) {
            return null;
        }
        if (isEmpty(padStr)) {
            padStr = ' ';
        }
        Integer padLen = padStr.length();
        Integer strLen = str.length();
        Integer padCharCount = size - strLen;
        if (padCharCount <= 0) {
            return str;
        }
        if (padCharCount == padLen) {
            return padStr + str;
        } else if (padCharCount < padLen) {
            return padStr.substring(0, padCharCount) + str;
        } else {
            String padding = '';
            for (Integer i = 0; i < padCharCount; i++) {
                padding += padStr.substring(Math.mod(i,padLen),Math.mod(i,padLen)+1);
            }
            return padding + str;
        }
    }

    global static Integer length(String str) {
        return str == null ? 0 : str.length();
    }    
    
    global static String lowerCase(String str) {
        if(str == null){
            return null;
        }
        return str.toLowerCase();
    }
    
    global static String remove(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        return replace(str, remove, EMPTY, -1);
    }

    global static String removeStart(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (str.startsWith(remove)){
            return str.substring(remove.length());
        }
        return str;
    }

    global static String removeStartIgnoreCase(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (startsWithIgnoreCase(str, remove)) {
            return str.substring(remove.length());
        }
        return str;
    }
    
    global static String removeEnd(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (str.endsWith(remove)) {
            return str.substring(0, str.length() - remove.length());
        }
        return str;
    }

    global static String removeEndIgnoreCase(String str, String remove) {
        if (isEmpty(str) || isEmpty(remove)) {
            return str;
        }
        if (endsWithIgnoreCase(str, remove)) {
            return str.substring(0, str.length() - remove.length());
        }
        return str;
    }

    global static String repeat(String str, Integer repeat) {
        if (str == null) {
            return null;
        }
        if (repeat <= 0) {
            return EMPTY;
        }
        Integer inputLength = str.length();
        if (repeat == 1 || inputLength == 0) {
            return str;
        }
        if (inputLength == 1 && repeat <= PAD_LIMIT) {
            return padding(repeat, charAt(str,0));
        }

        String buf = '';
        for (Integer i = 0; i < repeat; i++) {
            buf += str;
        }
        return buf;
/*        Integer outputLength = inputLength * repeat;
        if(inputLength == 1){
            String ch = charAt(str,0);
            String output1 = '';
            for (Integer i = repeat - 1; i >= 0; i--) {
                output1 += ch;
            }
            return output1;
        } else if(inputLength == 2){
            String ch0 = charAt(str,0);
            String ch1 = charAt(str,1);
            String output2 = '';
            for (Integer i = repeat * 2 - 2; i >= 0; i=i-2) {
                output2 += ch0;
                output2 += ch1;
            }
            return output2;
        } else {
        }*/
    }

    private static String padding(Integer repeat, String padChar){
        String buf = '';
        for (Integer i = 0; i < repeat; i++) {
            buf += padChar;
        }
        return buf;
    }

    global static String replace(String text, String searchString, String replacement) {
        return replace(text, searchString, replacement, -1);
    }

    global static String replaceOnce(String text, String searchString, String replacement) {
        return replace(text, searchString, replacement, 1);
    }

    global static String replace(String text, String searchString, String replacement, Integer max) {
        //'aba', 'a', '', -1
        if (isEmpty(text) || isEmpty(searchString) || replacement == null || max == 0) {
            return text;
        }
        Integer startIndex = 0;
        Integer endIndex = indexOf(text, searchString, startIndex);
        if (endIndex == -1) {
            return text;
        }
        Integer replLength = searchString.length();
        Integer increase = replacement.length() - replLength;
        increase = (increase < 0 ? 0 : increase);
        increase *= (max < 0 ? 16 : (max > 64 ? 64 : max));
        StringBuffer buf = new StringBuffer(); 
        while (endIndex != -1) {
            buf.append(substring(text, startIndex, endIndex)).append(replacement);
            startIndex = endIndex + replLength;
            if (--max == 0) {
                break;
            }
            endIndex = indexOf(text, searchString, startIndex);
        }
        buf.append(substring(text, startIndex));
        return buf.toStr();
    }

    global static String replaceEach(String text, String[] searchList, String[] replacementList) {
        return replaceEach(text, searchList, replacementList, false, 0);
    } 

    global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList,
        Boolean repeat) {
        return replaceEach(text, searchList, replacementList, repeat, 
            (searchList == null ? 0 : searchList.size()));
    }
    
 
    global static String replaceEach(
        String text, 
        String[] searchList, 
        String[] replacementList, 
        boolean repeat, 
        Integer timeToLive){
    
        // mchyzer Performance note: This creates very few new objects (one major goal)
        // let me know if there are performance requests, we can create a harness to measure

        if (text == null || text.length() == 0 || searchList == null || 
            searchList.size() == 0 || replacementList == null || replacementList.size() == 0){
            return text;
        }

        // if recursing, this shouldnt be less than 0
        if (timeToLive < 0) {
            throw new IllegalStateException('TimeToLive of ' + timeToLive + ' is less than 0: ' + text);
        } 

        Integer searchLength = searchList.size();
        Integer replacementLength = replacementList.size();

        // make sure lengths are ok, these need to be equal
        if (searchLength != replacementLength) {
            throw new IllegalArgumentException('Search and Replace array lengths don\'t match: '
                + searchLength
                + ' vs '
                + replacementLength);
        }

        // keep track of which still have matches
        boolean[] noMoreMatchesForReplIndex = new boolean[searchLength];
        for(Integer i = 0; i < noMoreMatchesForReplIndex.size(); i++){
            noMoreMatchesForReplIndex[i] = false;
        }

        // index on index that the match was found
        Integer textIndex = -1;
        Integer replaceIndex = -1;
        Integer tempIndex = -1;

        // index of replace array that will replace the search string found
        // NOTE: logic duplicated below START
        for (Integer i = 0; i < searchLength; i++) {
            if (noMoreMatchesForReplIndex[i] || searchList[i] == null || 
                searchList[i].length() == 0 || replacementList[i] == null) 
            {
                continue;
            }
            tempIndex = indexOf(text,searchList[i]);

            // see if we need to keep searching for this
            if (tempIndex == -1) {
                noMoreMatchesForReplIndex[i] = true;
            } else {
                if (textIndex == -1 || tempIndex < textIndex) {
                    textIndex = tempIndex;
                    replaceIndex = i;
                }
            }
        }
        // NOTE: logic mostly below END

        // no search strings found, we are done
        if (textIndex == -1) {
            return text;
        }

        Integer start = 0;

        StringBuffer buf = new StringBuffer();

        while (textIndex != -1) {

            for (Integer i = start; i < textIndex; i++) {
                buf.append(charAt(text,i));
            }
            buf.append(replacementList[replaceIndex]);

            start = textIndex + searchList[replaceIndex].length();

            textIndex = -1;
            replaceIndex = -1;
            tempIndex = -1;
            // find the next earliest match
            // NOTE: logic mostly duplicated above START
            for (Integer i = 0; i < searchLength; i++) {
                if (noMoreMatchesForReplIndex[i] || searchList[i] == null || 
                    searchList[i].length() == 0 || replacementList[i] == null){
                    continue;
                }
                tempIndex = indexOf(text, searchList[i], start);

                // see if we need to keep searching for this
                if (tempIndex == -1) {
                    noMoreMatchesForReplIndex[i] = true;
                } else {
                    if (textIndex == -1 || tempIndex < textIndex) {
                        textIndex = tempIndex;
                        replaceIndex = i;
                    }
                }
            }
            // NOTE: logic duplicated above END

        }
        Integer textLength = text.length();
        for (Integer i = start; i < textLength; i++) {
            buf.append(charAt(text,i));
        }
        String result = buf.toStr();
        if (!repeat) {
            return result;
        }

        return replaceEach(result, searchList, replacementList, repeat, timeToLive - 1);
    }
    
    global static String replaceChars(String str, String searchChars, String replaceChars) {
        if (isEmpty(str) || isEmpty(searchChars)) {
            return str;
        }
        if (replaceChars == null) {
            replaceChars = EMPTY;
        }
        Boolean modified = false;
        Integer replaceCharsLength = replaceChars.length();
        Integer strLength = str.length();
        String buf = '';
        for (Integer i = 0; i < strLength; i++) {
            String ch = charAt(str,i);
            Integer index = indexOf(searchChars,ch);
            if (index >= 0) {
                modified = true;
                if (index < replaceCharsLength) {
                    buf += charAt(replaceChars,index);
                }
            } else {
                buf += ch;
            }
        }
        if (modified) {
            return buf;
        }
        return str;
    }

   global static String reverse(String str) {
        if (str == null) {
            return null;
        }
        String returnString = '';
        for(Integer i = (str.length()-1); i >= 0; i--){
            returnString += charAt(str,i);
        }
        return returnString;
    }

    global static String reverseDelimited(String str, String separatorChar) {
        if (str == null) {
            return null;
        }
        if(separatorChar == null){
            separatorChar = ' ';    
        }
        validateChar(separatorChar);
        return joinArray(reverse(split(str,separatorChar)),separatorChar);
    }
    
    global static String right(String str, Integer len) {
        if (str == null) {
            return null;
        }
        if (len <= 0) {
            return EMPTY;
        }
        if (str.length() <= len) {
            return str;
        }
        return str.substring(str.length() - len);
    }

    global static String rightPad(String str, Integer size) {
        return rightPad(str, size, ' ');
    }

    global static String rightPad(String str, Integer size, String padStr) {
        if (str == null) {
            return null;
        }
        if (isEmpty(padStr)) {
            padStr = ' ';
        }
        Integer padLen = padStr.length();
        Integer strLen = str.length();
        Integer padCharCount = size - strLen;
        if (padCharCount <= 0) {
            return str; // returns original String when possible
        }

        if (padCharCount == padLen) {
            return str + padStr;
        } else if (padCharCount < padLen) {
            return str + padStr.substring(0, padCharCount);
        } else {
            String padding = '';
            for (Integer i = 0; i < padCharCount; i++) {
                padding += padStr.substring(Math.mod(i,padLen),Math.mod(i,padLen)+1);
            }
            return str + padding;
        }
    }
    
    global static String swapCase(String str) {
        if (isBlank(str)) {
            return str;
        }
        String buffer = '';
        String ch;
        for (Integer i = 0; i < str.length(); i++) {
            ch = str.substring(i,i+1);
            if (isUpperCase(ch)) {
                ch = lowerCase(ch);
            } else if (isLowerCase(ch)) {
                ch = upperCase(ch);
            }
            buffer += ch;
        }
        return buffer;
    }
    
    global static boolean startsWithIgnoreCase(String str, String prefix) {
        return startsWith(str, prefix, true);
    }

    global static boolean startsWith(String str, String prefix) {
        return startsWith(str, prefix, false);
    }

    private static boolean startsWith(String str, String prefix, boolean ignoreCase) {
        if (str == null || prefix == null) {
            return (str == null && prefix == null);
        }
        if (prefix.length() > str.length()) {
            return false;
        }
        return regionMatches(str, ignoreCase, 0, prefix, 0, prefix.length());
    }  
    
    global static boolean regionMatches(String str, Integer toffset, String other, Integer ooffset, Integer len){
        return regionMatches(str,false,toffset,other,ooffset,len);
    }
    
    global static boolean regionMatchesIgnoreCase(String str, Integer toffset, String other, Integer ooffset, Integer len){
        return regionMatches(str,true,toffset,other,ooffset,len);
    }

    global static boolean regionMatches(String str, boolean ignoreCase,
        Integer toffset, String other, Integer ooffset, Integer len){
        
        str = substring(str,toffset,toffset+len);
        other = substring(other,ooffset,ooffset+len);
        if(ignoreCase){
            return equalsIgnoreCase(str, other);            
        }
        return equals(str, other);
                                 
    }
    global static String[] split(String str) {
        return split(str, null, -1);
    }

    global static String[] split(String str, String separatorChars) {
        return splitWorker(str, separatorChars, -1, false);
    }

    global static String[] split(String str, String separatorChars, Integer max) {
        return splitWorker(str, separatorChars, max, false);
    }   
    
    global static String[] splitPreserveAllTokens(String str) {
        return splitWorker(str, null, -1, true);
    }

    global static String[] splitPreserveAllTokens(String str, String separatorChars) {
        return splitWorker(str, separatorChars, -1, true);
    }

    global static String[] splitPreserveAllTokens(String str, String separatorChars, Integer max) {
        return splitWorker(str, separatorChars, max, true);
    }        
    
    private static String[] splitWorker(
        String str, String separatorChars, 
        Integer max, boolean preserveAllTokens) {
            
        //' abc ',null, -1, true

        if (str == null) {return null;}
        Integer len = str.length();
        if (len == 0) { return new String[]{}; }

        List<String> theList = new List<String>();
        Integer sizePlus1 = 1;
        Integer i = 0, start = 0;
        boolean match = false;
        boolean lastMatch = false;
        if (separatorChars == null) {
            // Null separator means use whitespace
            while (i < len) {
                if (isWhitespace(charAt(str,i))) {
                    if (match || preserveAllTokens) {
                        lastMatch = true;
                        if (sizePlus1++ == max) {
                            i = len;
                            lastMatch = false;
                        }
                        if(start == i){
                            theList.add('');
                        } else {
                            theList.add(str.substring(start, i));
                        }
                        match = false;
                    }
                    start = ++i;
                    continue;
                }
                lastMatch = false;
                match = true;
                i++;
            }
        } else if (separatorChars.length() == 1) {
            // Optimise 1 character case
            String sep = charAt(separatorChars,0);
            while (i < len) {
                if (charAt(str,i) == sep) {
                    if (match || preserveAllTokens) {
                        lastMatch = true;
                        if (sizePlus1++ == max) {
                            i = len;
                            lastMatch = false;
                        }
                        if(start == i){
                            theList.add('');
                        } else {
                            theList.add(str.substring(start, i));
                        }
                        match = false;
                    }
                    start = ++i;
                    continue;
                }
                lastMatch = false;
                match = true;
                i++;
            }
        } else {
            // standard case
            while (i < len) {
                if (separatorChars.indexOf(charAt(str,i)) >= 0) {
                    if (match || preserveAllTokens) {
                        lastMatch = true;
                        if (sizePlus1++ == max) {
                            i = len;
                            lastMatch = false;
                        }
                        theList.add(start == i ? '' : str.substring(start, i));
                        match = false;
                    }
                    start = ++i;
                    continue;
                }
                lastMatch = false;
                match = true;
                i++;
            }
        }
        if (match || (preserveAllTokens && lastMatch)) {
            if(start == i){
                theList.add('');
            } else {
                theList.add(str.substring(start, i));
            }
        }
        return theList;
    }    
    
    global static String[] splitByWholeSeparator(String str, String separator) {
        return splitByWholeSeparatorWorker( str, separator, -1, false ) ;
    }

    global static String[] splitByWholeSeparator(String str, String separator, Integer max ) {
        return splitByWholeSeparatorWorker(str, separator, max, false);
    }

    global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator) {
        return splitByWholeSeparatorWorker(str, separator, -1, true);
    }

    global static String[] splitByWholeSeparatorPreserveAllTokens(String str, String separator, Integer max) {
        return splitByWholeSeparatorWorker(str, separator, max, true);
    }
     
    private static String[] splitByWholeSeparatorWorker(
        String str, String separator, 
        Integer max, boolean preserveAllTokens){
            
        if (str == null) {return null;}
        Integer len = str.length();
        if (len == 0) { return new String[]{}; }

        if ((separator == null) || (EMPTY.equals(separator))) {
            // Split on whitespace.
            return splitWorker(str, null, max, preserveAllTokens);
        }
        Integer separatorLength = separator.length();

        List<String> substrings = new List<String>();
        Integer numberOfSubstrings = 0;
        Integer begIndex = 0;
        Integer endIndex = 0;
        while (endIndex < len) {
            endIndex = str.indexOf(separator, begIndex);

            if (endIndex > -1) {
                if (endIndex > begIndex) {
                    numberOfSubstrings += 1;

                    if (numberOfSubstrings == max) {
                        endIndex = len;
                        substrings.add(str.substring(begIndex));
                    } else {
                        // The following is OK, because String.substring( begIndex, endIndex ) excludes
                        // the character at the position 'endIndex'.
                        substrings.add(str.substring(begIndex, endIndex));

                        // Set the starting point for the next search.
                        // The following is equivalent to begIndex = endIndex + (separatorLength - 1) + 1,
                        // which is the right calculation:
                        begIndex = endIndex + separatorLength;
                    }
                } else {
                    // We found a consecutive occurrence of the separator, so skip it.
                    if (preserveAllTokens) {
                        numberOfSubstrings += 1;
                        if (numberOfSubstrings == max) {
                            endIndex = len;
                            substrings.add(str.substring(begIndex));
                        } else {
                            substrings.add(EMPTY);
                        }
                    }
                    begIndex = endIndex + separatorLength;
                }
            } else {
                // String.substring( begIndex ) goes from 'begIndex' to the endIndex of the String.
                substrings.add(str.substring(begIndex));
                endIndex = len;
            }
        }

        return substrings;
    }    
    
    global static String[] splitByCharacterType(String str) {
        return splitByCharacterType(str, false);
    }

    global static String[] splitByCharacterTypeCamelCase(String str) {
        return splitByCharacterType(str, true);
    }

    private static String[] splitByCharacterType(String str, boolean camelCase) {
        if (str == null) {
            return null;
        }
        if (str.length() == 0) {
            return EMPTY_STRING_ARRAY;
        }
        List<String> aList = new List<String>();
        Integer tokenStart = 0;
        Integer currentType = getType(charAt(str,tokenStart));
        for (Integer pos = tokenStart + 1; pos < str.length(); pos++) {
            Integer theType = getType(charAt(str,pos));
            if (theType == currentType) {
                continue;
            } 
            if (camelCase && theType == LOWERCASE_LETTER && currentType == UPPERCASE_LETTER) {
                Integer newTokenStart = pos - 1;
                if (newTokenStart != tokenStart) {
                    aList.add(substring(str,tokenStart, newTokenStart));
                    tokenStart = newTokenStart;
                }
            } else {
                aList.add(substring(str, tokenStart, pos));
                tokenStart = pos;
            }
            currentType = theType;
        }
        aList.add(substring(str, tokenStart, str.length()));
        return aList;
    }

    global static String strip(String str) {
        return strip(str, null);
    }
    
    global static String stripToNull(String str) {
        if (str == null) {
            return null;
        }
        str = strip(str, null);
        return str.length() == 0 ? null : str;
    }

    global static String stripToEmpty(String str) {
        return str == null ? EMPTY : strip(str, null);
    }

    global static String strip(String str, String stripChars) {
        if (isEmpty(str)) {
            return str;
        }
        str = stripStart(str, stripChars);
        return stripEnd(str, stripChars);
    }

    global static String stripStart(String str, String stripChars) {
        Integer strLen;
        if (str == null || (strLen = str.length()) == 0) {
            return str;
        }
        Integer start = 0;
        if (stripChars == null) {
            while ((start != strLen) && isWhitespace(charAt(str,start))) {
                start++;
            }
        } else if (stripChars.length() == 0) {
            return str;
        } else {
            while ((start != strLen) && (stripChars.indexOf(charAt(str,start)) != -1)) {
                start++;
            }
        }
        return substring(str,start);
    }

    global static String stripEnd(String str, String stripChars) {
        Integer endIndex;
        if (str == null || (endIndex = str.length()) == 0) {
            return str;
        }

        if (stripChars == null) {
            while ((endIndex != 0) && isWhitespace(charAt(str,endIndex - 1))) {
                endIndex--;
            }
        } else if (stripChars.length() == 0) {
            return str;
        } else {
            while ((endIndex != 0) && (stripChars.indexOf(charAt(str,endIndex - 1)) != -1)) {
                endIndex--;
            }
        }
        return substring(str, 0, endIndex);
    }

    global static String[] stripAll(String[] strs) {
        return stripAll(strs, null);
    }

    global static String[] stripAll(String[] strs, String stripChars) {
        Integer strsLen;
        if (strs == null || (strsLen = strs.size()) == 0) {
            return strs;
        }
        String[] newArr = new String[strsLen];
        for (Integer i = 0; i < strsLen; i++) {
            newArr[i] = strip(strs[i], stripChars);
        }
        return newArr;
    }
    
    global static String substring(String str, Integer startIndex) {
        if (str == null) {
            return null;
        }
        // handle negatives, which means last n characters
        if (startIndex < 0) {
            startIndex = str.length() + startIndex; // remember startIndex is negative
        }
        if (startIndex < 0) {
            startIndex = 0;
        }
        if (startIndex >= str.length()) {
            return EMPTY;
        }
        return str.substring(startIndex);
    }

    global static String substring(String str, Integer startIndex, Integer endIndex) {
        if (str == null) {
            return null;
        }
        // handle negatives
        if (endIndex < 0) {
            endIndex = str.length() + endIndex; // remember endIndex is negative
        }
        if (startIndex < 0) {
            startIndex = str.length() + startIndex; // remember startIndex is negative
        }

        // check length next
        if (endIndex > str.length()) {
            endIndex = str.length();
        }

        // if startIndex is greater than endIndex, return ''
        if (startIndex >= endIndex) {
            return EMPTY;
        }

        if (startIndex < 0) {
            startIndex = 0;
        }
        if (endIndex < 0) {
            endIndex = 0;
        }
        return str.substring(startIndex, endIndex);
    }
    
    global static String substringBefore(String str, String separator) {
        if (isEmpty(str) || separator == null) {
            return str;
        }
        if (separator.length() == 0) {
            return EMPTY;
        }
        Integer pos = str.indexOf(separator);
        if (pos == -1) {
            return str;
        }
        return substring(str, 0, pos);
    }
    
    global static String substringAfter(String str, String separator) {
        if (isEmpty(str)) {
            return str;
        }
        if (separator == null) {
            return EMPTY;
        }
        Integer pos = str.indexOf(separator);
        if (pos == -1) {
            return EMPTY;
        }
        return substring(str, pos + separator.length());
    }

    global static String substringBeforeLast(String str, String separator) {
        if (isEmpty(str) || isEmpty(separator)) {
            return str;
        }
        Integer pos = str.lastIndexOf(separator);
        if (pos == -1) {
            return str;
        }
        return substring(str, 0, pos);
    }

    global static String substringAfterLast(String str, String separator) {
        if (isEmpty(str)) {
            return str;
        }
        if (isEmpty(separator)) {
            return EMPTY;
        }
        Integer pos = str.lastIndexOf(separator);
        if (pos == -1 || pos == (str.length() - separator.length())) {
            return EMPTY;
        }
        return substring(str, pos + separator.length());
    }

    global static String substringBetween(String str, String tag) {
        return substringBetween(str, tag, tag);
    }

    global static String substringBetween(String str, String open, String close) {
        if (str == null || open == null || close == null) {
            return null;
        }
        Integer start = str.indexOf(open);
        if (start != -1) {
            Integer endIndex = str.indexOf(close, start + open.length());
            if (endIndex != -1) {
                return substring(str, start + open.length(), endIndex);
            }
        }
        return null;
    }

    global static String[] substringsBetween(String str, String open, String close) {
        if (str == null || isEmpty(open) || isEmpty(close)) {
            return null;
        }
        Integer strLen = str.length();
        if (strLen == 0) {
            return EMPTY_STRING_ARRAY;
        }
        Integer closeLen = close.length();
        Integer openLen = open.length();
        List<String> returnList = new List<String>();
        Integer pos = 0;
        while (pos < (strLen - closeLen)) {
            Integer start = str.indexOf(open, pos);
            if (start < 0) {
                break;
            }
            start += openLen;
            Integer endIndex = str.indexOf(close, start);
            if (endIndex < 0) {
                break;
            }
            returnList.add(substring(str, start, endIndex));
            pos = endIndex + closeLen;
        }
        if (returnList.isEmpty()) {
            return null;
        } 
        return returnList;
    }
    
        
    global static String trim(String str){
        if(str == null){
            return null;
        }
        return str.trim();
    }
    
    global static List<String> trimAll(List<String> aList){
        List<String> returnValue = null;
        if(aList != null){
            returnValue = new List<String>();
            if(aList.size() > 0){
                for(String value : aList){
                    returnValue.add(trim(value));
                }
            }
        }
        return returnValue;
    }
    
    global static Set<String> trimAll(Set<String> aList){
        Set<String> returnValue = null;
        if(aList != null){
            returnValue = new Set<String>();
            if(aList.size() > 0){
                for(String value : aList){
                    returnValue.add(trim(value));
                }
            }
        }
        return returnValue;
    }
    
    global static String trimToNull(String str) {
        String ts = trim(str);
        return isEmpty(ts) ? null : ts;
    }

    global static String trimToEmpty(String str) {
        return str == null ? EMPTY : str.trim();
    }    
    
    //same method in wordUtils
    /*global static String uncapitalize(String str) {
        if(isBlank(str)){
            return str;
        }
        return lowerCase(str.substring(0,1)) + str.substring(1);
    }*/
    
    global static String upperCase(String str) {
        if (str == null) {
            return null;
        }
        return str.toUpperCase();
    }
    
    global static String ensureStringStartsEndsWithChar(String str, String charc){
        String returnStr = str;
        if(returnStr != null && charc != null){
            returnStr = startsWith(str,charc) ? returnStr : charc + returnStr;
            returnStr = endsWith(str,charc) ? returnStr : returnStr + charc;
        }
        return returnStr;
    }

    global static String[] toCharArray(String str){
        List<String> strs = new List<String>();
        if(str != null && str.length() > 0){
            for(Integer i = 0; i < str.length(); i++){
                strs.add(str.substring(i, i+1));
            }
        }    
        return strs;
    }

    /* StringUtils methods */

    /* Character methods */
   global static final IntegerRange UPPERCASE_ASCII_RANGE = new IntegerRange(65,90);
    global static final IntegerRange LOWERCASE_ASCII_RANGE = new IntegerRange(97,122);
    global static final IntegerRange DIGIT_ASCII_RANGE = new IntegerRange(48,57);
    
    //global static final Integer COMBINING_SPACING_MARK = 1;
    global static final Integer CONNECTOR_PUNCTUATION = 2;
    global static final Integer CONTROL = 3;
    global static final Integer CURRENCY_SYMBOL = 4;
    global static final Integer DASH_PUNCTUATION = 5;
    global static final Integer DECIMAL_DIGIT_NUMBER = 6;
    //global static final Integer ENCLOSING_MARK = 7;
    global static final Integer END_PUNCTUATION = 8;
    //global static final Integer FINAL_QUOTE_PUNCTUATION = 9;
    //global static final Integer FORMAT = 10;
    //global static final Integer INITIAL_QUOTE_PUNCTUATION = 11;
    //global static final Integer LETTER_NUMBER = 12;
    //global static final Integer LINE_SEPARATOR = 13;
    global static final Integer LOWERCASE_LETTER = 14;
    global static final Integer MATH_SYMBOL = 15;
    //global static final Integer MODIFIER_LETTER = 16;
    global static final Integer MODIFIER_SYMBOL = 17;
    //global static final Integer NON_SPACING_MARK = 18;
    //global static final Integer OTHER_LETTER = 19;
    //global static final Integer OTHER_NUMBER = 20;
    global static final Integer OTHER_PUNCTUATION = 21;
    //global static final Integer OTHER_SYMBOL = 22;
    //global static final Integer PARAGRAPH_SEPARATOR = 23;
    //global static final Integer PRIVATE_USE = 24;
    global static final Integer SPACE_SEPARATOR = 25;
    global static final Integer START_PUNCTUATION = 26;
    //global static final Integer SURROGATE = 27;
    //global static final Integer TITLECASE_LETTER = 28;
    global static final Integer UNASSIGNED = 29;
    global static final Integer UPPERCASE_LETTER = 30;

    private static final Map<String,Integer> charToAscii = new Map<String,Integer>();
    private static final Map<Integer,String> asciiToChar = new Map<Integer,String>();
    private static final Map<Integer,Integer> asciiToType = new Map<Integer,Integer>();
    
    
    global static Integer getType(String character){
        validateChar(character);
        Integer ascii = toAscii(character);
        if(asciiToType.containsKey(ascii)){
            return asciiToType.get(ascii);
        }
        return UNASSIGNED; 
    }
    
    global static Integer toAscii(String character){
        validateChar(character);
        if(charToAscii.containsKey(character)){
            return charToAscii.get(character);
        }
        return -1; 
    }
    
    global static String toChar(Integer ascii){
        if(ascii <= 0 || ascii > 127){
            return null;    
        }
        if(asciiToChar.containsKey(ascii)){
            return asciiToChar.get(ascii);
        }
        return null; 
    }
    
    global static String toTitleCase(String ch){
        if(inAsciiRange(ch,LOWERCASE_ASCII_RANGE)){
            return toChar(toAscii(ch)-32);
        }
        return ch; 
    }
    
    global static String toUpperCase(String ch){
        return toTitleCase(ch); 
    }
    
    global static String toLowerCase(String ch){
        if(inAsciiRange(ch,UPPERCASE_ASCII_RANGE)){
            return toChar(toAscii(ch)+32);
        }
        return ch; 
    }
    
    global static Boolean isUpperCase(String character){ 
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE); 
    }
    
    global static Boolean isTitleCase(String character){ 
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE); 
    }
    
    global static Boolean isLowerCase(String character){ 
        return inAsciiRange(character,LOWERCASE_ASCII_RANGE); 
    }
    
    global static Boolean isDigit(String character){ 
        return inAsciiRange(character,DIGIT_ASCII_RANGE); 
    }

    global static Boolean isLetter(String character){ 
        return isLowerCase(character) || isUpperCase(character);
    }
    
    global static Boolean isLetterOrDigit(String character){
        return isLetter(character) || isDigit(character);
    }
    
    global static Boolean isWhitespace(String character){
        validateChar(character);
        return 
            ' '.equals(character)
            || '\n'.equals(character)
            || '\t'.equals(character)
            || '\f'.equals(character)
            || '\r'.equals(character)
            ;        
    }
    
    global static boolean isAscii(String character) {
        Integer ascii = toAscii(character);
        return ascii >= 0 && ascii < 128;
    }
    
    global static boolean isAsciiPrintable(String character) {
        Integer ascii = toAscii(character);
        return ascii >= 32 && ascii < 127;
    }
    
    global static boolean isAsciiControl(String character) {
        Integer ascii = toAscii(character);
        return (ascii >= 0 && ascii < 32) || ascii == 127;
    }
    
    global static boolean isAsciiAlpha(String character) {
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE) || inAsciiRange(character,LOWERCASE_ASCII_RANGE);
    }
    
    global static boolean isAsciiAlphaUpper(String character) {
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE);
    }
    
    global static boolean isAsciiAlphaLower(String character) {
        return inAsciiRange(character,LOWERCASE_ASCII_RANGE);
    }
    
    global static boolean isAsciiNumeric(String character) {
        return inAsciiRange(character,DIGIT_ASCII_RANGE);
    }
    
    global static boolean isAsciiAlphanumeric(String character) {
        return inAsciiRange(character,UPPERCASE_ASCII_RANGE) 
            || inAsciiRange(character,LOWERCASE_ASCII_RANGE)
            || inAsciiRange(character,DIGIT_ASCII_RANGE);
    }
        
    global static void validateChar(String character){
        if(character != null && character.length() != 1){
            throw new InvalidCharacterStringException('Invalid charcter string: ' + character);
        }
    }

    private static Boolean inAsciiRange(String character, IntegerRange range){
        return range == null ? false : range.contains(toAscii(character));
    }
    
    static{
        charToAscii.put(null, 0);
        charToAscii.put('\t', 9);
        charToAscii.put('\n', 10);
        charToAscii.put('\f', 12);
        charToAscii.put('\r', 13);
        charToAscii.put(' ', 32);
        charToAscii.put('!', 33);
        charToAscii.put('"', 34);
        charToAscii.put('#', 35);
        charToAscii.put('$', 36);
        charToAscii.put('%', 37);
        charToAscii.put('&', 38);
        charToAscii.put('\'', 39);
        charToAscii.put('(', 40);
        charToAscii.put(')', 41);
        charToAscii.put('*', 42);
        charToAscii.put('+', 43);
        charToAscii.put(',', 44);
        charToAscii.put('-', 45);
        charToAscii.put('.', 46);
        charToAscii.put('/', 47);
        charToAscii.put('0', 48);
        charToAscii.put('1', 49);
        charToAscii.put('2', 50);
        charToAscii.put('3', 51);
        charToAscii.put('4', 52);
        charToAscii.put('5', 53);
        charToAscii.put('6', 54);
        charToAscii.put('7', 55);
        charToAscii.put('8', 56);
        charToAscii.put('9', 57);
        charToAscii.put(':', 58);
        charToAscii.put(';', 59);
        charToAscii.put('<', 60);
        charToAscii.put('=', 61);
        charToAscii.put('>', 62);
        charToAscii.put('?', 63);
        charToAscii.put('@', 64);
        charToAscii.put('A', 65);
        charToAscii.put('B', 66);
        charToAscii.put('C', 67);
        charToAscii.put('D', 68);
        charToAscii.put('E', 69);
        charToAscii.put('F', 70);
        charToAscii.put('G', 71);
        charToAscii.put('H', 72);
        charToAscii.put('I', 73);
        charToAscii.put('J', 74);
        charToAscii.put('K', 75);
        charToAscii.put('L', 76);
        charToAscii.put('M', 77);
        charToAscii.put('N', 78);
        charToAscii.put('O', 79);
        charToAscii.put('P', 80);
        charToAscii.put('Q', 81);
        charToAscii.put('R', 82);
        charToAscii.put('S', 83);
        charToAscii.put('T', 84);
        charToAscii.put('U', 85);
        charToAscii.put('V', 86);
        charToAscii.put('W', 87);
        charToAscii.put('X', 88);
        charToAscii.put('Y', 89);
        charToAscii.put('Z', 90);
        charToAscii.put('[', 91);
        charToAscii.put('\\', 92);
        charToAscii.put(']', 93);
        charToAscii.put('^', 94);
        charToAscii.put('_', 95);
        charToAscii.put('`', 96);
        charToAscii.put('a', 97);
        charToAscii.put('b', 98);
        charToAscii.put('c', 99);
        charToAscii.put('d', 100);
        charToAscii.put('e', 101);
        charToAscii.put('f', 102);
        charToAscii.put('g', 103);
        charToAscii.put('h', 104);
        charToAscii.put('i', 105);
        charToAscii.put('j', 106);
        charToAscii.put('k', 107);
        charToAscii.put('l', 108);
        charToAscii.put('m', 109);
        charToAscii.put('n', 110);
        charToAscii.put('o', 111);
        charToAscii.put('p', 112);
        charToAscii.put('q', 113);
        charToAscii.put('r', 114);
        charToAscii.put('s', 115);
        charToAscii.put('t', 116);
        charToAscii.put('u', 117);
        charToAscii.put('v', 118);
        charToAscii.put('w', 119);
        charToAscii.put('x', 120);
        charToAscii.put('y', 121);
        charToAscii.put('z', 122);
        charToAscii.put('{', 123);
        charToAscii.put('|', 124);
        charToAscii.put('}', 125);
        charToAscii.put('~', 126);
        for(String key : charToAscii.keySet()){
            asciiToChar.put(charToAscii.get(key), key);    
        }

        asciiToType.put(0, CONTROL);
        asciiToType.put(9, CONTROL);
        asciiToType.put(10, CONTROL);
        asciiToType.put(12, CONTROL);
        asciiToType.put(13, CONTROL);
        asciiToType.put(32, SPACE_SEPARATOR);
        asciiToType.put(33, OTHER_PUNCTUATION);
        asciiToType.put(34, OTHER_PUNCTUATION);
        asciiToType.put(35, OTHER_PUNCTUATION);
        asciiToType.put(36, CURRENCY_SYMBOL);
        asciiToType.put(37, OTHER_PUNCTUATION);
        asciiToType.put(38, OTHER_PUNCTUATION);
        asciiToType.put(39, OTHER_PUNCTUATION);
        asciiToType.put(40, START_PUNCTUATION);
        asciiToType.put(41, END_PUNCTUATION);
        asciiToType.put(42, OTHER_PUNCTUATION);
        asciiToType.put(43, MATH_SYMBOL);
        asciiToType.put(44, OTHER_PUNCTUATION);
        asciiToType.put(45, DASH_PUNCTUATION);
        asciiToType.put(46, OTHER_PUNCTUATION);
        asciiToType.put(47, OTHER_PUNCTUATION);
        asciiToType.put(48, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(49, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(50, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(51, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(52, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(53, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(54, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(55, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(56, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(57, DECIMAL_DIGIT_NUMBER);
        asciiToType.put(58, OTHER_PUNCTUATION);
        asciiToType.put(59, OTHER_PUNCTUATION);
        asciiToType.put(60, MATH_SYMBOL);
        asciiToType.put(61, MATH_SYMBOL);
        asciiToType.put(62, MATH_SYMBOL);
        asciiToType.put(63, OTHER_PUNCTUATION);
        asciiToType.put(64, OTHER_PUNCTUATION);
        asciiToType.put(65, UPPERCASE_LETTER);
        asciiToType.put(66, UPPERCASE_LETTER);
        asciiToType.put(67, UPPERCASE_LETTER);
        asciiToType.put(68, UPPERCASE_LETTER);
        asciiToType.put(69, UPPERCASE_LETTER);
        asciiToType.put(70, UPPERCASE_LETTER);
        asciiToType.put(71, UPPERCASE_LETTER);
        asciiToType.put(72, UPPERCASE_LETTER);
        asciiToType.put(73, UPPERCASE_LETTER);
        asciiToType.put(74, UPPERCASE_LETTER);
        asciiToType.put(75, UPPERCASE_LETTER);
        asciiToType.put(76, UPPERCASE_LETTER);
        asciiToType.put(77, UPPERCASE_LETTER);
        asciiToType.put(78, UPPERCASE_LETTER);
        asciiToType.put(79, UPPERCASE_LETTER);
        asciiToType.put(80, UPPERCASE_LETTER);
        asciiToType.put(81, UPPERCASE_LETTER);
        asciiToType.put(82, UPPERCASE_LETTER);
        asciiToType.put(83, UPPERCASE_LETTER);
        asciiToType.put(84, UPPERCASE_LETTER);
        asciiToType.put(85, UPPERCASE_LETTER);
        asciiToType.put(86, UPPERCASE_LETTER);
        asciiToType.put(87, UPPERCASE_LETTER);
        asciiToType.put(88, UPPERCASE_LETTER);
        asciiToType.put(89, UPPERCASE_LETTER);
        asciiToType.put(90, UPPERCASE_LETTER);
        asciiToType.put(91, START_PUNCTUATION);
        asciiToType.put(92, OTHER_PUNCTUATION);
        asciiToType.put(93, END_PUNCTUATION);
        asciiToType.put(94, MODIFIER_SYMBOL);
        asciiToType.put(95, CONNECTOR_PUNCTUATION);
        asciiToType.put(96, MODIFIER_SYMBOL);
        asciiToType.put(97, LOWERCASE_LETTER );
        asciiToType.put(98, LOWERCASE_LETTER );
        asciiToType.put(99, LOWERCASE_LETTER );
        asciiToType.put(100, LOWERCASE_LETTER );
        asciiToType.put(101, LOWERCASE_LETTER );
        asciiToType.put(102, LOWERCASE_LETTER );
        asciiToType.put(103, LOWERCASE_LETTER );
        asciiToType.put(104, LOWERCASE_LETTER );
        asciiToType.put(105, LOWERCASE_LETTER );
        asciiToType.put(106, LOWERCASE_LETTER );
        asciiToType.put(107, LOWERCASE_LETTER );
        asciiToType.put(108, LOWERCASE_LETTER );
        asciiToType.put(109, LOWERCASE_LETTER );
        asciiToType.put(110, LOWERCASE_LETTER );
        asciiToType.put(111, LOWERCASE_LETTER );
        asciiToType.put(112, LOWERCASE_LETTER );
        asciiToType.put(113, LOWERCASE_LETTER );
        asciiToType.put(114, LOWERCASE_LETTER );
        asciiToType.put(115, LOWERCASE_LETTER );
        asciiToType.put(116, LOWERCASE_LETTER );
        asciiToType.put(117, LOWERCASE_LETTER );
        asciiToType.put(118, LOWERCASE_LETTER );
        asciiToType.put(119, LOWERCASE_LETTER );
        asciiToType.put(120, LOWERCASE_LETTER );
        asciiToType.put(121, LOWERCASE_LETTER );
        asciiToType.put(122, LOWERCASE_LETTER );
        asciiToType.put(123, START_PUNCTUATION);
        asciiToType.put(124, MATH_SYMBOL);
        asciiToType.put(125, END_PUNCTUATION);
        asciiToType.put(126, MATH_SYMBOL);
        asciiToType.put(127, CONTROL);
    }    
    /* Character methods */

    /* NumberUtils methods */
    

    global static final Integer MAX_INTEGER = 2147483647;
    global static final Integer MIN_INTEGER = -2147483647;
    global static final IntegerRange MAX_INTEGER_RANGE = new IntegerRange(MIN_INTEGER,MAX_INTEGER);
    
    global static final Long MAX_LONG = 9223372036854775807L;
    global static final Long MIN_LONG = -9223372036854775807L;
    global static final LongRange MAX_LONG_RANGE = new LongRange(MIN_LONG,MAX_LONG);
    
    global static Integer parseInt(String str, Integer radix){
        return parseLong(str,radix).intValue();
    }
    
    global static Long parseLong(String str, Integer radix){
        str = upperCase(trim(str));
        if(isBlank(str)){
            throw new NumberFormatException();
        }
        if(radix < 2 || radix > 36){
            throw new IllegalArgumentException('invalid radix parameter: ' + radix + '; radix must be >= 2 and <= 36');
        }
        Boolean isNegative = false;
        if(startsWith(str, '-')){
            isNegative = true;
            str = removeStart(str, '-');
        }
        String validChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(0,radix);
        if(!containsOnly(str,validChars)){
            throw new NumberFormatException('Invalid characters found in number: ' + str + ', with radix = ' + radix);
        }
        final Integer LENGTH = length(str);
        Long returnValue = 0;
        for(Integer i = 0; i < LENGTH; i++){
            returnValue +=
                (validChars.indexOf(str.substring(LENGTH-i-1,LENGTH-i))
                * Math.pow(radix,i)).longValue();
        }
        if(isNegative){
            returnValue = -returnValue;
        }
        return returnValue;
    }
    
    
    
    global static String toBinaryString(Integer i){
        return toString(i,2);
    }

    global static String toOctalString(Integer i){
        return toString(i,8);
    }
    
    global static String toHexString(Integer i){
        return toString(i,16);
    }

    global static String toString(Integer i, Integer radix){
        if(i == null){
            return null;
        }
        return toString((Long)i,radix);
    }

    global static String toBinaryString(Long l){
        return toString(l,2);
    }

    global static String toOctalString(Long l){
        return toString(l,8);
    }

    global static String toHexString(Long l){
        return toString(l,16);
    }

    global static String toString(Long l, Integer radix){
        if(l == null){
            return null;
        }
        if(radix < 2 || radix > 36){
            throw new IllegalArgumentException('invalid radix parameter: ' + radix + '; radix must be >= 2 and <= 36');
        }
        return (l<0 ? '-' : '') + toStringPrivate(Math.abs(l),radix,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(0,radix));
    }

    private static String toStringPrivate(Long l, Integer radix, String validChars){
        Integer r = Math.mod(l,radix).intValue();
        String result;
        if(l-r == 0){ 
            result = charAt(validChars,r);
        }else{ 
            result = toStringPrivate(((l-r)/radix),radix,validChars) + charAt(validChars,r);
        }
        return result;
        
    }   
    
    /* NumberUtils methods */

    /* SetUtils methods */

    global static Set<Blob> objectToBlob(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Blob> blobSet = new Set<Blob>();
        for(Object anObject : objectSet){
            if(anObject instanceof Blob){
                blobSet.add((Blob)anObject);
            }
        }
        return blobSet;
    }

    global static Set<Boolean> objectToBoolean(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Boolean> booleanSet = new Set<Boolean>();
        for(Object anObject : objectSet){
            if(anObject instanceof Boolean){
                booleanSet.add((Boolean)anObject);
            }
        }
        return booleanSet;
    }

    global static Set<Date> objectToDate(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Date> dateSet = new Set<Date>();
        for(Object anObject : objectSet){
            if(anObject instanceof Date){
                dateSet.add((Date)anObject);
            }
        }return dateSet;
    }

    global static Set<Datetime> objectToDatetime(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Datetime> datetimeSet = new Set<Datetime>();
        for(Object anObject : objectSet){
            if(anObject instanceof Datetime){
                datetimeSet.add((Datetime)anObject);
            }
        }
        return datetimeSet;
    }

    global static Set<Decimal> objectToDecimal(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Decimal> decimalSet = new Set<Decimal>();
        for(Object anObject : objectSet){
            if(anObject instanceof Decimal){
                decimalSet.add((Decimal)anObject);
            }
        }
        return decimalSet;
    }

    global static Set<Double> objectToDouble(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Double> doubleSet = new Set<Double>();
        for(Object anObject : objectSet){
            if(anObject instanceof Double){
                doubleSet.add((Double)anObject);
            }
        }return doubleSet;
    }

    global static Set<ID> objectToID(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<ID> idSet = new Set<ID>();
        for(Object anObject : objectSet){
            if(anObject instanceof ID){
                idSet.add((ID)anObject);
            }
        }
        return idSet;
    }

    global static Set<Integer> objectToInteger(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Integer> integerSet = new Set<Integer>();
        for(Object anObject : objectSet){
            if(anObject instanceof Integer){
                integerSet.add((Integer)anObject);
            }
        }
        return integerSet;
    }

    global static Set<Long> objectToLong(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Long> longSet = new Set<Long>();
        for(Object anObject : objectSet){
            if(anObject instanceof Long){
                longSet.add((Long)anObject);
            }
        }
        return longSet;
    }

    global static Set<Time> objectToTime(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Time> timeSet = new Set<Time>();
        for(Object anObject : objectSet){
            if(anObject instanceof Time){
                timeSet.add((Time)anObject);
            }
        }
        return timeSet;
    }

    global static Set<String> objectToString(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<String> stringSet = new Set<String>();
        for(Object anObject : objectSet){
            if(anObject instanceof String){
                stringSet.add((String)anObject);
            }
        }
        return stringSet;
    }

    global static Set<Object> blobToObject(Set<Blob> blobSet){
        if(blobSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Blob aBlob : blobSet){
            objectSet.add(aBlob);
        }
        return objectSet;
    }
    
    global static Set<Object> booleanToObject(Set<Boolean> booleanSet){
        if(booleanSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Boolean aBoolean : booleanSet){
            objectSet.add(aBoolean);
        }
        return objectSet;
    }
        
    global static Set<Object> dateToObject(Set<Date> dateSet){
        if(dateSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Date aDate : dateSet){
            objectSet.add(aDate);
        }
        return objectSet;
    }
    
    global static Set<Object> datetimeToObject(Set<Datetime> datetimeSet){
        if(datetimeSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Datetime aDatetime : datetimeSet){
            objectSet.add(aDatetime);
        }
        return objectSet;
    }
    
    global static Set<Object> decimalToObject(Set<Decimal> decimalSet){
        if(decimalSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Decimal aDecimal : decimalSet){
            objectSet.add(aDecimal);
        }
        return objectSet;
    }
    
    global static Set<Object> doubleToObject(Set<Double> doubleSet){
        if(doubleSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Double aDouble : doubleSet){
            objectSet.add(aDouble);
        }
        return objectSet;
    }
    
    global static Set<Object> idToObject(Set<ID> idSet){
        if(idSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(ID aID : idSet){
            objectSet.add(aID);
        }
        return objectSet;
    }
    
    global static Set<Object> integerToObject(Set<Integer> integerSet){
        if(integerSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Integer aInteger : integerSet){
            objectSet.add(aInteger);
        }
        return objectSet;
    }
    
    global static Set<Object> longToObject(Set<Long> longSet){
        if(longSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Long aLong : longSet){
            objectSet.add(aLong);
        }
        return objectSet;
    }
    
    global static Set<Object> timeToObject(Set<Time> timeSet){
        if(timeSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Time aTime : timeSet){
            objectSet.add(aTime);
        }
        return objectSet;
    }
    
    global static Set<Object> stringToObject(Set<String> stringSet){
        if(stringSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(String aString : stringSet){
            objectSet.add(aString);
        }
        return objectSet;
    }

    global static String toString(Set<Blob> blobSet){ return toString(blobToObject(blobSet)); }
    global static String toString(Set<Boolean> booleanSet){ return toString(booleanToObject(booleanSet)); }
    global static String toString(Set<Date> dateSet){ return toString(dateToObject(dateSet)); }
    global static String toString(Set<Datetime> datetimeSet){ return toString(datetimeToObject(datetimeSet)); }
    global static String toString(Set<Decimal> decimalSet){ return toString(decimalToObject(decimalSet)); }
    global static String toString(Set<Double> doubleSet){ return toString(doubleToObject(doubleSet)); }
    global static String toString(Set<ID> idSet){ return toString(idToObject(idSet)); }
    global static String toString(Set<Integer> integerSet){ return toString(integerToObject(integerSet)); }
    global static String toString(Set<Long> longSet){ return toString(longToObject(longSet)); }
    global static String toString(Set<Time> timeSet){ return toString(timeToObject(timeSet)); }
    global static String toString(Set<String> stringSet){ return toString(stringToObject(stringSet)); }

    global static String toString(Set<Object> objectSet){
        if(objectSet == null){
            return 'null';
        }
        if(objectSet.size() <= 0){
            return '{}';
        }
        String returnValue = '';
        Boolean isFirst = true;
        for(Object anObject : objectSet){
            if(isFirst){
                isFirst = false;    
            } else {
                returnValue += ',';
            }
            if(anObject instanceof Blob){ returnValue += '\'' + ((Blob)anObject).toString() + '\'';
            } else if(anObject instanceof Boolean){ returnValue += ((Boolean)anObject);
            } else if(anObject instanceof Date){ returnValue += '\'' + ((Date)anObject) + '\'';
            } else if(anObject instanceof Datetime){ returnValue += '\'' + ((Datetime)anObject) + '\'';
            } else if(anObject instanceof Integer){ returnValue += ((Integer)anObject);
            } else if(anObject instanceof Long){ returnValue += ((Long)anObject);
            } else if(anObject instanceof Decimal){ returnValue += ((Decimal)anObject);
            //} else if(anObject instanceof Double){ returnValue += ((Double)anObject);
            } else if(anObject instanceof String){ returnValue += '\'' + ((String)anObject) + '\'';
            //} else if(anObject instanceof ID){ returnValue += '\'' + ((ID)anObject) + '\'';
            } else if(anObject instanceof Time){ returnValue += '\'' + ((Time)anObject) + '\'';}
        }
        return '{' + returnValue + '}';
    }
    
    global static Set<String> listToSet(List<String> aList){
        Set<String> returnValue = null;
        if(aList != null){
            returnValue = new Set<String>();
            if(aList.size() > 0){
                for(String value : aList){
                    returnValue.add(value);
                }
            }
        }
        return returnValue;
    }

    global static Set<Object> listToSet(List<Object> aList){
        Set<Object> returnValue = null;
        if(aList != null){
            returnValue = new Set<Object>();
            if(aList.size() > 0){
                for(Object value : aList){
                    returnValue.add(value);
                }
            }
        }
        return returnValue;
    }

    global static List<String> setToList(Set<String> aSet){
        List<String> returnValue = null;
        if(aSet != null){
            returnValue = new List<String>();
            if(aSet.size() > 0){
                for(String value : aSet){
                    returnValue.add(value);
                }
            }
        }
        return returnValue;
    }


    global static void assertEquals(Set<Blob> b1,Set<Blob> b2){ assertEquals(blobToObject(b1),blobToObject(b2)); }
    global static void assertEquals(Set<Boolean> b1,Set<Boolean> b2){ assertEquals(booleanToObject(b1),booleanToObject(b2)); }
    global static void assertEquals(Set<Date> d1,Set<Date> d2){ assertEquals(dateToObject(d1),dateToObject(d2)); }
    global static void assertEquals(Set<Datetime> d1,Set<Datetime> d2){ assertEquals(datetimeToObject(d1),datetimeToObject(d2)); }
    global static void assertEquals(Set<Decimal> d1,Set<Decimal> d2){ assertEquals(decimalToObject(d1),decimalToObject(d2)); }
    global static void assertEquals(Set<Double> d1,Set<Double> d2){ assertEquals(doubleToObject(d1),doubleToObject(d2)); }
    global static void assertEquals(Set<Integer> i1,Set<Integer> i2){ assertEquals(integerToObject(i1),integerToObject(i2)); }
    global static void assertEquals(Set<Long> l1,Set<Long> l2){ assertEquals(longToObject(l1),longToObject(l2)); }
    global static void assertEquals(Set<String> s1,Set<String> s2){ assertEquals(stringToObject(s1),stringToObject(s2)); }
    global static void assertEquals(Set<Time> t1,Set<Time> t2){ assertEquals(timeToObject(t1),timeToObject(t2)); }

    global static void assertEquals(Set<Object> expected, Set<Object> actual){
        System.assert(
            equals(expected,actual),
            'Assertion failed, the following two arrays are not equal.  Expected: ' 
                + toString(expected) 
                + ', Actual: ' 
                + toString(actual));
    }

    global static Boolean equals(Set<Blob> b1,Set<Blob> b2){ return equals(blobToObject(b1),blobToObject(b2)); }
    global static Boolean equals(Set<Boolean> b1,Set<Boolean> b2){ return equals(booleanToObject(b1),booleanToObject(b2)); }
    global static Boolean equals(Set<Date> d1,Set<Date> d2){ return equals(dateToObject(d1),dateToObject(d2)); }
    global static Boolean equals(Set<Datetime> d1,Set<Datetime> d2){ return equals(datetimeToObject(d1),datetimeToObject(d2)); }
    global static Boolean equals(Set<Decimal> d1,Set<Decimal> d2){ return equals(decimalToObject(d1),decimalToObject(d2)); }
    global static Boolean equals(Set<Double> d1,Set<Double> d2){ return equals(doubleToObject(d1),doubleToObject(d2)); }
    global static Boolean equals(Set<Integer> i1,Set<Integer> i2){ return equals(integerToObject(i1),integerToObject(i2)); }
    global static Boolean equals(Set<Long> l1,Set<Long> l2){ return equals(longToObject(l1),longToObject(l2)); }
    global static Boolean equals(Set<String> s1,Set<String> s2){ return equals(stringToObject(s1),stringToObject(s2)); }
    global static Boolean equals(Set<Time> t1,Set<Time> t2){ return equals(timeToObject(t1),timeToObject(t2)); }
    
    global static Boolean equals(Set<Object> expected, Set<Object> actual){
        if(expected == null && actual == null){
            return true;
        }
        if((expected == null && actual != null) || (expected != null && actual == null)){
            return false;
        }
        if(expected.size() != actual.size()){
            return false;
        }
        for(Object obj : expected){
            if(!actual.contains(obj)){
                return false;
            }
        }
        return true;
    }
        
    /* SetUtils methods */
    
    /* ArrayUtils methods */
   
    global static String[] EMPTY_STRING_ARRAY = new String[]{};
    global static Integer MAX_NUMBER_OF_ELEMENTS_IN_LIST {get{return 1000;}}
    
    global static Object[] reverse(Object[] anArray) {
        if (anArray == null) {
            return null;
        }
        Integer i = 0;
        Integer j = anArray.size() - 1;
        Object tmp;
        while (j > i) {
            tmp = anArray[j];
            anArray[j] = anArray[i];
            anArray[i] = tmp;
            j--;
            i++;
        }
        return anArray;
    }
    
    global static SObject[] reverse(SObject[] anArray) {
        if (anArray == null) {
            return null;
        }
        Integer i = 0;
        Integer j = anArray.size() - 1;
        SObject tmp;
        while (j > i) {
            tmp = anArray[j];
            anArray[j] = anArray[i];
            anArray[i] = tmp;
            j--;
            i++;
        }
        return anArray;
    }
    
    global static Object[] mergex(Object[] array1, Object[] array2){
        if(array1 == null){ return array2; }
        if(array2 == null){ return array1; }
        Object[] merged = new Object[array1.size() + array2.size()];
        for(Integer i = 0; i < array1.size(); i++){
            merged[i] = array1[i];
        }
        for(Integer i = 0; i < array2.size(); i++){
            merged[i+array1.size()] = array2[i];
        }
        return merged;
    }   
     
    global static SObject[] mergex(SObject[] array1, SObject[] array2){
        if(array1 == null){ return array2; }
        if(array2 == null){ return array1; }
        if(array1.size() <= 0){ return array2; }
        List<SObject> merged = createEmptySObjectList(array1[0]);
        for(SObject sObj : array1){ merged.add(sObj); }
        for(SObject sObj : array2){ merged.add(sObj); }
        return merged;
    }   
    
    global static Boolean isEmpty(Object[] objectArray){
        if(objectArray == null){
            return true;
        }
        return objectArray.size() == 0;
    }
    
    global static Boolean isEmpty(SObject[] objectArray){
        if(objectArray == null){
            return true;
        }
        return objectArray.size() == 0;
    }
    
    global static Boolean isNotEmpty(Object[] objectArray){
        return !isEmpty(objectArray);
    }
    
    global static Boolean isNotEmpty(SObject[] objectArray){
        return !isEmpty(objectArray);
    }
    
       global static Object[] pluck(SObject[] objectArray, String fieldName){
        if(isEmpty(objectArray) || isBlank(fieldName)){
            return new Object[]{};
        }
        Object[] plucked = new Object[objectArray.size()];
        for(Integer i = 0; i < objectArray.size(); i++){
            plucked[i] = objectArray[i].get(fieldName);
        }
        return plucked;
    }
    
    
    global static String toString(Object[] objectArray){
        if(objectArray == null){
            return 'null';    
        }
        String returnValue = '{';
        for(Integer i = 0; i < objectArray.size(); i++){
            if(i!=0){ returnValue += ','; }
            returnValue += '\'' + objectArray[i] + '\'';
        }
        returnValue += '}';
        return returnValue; 
    }
    
    global static String toString(SObject[] objectArray){
        if(objectArray == null){
            return 'null';    
        }
        String returnValue = '{';
        for(Integer i = 0; i < objectArray.size(); i++){
            if(i!=0){ returnValue += ','; }
            returnValue += '\'' + objectArray[i] + '\'';
        }
        returnValue += '}';
        return returnValue; 
    }
    
    global static void assertArraysAreEqual(Object[] expected, Object[] actual){
        //check to see if one param is null but the other is not
        System.assert((expected == null && actual == null)|| (expected != null && actual != null),
            'Assertion failed, the following two arrays are not equal.  Expected: ' 
                    + toString(expected) + ', Actual: ' + toString(actual));
        if(expected != null && actual != null){
            System.assert(expected.size() == actual.size(), 'Assertion failed, the following two arrays are not equal.  Expected: ' 
                    + toString(expected) + ', Actual: ' + toString(actual));
            for(Integer i = 0; i < expected.size(); i++){
                System.assert(expected[i] == actual[i], 'Assertion failed, the following two arrays are not equal.  Expected: ' 
                    + toString(expected) + ', Actual: ' + toString(actual));
            }
        }
    }
    
    global static void assertArraysAreEqual(SObject[] expected, SObject[] actual){
        //check to see if one param is null but the other is not
        System.assert((expected == null && actual == null)|| (expected != null && actual != null),
            'Assertion failed, the following two arrays are not equal.  Expected: ' 
                    + toString(expected) + ', Actual: ' + toString(actual));
        if(expected != null && actual != null){
            System.assert(expected.size() == actual.size(), 'Assertion failed, the following two arrays are not equal.  Expected: ' 
                    + toString(expected) + ', Actual: ' + toString(actual));
            for(Integer i = 0; i < expected.size(); i++){
                System.assert(expected[i] == actual[i], 'Assertion failed, the following two arrays are not equal.  Expected: ' 
                    + toString(expected) + ', Actual: ' + toString(actual));
            }
        }
    }
    
    /**
     * This method is no longer needed as in Spring '10, you can created
     * generic SObject lists.
     * 
     * @deprecated
     */
    global static List<SObject> createEmptySObjectList(SObject prototype){
        if(prototype == null){
            return null;
        }
        return Database.query(
            'select Id from ' 
            + split(''+prototype,':')[0] 
            + ' where Id = \'0015000000Mrr40\' LIMIT 0'); // use dummy Id to ensure no return
    }

    global static List<Object> merg(List<Object> list1, List<Object> list2) {
        List<Object> returnList = new List<Object>();
        if(list1 != null && list2 != null && (list1.size()+list2.size()) > MAX_NUMBER_OF_ELEMENTS_IN_LIST){
            throw new IllegalArgumentException('Lists cannot be merged because new list would be greater than maximum number of elements in a list: ' + MAX_NUMBER_OF_ELEMENTS_IN_LIST);
        }
        if(isNotEmpty(list1)){
            for(Object elmt : list1){
                returnList.add(elmt);
            }
        }
        if(isNotEmpty(list2)){
            for(Object elmt : list2){
                returnList.add(elmt);
            }
        }
        return returnList;
    }

    
    global static List<SObject> merg(List<SObject> list1, List<SObject> list2) {
        if(list1 != null && list2 != null && (list1.size()+list2.size()) > MAX_NUMBER_OF_ELEMENTS_IN_LIST){
            throw new IllegalArgumentException('Lists cannot be merged because new list would be greater than maximum number of elements in a list: ' + MAX_NUMBER_OF_ELEMENTS_IN_LIST);
        }
        if(isEmpty(list1) && isEmpty(list2)){
            return null;
        }
        List<SObject> returnList = createEmptySObjectList(isNotEmpty(list1) ? list1.get(0) : list2.get(0));
        if(list1 != null){
            for(SObject elmt : list1){
                returnList.add(elmt);
            }
        }
        if(list2 != null){
            for(SObject elmt : list2){
                returnList.add(elmt);
            }
        }
        return returnList;
    }
    
    global static List<Object> subset(List<Object> aList, Integer count) {
        return subset(aList,0,count);
    }

    global static List<Object> subset(List<Object> list1, Integer startIndex, Integer count) {
        List<Object> returnList = new List<Object>();
        if(list1 != null && list1.size() > 0 && startIndex >= 0 && startIndex <= list1.size()-1 && count > 0){
            for(Integer i = startIndex; i < list1.size() && i - startIndex < count; i++){
                returnList.add(list1.get(i));
            }
        }
        return returnList;
    }

    
    global static List<SObject> subset(List<SObject> aList, Integer count) {
        return subset(aList,0,count);
    }

    global static List<SObject> subset(List<SObject> list1, Integer startIndex, Integer count) {
        List<SObject> returnList = null;
        if(list1 != null && list1.size() > 0 && startIndex <= list1.size()-1 && count > 0){
            returnList = createEmptySObjectList(list1.get(0));
            for(Integer i = startIndex; i < list1.size() && i - startIndex < count; i++){
                returnList.add(list1.get(i));
            }
        }
        return returnList;
    }
    
    //===============================================
    //LIST/ARRAY SORTING
    //===============================================

    //FOR FORCE.COM PRIMITIVES (Double,Integer,ID,etc.):
    global static List<Object> qsort(List<Object> theList) {
        return qsort(theList,new PrimitiveComparator());
    }

    global static List<Object> qsort(List<Object> theList, Boolean sortAsc) {
        return qsort(theList,new PrimitiveComparator(),sortAsc);
    }
    
    global static List<Object> qsort(List<Object> theList, ObjectComparator comparator) {
        return qsort(theList,comparator,true);
    }
    
    global static List<Object> qsort(List<Object> theList, ObjectComparator comparator, Boolean sortAsc) {
        return qsort(theList, 0, (theList == null ? 0 : theList.size()-1),comparator,sortAsc);
    }
    

    
    //FOR SALESFORCE OBJECTS (sObjects):
    global static List<SObject> qsort(List<SObject> theList, ISObjectComparator comparator) {
        return qsort(theList,comparator,true);
    }
    
    global static List<SObject> qsort(List<SObject> theList, ISObjectComparator comparator,Boolean sortAsc ) {
        return qsort(theList,  0, (theList == null ? 0 : theList.size()-1),comparator,sortAsc);
    }

    private static List<Object> qsort(List<Object> theList,
                                Integer lo0, 
                                Integer hi0, 
                                ObjectComparator comparator,
                                Boolean sortAsc){
        Integer lo = lo0;
        Integer hi = hi0;
     
        if (lo >= hi) {
            return theList;
        } else if( lo == hi - 1 ) {
        
            if (( comparator.compare(theList[lo],theList[hi])>0 && sortAsc) || 
                  (comparator.compare(theList[lo],theList[hi])<0 && !sortAsc)    
                ) {
                 Object prs = theList[lo];
                 theList[lo]         = theList[hi];
                 theList[hi]         = prs;
            }
            return theList;
        }

        Object pivot = theList[(lo + hi) / 2];
        theList[(lo + hi) / 2] = theList[hi];
        theList[hi] = pivot;

        while( lo < hi ) {
            while ((comparator.compare(theList[lo], pivot)<=0 && lo < hi && sortAsc) || 
                   (comparator.compare(theList[lo], pivot)>=0 && lo < hi && !sortAsc)
                  ) { lo++; }
            while (( comparator.compare(pivot,theList[hi])<=0 && lo < hi && sortAsc) ||
                   ( comparator.compare(pivot,theList[hi])>=0 && lo < hi && !sortAsc)
                  ) { hi--; }
            
            if( lo < hi ){
                 Object prs = theList[lo];
                 theList[lo]   = theList[hi];
                 theList[hi]    = prs;
            }
        }

        theList[hi0] = theList[hi];
        theList[hi] = pivot;
        
        qsort(theList, lo0, lo-1,comparator,sortAsc);
        qsort(theList, hi+1, hi0,comparator,sortAsc);
        return theList;
    }    
        
    
    private static List<SObject> qsort(List<SObject> theList,
                                Integer lo0, 
                                Integer hi0, 
                                ISObjectComparator comparator,
                                Boolean sortAsc){
        Integer lo = lo0;
        Integer hi = hi0;
     
        if (lo >= hi) {
            return theList;
        } else if( lo == hi - 1 ) {
        
            if (( comparator.compare(theList[lo],theList[hi])>0 && sortAsc) || 
                  (comparator.compare(theList[lo],theList[hi])<0 && !sortAsc)    
                ) {
                 SObject prs = theList[lo];
                 theList[lo]         = theList[hi];
                 theList[hi]         = prs;
            }
            return theList;
        }

        SObject pivot = theList[(lo + hi) / 2];
        theList[(lo + hi) / 2] = theList[hi];
        theList[hi] = pivot;

        while( lo < hi ) {
            while ((comparator.compare(theList[lo], pivot)<=0 && lo < hi && sortAsc) || 
                   (comparator.compare(theList[lo], pivot)>=0 && lo < hi && !sortAsc)
                  ) { lo++; }
            while (( comparator.compare(pivot,theList[hi])<=0 && lo < hi && sortAsc) ||
                   ( comparator.compare(pivot,theList[hi])>=0 && lo < hi && !sortAsc)
                  ) { hi--; }
            
            if( lo < hi ){
                 SObject prs = theList[lo];
                 theList[lo]   = theList[hi];
                 theList[hi]    = prs;
            }
        }

        theList[hi0] = theList[hi];
        theList[hi] = pivot;
        
        qsort(theList, lo0, lo-1,comparator,sortAsc);
        qsort(theList, hi+1, hi0,comparator,sortAsc);
        return theList;
    }
    
    /* ArrayUtils methods */
    
    /* BooleanUtils methods */
    global static Boolean isFalse(Boolean bool)
    {
        if(bool==null)
            return false;
        else
            return !bool;
    }
    
    global static Boolean isNotFalse(Boolean bool)
    {
        if(bool==null)
            return true;
        else
            return bool;
    }
    
    global static Boolean isNotTrue(Boolean bool)
    {
        if(bool==null)
            return true;
        else
            return !bool;
    }
    
    global static Boolean isTrue(Boolean bool)
    {
        if(bool==null)
            return false;
        else
            return bool;
    }
    
    global static Boolean negate(Boolean bool)
    {
        if(bool==null)
            return null;
        else
            return !bool;
    }
    
    global static Boolean toBooleanDefaultIfNull(Boolean bool, Boolean defaultVal)
    {
        if(bool==null)
            return defaultVal;
        else
            return bool;
    }
    
    global static Boolean toBoolean(Integer value)
    {
        if(value==null)
            return false;
        else
        {
            if(value==0)
                return false;
            else
                return true;
        }
    }
    
    global static Boolean strToBoolean(String value)
    {
        if(value==null)
            return false;
        else
        {
            if(equalsIgnoreCase(value,'true'))
                return true;
            else
                return false;
        }
    }
    
    /************************************/
    //Converts an int to a boolean specifying 
    //the conversion values.
    //    Parameters:
    //    value - the Integer to convert, may be null
    //    trueValue - the value to match for true, may be null
    //    falseValue - the value to match for false, may be null 
    //Returns:
    //    true or false 
    //Throws:
    //    java.lang.IllegalArgumentException - if no match
    /************************************/
    global static Boolean toBoolean(Integer value,
                                    Integer trueValue,
                                    Integer falseValue)
    {
        if(value==trueValue)
            return true;
        else if(value==falseValue)
            return false;
        else
            throw new IllegalArgumentException();
    }
    
    
    global static Integer toInteger(Boolean bool)
    {
        if(bool==null)
            throw new IllegalArgumentException();
        else
        {
            if(bool)
                return 1;
            else
                return 0;
        }
    }
    
    
    global static String toStringYesNo(Boolean bool)
    {
        if(bool==null)
            return null;
        else
        {
            if(bool)
                return 'yes';
            else
                return 'no';
        }
    }
    
    global static String toStringYN(Boolean bool)
    {
        if(bool==null)
            return null;
        else
        {
            if(bool)
                return 'Y';
            else
                return 'N';
        }
    }
    
    
    global static String toString(Boolean bool,
                                  String trueString,
                                  String falseString)
    {
        if(bool==null)
            return null;        
        else
        {
            if(bool)
                return trueString;
            else
                return falseString;
        }
    }
    
    global static Boolean xor(Boolean[] boolArray)
    {
        if(boolArray==null || boolArray.size()==0)
            throw new IllegalArgumentException();
        else
        {
            Boolean firstItem=boolArray[0];
            for(Boolean bool:boolArray)
            {
                if(bool!=firstItem)
                    return false;
            }
            return true;
        }    
    }   
    /* BooleanUtils methods */
    
    /* EmailUtils methods */
    
    global static void sendEmailWithStandardAttachments(List<String> recipients,String emailSubject,String body,Boolean useHTML,List<Id> attachmentIDs) {
        List<Attachment> stdAttachments = [SELECT id, name, body FROM Attachment WHERE Id IN:attachmentIDs];
        sendEmailWithStandardAttachments(recipients, emailSubject, body, useHTML, stdAttachments);
    }
    
    global static void sendEmailWithStandardAttachments(List<String> recipients,String emailSubject,String body,Boolean useHTML,List<Attachment> stdAttachments) {
        List<Messaging.EmailFileAttachment> fileAttachments = new List<Messaging.EmailFileAttachment>();
        
        for(Attachment attachment : stdAttachments) {
            Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
            fileAttachment.setFileName(attachment.Name);
            fileAttachment.setBody(attachment.Body);
            fileAttachments.add(fileAttachment);
        }
        sendEmail(recipients, emailSubject, body, useHTML, fileAttachments);
    }
     
    global static void sendTextEmail(List<String> recipients,String emailSubject,String textBody) { 
        sendEmail(recipients, emailSubject, textBody, false, null);
    }
    
    global static void sendHTMLEmail(List<String> recipients,String emailSubject,String htmlBody) { 
        sendEmail(recipients, emailSubject, htmlBody, true, null);
    }
    
    global static void sendEmail(List<String> recipients,String emailSubject,String body,Boolean useHTML,List<Messaging.EmailFileAttachment> fileAttachments) { 
        if(recipients == null) return;
        if(recipients.size() == 0) return;
        // Create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();        
        //the email is not saved as an activity.
        mail.setSaveAsActivity(false);
        // Assign the addresses for the To lists to the mail object.
        mail.setToAddresses(recipients);          
        // Specify the subject line for your email address.
        mail.setSubject(emailSubject);
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        if (useHTML) {
            // Specify the html content of the email.
            mail.setHtmlBody(body);
        } else {
            // Specify the text content of the email.
            mail.setPlainTextBody(body);
        }
        // Specify FileAttachments
        if(fileAttachments != null && fileAttachments.size() > 0) {
            mail.setFileAttachments(fileAttachments);
        }
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }   
    /* EmailUtils methods */
    
    /* LanguageUtils methods */


    global static final String HTTP_LANGUAGE_CODE_PARAMETER_KEY = 'l';
    global static final String DEFAULT_LANGUAGE_CODE = 'en_us';

    global static Set<String> SUPPORTED_LANGUAGE_CODES = new Set<String>{
        'zh-cn'         //Chinese (Simplified)
        ,'zh-tw'        //Chinese (Traditional)
        ,'nl-nl'        //Dutch
        ,'en-us'        //English
        ,'fi'           //Finnish
        ,'fr'           //French
        ,'de'           //German
        ,'it'           //Italian
        ,'ja'           //Japanese
        ,'ko'           //Korean
        ,'pl'           //Polish
        ,'pt-br'        //Portuguese (Brazilian)
        ,'ru'           //Russian
        ,'es'           //Spanish
        ,'sv'           //Swedish
        ,'th'           //Thai
        ,'cs'           //Czech
        ,'da'           //Danish
        ,'hu'           //Hungarian
        ,'in'           //Indonesian
        ,'tr'           //Turkish
    };
    
    private static Map<String,String> DEFAULTS = new Map<String,String>{
        'en'=>'en-us'
        ,'zh'=>'zh-cn'
        ,'nl'=>'nl-nl'
        ,'pt'=>'pt-br'
    };
    

    global static String getLangCodeByHttpParam(){
        final Set<String> LANGUAGE_CODE_SET = getSuppLangCodeSet();
        String LANGUAGE_HTTP_PARAMETER = 
            lowerCase(
                replaceChars( 
                    param(HTTP_LANGUAGE_CODE_PARAMETER_KEY)
                    , '_' //underscore
                    , '-' //dash
                )
            );
        if(DEFAULTS.containsKey(LANGUAGE_HTTP_PARAMETER)){
            LANGUAGE_HTTP_PARAMETER = DEFAULTS.get(LANGUAGE_HTTP_PARAMETER);
        }
        if(isNotBlank(LANGUAGE_HTTP_PARAMETER)
            && SUPPORTED_LANGUAGE_CODES.contains(LANGUAGE_HTTP_PARAMETER)){
            return LANGUAGE_HTTP_PARAMETER;
        }        
        return null;
    }

    global static String getLangCodeByBrowser(){
        final String LANGUAGES_FROM_BROWSER_AS_STRING = ApexPages.currentPage().getHeaders().get('Accept-Language');
        final List<String> LANGUAGES_FROM_BROWSER_AS_LIST = splitAndFilterAcceptLanguageHeader(LANGUAGES_FROM_BROWSER_AS_STRING);
        if(LANGUAGES_FROM_BROWSER_AS_LIST != null && LANGUAGES_FROM_BROWSER_AS_LIST.size() > 0){
            for(String languageFromBrowser : LANGUAGES_FROM_BROWSER_AS_LIST){
                if(DEFAULTS.containsKey(languageFromBrowser)){
                    languageFromBrowser = DEFAULTS.get(languageFromBrowser);
                }
                if(SUPPORTED_LANGUAGE_CODES.contains(languageFromBrowser)){
                    return languageFromBrowser;
                }
            }               
        }
        return null;
    }
    
    global static String getLangCodeByUser(){
        return UserInfo.getLanguage();
    }
    
    global static String getLangCodeByHttpParamOrIfNullThenBrowser(){
        return defaultString(getLangCodeByHttpParam(),getLangCodeByBrowser());
    }

    global static String getLangCodeByHttpParamOrIfNullThenUser(){
        return defaultString(getLangCodeByHttpParam(),getLangCodeByUser());
    }
    
    global static String getLangCodeByBrowserOrIfNullThenHttpParam(){
        return defaultString(getLangCodeByBrowser(),getLangCodeByHttpParam());
    }
    
    global static String getLangCodeByBrowserOrIfNullThenUser(){
        return defaultString(getLangCodeByBrowser(),getLangCodeByUser());
    }
    
    private static List<String> splitAndFilterAcceptLanguageHeader(String header){
        List<String> returnList = new List<String>();
        String[] tokens = split(header,',');
        if(tokens != null){
            for(String token : tokens){
                if(token != null ){
                    if(token.contains(';')){
                        token = token.substring(0,token.indexOf(';',0));
                    }
                    returnList.add(token);
                    if(length(token) > 2){
                        returnList.add(substring(token,0,2));
                    }
                }
            }       
        }
        return returnList;
    }
    
    private static Set<String> getSuppLangCodeSet(){
        Set<String> langCodes = new Set<String>();
        for(String langCode : SUPPORTED_LANGUAGE_CODES){
            if(langCode != null){ 
                langCodes.add(lowerCase(langCode));
            }
        }
        return langCodes;
    }

    
    global static String getLanguageName(String displayLanguageCode, String languageCode){
        return translatedLanguageNames.get(filterLanguageCode(displayLanguageCode)).get(filterLanguageCode(languageCode));
    }
    
    global static List<SelectOption> getAllLanguageSelectOptions(){
        return getAllLanguageSelectOptions(DEFAULT_LANGUAGE_CODE);
    }
    
    global static List<SelectOption> getAllLanguageSelectOptions(String displayLanguageCode){
        return mapToSelectOptions(getAllLanguages(displayLanguageCode));
    }
    
    global static Map<String,String> getAllLanguages(){
        return getAllLanguages(DEFAULT_LANGUAGE_CODE);
    }
    
    global static Map<String,String> getAllLanguages(String displayLanguageCode){
        return translatedLanguageNames.get(filterLanguageCode(displayLanguageCode));
    }
    
    global static List<SelectOption> mapToSelectOptions(Map<String,String> theMap){
        final List<SelectOption> options = new List<SelectOption>();
        if(theMap != null){
            for(String key : theMap.keySet()){
                options.add(new SelectOption(key,theMap.get(key)));
            }
        }
        return sortOptions(options);
    }   
    
    private static List<SelectOption> sortOptions(List<SelectOption> theList){
        return SelectOptionComparator.sort(theList,true,true);  
    }
    
    private static String filterLanguageCode(String displayLanguageCode){
        displayLanguageCode = lowerCase(displayLanguageCode);
        if(DEFAULTS.containsKey(displayLanguageCode)){
            displayLanguageCode = replaceChars(DEFAULTS.get(displayLanguageCode),'-','_');
        }
        if(!translatedLanguageNames.containsKey(displayLanguageCode)){
            displayLanguageCode = DEFAULT_LANGUAGE_CODE; 
        }
        return displayLanguageCode;
    }

    private static final Map<String,Map<String,String>> translatedLanguageNames = new Map<String,Map<String,String>>{
        'cs'=> new Map<String,String>{
'cs'=>'Čeština'
,'da'=>'Dánština'
,'de'=>'Němčina'
,'en_us'=>'Angličtina (Spojené státy)'
,'es'=>'Španělština'
,'es_mx'=>'Mexická španělština'
,'fi'=>'Finština'
,'fr'=>'Francouzština'
,'hu'=>'Maďarština'
,'in'=>'Indonéština'
,'it'=>'Italština'
,'ja'=>'Japonština'
,'ko'=>'Korejština'
,'nl_nl'=>'Nizozemština'
,'pl'=>'Polština'
,'pt_br'=>'Portugalština (Brazílie)'
,'ro'=>'Rumunština'
,'ru'=>'Ruština'
,'sv'=>'Švédština'
,'th'=>'Thajská'
,'tr'=>'Turečtina'
,'zh_cn'=>'Čínština (zjednodušená)'
,'zh_tw'=>'Čínština (tradiční)'
}
,'da'=> new Map<String,String>{
'cs'=>'Tjekkisk'
,'da'=>'Dansk'
,'de'=>'Tysk'
,'en_us'=>'Engelsk (USA)'
,'es'=>'Spansk'
,'es_mx'=>'Mexicansk spansk'
,'fi'=>'Finsk'
,'fr'=>'Fransk'
,'hu'=>'Ungarsk'
,'in'=>'Indonesisk'
,'it'=>'Italiensk'
,'ja'=>'Japansk'
,'ko'=>'Koreansk'
,'nl_nl'=>'Hollandsk'
,'pl'=>'Polsk'
,'pt_br'=>'Portugisisk (Brasilien)'
,'ro'=>'Rumænsk'
,'ru'=>'Russisk'
,'sv'=>'Svensk'
,'th'=>'Thai'
,'tr'=>'Tyrkisk'
,'zh_cn'=>'Kinesisk (forenklet)'
,'zh_tw'=>'Kinesisk (traditionelt)'
}
,'de'=> new Map<String,String>{
'cs'=>'Tschechisch'
,'da'=>'Dänisch'
,'de'=>'Deutsch'
,'en_us'=>'Englisch (Vereinigte Staaten)'
,'es'=>'Spanisch'
,'es_mx'=>'Mexican Spanish'
,'fi'=>'Finnisch'
,'fr'=>'Französisch'
,'hu'=>'Ungarisch'
,'in'=>'Indonesisch'
,'it'=>'Italienisch'
,'ja'=>'Japanisch'
,'ko'=>'Koreanisch'
,'nl_nl'=>'Niederländisch'
,'pl'=>'Polnisch'
,'pt_br'=>'Portugiesisch (Brasilien)'
,'ro'=>'Rumänisch'
,'ru'=>'Russisch'
,'sv'=>'Schwedisch'
,'th'=>'Thai'
,'tr'=>'Türkisch'
,'zh_cn'=>'Chinesisch (Taiwan)'
,'zh_tw'=>'Chinesisch (traditionell)'
}
,'en_us'=> new Map<String,String>{
'cs'=>'Czech'
,'da'=>'Danish'
,'de'=>'German'
,'en_us'=>'English (United States)'
,'es'=>'Spanish'
,'es_mx'=>'Mexican Spanish'
,'fi'=>'Finnish'
,'fr'=>'French'
,'hu'=>'Hungarian'
,'in'=>'Indonesian'
,'it'=>'Italian'
,'ja'=>'Japanese'
,'ko'=>'Korean'
,'nl_nl'=>'Dutch'
,'pl'=>'Polish'
,'pt_br'=>'Portuguese (Brazilian)'
,'ro'=>'Romanian'
,'ru'=>'Russian'
,'sv'=>'Swedish'
,'th'=>'Thai'
,'tr'=>'Turkish'
,'zh_cn'=>'Chinese (Simplified)'
,'zh_tw'=>'Chinese (Traditional)'
}
,'es'=> new Map<String,String>{
'cs'=>'Checa'
,'da'=>'Danés'
,'de'=>'Alemán'
,'en_us'=>'Inglés (Estados Unidos)'
,'es'=>'Español'
,'es_mx'=>'El español de México'
,'fi'=>'Finlandés'
,'fr'=>'Francés'
,'hu'=>'Húngaro'
,'in'=>'Indonesia'
,'it'=>'Italiano'
,'ja'=>'Japonés'
,'ko'=>'Corea'
,'nl_nl'=>'Neerlandés'
,'pl'=>'Polaco'
,'pt_br'=>'Portugués (brasileño)'
,'ro'=>'Rumano'
,'ru'=>'Rusia'
,'sv'=>'Sueco'
,'th'=>'Tailandia'
,'tr'=>'Turquía'
,'zh_cn'=>'Chino (simplificado)'
,'zh_tw'=>'Chino (tradicional)'
}
,'es_mx'=> new Map<String,String>{
'cs'=>'Checa'
,'da'=>'Danés'
,'de'=>'Alemán'
,'en_us'=>'Inglés (Estados Unidos)'
,'es'=>'Español'
,'es_mx'=>'El español de México'
,'fi'=>'Finlandés'
,'fr'=>'Francés'
,'hu'=>'Húngaro'
,'in'=>'Indonesia'
,'it'=>'Italiano'
,'ja'=>'Japonés'
,'ko'=>'Corea'
,'nl_nl'=>'Neerlandés'
,'pl'=>'Polaco'
,'pt_br'=>'Portugués (brasileño)'
,'ro'=>'Rumano'
,'ru'=>'Rusia'
,'sv'=>'Sueco'
,'th'=>'Tailandia'
,'tr'=>'Turquía'
,'zh_cn'=>'Chino (simplificado)'
,'zh_tw'=>'Chino (tradicional)'
}
,'fi'=> new Map<String,String>{
'cs'=>'Tšekki'
,'da'=>'Tanska'
,'de'=>'Saksa'
,'en_us'=>'Englanti (Yhdysvallat)'
,'es'=>'Espanja'
,'es_mx'=>'Meksikon espanja'
,'fi'=>'Suomen'
,'fr'=>'Ranska'
,'hu'=>'Unkari'
,'in'=>'Indonesia'
,'it'=>'Italia'
,'ja'=>'Japani'
,'ko'=>'Korea'
,'nl_nl'=>'Hollanti'
,'pl'=>'Puola'
,'pt_br'=>'Portugali (Brasilia)'
,'ro'=>'Romania'
,'ru'=>'Venäjä'
,'sv'=>'Ruotsi'
,'th'=>'Thaimaalaisen'
,'tr'=>'Turkki'
,'zh_cn'=>'Kiina (yksinkertaistettu)'
,'zh_tw'=>'Kiina (perinteinen)'
}
,'fr'=> new Map<String,String>{
'cs'=>'Tchèque'
,'da'=>'Danois'
,'de'=>'Allemand'
,'en_us'=>'Anglais (Etats Unis)'
,'es'=>'Espagnol'
,'es_mx'=>'Espagnol mexicain'
,'fi'=>'Finnois'
,'fr'=>'Français'
,'hu'=>'Hongrois'
,'in'=>'Indonésien'
,'it'=>'Italien'
,'ja'=>'Japonais'
,'ko'=>'Coréen'
,'nl_nl'=>'Néerlandais'
,'pl'=>'Polonais'
,'pt_br'=>'Portugais (brésilien)'
,'ro'=>'Roumain'
,'ru'=>'Russe'
,'sv'=>'Suédois'
,'th'=>'Thai'
,'tr'=>'Turc'
,'zh_cn'=>'Chinois (simplifié)'
,'zh_tw'=>'Chinois (Traditionnel)'
}
,'hu'=> new Map<String,String>{
'cs'=>'Cseh'
,'da'=>'Dán'
,'de'=>'Német'
,'en_us'=>'Angol (Egyesült Államok)'
,'es'=>'Spanyol'
,'es_mx'=>'Mexikói spanyol'
,'fi'=>'Finn'
,'fr'=>'Francia'
,'hu'=>'Magyar'
,'in'=>'Indonéz'
,'it'=>'Olasz'
,'ja'=>'Japán'
,'ko'=>'Koreai'
,'nl_nl'=>'Holland'
,'pl'=>'Lengyel'
,'pt_br'=>'Portugál (brazíliai)'
,'ro'=>'Román'
,'ru'=>'Orosz'
,'sv'=>'Svéd'
,'th'=>'Thaiföldi'
,'tr'=>'Török'
,'zh_cn'=>'Kínai (egyszerűsített)'
,'zh_tw'=>'Kínai (hagyományos)'
}
,'in'=> new Map<String,String>{
'cs'=>'Ceko'
,'da'=>'Denmark'
,'de'=>'Jerman'
,'en_us'=>'Inggris (Amerika Serikat)'
,'es'=>'Spanyol'
,'es_mx'=>'Meksiko Spanyol'
,'fi'=>'Finlandia'
,'fr'=>'Prancis'
,'hu'=>'Hungaria'
,'in'=>'Indonesia'
,'it'=>'Italia'
,'ja'=>'Jepang'
,'ko'=>'Korea'
,'nl_nl'=>'Belanda'
,'pl'=>'Polish'
,'pt_br'=>'Portugis (Brasil)'
,'ro'=>'Romanian'
,'ru'=>'Russian'
,'sv'=>'Swedia'
,'th'=>'Thai'
,'tr'=>'Turkish'
,'zh_cn'=>'Cina (Sederhana)'
,'zh_tw'=>'Cina (Tradisional)'
}
,'it'=> new Map<String,String>{
'cs'=>'Ceco'
,'da'=>'Danese'
,'de'=>'Tedesco'
,'en_us'=>'Inglese (Stati Uniti)'
,'es'=>'Spagnolo'
,'es_mx'=>'Spagnolo messicano'
,'fi'=>'Finlandese'
,'fr'=>'Francese'
,'hu'=>'Ungherese'
,'in'=>'Indonesiano'
,'it'=>'Italiano'
,'ja'=>'Giapponese'
,'ko'=>'Coreano'
,'nl_nl'=>'Olandese'
,'pl'=>'Polacco'
,'pt_br'=>'Portoghese (brasiliano)'
,'ro'=>'Rumeno'
,'ru'=>'Russo'
,'sv'=>'Svedese'
,'th'=>'Thai'
,'tr'=>'Turco'
,'zh_cn'=>'Cinese (semplificato)'
,'zh_tw'=>'Cinese (tradizionale)'
}
,'ja'=> new Map<String,String>{
'cs'=>'チェコ語'
,'da'=>'デンマーク語'
,'de'=>'ドイツ語'
,'en_us'=>'英語（アメリカ合衆国）'
,'es'=>'スペイン語'
,'es_mx'=>'メキシコのスペイン語'
,'fi'=>'フィンランド語'
,'fr'=>'フランス語'
,'hu'=>'ハンガリー語'
,'in'=>'インドネシア語'
,'it'=>'イタリア語'
,'ja'=>'日本語'
,'ko'=>'韓国語'
,'nl_nl'=>'オランダ語'
,'pl'=>'ポーランド語'
,'pt_br'=>'ポルトガル語（ブラジル）'
,'ro'=>'ルーマニア語'
,'ru'=>'ロシア語'
,'sv'=>'スウェーデン語'
,'th'=>'タイ'
,'tr'=>'トルコ語'
,'zh_cn'=>'中国語（簡体字）'
,'zh_tw'=>'中国語（繁体字）'
}
,'ko'=> new Map<String,String>{
'cs'=>'체코어'
,'da'=>'덴마크어'
,'de'=>'독일어'
,'en_us'=>'영어 (미국)'
,'es'=>'스페인어'
,'es_mx'=>'멕시코 스페인'
,'fi'=>'핀란드어'
,'fr'=>'프랑스어'
,'hu'=>'헝가리어'
,'in'=>'인도네시 아어'
,'it'=>'이탈리아어'
,'ja'=>'일본어'
,'ko'=>'한국어'
,'nl_nl'=>'네덜란드'
,'pl'=>'폴란드어'
,'pt_br'=>'포르투갈어 (브라질)'
,'ro'=>'루마니아어'
,'ru'=>'러시아어'
,'sv'=>'스웨덴어'
,'th'=>'타이어'
,'tr'=>'터키어'
,'zh_cn'=>'중국어 (간체)'
,'zh_tw'=>'중국어 (번체)'
}
,'nl_nl'=> new Map<String,String>{
'cs'=>'Tsjechisch'
,'da'=>'Deens'
,'de'=>'Duits'
,'en_us'=>'Engels (Verenigde Staten)'
,'es'=>'Spaans'
,'es_mx'=>'Mexicaans Spaans'
,'fi'=>'Fins'
,'fr'=>'Frans'
,'hu'=>'Hongaars'
,'in'=>'Indonesisch'
,'it'=>'Italiaans'
,'ja'=>'Japans'
,'ko'=>'Koreaans'
,'nl_nl'=>'Nederlandse'
,'pl'=>'Pools'
,'pt_br'=>'Portugees (Braziliaans)'
,'ro'=>'Roemeens'
,'ru'=>'Russisch'
,'sv'=>'Zweeds'
,'th'=>'Thais'
,'tr'=>'Turks'
,'zh_cn'=>'Chinese (Simplified)'
,'zh_tw'=>'Chinees (traditioneel)'
}
,'pl'=> new Map<String,String>{
'cs'=>'Czeski'
,'da'=>'Duński'
,'de'=>'Niemiecki'
,'en_us'=>'Angielski (Stany Zjednoczone)'
,'es'=>'Hiszpański'
,'es_mx'=>'Mexican hiszpański'
,'fi'=>'Fiński'
,'fr'=>'Francuski'
,'hu'=>'Węgierski'
,'in'=>'Indonezyjski'
,'it'=>'Włoski'
,'ja'=>'Japoński'
,'ko'=>'Koreański'
,'nl_nl'=>'Niderlandzki'
,'pl'=>'Polska'
,'pt_br'=>'Portugalski (Brazylia)'
,'ro'=>'Rumuński'
,'ru'=>'Rosyjski'
,'sv'=>'Szwedzki'
,'th'=>'Taj'
,'tr'=>'Turecki'
,'zh_cn'=>'Chiński (uproszczony)'
,'zh_tw'=>'Chiński (tradycyjny)'
}
,'pt_br'=> new Map<String,String>{
'cs'=>'Tcheco'
,'da'=>'Dinamarquês'
,'de'=>'Alemão'
,'en_us'=>'Inglês (Estados Unidos)'
,'es'=>'Espanhol'
,'es_mx'=>'Espanhol mexicano'
,'fi'=>'Finlandês'
,'fr'=>'Francês'
,'hu'=>'Húngaro'
,'in'=>'Indonésio'
,'it'=>'Italiano'
,'ja'=>'Japonês'
,'ko'=>'Coreano'
,'nl_nl'=>'Holandês'
,'pl'=>'Polonês'
,'pt_br'=>'Português (Brasil)'
,'ro'=>'Romeno'
,'ru'=>'Russo'
,'sv'=>'Sueco'
,'th'=>'Tailandês'
,'tr'=>'Turco'
,'zh_cn'=>'Chinês (simplificado)'
,'zh_tw'=>'Chinês (Tradicional)'
}
,'ro'=> new Map<String,String>{
'cs'=>'Cehă'
,'da'=>'Daneză'
,'de'=>'Germană'
,'en_us'=>'În limba engleză (Statele Unite)'
,'es'=>'Spaniolă'
,'es_mx'=>'Mexicane Spanish'
,'fi'=>'Finlandeză'
,'fr'=>'Franţuzesc'
,'hu'=>'Maghiară'
,'in'=>'Indoneziană'
,'it'=>'Italiană'
,'ja'=>'Japoneză'
,'ko'=>'Coreeană'
,'nl_nl'=>'Olandeză'
,'pl'=>'Poloneză'
,'pt_br'=>'Portuguese (Brazilian)'
,'ro'=>'Român'
,'ru'=>'Rus'
,'sv'=>'Suedez'
,'th'=>'Thai'
,'tr'=>'Turcă'
,'zh_cn'=>'Chineză (simplificată)'
,'zh_tw'=>'Chineză (Tradiţională)'
}
,'ru'=> new Map<String,String>{
'cs'=>'Чешский'
,'da'=>'Датский'
,'de'=>'Немецкий'
,'en_us'=>'Английский (США)'
,'es'=>'Испанский'
,'es_mx'=>'Мексиканские Испанский'
,'fi'=>'Финский'
,'fr'=>'Французский'
,'hu'=>'Венгерский'
,'in'=>'Индонезийский'
,'it'=>'Итальянский'
,'ja'=>'Японский'
,'ko'=>'Корейский'
,'nl_nl'=>'Голландский'
,'pl'=>'Польский'
,'pt_br'=>'Португальский (бразильский)'
,'ro'=>'Румынский'
,'ru'=>'Русский'
,'sv'=>'Шведский'
,'th'=>'Тайский'
,'tr'=>'Турецкий'
,'zh_cn'=>'Китайский (упрощенный)'
,'zh_tw'=>'Китайский (традиционный)'
}
,'sv'=> new Map<String,String>{
'cs'=>'Tjeckiska'
,'da'=>'Danska'
,'de'=>'Tyska'
,'en_us'=>'Engelska (USA)'
,'es'=>'Spanska'
,'es_mx'=>'Mexikansk spanska'
,'fi'=>'Finska'
,'fr'=>'Franska'
,'hu'=>'Ungerska'
,'in'=>'Indonesiska'
,'it'=>'Italienska'
,'ja'=>'Japanska'
,'ko'=>'Koreanska'
,'nl_nl'=>'Nederländska'
,'pl'=>'Polska'
,'pt_br'=>'Portugisiska (Brasilien)'
,'ro'=>'Rumänska'
,'ru'=>'Ryska'
,'sv'=>'Svenska'
,'th'=>'Thai'
,'tr'=>'Turkiska'
,'zh_cn'=>'Kinesiska (förenklad)'
,'zh_tw'=>'Kinesiska (traditionell)'
}
,'th'=> new Map<String,String>{
'cs'=>'สาธารณรัฐ เช็ ก'
,'da'=>'เดนมาร์ก'
,'de'=>'เยอรมัน'
,'en_us'=>'ภาษา อังกฤษ States (United)'
,'es'=>'สเปน'
,'es_mx'=>'สเปน เม็ก ซิ กัน'
,'fi'=>'ฟินแลนด์'
,'fr'=>'ฝรั่งเศส'
,'hu'=>'ฮังการี'
,'in'=>'อินโดนีเซีย'
,'it'=>'อิตาเลียน'
,'ja'=>'ญี่ปุ่น'
,'ko'=>'เกาหลี'
,'nl_nl'=>'ดัตช์'
,'pl'=>'เงา'
,'pt_br'=>'โปรตุเกส (บราซิล)'
,'ro'=>'โรมาเนีย'
,'ru'=>'ภาษา รัสเซีย'
,'sv'=>'สวีเดน'
,'th'=>'ไทย'
,'tr'=>'ภาษา ตุรกี'
,'zh_cn'=>'จีน (ประยุกต์)'
,'zh_tw'=>'ภาษา จีน (ดั้งเดิม)'
}
,'tr'=> new Map<String,String>{
'cs'=>'Çekçe'
,'da'=>'Danca'
,'de'=>'Almanca'
,'en_us'=>'İngilizce (ABD)'
,'es'=>'İspanyolca'
,'es_mx'=>'Mexican İspanyolca'
,'fi'=>'Fince'
,'fr'=>'Fransızca'
,'hu'=>'Macarca'
,'in'=>'Endonezya Dili'
,'it'=>'İtalyanca'
,'ja'=>'Japonca'
,'ko'=>'Korece'
,'nl_nl'=>'Hollanda Dili'
,'pl'=>'Lehçe'
,'pt_br'=>'Portekizce (Brezilya)'
,'ro'=>'Romence'
,'ru'=>'Rusça'
,'sv'=>'İsveççe'
,'th'=>'Tay'
,'tr'=>'Türkçe'
,'zh_cn'=>'Çince (Basitleştirilmiş)'
,'zh_tw'=>'Çince (Geleneksel)'
}
,'zh_cn'=> new Map<String,String>{
'cs'=>'捷克文'
,'da'=>'丹麦文'
,'de'=>'德语'
,'en_us'=>'英语（美国）'
,'es'=>'西班牙语'
,'es_mx'=>'墨西哥西班牙语'
,'fi'=>'芬兰文'
,'fr'=>'法语'
,'hu'=>'匈牙利文'
,'in'=>'印度尼西亚文'
,'it'=>'意大利语'
,'ja'=>'日语'
,'ko'=>'韩文'
,'nl_nl'=>'荷兰文'
,'pl'=>'波兰文'
,'pt_br'=>'葡萄牙语（巴西）'
,'ro'=>'罗马尼亚文'
,'ru'=>'俄文'
,'sv'=>'瑞典文'
,'th'=>'泰国'
,'tr'=>'土耳其文'
,'zh_cn'=>'中文（简体）'
,'zh_tw'=>'中文（繁体）'
}
,'zh_tw'=> new Map<String,String>{
'cs'=>'捷克文'
,'da'=>'丹麥文'
,'de'=>'德語'
,'en_us'=>'英語（美國）'
,'es'=>'西班牙語'
,'es_mx'=>'墨西哥西班牙語'
,'fi'=>'芬蘭文'
,'fr'=>'法語'
,'hu'=>'匈牙利文'
,'in'=>'印度尼西亞文'
,'it'=>'意大利語'
,'ja'=>'日語'
,'ko'=>'韓文'
,'nl_nl'=>'荷蘭文'
,'pl'=>'波蘭文'
,'pt_br'=>'葡萄牙語（巴西）'
,'ro'=>'羅馬尼亞文'
,'ru'=>'俄文'
,'sv'=>'瑞典文'
,'th'=>'泰國'
,'tr'=>'土耳其文'
,'zh_cn'=>'中文（簡體）'
,'zh_tw'=>'中文（繁體）'
}

    };    

    /* LanguageUtils methods */
    
    /* PageUtils methods */
    

    global static PageReference redirect(String url){
        PageReference pageRef = new PageReference(url);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    global static String param(String param){
        return get(param);
    }
    
    global static String param(String param, String value){
        return put(param,value);
    }
    
    global static String get(String param){
        return ApexPages.currentPage().getParameters().get(param);
    }
    
    // Returns the parameters which contains a part of the key
    global static Map<String,String> getParameters(String param){
        Map<String,String> parameters = new Map<String,String>();
        for(String key:ApexPages.currentPage().getParameters().keySet()){
            if(key.contains(param)){
                parameters.put(key,ApexPages.currentPage().getParameters().get(key));
            }
        }
        return parameters;
    }
    
    global static String put(String param, String value){
        ApexPages.currentPage().getParameters().put(param,value);
        return value;
    }
    
    global static void addConfirm(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,message));
    }
    
    global static void addInfo(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,message));
    }
    
    global static void addWarning(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,message));
    }
    
    global static void addError(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,message));
    }
    
    global static void addFatal(String message){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL,message));
    }
    
    global static ApexPages.Message[] getMessagesAtLevel(ApexPages.Severity level,
        Boolean includeParents){
        final ApexPages.Message[] all = ApexPages.getMessages();
        final List<ApexPages.Message> filtered = new List<ApexPages.Message>();
        if(all != null && all.size() > 0){
            for(ApexPages.Message message : all){
                if(message.getSeverity() == level 
                    || (includeParents && isMessageAtLevelOrHigher(message,level))){
                    filtered.add(message);
                }
            }
        }
        return filtered;
    }
    
    global static ApexPages.Message[] getErrorMessages(){
        return getMessagesAtLevel(ApexPages.Severity.ERROR, true);
    }

    global static ApexPages.Message[] getErrorMessagesOnly(){
        return getMessagesAtLevel(ApexPages.Severity.ERROR, false);
    }
    
    global static String messagesToString(){
        return messagesToString(ApexPages.getMessages());
    }
    
    global static String messagesToString(ApexPages.Message[] messages){
        if(messages == null){
            return 'null';
        }
        if( messages.size() <= 0){
            return '{empty}';
        }
        String returnString = '';
        for(Integer i = 0; i < messages.size(); i++){
            if(i != 0){ returnString += '; '; }
            returnString += 'ApexPages.Message[';
            returnString += i;
            returnString += ']: (summary=';
            returnString += messages[i].getSummary(); 
            returnString += ',componentLabel=';
            returnString += messages[i].getComponentLabel(); 
            returnString += ',severity=';
            returnString += messages[i].getSeverity(); 
            returnString += ',detail=';
            returnString += messages[i].getDetail(); 
            returnString += ')';
        }
        return '{' + returnString + '}';
    }
    
    global static Boolean isMessageAtLevelOrHigher(ApexPages.Message message, ApexPages.Severity level){
        if(level == null || message == null){
            return false;
        }
        ApexPages.Severity msgLevel = message.getSeverity();
        while(true){
            if(level == msgLevel){
                return true;    
            }
            if(msgLevel == ApexPages.Severity.CONFIRM){msgLevel = ApexPages.Severity.WARNING;}
            else if(msgLevel == ApexPages.Severity.INFO){msgLevel = ApexPages.Severity.WARNING;}
            else if(msgLevel == ApexPages.Severity.WARNING){msgLevel = ApexPages.Severity.ERROR;}
            else if(msgLevel == ApexPages.Severity.ERROR){msgLevel = ApexPages.Severity.FATAL;}
            else { break; }
        }
        return false;
    }

    global static String encodeVariable(String variable){
        if(variable!=null){
            return EncodingUtil.urlEncode(variable,'UTF-8');
        } else {
            return '';
        }                        
    }    
    
    /* PageUtils methods */ 
    
    /* MapUtils methods */
    
    global static String joinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator){
        if(theMap == null){
            return null;
        }
        List<String> keyValuePairs = new List<String>();
        for(String key : theMap.keySet()){
            keyValuePairs.add(key + keyValueSeparator + theMap.get(key));
        }
        return joinArray(keyValuePairs, recordSeparator);
    }
    
    global static String toString(Map<String,String> theMap){
        return '<Map#([' + joinMap(theMap,'=',';') + '])>';
    }
    
    global static Boolean equals(Map<String,String> map1, Map<String,String> map2){
        if(map1 == null && map2 == null){
            return true;
        }
        if((map1 != null && map2 == null) 
            || (map1 == null && map2 != null)
            || (map1.size() != map2.size())){
            return false;
        }
        for(String key1 : map1.keySet()){
            if(!map2.containsKey(key1)){
                return false;
            }
            if(map1.get(key1) != map2.get(key1)){
                return false;
            }
        }
        return true;
    }   
    /* MapUtils methods */
    /* RandomStringUtils methods */

    global static String random(Integer count) {
        return random(count, false, false);
    }

    global static String randomAscii(Integer count) {
        return random(count, 32, 127, false, false);
    }
    
    global static String randomAlphabetic(Integer count) {
        return random(count, true, false);
    }
    
    global static String randomAlphanumeric(Integer count) {
        return random(count, true, true);
    }
    
    global static String randomNumeric(Integer count) {
        return random(count, false, true);
    }

    global static String random(Integer count, String chars) {
        return random(count, 0, (chars == null ? 0 : chars.length()), false, false, chars);
    }

    global static String random(Integer count, boolean letters, boolean numbers) {
        return random(count, 0, 0, letters, numbers);
    }
    
    global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers) {
        return random(count, startIndex, endIndex, letters, numbers, null);
    }

    global static String random(Integer count, Integer startIndex, Integer endIndex, boolean letters, boolean numbers, String chars) {
        if (count <= 0) {
            return '';
        }
        if(chars == null && (letters || numbers)){
            chars = '';
            startIndex = 0;
            if(letters){
                endIndex += 52;
                for(Integer i = toAscii('a'), max = toAscii('z'); i <= max; i++){
                    chars += toChar(i);
                }    
                for(Integer i = toAscii('A'), max = toAscii('Z'); i <= max; i++){
                    chars += toChar(i);
                }    
            }
            if(numbers){
                endIndex += 10;
                for(Integer i = toAscii('0'), max = toAscii('9'); i <= max; i++){
                    chars += toChar(i);
                }    
            }
        }
        IntegerRange allowableRange = null;
        if(chars == null){
            allowableRange = new IntegerRange(32,127);
        } else {
            allowableRange = new IntegerRange(0,chars.length());
        }
        if(!allowableRange.contains(new IntegerRange(startIndex,endIndex))){
            startIndex = allowableRange.min();
            endIndex = allowableRange.max();
        }    

        String buffer = '';
        String ch;
        Integer gap = endIndex - startIndex;
        Integer next = 0;
        
        while (count-- > 0) {
            next = Math.round(Math.floor(Math.random()*gap)) + startIndex;
            if (chars == null) {
                ch = toChar(next);
            } else {
                ch = charAt(chars,next);
            }
            buffer += ch;
        }
        return buffer;
    }

    private static String kHexChars = '0123456789abcdefABCDEF';
    
    /**
     * Implementation ported from Java Library at http://jug.safehaus.org
     */
    global static String randomUUID(){
        String returnValue = '';
        Integer nextByte = 0;
        for(Integer i = 0; i < 16; i++){
            if(i==4 || i==6 || i==8 || i==10){
                returnValue += '-';
            }
            //generate a "byte"; i.e., number in range [-2^7,2^7-1]
            nextByte = (Math.round(Math.random() * 255)-128) & 255;

            if(i==6){
                nextByte = nextByte & 15;
                nextByte = nextByte | (4 << 4);
            }
            if(i==8){
                nextByte = nextByte & 63;
                nextByte = nextByte | 128;
            }
            
            returnValue += charAt(kHexChars,nextByte >> 4);
            returnValue += charAt(kHexChars,nextByte & 15);
        }
        return returnValue;
    }   
    /* RandomStringUtils methods */    
    
    /* SObjectUtils methods */



    //NOTE: would've preferred to use a Set instead of a List but unfortunately, Sets of Enums
    //  are not allowed as of Spring '10.  Seems silly they aren't.  Especially since it
    //  necessitates a custom "contains" method.  Even though using a List is a workaround, it
    //  still looks better than multiple ORs in the bottom of the copyFields method.
    private static final List<Schema.DisplayType> STRING_TYPES      = new List<Schema.DisplayType>{
        Schema.DisplayType.base64
        ,Schema.DisplayType.Email
        ,Schema.DisplayType.MultiPicklist
        ,Schema.DisplayType.Phone
        ,Schema.DisplayType.Picklist
        ,Schema.DisplayType.String
        ,Schema.DisplayType.TextArea
        ,Schema.DisplayType.URL
    };
    private static final List<Schema.DisplayType> INTEGER_TYPES     = new List<Schema.DisplayType>{
        Schema.DisplayType.Integer
    };
    private static final List<Schema.DisplayType> ID_TYPES          = new List<Schema.DisplayType>{
        Schema.DisplayType.ID
        ,Schema.DisplayType.Reference
    };
    private static final List<Schema.DisplayType> DOUBLE_TYPES      = new List<Schema.DisplayType>{
        Schema.DisplayType.Currency
        ,Schema.DisplayType.Double
        ,Schema.DisplayType.Percent
    };
    private static final List<Schema.DisplayType> DATETIME_TYPES    = new List<Schema.DisplayType>{
        Schema.DisplayType.DateTime
    };
    private static final List<Schema.DisplayType> DATE_TYPES        = new List<Schema.DisplayType>{
        Schema.DisplayType.Date
    };
    private static final List<Schema.DisplayType> BOOLEAN_TYPES     = new List<Schema.DisplayType>{
        Schema.DisplayType.Boolean
        ,Schema.DisplayType.Combobox
    };

    global static Boolean isAnyFieldBlank(SObject obj, String[] fields){
        return isNotEmpty(getBlankFields(obj,fields));
    }
    
    global static String[] getBlankFields(SObject obj, String[] fields){
        if(obj == null || isEmpty(fields)){
            return new String[]{};
        }
        List<String> blankFields = new List<String>();
        Object value = null;
        for(String field : fields){
            value = obj.get(field);
            if(value == null || (value instanceof String && isBlank((String)value))){
                blankFields.add(field);
            }
        }
        return blankFields;
    }
    
    /*
    private static final Map<String,Schema.DescribeSObjectResult> cachedDescribes = new Map<String,Schema.DescribeSObjectResult>();
    global static Schema.DescribeSObjectResult getCachedDescribe(SObject obj){
        if(obj == null){
            return null;
        }
        final String objectApiName = ''+ obj.getsObjectType();
        if(!cachedDescribes.containsKey(objectApiName)){
            cachedDescribes.put(objectApiName, obj.getsObjectType().getDescribe());
        }
        return cachedDescribes.get(objectApiName);
    }
    */
    
    global static String toString(SObject obj){
        if(Limits.getFieldsDescribes() >= Limits.getLimitFieldsDescribes()){
            return null;
        }
        if(obj == null){
            return 'null';
        }
        Schema.DescribeSObjectResult objDesc = obj.getSObjectType().getDescribe();
        List<String> fieldValues = new List<String>();
        Map<String, Schema.SObjectField> m = objDesc.fields.getMap();        
        for (Schema.SObjectField f : m.values()) { 
            Schema.DescribeFieldResult d = f.getDescribe();    
            fieldValues.add(d.getName() + '=' + obj.get(d.getName()));
        }
        return '<#' + objDesc.getName() + '(' + joinArray(fieldValues,',') + ')>';
    }
    
    /*
    //Commenting this out because it can't be reliably tested.  In order to get 100%
    //  code coverage on this method, an org MUST have at least one queue (the test
    //  case actually needs a Lead queue).  But since that can't be controlled by
    //  test code, I'm just commenting this out but it in the source in case anyone
    //  would like to re-use it in the future.  If you do want to re-use it, you'll
    //  need to do one of the following:
    //    (1) customize test method SObjectUtilsTest.testSendNotificationEmail()
    //    (2) create a Lead queue
    
    global static void sendNotificationEmail(SObject obj){
        if(obj == null || obj.id == null){
            throw new IllegalArgumentException();
        }
        
        final Schema.DescribeSObjectResult objDesc = obj.getSObjectType().getDescribe();
        SObject retrieved = null;
        try{
            retrieved = Database.query(
               'select id,name,ownerid from '+ objDesc.getName() 
               + ' where id = \'' + obj.id + '\' and owner.type = \'Queue\'');
        }catch(QueryException e){}
        if(retrieved == null){
            throw new IllegalArgumentException();
        }
        final Set<String> emailSet = new Set<String>();
        final ID ownerId = (ID) retrieved.get('ownerid');
        final List<GroupMember> members = [select UserOrGroupId, Group.Email from GroupMember where groupid = :ownerId];
        final Set<ID> userIds = new Set<ID>();
        if(members != null && members.size() > 0){
            for(GroupMember member : members){
                userIds.add(member.UserOrGroupId);
                if(StringUtils.isNotEmpty(member.Group.Email)){
                    emailSet.add(member.Group.Email);
                }
            }
        }
        final List<User> users = [select id,email from user where id in :userIds];
        if(users != null && users.size() > 0){
            for(User usr : users){
                if(StringUtils.isNotEmpty(usr.email)){
                    emailSet.add(usr.email);
                }
            }
        }
        final List<String> emailList = new List<String>();
        for(String email : emailSet){
            emailList.add(email);
        }
        EmailUtils.sendTextEmail(   emailList,
                                    objDesc.getName() + ' transferred to you.',
                                    objDesc.getName() + ' ' + retrieved.get('name') + ' has been assigned to you. Please click on the link below to view the record.\n\nhttps://login.salesforce.com/?startURL=%2F' + retrieved.get('id')
        );
    }
    */

    global static SObject copyFields(SObject source, SObject destination){
        if(source == null || destination == null){
            return destination;
        }
        final Map<String,Schema.SObjectField> sourceFields = source.getSObjectType().getDescribe().fields.getMap();
        final Map<String,Schema.SObjectField> destinationFields = destination.getSObjectType().getDescribe().fields.getMap();
        final List<Schema.DescribeFieldResult> commonFieldsToCopy = new List<Schema.DescribeFieldResult>();
        
        Schema.DescribeFieldResult sourceField = null;
        Schema.DescribeFieldResult destinationField = null;
        for(String fieldName : sourceFields.keySet()){ 
            sourceField = sourceFields.get(fieldName).getDescribe();
            if(destinationFields.get(fieldName) == null){
                //destination doesn't have corresponding field so skip
                continue;
            }
            destinationField = destinationFields.get(fieldName).getDescribe();
            if( !sourceField.isAccessible()
                || !destinationField.isAccessible()
                || destinationField.isAutoNumber()
                || destinationField.isCalculated()
                || (isBlank((String)destination.get('id')) && !destinationField.isCreateable()) 
                || (isNotBlank((String)destination.get('id')) && !destinationField.isUpdateable())
                || sourceField.getType() != destinationField.getType()){
                //source or destination field either can't or shouldn't be read or written to    
                continue;
            }
            if(contains(STRING_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(String)source.get(sourceField.getName()));
            } else if(contains(INTEGER_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Integer)source.get(sourceField.getName()));
            } else if(contains(ID_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(ID)source.get(sourceField.getName()));
            } else if(contains(DOUBLE_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Double)source.get(sourceField.getName()));
            } else if(contains(DATETIME_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(DateTime)source.get(sourceField.getName()));
            } else if(contains(DATE_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Date)source.get(sourceField.getName()));
            } else if(contains(BOOLEAN_TYPES,sourceField.getType())){
                destination.put(sourceField.getName(),(Boolean)source.get(sourceField.getName()));
            }
        }
        return destination;
    }   
    
    private static Boolean contains(List<Schema.DisplayType> aListActingAsSet, Schema.DisplayType typeToCheck){
        if(aListActingAsSet != null && aListActingAsSet.size() > 0){
            for(Schema.DisplayType aType : aListActingAsSet){
                if(aType == typeToCheck){
                    return true;
                }
            }
        }
        return false;
    }
    
    global static Object putQuietly(SObject sobj, String fieldName, Object value){
        Object old = null;
        if(sobj != null && fieldName != null){
            try{
            	old = getQuietly(sobj,fieldName);
            	
            	//NOTE:  the following line doesn't handle nulls for some strange reason
            	//  in Spring '10.  In order to make it work, the if is needed to explicitly 
            	//  pass null.
                //sobj.put(fieldName,value);
				if(value==null){
				    sobj.put(fieldName,null);
				}else{
				    sobj.put(fieldName,value);
				}
            }catch(System.SObjectException e){}
        }
        return old;
    }
    
    global static Object getQuietly(SObject sobj, String fieldName){
    	Object returnValue = null;
        if(sobj != null && fieldName != null){
            try{
                returnValue = sobj.get(fieldName);
            }catch(SObjectException e){}
        }
        return returnValue;
    }
    

    /* SObjectUtils methods */
    
    /* TestUtils methods*/

    global static void assertConfirmMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.CONFIRM,true); }
    global static void assertInfoMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.INFO,true); }
    global static void assertWarningMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.WARNING,true); }
    global static void assertErrorMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.ERROR,true); }
    global static void assertFatalMessagesExist(){ assertMessagesAtLevelExist(ApexPages.Severity.FATAL,true); }

    global static void assertNoConfirmMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.CONFIRM,true); }
    global static void assertNoInfoMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.INFO,true); }
    global static void assertNoWarningMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.WARNING,true); }
    global static void assertNoErrorMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.ERROR,true); }
    global static void assertNoFatalMessagesExist(){ assertNoMessagesAtLevelExist(ApexPages.Severity.FATAL,true); }

    global static void assertMessagesAtLevelExist(ApexPages.Severity level, Boolean includeHigher){
        final ApexPages.Message[] messages = getMessagesAtLevel(level,includeHigher);
        System.assert(messages != null && messages.size() > 0,'No errors exist');
    }
    
    global static void assertNoMessagesAtLevelExist(ApexPages.Severity level, Boolean includeHigher){
        final ApexPages.Message[] messages = getMessagesAtLevel(level,includeHigher);
        System.assert(messages == null || messages.size() <= 0,messagesToString(messages));
    } 
    
    
    global static List<SObject> getObject(SObject prototype, Integer count){
        return getObject(prototype,count,null,false);
    }
    
    global static List<SObject> getObject(SObject prototype, Integer count, Map<String,String> mString){
        return getObject(prototype,count,mString,false);
    }
    
    global static List<SObject> getObject(SObject prototype, Integer count, Map<String,String> mString, Boolean doInsert){
        final Integer MAX_COUNT = 100;
        if(prototype == null){
            return null;
        }
        //the following will for sure work; however, it requires a describe
        //String objectName = prototype.getSObjectType().getDescribe().getName();
        
        //the following will work using observed string representations of SObjects
        String objectName = split(''+prototype,':')[0];
        
        List<SObject> objects = Database.query(
            'select Id from ' 
            + objectName 
            + ' where Id = \'0015000000Mrr40\' LIMIT 0'); // use dummy Id to ensure no return
        if(count <= 0){
            return objects;
        }
        Schema.sObjectType prototypeToken = prototype.getSObjectType();
        for(Integer i = 0; i < count && i < MAX_COUNT; i++){
            objects.add((SObject)prototypeToken.newSObject());
        }

        if(mString != null && !mString.isEmpty()){
            for(SObject anObject : objects){
                for(String key : mString.keySet()){
                    anObject.put(key,mString.get(key));
                }            
            }
        }
        if(doInsert){
            insert objects;
        }    
        return objects;
    } 
    
	    
    /* TestUtils methods */
    
    /* UrlUtils methods */

    
    global static String getBase(String url){
        String[] split = split(url, '?');
        if(split == null || split.size() == 0){
            return null;
        }
        return split[0];
    }

    global static Map<String,String> getParams(String url){
        //url -> http://google.com?api=x&xyz=123
        Map<String,String> returnMap = new Map<String,String>();
        String[] split = split(url, '?');
        //split -> ['http://google.com','api=x&xyz=123']
        if(split == null || split.size() != 2 || split[1] == null){
            return returnMap;
        }
        split = split(split[1],'&');
        //split -> ['api=x','xyz=123']
        if(split != null && split.size() > 0){
            String[] split2 = null;
            for(String keyValuePair : split){
                //keyValuePair -> 'api=x'
                split2 = split(keyValuePair,'=');
                returnMap.put(
                    (split2 == null || split2.size() < 1 ? '' : split2[0]),
                    EncodingUtil.urlDecode(split2 == null || split2.size() < 2 ? '' : split2[1], 'UTF-8'));
            }
        }
        return returnMap;
    }


    /* UrlUtils methods */
    
    /* UserUtils methods */

    global static Boolean isCurrentUserSysAdmin(){
    	final List<User> users = [
    	   select id, name 
    	   from User 
    	   where id = :UserInfo.getUserId() 
    	   and profile.name = 'System Administrator']; 
    	return (users == null ? false : users.size() > 0);
    }

    global static Boolean isCurrentUserPortalUser(){
        return getCurrentUserPortalAccountID() != null;
    }
    
    global static ID getCurrentUserPortalAccountID(){
        User usr = 
            [select id, ContactId, Contact.AccountId, userrole.name 
            from user 
            where id = :UserInfo.getUserId()];
        return usr.Contact.AccountId;
    }

    /* UserUtils methods */
}