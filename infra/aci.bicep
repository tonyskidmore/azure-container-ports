@description('Name for the container group')
param name string = 'azurecontainerportscontainergroup'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Container image to deploy')
param image string = 'ghcr.io/tonyskidmore/azure-container-ports:main'

@description('Port to open for HTTP on the container and the public IP address.')
param httpPort int = 5000

@description('Port to open for TCP socket on the container and the public IP address.')
param tcpPort int = 5001

@description('The number of CPU cores to allocate to the container.')
param cpuCores int = 1

@description('The amount of memory to allocate to the container in gigabytes.')
param memoryInGb int = 2

@description('The behavior of Azure runtime if container has stopped.')
@allowed([
  'Always'
  'Never'
  'OnFailure'
])
param restartPolicy string = 'Always'

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2021-03-01' = {
  name: name
  location: location
  properties: {
    containers: [
      {
        name: name
        properties: {
          image: image
          resources: {
            requests: {
              cpu: cpuCores
              memoryInGB: memoryInGb
            }
          }
          ports: [
            {
              port: httpPort
            }
            {
              port: tcpPort
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: restartPolicy
    ipAddress: {
      type: 'Public'
      ports: [
        {
          protocol: 'tcp'
          port: httpPort
        }
        {
          protocol: 'tcp'
          port: tcpPort
        }
      ]
    }
  }
}

output containerIPv4Address string = containerGroup.properties.ipAddress.ip
