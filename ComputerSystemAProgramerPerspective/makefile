CXXFLAGS=-g -std=c++11
.PHONY:all clean

all:
	g++ $(CXXFLAGS) P14_memory_performance.cc  -o p14_m_p
	g++ $(CXXFLAGS) P14.cc -o p14
s:
	gcc -S -fverbose-asm  P10_memory_referencing_bug.c 
clean:
	rm p14 ; rm -rf a.out
