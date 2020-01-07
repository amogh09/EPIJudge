.PHONY: all clean

HC = ghc 
OPTFLAG = -O2
BUILD_DIR = build

RECTANGLE_INTERSECTION = rectangleIntersection
COUNT_BITS = countBits
PARITY = parity

all: \
	${BUILD_DIR}/${RECTANGLE_INTERSECTION}
	${BUILD_DIR}/${COUNT_BITS}

.PHONY: ${RECTANGLE_INTERSECTION}
${BUILD_DIR}/${RECTANGLE_INTERSECTION}: ${BUILD_DIR} ${RECTANGLE_INTERSECTION}.hs
	@echo "Compiling ${RECTANGLE_INTERSECTION}.hs"
	${HC} ${OPTFLAG} -o ${BUILD_DIR}/${RECTANGLE_INTERSECTION} -outputdir ${BUILD_DIR} ${RECTANGLE_INTERSECTION}.hs
${RECTANGLE_INTERSECTION}: ${BUILD_DIR}/${RECTANGLE_INTERSECTION}
	@echo "Running ${RECTANGLE_INTERSECTION}"
	${BUILD_DIR}/${RECTANGLE_INTERSECTION}
	@rm -f ${BUILD_DIR}/Main.hi ${BUILD_DIR}/Main.o

.PHONY: ${COUNT_BITS}
${BUILD_DIR}/${COUNT_BITS}: ${BUILD_DIR} ${COUNT_BITS}.hs
	@echo "Compiling ${COUNT_BITS}.hs"
	${HC} ${OPTFLAG} -o ${BUILD_DIR}/${COUNT_BITS} -outputdir ${BUILD_DIR} ${COUNT_BITS}.hs
${COUNT_BITS}: ${BUILD_DIR}/${COUNT_BITS}
	@echo "Running ${COUNT_BITS}"
	${BUILD_DIR}/${COUNT_BITS}
	@rm -f ${BUILD_DIR}/Main.hi ${BUILD_DIR}/Main.o

.PHONY: ${PARITY}
${BUILD_DIR}/${PARITY}: ${BUILD_DIR} ${PARITY}.hs
	@echo "Compiling ${PARITY}.hs"
	${HC} ${OPTFLAG} -o ${BUILD_DIR}/${PARITY} -outputdir ${BUILD_DIR} ${PARITY}.hs
${PARITY}: ${BUILD_DIR}/${PARITY}
	@echo "Running ${PARITY}"
	${BUILD_DIR}/${PARITY}
	@rm -f ${BUILD_DIR}/Main.hi ${BUILD_DIR}/Main.o

${BUILD_DIR}: 
	@echo "Creating build directory"
	mkdir -p ${BUILD_DIR}

clean:
	@echo "Cleaning up..."
	rm -f ${RECTANGLE_INTERSECTION}
	rm -rf ${BUILD_DIR}/