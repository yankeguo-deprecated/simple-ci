all:
	coffee -bc .
	echo "#!/usr/bin/env node" > ./bin/simple-ci
	cat ./bin/simple-ci.js >> ./bin/simple-ci
	rm -f ./bin/simple-ci.js
	chmod +x ./bin/simple-ci
clean:
	rm -f *.js
	rm -f ./db/*.js
	rm -f ./routers/*.js
	rm -f ./test/*.js
	rm -f ./bin/simple-ci
