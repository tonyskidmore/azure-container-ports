
````bash

curl http://localhost:5000

curl -v telnet://localhost:5001 <<< "testing TCP connection"

````

````bash

docker build -t python-multiservice .

docker run -p 5000:5000 -p 5001:5001 python-multiservice


````
