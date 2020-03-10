# CIU-4-SistemaPlanetario-nave

### Autor: Víctor Herrera Delgado
Estudiante de Ingeniería Informática en la Universidad de Las Palmas de Gran Canaria, en último curso de su grado.



## Introducción 

Este programa consiste en una representación de un sistema planetario, en este caso, uno basado en el sistema solar pero con libertad del autor para cambiar nombres, astros, texturas y demás características de estos. Esto realizado en la práctica anterior se combinará con una segunda vista con la cual el usuario podrá manejar una pequeña nave y ver su entorno en tercera persona.

## Programa
El sistema cuenta con una estrella principal (sun) que se muestra en el centro de la pantalla, rodeada por cinco planetas que giran alrededor suyo (Earth, Prometheus, Watzan, Dust II y Chained planet). Estos planetas presentan distintos tamaños además de que se mueven y rotan sobre si mismos a distintas velocidades (incluso en distintas direcciones en algunos casos). 
Dos de los planetas (Earth y Chained planet) presentan también astros girando alrededor de cada uno también con distintas velocidades.

Se muestra el nombre de cada uno de los planetas siempre al usuario, aunque en el caso de los astros, debido a su movimiento sus nombres solo podrán ser vistos en algunos casos.
Cabe destacar por último que se le ha aplicado una textura a cada cuerpo que forma el sistema planetario

Al pasar a la segunda vista, el usuario pasará a controlar la nave de distintas formas: podrá rotar la nave horizontalmente consiguiendo rotar la vista también, así como mover el punto de mira arriba o abajo, ambas acciones con las flechas de control. Usando la tecla espacio la nave se moverá a donde apunte la vista (por ejemplo, viendo la nave desde arriba hacia abajo, la nave empezará a bajar hacia la dirección apuntada). La vista desde la nave puede ser viendo la nave desde lejos o en primera persona (usando una esfera como punto de mira).

Desde la vista original se podrá observar la nave en su última posición en el sistema. 

En caso de no querer verla en la pantalla o querer volver a la posición inicial podrá resetear su posición y vista.

## Decisiones tomadas
Se ha decidido implementar el reseteo de la nave en vez de ponerle límites al usuario para darle total control al usuario pudiendo volver en caso de tener problemas.
La vista de la nave en cuanto a su movimiento vertical se ha definido sin implementar rotación sobre ella manteniendo un estilo de propulsión en vertical por parte de la nave para facilitar su movimiento.

## Controles
- **Enter** : Cambia la vista entre general y nave.
- **Flechas** de control : Rotan la nave horizontalmente o cambian el punto de mira verticalmente.
- **Espacio** : Mueve la nave hacia el punto de mira.
- **Tecla R** : Resetea la posición y vista de la nave.
- **Tecla P** : CAmbiar vista de la nave entre primera persona y una aproximación a tercera persona.

## Resumen del código
El código consiste en dos archivos:

- El archivo **Practica4**, que es el principal y por lo tanto encargado de crear, cargar e inicializar los componentes necesarios para el funcionamiento del programa (crear planetas, cargar imágenes, etc.) así como de mandar a dibujar el sistema planetario en pantalla. También se encarga de la posición de la nave y su respectivo movimiento, así como de plasmarlo en la vista.
Teniendo el punto de mira y el punto de posición de la vista, el programa se encarga de calcular el vector dirección para los movimientos hacia adelante de la nave. Para la rotación, en el caso de la vista vertical simplemente se cambian los valores de la Y mientras que para la rotación horizontal, se hace uso de una rotación de un punto alrededor del eje y basándonos en lo utilizado en la [práctica 2](https://github.com/VictorHerreraDelgado/CIU-2-Generador3D)
- El archivo **Planet**, que es la representación de un cuerpo en el sistema solar (planeta ,astro o estrella). Este no solo inicializará sus características y se podrá dibujar a sí mismo a partir de estas, sino que además guardará una lista con los cuerpos que giran alrededor suya para que se dibujen cuando lo manden a dibujarse a si mismo.
Por lo tanto, al dibujarse solo se llama al método de dibujo de la estrella y los demás cuerpos se dibujarán derivando de este.

## Funcionamiento
El gif no muestra el verdadero rendimiento de la aplicación. El video ha sido grabado con el capturador de Windows.
![](Practica4.gif)

## Herramientas

Conversor de video a gif:

https://hnet.com/video-to-gif/


Páginas de las que se han obtenido las texturas:

https://www.pinterest.es/pin/423971752420031073/   
https://www.flickr.com/photos/42084302@N05/3884071286   
https://giovannaimperia.com/textures/chains.html     
https://svs.gsfc.nasa.gov/4720  
http://www.textures4photoshop.com/tex/clouds-and-sky/sun-texture-seamless.aspx
http://www.textures4photoshop.com/tex/fire-and-smoke/smoke-texture-free-download.aspx
http://www.textures4photoshop.com/tex/paper/grunge-stained-old-paper-texture.aspx
https://freestocktextures.com/photos-universe/

Página de donde se obtuvo la forma de la nave:
https://free3d.com/3d-model/quarren-coyote-ship-star-trek-voyager-118597.html

Tutorial para cargar objetos en Processing:
https://medium.com/@behreajj/3d-models-in-processing-7d968a7cede5
