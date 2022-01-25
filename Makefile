CC = g++
DEBUG = n
RM = rm -rf
MAKE = make

DIR_INC = ./include
DIR_SRC = ./src
DIR_SRC_IMPL = ./src/impl
DIR_BIN = ./bin

#需要遍历所有包含.cc文件的目录，生成对应的.o文件
SRC = $(wildcard ${DIR_SRC}/*.cc)  
SRC += $(wildcard ${DIR_SRC_IMPL}/*.cc)  
OBJ = $(patsubst %.cc,${DIR_BIN}/%.o,$(notdir ${SRC})) 

TARGET = main
BIN_TARGET = ${DIR_BIN}/${TARGET}

CFLAGS = -Wall -I${DIR_INC}
ifeq ($(DEBUG), y)
CFLAGS += -g
else
CFLAGS += -O2
endif

.PHONY:all clean

all:${BIN_TARGET}


${BIN_TARGET}:${OBJ} main.o
	$(CC) $^ -lrt -o $@ 

${DIR_BIN}/%.o:$(DIR_SRC)/%.cc
	$(CC) $(CFLAGS) -c $^ -o $@ 

${DIR_BIN}/%.o:$(DIR_SRC_IMPL)/%.cc
	$(CC) $(CFLAGS) -c $^ -o $@ 

main.o:main.cc
	$(CC) $(CFLAGS) -c $^ -o $@ 
clean:
	find ${DIR_BIN} . -name '*.o' -exec $(RM) '{}' \;
	$(RM) ${BIN_TARGET}
