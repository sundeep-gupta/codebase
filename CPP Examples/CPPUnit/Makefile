SRC_DIR=src/CPP
NAMESPACE=linklist
TEST_DIR=${SRC_DIR}/tests/${NAMESPACE}
MAIN_DIR=${SRC_DIR}/main/${NAMESPACE}
MAIN_INC_DIR=${MAIN_DIR}
TEST_INC_DIR=${TEST_DIR}

BUILD_DIR=build/${NAMESPACE}
# Compile the main code.
unittest: main tests unittests
	gcc -o ${BUILD_DIR}/LinkListUnitTests ${BUILD_DIR}/LinkListUnitTests.o ${BUILD_DIR}/LinkListReverse.o ${BUILD_DIR}/LinkListReverseTestSuite.o  -lstdc++ -lcppunit -ldl

main:
	gcc -c -o ${BUILD_DIR}/LinkListReverse.o ${MAIN_DIR}/LinkListReverse.cc -I${MAIN_INC_DIR}

tests:
	gcc -c -o ${BUILD_DIR}/LinkListReverseTestSuite.o ${TEST_DIR}/LinkListReverseTestSuite.cc -I${MAIN_INC_DIR} -I${TEST_INC_DIR}

unittests: 
	gcc -c -o  ${BUILD_DIR}/LinkListUnitTests.o ${TEST_DIR}/UnitTests.cc
