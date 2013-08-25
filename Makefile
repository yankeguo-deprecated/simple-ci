all:
	coffee -bc .
	echo "#!/usr/bin/env node\n" > ./bin/simple-ci
	cat ./bin/simple-ci.js >> ./bin/simple-ci
	rm -f ./bin/simple-ci.js
clean:
	rm -f *.js
	rm -f ./db/*.js
	rm -f ./routers/*.js
	rm -f ./test/*.js
	rm -f ./bin/simple-ci
