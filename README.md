# Democracia en Red: Levanta la mano!

Este repositorio permite levantar una instancia de [VotaInteligente](https://github.com/DemocraciaEnRed/votainteligente-portal-electoral) configurada para funcionar con la aplicación Levanta la mano! por defecto.
Se utiliza un docker-compose y el repositorio de [VotaInteligente](https://github.com/DemocraciaEnRed/votainteligente-portal-electoral) como un submódulo de GIT.

---
## How To

#### Clonar este repositorio y hacer magia con GIT
Es importante que no olviden el flag `--recurse-submodules` ya que permite inicializar y actualizar los submódulos que se incluyan en un repositorio.

NOTA: el código de VotaInteligente está en un branch fuera del master ya que estamos esperando algunos cambios en upstream.

```bash
# El primer paso es clonar este repositorio y agregar recursivamente votainteligente como submodulo
$ git clone --recurse-submodules https://github.com/DemocraciaEnRed/levantalamano-docker

# Entramos al repositorio
$ cd levantalamano-docker

# La actualizacion del submodulo al clonar deja al submodulo en modo detached head asi que es necesario hacer checkout del branch necesario
$ git submodule foreach -q --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'

# Vamos al código
$ cd votainteligente-portal-electoral

# Iniciar otro branch para nuestro trabajo
$ git checkout -b "dev-tasks"
```

#### Buildear y correr el compose
Es importante hacer el build ya que es necesario configurar un usuario en el contenedor con el UID y el GID local para evitar problemas de permisos. El código de VotaInteligente se monta como un volumen de Docker en el contenedor de la aplicación y necesitamos permisos correctos para hacer cambios.

```bash
$ sudo docker-compose build --build-arg uid=$(echo $UID) --build-arg gid=$(echo $GID)
$ sudo docker-compose up
```

No incluyo el flag `-d` en el `docker-compose up` ya que es mejor observar el output de Docker para saber cuándo la aplicación ya esta accesible. Una vez que Django haya hechos los últimos tests, la aplicación estará disponible en http://127.0.0.1:8000.

#### MUY IMPORTANTE
Trabajar con submódulos es complejo, lo ideal es que el desarrollador trabaje sobre su branch y pushee al repositorio del submódulo. Cuando sea necesario mostrar los cambios realizados tiene que volver al repositorio principal y hacer los `git add` y `git commit` para actualizar la realidad del submódulo en el repositorio principal.
