AMP = @

CC = ${AMP}gcc
CC_FLAGS = -fPIC -Wall

INCLUDE_FLAG = -Iinclude
LINK_FLAG = -lkuz

AR = ${AMP}ar
RM = ${AMP}rm -f

KUZ_NAMES = 
KUZ_NAMES += kuz

KUZ_OBJ_NAMES = ${addsuffix .o, ${KUZ_NAMES}}
KUZ_OBJS = ${addprefix build/, ${KUZ_OBJ_NAMES}}

KUZ_STATIC_LIB = build/libkuz.a
KUZ_DYNAMIC_LIB = build/libkuz.so

MAIN_SRC = src/main.c
MAIN_OBJ = build/main.o

BIN = build/kuz-c

default: clean lib ${BIN}

lib: ${KUZ_STATIC_LIB} ${KUZ_DYNAMIC_LIB}

debug:
	${eval AMP := }

${BIN}: ${MAIN_OBJ} ${KUZ_OBJS}
	${CC} $^ -o $@

${MAIN_OBJ}: ${MAIN_SRC}
	${CC} -c ${CC_FLAGS} $< -o $@ ${INCLUDE_FLAG}

${KUZ_OBJS}: build/%.o: lib/%.c include/%.h
	${CC} -c ${CC_FLAGS} $< -o $@ ${INCLUDE_FLAG}

${KUZ_STATIC_LIB}: ${KUZ_OBJS}
	${AR} rcs $@ $^

${KUZ_DYNAMIC_LIB}: ${KUZ_OBJS}
	${CC} -shared $^ -o $@

redo: clean default

run: ${BIN}
	@${BIN}

move:
	sudo cp ${BIN} /usr/bin

clean:
	${RM} ${BIN}
	${RM} ${MAIN_OBJ}
	${RM} ${KUZ_OBJS}
	${RM} ${KUZ_STATIC_LIB}
	${RM} ${KUZ_DYNAMIC_LIB}


