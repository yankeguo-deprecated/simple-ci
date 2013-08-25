all:
	coffee -c .
clean:
	rm -f *.js
	rm -f ./db/*.js
	rm -f ./routers/*.js
	rm -f ./test/*.js
