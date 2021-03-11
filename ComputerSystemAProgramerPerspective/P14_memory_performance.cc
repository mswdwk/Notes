#include<iostream>
#include<chrono>
//using namespace std;
#define MAX 2048
void copyij(int src[2048][2048],
            int dst[2048][2048])
{
  int i,j;
  for (i = 0; i < 2048; i++)
    for (j = 0; j < 2048; j++)
      dst[i][j] = src[i][j];
}

void copyji(int src[2048][2048],
            int dst[2048][2048])
{
  int i,j;
  for (j = 0; j < 2048; j++)
    for (i = 0; i < 2048; i++)
      dst[i][j] = src[i][j];
}

int main()
{	
	using namespace std::chrono;
	using namespace std;
	milliseconds cost(1);
	int src[MAX][MAX] ;//= {0};	
	int dst[MAX][MAX] ;//= {0};	
	cout<<"cost "<<cost.count()<<" milliseconds\n";//<<std::endl;
	//copyij(src,dst);
	//std::cout<<"cost "<<cost.count()<<" milliseconds"<<std::endl;
	//copyji(src,dst);
	//std::cout<<"cost "<<cost.count()<<" milliseconds"<<std::endl;
	return 0;
}
