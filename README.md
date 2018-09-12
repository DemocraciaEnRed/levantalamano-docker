# Democracia en Red: Levanta la mano!

Este repositorio permite levantar una instancia de [VotaInteligente](https://github.com/DemocraciaEnRed/votainteligente-portal-electoral) configurada para funcionar con la aplicación Levanta la mano! por defecto.

---
## How To

#### Clonar este repositorio
NOTA: el código de VotaInteligente está en un branch fuera del master ya que estamos esperando algunos cambios en upstream.

```bash
# El primer paso es clonar este repositorio
$ git clone https://github.com/DemocraciaEnRed/levantalamano-docker
```

#### Buildear y correr el compose
Es importante hacer el build ya que es necesario configurar un usuario en el contenedor con el UID y el GID local para evitar problemas de permisos. El código de VotaInteligente se monta como un volumen de Docker en el contenedor de la aplicación y necesitamos permisos correctos para hacer cambios.

```bash
# Entrar al directorio
$ cd levantalamano-docker

# Buildear la aplicación
$ sudo docker-compose build --build-arg uid=$(echo $UID) --build-arg gid=$(echo $GID)

# Levantar la aplicación
$ sudo docker-compose up
```

No incluyo el flag `-d` en el `docker-compose up` ya que es mejor observar el output de Docker para saber cuándo la aplicación ya esta accesible. Una vez que Django haya hechos los últimos tests, la aplicación estará disponible en http://127.0.0.1:8000.
