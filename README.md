[![Pulque](ui/img/maguey.png)](http://www.tuzoftware.com/)

Conjunto de Componentes ACL, twig natural templating engine, Modular basado en MVC y otros componentes para usar 
en F3 Fat Free Framework PHP micro-framework.

# Instrucciones

Crear una base de datos llamada pulque

Ejecutar el script pulquedb.sql como root en mysql

Copiar la carpeta al www o a htdocs de wamp o xammp

Dar permisos 777 al archivo folio.log 

Dar permisos 777 a la carpeta tmp

Version minima de php 5.4

Usuario para entrar admin contrasenia password

# Documentaci&oacute;n

El link
<a href="http://www.tuzoftware.com/pulque-documentacion">Documentaci&oacute;n</a>,
o visitar las siguientes urls ,http://www.tuzoftware.com/pulque-documentacion, 
http://www.tuzoftware.com/#pulque.

# Pasos para Eliminar los test

El framework tiene un modulo de test para mostrar como funcionan los componentes,
se recomienda eliminar este modulo una vez concluido o empezado el desarrollo.
A continuación se listan los pasos :

- [ ] Eliminar la carpeta test que se encuentra en la ruta de app/test
- [ ] Eliminar la clase TestRepository que se encuentra en la ruta/app/repository
- [ ] Eliminar ls carpeta test que se encuentra dentro ui/modulos
- [ ] Eliminar las rutas de test que se encuentran en el index.php
- [ ] Método redireccionar Rol en AutenticacionController

Version 1.68