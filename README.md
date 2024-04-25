# Game 2048 (A elegir)
Implementacion del juego 2048 utilizando el lenguaje de programacion de Huskell, para el proyecto se uso Stack y para el manejo de la interfaz del juego se utilizo la libreria Gloss.

## Índice

1. [Instalación](#instalación)
2. [Uso](#uso)
3. [Estructura del Proyecto](#estructura-del-proyecto)
4. [Funcionalidades](#funcionalidades)
5. [Estado del Proyecto](#estado-del-proyecto)
6. [Ejemplos o Capturas de Pantalla](#ejemplos-o-capturas-de-pantalla)
7. [Links](#links)
8. [Créditos](#créditos)

## [Instalación](#instalación)
Para ejecutar el juego 2048, necesitarás tener Haskell(GHCI) y Stack instalado en tu sistema. Además, el proyecto hace uso de la biblioteca Gloss para el manejo de la interfaz del juego. 
Para la instalacion el proyecto fue trabajado en el sistema operativo Linux/Ubuntu 20.04.
  
  1. **Instalacion del IDE(Visual Studio Code)**
     1. Abre una terminal en tu sistema Linux/Ubuntu.
     2. Agrega el repositorio de Visual Studio Code ejecutando el siguiente comando: [sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"]
     4. Descarga e importa la clave de Microsoft GPG ejecutando los siguientes comandos:
      [wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo mv packages.microsoft.gpg /etc/apt/trusted.gpg.d/]
     5. Actualiza la lista de paquetes e instala Visual Studio Code ejecutando los siguientes comandos:
      [sudo apt update]
      [sudo apt install code]
     6. Una vez que la instalación se haya completado, puedes iniciar Visual Studio Code desde el menú de aplicaciones o ejecutando el siguiente comando en la terminal: [code]
  2. **Instalación de Haskell(GHCI y extensiones en Visul Studio Code):**
    - Instalacion de GHCI para manejo del lenguaje:
       1. Abre una terminal en tu sistema Linux/Ubuntu.
       2. Ejecuta el siguiente comando para actualizar los repositorios de paquetes: [sudo apt update]
       3. Después de que se complete la actualización, ejecuta el siguiente comando para instalar GHC (Glasgow Haskell Compiler) y GHCi (Glasgow Haskell Compiler Interactive): [sudo apt install ghc]
       4. Una vez que la instalación se haya completado, puedes verificar que GHCi se haya instalado correctamente ejecutando: [ghci --version]

  - Extensiones de Visual Studio Code:
    
    ![image](https://github.com/victor-villca/game2048/assets/101211793/b8d4479e-0a2c-417d-9868-63600900ea48)

    Esta extension nos permite hacer manejo del lenguaje Haskell en nuestro IDE, se uso otra extension mas para el manejo de sintaxis del codigo.

    ![image](https://github.com/victor-villca/game2048/assets/101211793/d751647f-7a3f-4265-b4ff-ea12f7f08c9b)

  3. **Instalacion de Stack:**
     - Abre una terminal en tu sistema Linux/Ubuntu.
     - Ejecuta uno de los siguientes comandos en la terminal, según tu preferencia: 
         - Utilizando curl
          [curl -sSL https://get.haskellstack.org/ | sh]
         - Utilizando wget: 
         [wget -qO- https://get.haskellstack.org/ | sh]
     - El comando descargará el script de instalación de Stack desde el sitio oficial de Haskell Stack y lo ejecutará. Sigue las instrucciones del script para completar la instalación de Stack en tu sistema.
     - Puedes verificar que Stack se haya instalado correctamente ejecutando el comando [stack --version] en la terminal.
  5. **Instalacion de Gloss:**
     - Abre una terminal en tu sistema Linux/Ubuntu.
     - Asegúrate de tener Stack instalado siguiendo los pasos mencionados anteriormente.
     - Navega hasta el directorio de tu proyecto Haskell donde tienes el archivo "package.yaml".
     - Ejecuta el siguiente comando para instalar la biblioteca Gloss como una dependencia de tu proyecto utilizando Stack: [stack install gloss]
     - Espera a que Stack descargue e instale la biblioteca Gloss y sus dependencias.

## [Uso](#uso)
Para utilizar el juego 2048, sigue estos pasos:
1. **Clonar el Repositorio:** Clona este repositorio en tu máquina local utilizando Git.
  - [git clone https://github.com/victor-villca/game2048.git] (Con https)
  - [git clone git@github.com:victor-villca/game2048.git] (Con ssh)
2. **Navegar al Directorio del Proyecto:** Abre una terminal y navega hasta el directorio donde hayas clonado el repositorio.
[cd game2048/]
3. **Compilar el Proyecto:** Verifica que el proyecto compile correctamente utilizando Stack.
[stack build]
4. **Ejecutar el Juego:** Una vez compilado, ejecuta el juego utilizando Stack.
[stack run]
5. **Interacción con el Juego:**
- Puedes mover las fichas utilizando las teclas de dirección (arriba, abajo, izquierda, derecha) en tu teclado.
- La suma de dos celdas será la puntuación asignada.
- Para reiniciar el juego, utiliza la tecla R.
- La puntuación más alta se mantendrá mientras la aplicación esté en ejecución.
- Puedes utilizar la tecla Esc para salir de la aplicación.
- Presiona C para continuar el juego después de ganar. 

## [Estructura del Proyecto](#estructura-del-proyecto)

El proyecto sigue una estructura organizada con dos carpetas principales:

- **app:** En esta carpeta se encuentra el archivo principal del proyecto, `Main.hs`. Aquí se configuran aspectos importantes de la interfaz de usuario, como el color de fondo, el tamaño de la ventana y la llamada a la función de renderización del tablero.

- **src:** Esta carpeta contiene la lógica del juego y las funcionalidades principales:
  - `Game.hs`: Define los tipos de datos del juego, como el estado del tablero y de las celdas, así como las constantes importantes como `winning = 2048`.
  - `GameOver.hs`: Contiene la lógica para verificar si el juego ha terminado y cómo manejar el fin del juego.
  - `Logic.hs`: Implementa la lógica del juego, como la generación del tablero inicial, la verificación de estados como la victoria o la continuación del juego, y el manejo de las teclas.
  - `Movement.hs`: Define los métodos para realizar movimientos dentro del tablero.
  - `Random.hs`: Gestiona la generación de celdas aleatorias con valores de 2 o 4.
  - `Rendering.hs`: Se encarga de la interfaz de usuario, mostrando el tablero, textos y gestionando colores y posiciones.
  - `Utils.hs`: Contiene métodos para mejorar la visualización de la interfaz, como la función `boldText`, y asigna valores de celdas.

![image](https://github.com/victor-villca/game2048/assets/101211793/0dedacc3-19c7-45fc-ac21-f7315d180e20)

## [Funcionalidades](#funcionalidades)

- **Creación del tablero al iniciar el juego:** Se genera un tablero inicial al comenzar el juego, este tablero inicial sera generado segun el tamaño de que se define dentro del codigo que es 4x4.

- **Verificación de victoria al alcanzar la celda 2048:** Se comprueba si el jugador ha alcanzado la celda asignada con la constante winning que en este caso se utiliza la celda 2048, al verificar que esta existe dentro del tablero se muestra el mensaje "You Win!".

- **Implementación de un apartado de reglas o indicaciones sobre el juego:** Se proporciona al jugador información sobre como tiene que jugar el jugador, este apartado se mostrara debajo del tablero, y mostrara principalmente informacion sobre que teclas del teclado tiene que usar para cumplir que acciones, para que el usuario tenga total conocimiento de como poder jugar.

- **Movimiento de las celdas del juego dentro del tablero:** Permite al jugador mover las celdas dentro del tablero utilizando las flechas del teclado, las celdas movidas siempre iran hasta el borde del tablero de la direccion asignada.

- **Verificación de movimientos válidos antes de generar una celda:** Se verifica la disponibilidad de movimientos válidos antes de generar una nueva celda en el tablero.
  
- **Funcionalidad de reinicio del juego:** Permite al jugador reiniciar el juego en cualquier momento, restableciendo el tablero a su estado inicial, para lograr esto el jugador tiene que apretar la tecla "R" que es la encargada de realizar esta accion.

- **Mensaje de "Game Over" al no tener movimientos válidos disponibles:** Se muestra un mensaje de "Game Over" cuando el jugador llene completamente el tablero y se verifque que no tiene movimientos válidos disponibles o combinaciones de celdas disponibles.

- **Generación aleatoria de celdas con valores 2 o 4:** Se generan celdas aleatorias en el tablero con valores de 2 o 4 después de cada movimiento válido, manejamos una probabilidad de un 10% para el 4 y un 90% para el numero 2.

- **Asignación de puntuación según combinación de celdas en la partida:** Se asigna una puntuación al jugador según las combinaciones de celdas realizadas durante la partida.

- **Mejor puntuación del juego:** Se registra y muestra la mejor puntuación alcanzada por el jugador en partidas anteriores, este mejor puntaje es comparado constantemente con la puntacion actual del jugador,  si se utiliza la funcionalidad de "Reinicio" el puntaje se seguira manteinedo y se mantinee cada vez que la aplicacion este corriendo.


- **Fusión de celdas:** Las celdas del mismo valor se fusionan en una sola celda con el valor sumado el valor de ambas celdascuando chocan.

- **Tecla para continuar jugando después de haber ganado:** Después de alcanzar la celda 2048 y mostrar el mensaje de "You Win!", el jugador puede continuar jugando para alcanzar una puntuación más alta, para esto el usuario tiene que apretar la tecla asignada en este caso la tecla "C" para poder continuar jugando a pesar de ya haber ganado.

## [Estado del Proyecto](#estado-del-proyecto)
El juego "Game2048" se encuentra actualmente en su primera versión. Todas las funcionalidades principales han sido implementadas de manera correcta y funcional, ofreciendo una experiencia de juego completa.

### Características Implementadas:

- Se ha desarrollado el juego completo de 2048 con todas sus funcionalidades principales, incluyendo la generación del tablero, el movimiento de las fichas, y la verificación de victoria o derrota.
- La interfaz de usuario ha sido diseñada y está completamente funcional en base al diseño definido por nuestro equipo, proporcionando una experiencia de juego intuitiva y agradable.

### Errores Conocidos:

- Se ha identificado un problema con la importación de clases en la suite de pruebas (tests). Algunas clases no se importan correctamente debido a la estructura anterior del código antes de su modularización. Esto afecta la ejecución de ciertas pruebas unitarias.

## [Ejemplos o Capturas de Pantalla](#ejemplos-o-capturas-de-pantalla)

- Interfaz inicial del juego: Se ejecuto la aplicacion mostrandonos el tablero inicial con las dos celdas ya generadas
  - En la interfaz se puede ver los mensajes en la parte superior izquierda mostrando el nombre del juego y el nombre de nuestro equipo.
  - En la interfaz se puede ver las instrucciones en la parte inferior debajo del tablero indicando las reglas del juego.
  - En la interfaz se puede ver los textos de Score y Best Score que se iran actualizando segun vayamos jugado.   
![image](https://github.com/victor-villca/game2048/assets/101211793/f4828655-b347-4a78-94a6-21c249176b22)
- Movimiento y fusion de celdas: Del mismo tablero inicial se realizaron dos movimientos, la primera imagen un movimiento a la derecha y la segundo imagen un movimiento arriba.

![image](https://github.com/victor-villca/game2048/assets/101211793/acf6eab2-bd84-4482-b7ab-5e076739f3e0)
![image](https://github.com/victor-villca/game2048/assets/101211793/647e7f33-46c8-4a4f-99d5-08f2654d0928)
- Asignacion de Puntaje: Como se vio en la anterior imagen el puntaje actual es 4 por la fusion que hubo de las dos celdas con valor 2 cada una.
![image](https://github.com/victor-villca/game2048/assets/101211793/acd88830-8d54-4302-9b9d-438154ce3504)
- Mejor Puntaje y Reinicio de juego: De donde se esta se realizara unos movimientos para definir el mejor puntaje a un valor mayor (un movimiento hacia arriba y dos movimientos a la derecha)
  - La primera imagen es ya con el best score asignado a 16.
  - La segunda imagen es despues de apretar la tecla R se muestra que el best score se mantiene en 16 y se muestra un nuevo tablero con sus dos celdas generadas. 
![image](https://github.com/victor-villca/game2048/assets/101211793/c8984466-1933-4f25-91ba-f3fe47808ec0)
![image](https://github.com/victor-villca/game2048/assets/101211793/e227635e-e454-49eb-aed2-c1525f078af7)
- Mensaje de Game Over: Cuando el tablero esta lleno y sin movimientos o fusiones validos, el juego mostrara el mensaje de "Game Over", para poder jugar otra partida es necesario apretar la tecla de reinicio, la letra "R".
![image](https://github.com/victor-villca/game2048/assets/101211793/a438ec0f-dd66-44c2-b5b1-582596819a1a)
![image](https://github.com/victor-villca/game2048/assets/101211793/b8d196d7-5b91-46a8-9ab7-c22626878702)
- Mensaje de "You Win!" y Continuar Juego: Para esto cambiaremos el valor de la ficha a un valor mas pequeño esto lo haremos en la clase Game.hs
![image](https://github.com/victor-villca/game2048/assets/101211793/8219a7e3-100a-4b4d-9bda-178cf6a96225)
  - Ahora corremos el juego y al llegar a ese valor nos aparecera el mensaje "You Win!": Mientras el mensaje sea visible el jugador no podra moverse con las flechas.
![image](https://github.com/victor-villca/game2048/assets/101211793/6deed145-b177-4976-83bd-0e29de297b76)
  - Pero si el jugador quisiera seguir jugando a pesar de ya haber llegado al valor de la celda que hemos definido apretara la tecla "C" y el mensaje ya no se mostrara y podremos seguir jugando hasta perder.
![image](https://github.com/victor-villca/game2048/assets/101211793/ced2d545-60ee-45c2-b01c-2e99e9dcf5c7)
![image](https://github.com/victor-villca/game2048/assets/101211793/361ff5fc-34c5-4ad9-b1ea-a98f9e916dd4)
    - En la primera imagen vemos como desaparece la imagen despues de apretar la tecla "C".
    - En la segunda imagen ya es continuando jugando despues, y como se ve a pesar de que nuestra celda ganadora que es 16, se muestre el tablero se puede seguir jugando.

## [Links](#links)
Las plataformas utilizadas fueron Trello para la creacion, asignacion y organizacion de las tareas del equipo, y Figma para la creacion del mockup utilizado dentro de nuestro proyecto.
- Trello: Fueron creadas user stories para el manejo de las tareas, cada una de estas seguia la estructura de:
  - Nombre de la user story
  - Descripcion de la user story
  - Criterios de Aceptacion
En la mayoria se manejaron comentarios para seguir el proceso de cada una de las tareas.
**Link del Trello:** https://trello.com/b/h46ggQum/game2048
- Figma: Aqui se definio la paleta de colores y el modelo en como se organizaria toda nuestra interfaz de usuario.
**Link del Figma:** https://www.figma.com/file/vbpHz2V6AUdJ0Tr8rULsgG/2048-Game?node-id=0%3A1&mode=dev

## [Créditos](#créditos)
Los miembros del equipo **"A Elegir** se esforzaron para poder crear un proyecto funcional y a gusto de cada usuario, tambien cada uno participo activamente en el proyecto y la revision de codigo para mejorar la calidad del codigo, siguiendo como base el juego original del 2048, y en este punt daremos reconocimiento al trabajo que realizo cada uno de nuestro compañeros:
- Lider Del Equipo: **Anghelo Leonardo Zambrana Quinteros**
  Trabajó como líder del proyecto y estuvo a cargo de la dev lit, así como de la creación, asignación y organización de las tareas del equipo.
  - Las tareas que trabajo en el proyecto como desarollador backend fueron:
    - Fusión de fichas.
    - Verificación de victoria al alcanzar la ficha 2048.
  - Las tareas que trabajo en el proyecto como desarollador frontend fueron:
    - Visualización del puntaje actual en la pantalla durante el juego.
    - Implementación de un apartado de reglas o indicaciones sobre el juego.       
  Link de perfil de github: https://github.com/AngheloZambrana
- Co-lider del equipo: **Victor Villca Silva**
- Trabajo como co-lider y devOps del equipo, fue encargado de la revision de codigo de una mayoria de las tareas y la configuracion & mantenimiento del repositrio.
  - Las tareas que trabajo en el proyecto como desarollador backend fueron:
    - Movimiento de las fichas del juego dentro de la cuadrícula. (Fue trabajada por mas de un miembro)
    - Verificación de movimientos válidos antes de generar una ficha.
    - Funcionalidad de reinicio del juego.
    - Trabajo tambien en la modularizacion del codigo
  Link de perfil de github: https://github.com/victor-villca
- Desarolladora Full Stack: **Deidamia Fuentes Nogales**
- Trabajo en el area de desarollo, trabajo en distintas tareas que se vieron relacionadas tanto en frontend como en backend, tambien tuvo la tarea de revisar codigo.
  - Las tareas que trabajo en el proyecto como desarollador backend fueron:
    - Generación aleatoria de fichas con valores 2 o 4.
    - Asignación de puntuación según combinación de fichas en la partida.
    - Mejor puntuación del juego.
    - Tecla para continuar jugando después de haber ganado.
  - Las tareas que trabajo en el proyecto como desarollador frontend fueron:
    - Visualizacion de mejor puntuación del juego.
  Link de perfil de github: https://github.com/DeidamiaFuentes
- Desarolladora Full Stack: **Mayerli Santander Sejas**
- Trabajo en el area de desarollo, trabajo en distintas tareas que se vieron relacionadas tanto en frontend como en backend, tambien tuvo la tarea de revisar codigo.
  - Las tareas que trabajo en el proyecto como desarollador backend fueron:
    - Verificacion de movimientos validos disponibles para la funcionalidad del Game Over.
    - Movimiento de las fichas del juego dentro de la cuadrícula. (Fue trabajada por mas de un miembro)
  - Las tareas que trabajo en el proyecto como desarollador frontend fueron:
    - Mensaje de "Game Over" al no tener movimientos válidos disponibles.
    - Creacion del Mockup, (Definiendo la paleta de colores para el juego, los tamaños y posiciones de los textos, etc.)
    - Mejora de la interfaz en base al Mockup trabajado.
  Link de perfil de github: https://github.com/MayerliSantander
- Desarollador Backend: **Victor Alejandro Cespedes Cartagena**
- Trabajo en el area de desarollo, trabajo en tareas que se vieron relacionadas a backend principalmente.
  - Las tareas que trabajo en el proyecto como desarollador backend fueron:
    - Creación del tablero al iniciar el juego.
    - Verificación de victoria al alcanzar la ficha 2048 (No completada y fue reasignada)
    - Implementación de un apartado de reglas o indicaciones sobre el juego (No completada y fue reasignada)
  Link de perfil de github: https://github.com/VictorCespedesCC

Este juego fue trabajado con mucho esfuerzo por parte de todos los miembros del equipo, asi mismo esperar la pronta recuperacion de nuestro desarollador Victor Alejandro Cespedes Cartagena que tuvo problemas de salud en el proceso de desarollo, esperemos su recuperacion y un agradecimiento enorme a todos los miembros del equipo por su activa participacion en el proyecto, esperemos que sea de su agrado.
