#include <iostream>
using namespace std;


void ch(int a[])
{
    cout << "sizeof(a)/sizeof(a[0])= " << sizeof(a) / sizeof(a[0]) << " sizeof(a)=" << sizeof(a) << endl;
}
int main()
{
    int a[] = { 1,3,5,7,9,11,13,15,17,19 };//size=10
    cout << "sizeof(a)/sizeof(a[0])= " << sizeof(a) / sizeof(a[0]) << " sizeof(a)=" << sizeof(a) << endl;
    ch(a);
}

运行后发现在主函数内数组a的长度是正确的10，在函数内却只有1，sizeof(a)=4，在函数输出数组无误后推断应该是传参的问题，于是去网上查找相关的内容发现是因为：

当数组名作为函数参数传递后，“退化”为指针，sizeof自然也就不能得到数组的长度，只是得到一个指针的长度而已。

但是当然可以在不增加新的函数参数的前提下实现在函数中求出数组长度：

/*首先，void tot( int a[] ) 这种形式，传递的是指针，不是数组。
（平时说“传递数组”无所谓，但在这个话题下，需要严格区分）
传递数组也是可以的，例如 void tot( int (&a)[10] )。
假如你就是要传递一个 int[10] 作参数，那么 void tot( int (&a)[10] ) 是完美的。
然而很多时候，可能既要传递 int[10]，也要传递 int[9]、int[123] 等等。
可是 int[10]、int[9]、int[123] 等是不同的类型，
没法使用同一个函数申明，所以普通的函数是没有任何办法了。
可以使用 函数模板，函数模板 不是 函数，函数模板 是能生成函数的模板。例如*/
#include <iostream>
using namespace std;

template<size_t N> void tot( int (&a)[N] )
{
    cout << sizeof(a)/sizeof(a[0]) << '\n';
    cout << std::size(a) << '\n'; // 更建议使用这种简洁的模板函数
}

int main( void )
{
    int a[] = { 1,3,5,7,9,11,13,15,17,19 };
    tot(a);
    
    int b[] = { 1,2,3 };
    tot(b);
}

/*template<size_t N> void tot( int (&a)[N] ) 这个函数因为被 tot(a) 和 tot(b) 调用，
所以它实际生成了两个函数，分别是 void tot( int (&a)[10] ) 和 void tot( int (&a)[3] )。
从上面可以看出，几种不同的参数调用就生成几种不同的函数重载。
假如你的 tot 函数实现就是如此简单，那么到此可以结束。
可是，如果tot本身实现很复杂，有100行代码，又被100种参数调用了，
那么100行的代码就被复制了100份，严重浪费的代码膨胀。
这时候，可以只用 函数模板 传递数组长度，其本身不包含任何实现。例如*/
#include <iostream>
using namespace std;

static void tot_( int a[], size_t n )
{
    cout << n << '\n';
}

template<size_t N> void tot( int (&a)[N] )
{
    tot_( a, N );
}

int main( void )
{
    int a[] = { 1,3,5,7,9,11,13,15,17,19 };
    tot(a);
    
    int b[] = { 1,2,3 };
    tot(b);
}
在大一学习C++后到现在这段时间里还没有实际应用过函数模板，就像C++的class一样抛在脑后，说白了就是馋C++的语法和STL而忽视了C++作为面向对象语音最根本的结构，比如函数模板和类的封装，重载等等，这些才是C++最根本的特点，抓住细节，及时查漏补缺

来源：https://www.cnblogs.com/murenma/p/13205795.html
