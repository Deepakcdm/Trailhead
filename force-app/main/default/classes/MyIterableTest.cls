/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 01-11-2025
 * @last modified by  : Deepak
**/
@istest
private class MyIterableTest {

    /**
    * @description 
    * @author Deepak | 01-11-2025 
    **/
    @istest static void testIterableForLoop(){
        List<String> strings = new List<String>{'Hello', 'World'};
        MyIterable myIterable = new MyIterable(strings);
        for(String str : myIterable ){
            System.debug(str);
        }
    }
}