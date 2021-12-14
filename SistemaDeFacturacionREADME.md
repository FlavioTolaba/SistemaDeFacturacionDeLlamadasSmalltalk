# Sistema De Facturacion De Llamadas Smalltalk
Un sistema de facturacion de llamadas

El sistema esta hecho con conceptos importantes de POO como lo son Polimorfismo, Herencia, patrones y TDD

## como se hizo 
 
 
*Antes de empezar a escribir codigo se realizo un diagrama UML

*Se asume que el sistema realiza llamadas desde Buenos Aires

*hay un usuario que realiza las llamadas

*se utilizo patron State para elegir el costo por minuto de llamadas locales, segun si es dia habil diurno, nocturno o fin de semana

*el ultimo test imprime una factura en un archito llamado "FacturaUsuario" con el nombre del usuario, la factura correspondiente al periodo dado, las llamadas que realizo y el costoTotal a cobrar.

*las horas son solo numeros del 0 al 24

*el codigo esta hecho en CuisUniversity Smalltalk

*al momento de imprimir la factura, imprime el nombre del dia y no la fecha como tal. Se debe modificar para que muestre la fecha.

*otro detalle, YO asumo que en el sistema solo hay un usuario ya que al final quiero imprimir la factura de ese usuario, si bien no contemple que hubiera mas usuarios, por el momento no me parecio necesario ya que solo queria saber como es una factura y me bastaba con saber el del primer usuario del sistema, que fue el que realizo llamadas para el Test
