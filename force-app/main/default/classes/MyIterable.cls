/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 01-11-2025
 * @last modified by  : Deepak
**/
public class MyIterable implements Iterable<String> {
private List<String> strings;

    public MyIterable(List<String> strings){
        this.strings = strings;
    }

    public Iterator<String> iterator() {
       return strings.iterator();
    }
 }