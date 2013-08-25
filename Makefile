all:
	coffee -bc .
	echo "#!/usr/bin/env node" > ./bin/simpleci
	cat ./bin/simpleci.js >> ./bin/simpleci
	rm -f ./bin/simpleci.js
	chmod +x ./bin/simpleci
clean:
	rm -f *.js
	rm -f ./routers/*.js
	rm -f ./bin/simpleci
