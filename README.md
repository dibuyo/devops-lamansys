<p align="center">
 <img width="100px" src="https://img.freepik.com/vector-premium/logotipo-educacion-linea-icono-pegatina-vector-curso-e-learning-casa-estudio-linea-educacion-distancia-libros-electronicos-banner-examen-distancia-vector-sobre-fondo-aislado-eps-10_399089-1128.jpg" align="center" alt="Proyect Logo" />
 <h2 align="center">Curso Introductorio a DevOps - Lamansys</h2>
 <p align="center">¡Aprendiendo súper rápido!</p>
</p>
  
  <p align="center">
    <a href="#demo">Github</a>
    ·
    <a href="#demo">Descargar Material</a>
    ·
    <a href="https://github.com/dibuyo/devops-lamansys/issues/new/choose">Report Bug</a>
    ·
    <a href="https://github.com/dibuyo/devops-lamansys/issues/new/choose">Request Feature</a>
    ·
    <a href="https://github.com/dibuyo/devops-lamansys/discussions">Ask Question</a>
  </p>
</p>

# DevOps

Transferencia de conocimiento para la instalación, configuración y gestión de Kubernetes en ambientes BareMetal y/o Cloud.

Vamos a tratar de aprender comandos necesarios para la gestión de tareas de DevOps.


## Introducción a los Comandos Básicos

<details>
  <summary><strong>whoami</strong></summary>
  El comando whoami permite a los usuarios de Linux ver al usuario que ha iniciado sesión actualmente. 

  ```bash
  lamansys@bar:~$ whoami
  lamansys
  ```
</details>

<details>
  <summary><strong>history</strong></summary>
  Se utiliza para ver el comando ejecutado anteriormente. Esta función no estaba disponible en el shell como Bourne. 

  ```bash
  lamansys@bar:~$ history
  10047  4.11.2022 09:40  clear
  10048  4.11.2022 09:48  docekr ps
  10049  4.11.2022 09:48  docker ps
  10050  4.11.2022 09:49  docker
  10051  4.11.2022 09:49  kubectl
  ```
</details>

<details>
  <summary><strong>ls</strong></summary>
    Enumerar archivos y directorios

  ```bash
  lamansys@bar:~$ ls
  bin  boot  dev	etc  home  lib	lib64  media  mnt  opt	proc  root  run  sbin  srv  sys  tmp  usr  var
  ```
</details>

<details>
  <summary><strong>cp</strong> origen destino</summary>
    Para copiar archivos y directorios

  ```bash
  lamansys@bar:~$ cp avatar.png /tmp/avatar.png
  ```
</details>

<details>
  <summary><strong>mkdir</strong> directorio</summary>
    Permite al usuario crear directorios

    ```bash
    lamansys@bar:~$ mkdir /tmp/carpeta
    ```
</details>

<details>
  <summary><strong>tail</strong> archivo</summary>
    Es el complemento del comando de cabeza. El comando de cola, como su nombre lo indica, imprime el último número N de datos de la entrada dada.

    ```bash
    lamansys@bar:~$ tail /var/log/alternatives.log
    update-alternatives 2022-08-02 16:07:19: run with --install /usr/bin/rview rview /usr/bin/vim.basic 30
    update-alternatives 2022-08-02 16:07:19: link group rview updated to point to /usr/bin/vim.basic
    update-alternatives 2022-08-02 16:07:19: run with --install /usr/bin/vi vi /usr/bin/vim.basic
    ```
</details>

<details>
  <summary><strong>head</strong> archivo</summary>
    Imprime el número N superior de datos de la entrada dada.

    ```bash
    lamansys@bar:~$ head /var/log/alternatives.log
    update-alternatives 2020-09-10 01:11:19: run with --quiet --install /usr/bin/pinentry pinentry /usr/bin/pinentry-curses 50 --slave /usr/share/man/man1/pinentry.1.gz pinentry.1.gz /usr/share/man/man1/pinentry-curses.1.gz
    update-alternatives 2020-09-10 01:11:19: link group pinentry updated to point to /usr/bin/pinentry-curses
    ```
</details>

<details>
  <summary><strong>cat</strong> archivo</summary>
    Imprimir el contenido de un archivo en el flujo de salida estándar.

    ```bash
    lamansys@bar:~$ cat /var/log/alternatives.log
    update-alternatives 2020-09-10 01:11:19: run with --quiet --install /usr/bin/pinentry pinentry /usr/bin/pinentry-curses 50 --slave /usr/share/man/man1/pinentry.1.gz pinentry.1.gz /usr/share/man/man1/pinentry-curses.1.gz
    update-alternatives 2020-09-10 01:11:19: link group pinentry updated to point to /usr/bin/pinentry-curses
    update-alternatives 2020-09-10 01:11:19: run with --quiet --install /usr/bin/pinentry pinentry /usr/bin/pinentry-curses 50 --slave /usr/share/man/man1/pinentry.1.gz pinentry.1.gz /usr/share/man/man1/pinentry-curses.1.gz
    update-alternatives 2020-09-10 01:11:19: link group pinentry updated to point to /usr/bin/pinentry-curses
    ```
</details>

<details>
  <summary><strong>ssh</strong> usuario@conexion</summary>
    Comando ssh le indica al sistema que establezca una conexión segura cifrada con la máquina host.

    ```bash
    lamansys@bar:~$ ssh martin@10.10.10.20
    ```
</details>

