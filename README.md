# azure-container-ports

Example Flask and socket app running on 2 separate ports in a container image.  
Includes code to deploy to Azure Container instance with public access.  

Built and tested on Windows 11 installed with Windows Subsystem for Linux and Docker Desktop.


## Build and run the app

````bash

git clone https://github.com/tonyskidmore/azure-container-ports.git

cd azure-container-ports

docker build -t python-multiservice .

docker run -p 5000:5000 -p 5001:5001 python-multiservice


````

## Test the app locally

````bash

curl http://localhost:5000

curl telnet://localhost:5001 <<< "testing TCP connection"

````

## Deploy the app

````bash

az login
az group create \
  --name rg-azure-container-ports \
  --location uksouth

ip_address=$(az deployment group create \
  --resource-group rg-azure-container-ports \
  --template-file infra/aci.bicep \
  --query "properties.outputs.containerIPv4Address.value" \
  --output tsv)

````

## Test the app in Azure

_Note:_ assumes that ports 5000/tcp and 5001/tcp are allowed outbound

````bash

curl http://${ip_address}:5000

curl telnet://${ip_address}:5001 <<< "testing TCP connection"

````

## Delete the app

````bash

az group delete --name rg-azure-container-ports

````
