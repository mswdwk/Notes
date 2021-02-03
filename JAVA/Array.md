# List to Array

　　List 提供了toArray的接口，所以可以直接调用转为object型数组
```
List<String> list = new ArrayList<String>();
Object[] array=list.toArray();
```
　　上述方法存在强制转换时会抛异常，下面此种方式更推荐：可以指定类型
```java
String[] array=list.toArray(new String[list.size()]);
```

# Array to List
1、运用ArrayList的构造方法是目前来说最完美的作法，代码简洁，效率高：
```java
List<String> list = new ArrayList<String>(Arrays.asList(array));
```
2、运用Collections的addAll方法也也是不错的解决办法
```java
List<String> list = new ArrayList<String>(array.length);
Collections.addAll(list, array);
```
# Array or List 分隔

　　其实自己实现一个分隔list或者数组的方法也并不复杂，但强大的第三方库自然提供的有此类似的功能
```java
// org.apache.commons.lang3.StringUtils.join(Iterable<?>, String)
StringUtils.join(list, ",")

// org.apache.commons.lang3.StringUtils.join(Object[], String)
StringUtils.join(array, ",")
```
