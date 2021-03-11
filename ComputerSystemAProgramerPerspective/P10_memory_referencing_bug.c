#include<stdio.h>
typedef struct {
  int a[2];
  double d;
} struct_t;

double fun(int i) {
  volatile struct_t s;
  s.d = 3.14;
  s.a[i] = 1073741824; /* Possibly out of bounds */
  return s.d;
}
#define PRINT(x) printf("fun(%d) --> %f\n",(x),fun(x)) 
void main()
{
	PRINT(0);
	PRINT(1);
	PRINT(2);
	PRINT(3);
	PRINT(4);
	PRINT(6);
}
