# documentserver-cluster
The ansible tasks for deploy the DocumentServer Cluster

## Requirements on remote hosts

### OS Platforms for redis cluster nodes:
```
Debian	bullseye
Debian	buster
Debian	etch
Debian	jessie
Debian	lenny
Debian	sid
Debian	squeeze
Debian	stretch
Debian	wheezy
EL	6
EL	7
SLES	11
SLES	12
Ubuntu	artful
Ubuntu	bionic
Ubuntu	cosmic
Ubuntu	cuttlefish
Ubuntu	disco
Ubuntu	eoan
Ubuntu	focal
Ubuntu	lucid
Ubuntu	maverick
Ubuntu	natty
Ubuntu	oneiric
Ubuntu	precise
Ubuntu	quantal
Ubuntu	raring
Ubuntu	saucy
Ubuntu	trusty
Ubuntu	utopic
Ubuntu	vivid
Ubuntu	wily
Ubuntu	xenial
Ubuntu	yakkety
Ubuntu	zesty
```

### OS Platforms for rabbitmq cluster nodes:
```
Debian	stretch
EL	7
Ubuntu	bionic
```

### OS Platforms for zookeeper cluster nodes:

```
Debian	buster
Debian	jessie
Debian	stretch
EL	7
Fedora	23
Fedora	24
Fedora	25
Fedora	26
Fedora	27
Fedora	28
Fedora	29
Fedora	30
Fedora	31
Ubuntu	bionic
Ubuntu	xenial
```

### OS Platforms for postgresql cluster nodes:

```
Debian	jessie
Debian	stretch
EL	6
EL	7
Ubuntu	bionic
Ubuntu	xenial
```

### OS Platforms for the Haproxy host:

```
Debian	buster
Debian	jessie
Debian	stretch
EL	7
Ubuntu	bionic
```

## How to use it

### Step 1

#### Install the latest Ansible version. Please see the [Installation section](http://docs.ansible.com/ansible/intro_installation.html) on Ansible website to learn how to get it.

### Step 2

#### Get the latest version of DocumentServer Cluster source code from GitHub:
```
git clone https://github.com/ONLYOFFICE/document-server-cluster.git
```
#### Switch to the DocumentServer Cluster directory:
```
cd document-server-cluster
```

### Step 3

#### Configure your cluster, in the ```staging``` file,  put under each ```[section]``` except ```[all:children]``` the address for servrer which will be used for appropriated role in the next format:
```
<server_address> [ansible_user=<user_name>] [ansible_ssh_pass=<user_password>]
```

#### Note 1: Each section can contain several server addresses, but only the first will be used in the cluster except ```[documentservers]```.

#### Note 2: For the ```[documentservers]``` and ```[documentserver-example]``` sections, parameter ```ansible_user``` is requied.

#### Note 3: See the [Managed Node Requirements](https://docs.ansible.com/ansible/intro_installation.html#managed-node-requirements) to the details of initial setup DocumentServer Cluster nodes.

#### Example of staging file:
```
[documentservers]
documentserver_server_address_1 ansible_user=root
documentserver_server_address_2 ansible_user=root

[postgresql]
database_server_address_1 zookeeper_myid=0
database_server_address_2 zookeeper_myid=1
database_server_address_3 zookeeper_myid=2

[filestorage]
filestorage_server_address

[rabbitmq_master]
rabbitmq_master_server_address

[rabbitmq_slave]
rabbitmq_slave_server_address_1
rabbitmq_slave_server_address_2

[rabbitmq:children]
rabbitmq_master
rabbitmq_slave

[redis_master]
redis_master_server_address

[redis_slave]
redis_slave_server_address_1
redis_slave_server_address_2

[redis:children]
redis_master
redis_slave

[redis_sentinel]
redis_sentinel_server_address_1
redis_sentinel_server_address_2
redis_sentinel_server_address_3

[all:children]
haproxy_cluster
documentservers
postgresql
all_redis
rabbitmq
filestorage
```

### Step 4

#### Deploy your cluster:
```
./deploy.sh
```

### Running DocumentServer Cluster using HTTPS

#### STEP 1
In file ```groups_vars/all``` replace ```loadbalancer_ssl: false``` with ```loadbalancer_ssl: true```

#### STEP 2
Create the ```/app/onlyoffice/DocumentServer/data/certs/onlyoffice.pem``` file that contains a certificate and a private key

#### STEP 3
Deploy cluster

When using CA certified certificates, the **Private key (.key)** and **SSL certificate (.crt)** are provided to you by the CA. When using self-signed certificates you need to generate these files yourself. Skip **steps 1-3** in the following section if you have CA certified SSL certificates.

#### Generation of Self Signed Certificates

Generation of self-signed SSL certificates involves a simple 3 step procedure.

**STEP 1**: Create the server private key

```bash
openssl genrsa -out onlyoffice.key 2048
```

**STEP 2**: Create the certificate signing request (CSR)

```bash
openssl req -new -key onlyoffice.key -out onlyoffice.csr
```

**STEP 3**: Sign the certificate using the private key and CSR

```bash
openssl x509 -req -days 365 -in onlyoffice.csr -signkey onlyoffice.key -out onlyoffice.crt
```
**STEP 4**: Merge both the files
```
cp onlyoffice.crt onlyoffice.pem
cat onlyoffice.key >> onlyoffice.pem
```
