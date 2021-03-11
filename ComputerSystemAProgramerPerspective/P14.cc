#include <iostream>
#include <string>
#include <chrono>
using namespace std;
#define MAX 2048
void copyij(int src[2048][2048],
            int dst[2048][2048])
{
  int i,j;
  auto beforeTime = std::chrono::steady_clock::now();
  for (i = 0; i < 2048; i++)
    for (j = 0; j < 2048; j++)
      dst[i][j] = src[i][j];
  auto afterTime = std::chrono::steady_clock::now();
	cout<<__func__<<" cost: ";
	//毫秒级
	double duration_millsecond = std::chrono::duration<double, std::milli>(afterTime - beforeTime).count();
	std::cout << duration_millsecond << "毫秒" << std::endl;
}

void copyji(int src[2048][2048],
            int dst[2048][2048])
{
  int i,j;
  auto beforeTime = std::chrono::steady_clock::now();
  for (j = 0; j < 2048; j++)
    for (i = 0; i < 2048; i++)
      dst[i][j] = src[i][j];

  auto afterTime = std::chrono::steady_clock::now();
	cout<<__func__<<" cost: ";
	//毫秒级
	cout<<__func__<<" cost: ";
	double duration_millsecond = std::chrono::duration<double, std::milli>(afterTime - beforeTime).count();
	std::cout << duration_millsecond << "毫秒" << std::endl;
}

void Run()
{
	for (int i = 0; i < 1000000000; ++i)
	{

	}

}

int main()
{
	int src[MAX][MAX] ;//= {0};	
	int dst[MAX][MAX] ;//= {0};	
	
	// Run();
	copyij(src,dst);
	copyji(src,dst);
/*
	std::cout << "总耗时:" << std::endl;
	//秒
	double duration_second = std::chrono::duration<double>(afterTime - beforeTime).count();
	std::cout << duration_second << "秒" << std::endl;


	//微妙级
	double duration_microsecond = std::chrono::duration<double, std::micro>(afterTime - beforeTime).count();
	std::cout << duration_microsecond << "微秒" << std::endl;

	//纳秒级
	double duration_nanosecond = std::chrono::duration<double, std::nano>(afterTime - beforeTime).count();
	std::cout << duration_nanosecond << "纳秒" << std::endl;
*/
	//getchar();
	return 0;
}
