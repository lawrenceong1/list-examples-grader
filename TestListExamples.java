import static org.junit.Assert.*;
import org.junit.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

class StringCheck implements StringChecker {
  public boolean checkString(String s) {
    if (s instanceof String) {
      return true;
    }
    else {
      return false;
    }
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

    @Test
    public void testFilter3() {
        StringCheck sc = new StringCheck();
        List<String> testList = new ArrayList<>();
        testList.add("a");
        testList.add("b");
        testList.add("c");
        testList.add("d");
        List<String> expected = Arrays.asList("a", "b", "c", "d");
        assertEquals(expected, ListExamples.filter(testList, sc));
    }

    @Test
    public void testFilter() {
      List<String> list = Arrays.asList("moon", "sun", "earth", "mars");
      StringChecker sc = new IsMoon();
      List<String> result = ListExamples.filter(list, sc);
      assertEquals(Arrays.asList("moon"), result);
    }
  
    @Test
    public void testMerge() {
      List<String> list1 = Arrays.asList("apple", "banana", "cherry");
      List<String> list2 = Arrays.asList("date", "elderberry", "fig");
      List<String> result = ListExamples.merge(list1, list2);
      assertEquals(Arrays.asList("apple", "banana", "cherry", "date", "elderberry", "fig"), result);
    }
  
    @Test
    public void testMergeWithOverlap() {
      List<String> list1 = Arrays.asList("apple", "banana", "cherry");
      List<String> list2 = Arrays.asList("banana", "cherry", "date");
      List<String> result = ListExamples.merge(list1, list2);
      assertEquals(Arrays.asList("apple", "banana", "banana", "cherry", "cherry", "date"), result);
    }
}
