# documentserver-cluster
The ansible tasks for deploy the DocumentServer Cluster

## How to use it

### Step 1

#### Install the latest Ansible version. Please see the [Installation section](http://docs.ansible.com/ansible/intro_installation.html) on Ansible website to learn how to get it.

### Step 2

#### Get the latest version of DocumentServer Cluster source code from GitHub:
```
https://github.com/ONLYOFFICE/document-server-cluster.git
```
#### Switch to the DocumentServer Cluster directory:
```
cd document-server-cluster
```

### Step 3

#### Configure your cluster, in the ```staging``` file,  put under each ```[section]``` the address for servrer which will be used for appropriated role.

#### Note 1: Each section can contain several server addresses, but only the first will be used in the cluster except ```[documentservers]```.

#### Note 2: See the [Managed Node Requirements](https://docs.ansible.com/ansible/intro_installation.html#managed-node-requirements) to the details of initial setup DocumentServer Cluster nodes.

### Step 4

#### Deploy your cluster:
```
./deploy.sh
```


