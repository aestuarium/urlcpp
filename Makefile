all: url_test url.so test

url_test:
	$(CXX) -Wall -Wnon-virtual-dtor -DBOOST_TEST_MAIN -DBOOST_TEST_DYN_LINK ./src/url.cpp ./src/path.cpp Url_test.cpp -lboost_unit_test_framework -lboost_regex -I ./include -o url_test

url.so:
	$(CXX) ./src/path.cpp ./src/url.cpp url_python_module.cpp -shared -lboost_python -lboost_regex -I /usr/include/python2.7 -I ./include -fPIC -o url.so

test:
	./url_test
	./test_python.py


clean:
	rm url_test url.so

.PHONY: all clean
