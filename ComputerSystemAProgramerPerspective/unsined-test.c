#include<stdio.h>
#include<time.h>
#define DELTA sizeof(int)
int main(){
int i;
int count = 0;
int CNT = 10;
for (i = CNT; i-DELTA >= 0; i-= DELTA){
	sleep(1);
	count++;
	printf("count=%d\n",count);
}
}