<details>
  <summary><strong>ping</strong> host</summary>
    Probar la accesibilidad de un host en una red de Protocolo de Internet.

    ```bash
    lamansys@bar:~$ ping localhost
    PING localhost (127.0.0.1): 56 data bytes
    64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=0.055 ms
    64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.079 ms
    64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.059 ms
    64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.082 ms
    ```
</details>

<details>
  <summary><strong>nslookup</strong> host</summary>
    Consulta los servidores de nombres de dominio de Internet

    ```bash
    lamansys@bar:~$ nslookup google.com
    Server:		8.8.8.8
    Address:	8.8.8.8#53

    Non-authoritative answer:
    Name:	google.com
    Address: 142.251.133.206
    ```
</details>

<details>
  <summary><strong>telnet</strong> host puerto</summary>
    Herramienta para solucionar problemas de conexión.

    ```bash
    lamansys@bar:~$ telnet localhost 80
    Trying ::1...
    Connected to localhost.
    Escape character is '^]'.
    ```
</details>

<details>
  <summary><strong>sh</strong></summary>
    Invoca el shell predeterminado

    ```bash
    lamansys@bar:~$ sh
    sh-3.2$
    ```
</details>

<details>
  <summary><strong>bash</strong></summary>
    Indicar al sistema que use bash como intérprete de comandos.

    ```bash
    lamansys@bar:~$ bash
    bash-3.2$
    ```
</details>

<br/>
Se agregaran nuevos comandos a medida que vayamos avanzando y utilizando.

<br/>

## Roadmap Ejecutado
  - [x] Introducción.
  - [x] Entorno de trabajo.
  - [x] Completar Formulario de Google. [Link](https://forms.gle/qbiayoN7nrUECJFU8 "Nivel de conocimiento.")
  - [x] Comandos Básicos.
  - [x] Docker y sus componentes.


## Requisitos

- Https connection [openssl](https://github.com/openssl/openssl)
- Docker
- Docker-compose
- Window
- - [WSL 2](https://docs.microsoft.com/en-us/windows/wsl/install) 


```console
lamansys@bar:~$ apt-get update
lamansys@bar:~$ apt-get install docker-compose docker
```

## Ejemplo de Docker Run

```console
lamansys@bar:~$ docker run -P -d --rm --mount type=bind,source="$PWD"/src/public,target="/usr/share/nginx/html" nginx:latest
```

## Comando para Instalar certificado y generar los pem

Instalar el certificado Raiz.

```bash
mkcert -install
```

Ejecutar el siguiente comando para crear un certificado autofirmado

```bash
mkcert -key-file cert/cert-key.pem -cert-file cert/cert.pem localhost 127.0.0.1 ::1
```

### Nombres por DNS

1. Configure hosts file

```bash
127.0.0.1       intranet
127.0.0.1       database
127.0.0.1       portainer
```

### Docker Compose

Para levantar el proyecto de docker compose

```bash
docker-compose up -d --build
```

### Instalación de K3s
Tenemos muchas formas de instalar k3s en nuestro equipo local. Nosotros vamos a utilizar docker-compose que es la que venimos trabajando.

En la carpeta de k3s en el raíz de este repositorio pueden encontrar el archivo. Para instalar el cluster ejecutar docker-compose up -d.

Una vez que se ejecute por primera vez se creará en la misma carpeta el archivo de kubectonfig.yaml. 

Hacer una copia de seguridad si ya tenemos un archivo de configuración existente.

```bash
$ cp ~/.kube/config ~/.kube/config.bak
```

Utilizamos una variable de entorno que consulta kubectl antes de ir a buscar la ubicación por defecto. Exportamos el resultado a un nuevo archivo

```bash
KUBECONFIG=~/.kube/config:/path/to/new/config kubectl config view --flatten > /tmp/config
```

Nos aseguramos de tener todos los archivos necesarios y luego lo movemos a la ruta por defecto
```bash
mv /tmp/config ~/.kube/config 
```
Eliminamos el archivo de Backup de ser necesario.

```bash
rm ~/.kube/config.bak
```

### Recomandaciones de terceros - AddOn / Plugins
A continuación disponibilizamos un repositorio con la solución de Kubectx y Kubens que nos ayudan de manera simple a movernos de contexto y de nombre de espacio de trabajo.

[kubectx](https://github.com/ahmetb/kubectx)

![Kubectx](https://raw.githubusercontent.com/ahmetb/kubectx/master/img/kubectx-demo.gif "kubectx & kubens")

### Helm
Como instalar Helm sin utilizar el gestor de paquetes.

```bash
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
```

Como instalar Helm utilizando Brew.

```bash
brew install helm
```

Como instalar un repositorio de imagenes de Helm más popular:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Como instalar un Chart de Helm como redis
```bash
helm install redis bitnami/redis
```

Como instalar odoo como ejemplo.

```bash
helm install odoo bitnami/odoo --set serviceType=NodePort
```
### Como Ejecutar Rancher
El siguiente comando ejecuta Rancher de manera Local utilizando Docker como plataforma. Donde se instalara una versión reduciza de k3s para la gestion de los servicios de Rancher.

```bash
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  rancher/rancher:latest
```

### Como instalar Prometheus con Helm

Crear un namespace que se llame metrics. Y luego instalar con Helm

```bash
kubectl create namespace metrics

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

kubectl create namespace metrics

helm install -n metrics prometheus prometheus-community/prometheus

kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-np

minikube service prometheus-server-np
```

### Como instalar Grafana con Helm

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

helm install grafana bitnami/grafana

kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-np

minikube service -n metrics grafana-np
```