!classDefinition: #SistemaDeFacturacionDeLlamadasTest category: 'SistemaFacturacionDeLlamadas'!
TestCase subclass: #SistemaDeFacturacionDeLlamadasTest
	instanceVariableNames: 'quilmes rusia tucuman usuario1 planTelefonico sistemaDeLlamadas usuario2 bernal archivoVacio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 02:13:40'!
setUp
	"Se asume que este sistema de llamadas el usuario realizar llamadas desde Buenos Aires"
	 
	"ubicaciones"
	quilmes _ LocalidadArg nombre: 'Quilmes' costoPorMinuto: 0. "si bien es 0, hice que esta clase tambien sepa este metodo ya que a futuro podemos usarlo y aprovechas el polimorfismo"
	bernal _ LocalidadArg  nombre: 'Bernal' costoPorMinuto:0. "es 0 porque ya el enunciado aclara que las llamadas locales tienen un costo por minuto variado segun el dia y banda horaria dada"
	rusia _ PaisExtranjero nombre: 'Rusia' costoPorMinuto: 5 "pesos".
	tucuman _ Provincia nombre: 'Tucuman' costoPorMinuto: 0.45 "pesos".
	
	"plan telefonico"
	planTelefonico _ PlanTelefonico mensualBase: 1000 "pesos".
	
	"usuarios"
	usuario1 _ Usuario conNombre: 'Leandro' conPlanTelefonico: planTelefonico .
	usuario2 _ Usuario conNombre: 'Agustin' conPlanTelefonico: planTelefonico .
	"sistema de llamadas"
	sistemaDeLlamadas _ SistemaDeLlamadas new.
	
	"-----------.-------------------"
	sistemaDeLlamadas registrarUsuario: usuario1.
	"sistemaDeLlamadas registrarUsuario: usuario2. "
	
	"archivo a imprimir factura"
	
	archivoVacio _ Archivo new.
	! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/12/2021 15:02:46'!
test001_SistemaDeLlamadasNoTieneUsuarios

	| unSistemaDeLlamadas |
	unSistemaDeLlamadas _ SistemaDeLlamadas new.	
			
    	Assert  that: unSistemaDeLlamadas cantidadDeUsuarios isEqualTo: 0 ! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/13/2021 15:24:04'!
test002_SistemaDeLlamadasTieneUnUsuarioNuevo

	
			
    	Assert  that: sistemaDeLlamadas cantidadDeUsuarios isEqualTo: 1. ! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/13/2021 15:26:36'!
test003_UnUsuarioSinLlamadasRealizadas


		
    	Assert  that: sistemaDeLlamadas cantidadDeUsuarios isEqualTo: 1. 
	Assert  that: ((usuario1 planTelefonico)facturas)size isEqualTo: 0  ! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/13/2021 15:29:25'!
test004_UnUsuarioRealizaUnaLlamada

	
	usuario1 llamadaAUbicacion: rusia deDuracion: 5 "minutos"  conFecha: ('10/10/2021') asDate  aLas: 15 "horas". 
	
    	Assert  that: sistemaDeLlamadas cantidadDeUsuarios isEqualTo: 1. 
	Assert  that: (usuario1 planTelefonico) cantidadDeLlamadasRealizadas  isEqualTo: 1 ! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/13/2021 15:30:30'!
test005_ProvinciaConNombreTucumanYcostoPorMinutoDe45Centavos

	
	
	Assert that: tucuman nombreUbicacion isEqualTo: 'Tucuman' .
	Assert that: tucuman costoPorMinuto isEqualTo: 0.45.! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 00:41:19'!
test006_UnUsuarioRealizaUnaLlamadaLocalYSuConsumoTotalEsDe1000_5Pesos

	
	| consumoTotal |
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('22/09/2021' asDate) aLas: 22 "horas". "la fecha corresponde al miercoles  22 de septiembre del 2021"
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('22/09/2021' asDate)monthName )asString) año: (('22/09/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1000.5 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 02:12:53'!
test007_UnUsuarioRealizaUnaLlamadaInternacional

	| consumoTotal |
	

	usuario1 llamadaAUbicacion: rusia deDuracion: 5 conFecha: ('22/09/2021' asDate) aLas: 22 "horas"."la fecha corresponde al miercoles  22 de septiembre del 2021"
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('22/09/2021' asDate)monthName )asString) año: (('22/09/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1025 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 02:12:47'!
test008_UnUsuarioRealizaUnaLlamadaProvincialYSuConsumoTotalDelMesEsDe2002_25Pesos

	| consumoTotal |
	
	usuario1 llamadaAUbicacion: tucuman deDuracion: 5 conFecha: ('22/09/2021' asDate) aLas: 22 "horas". "la fecha corresponde al miercoles  22 de septiembre del 2021"
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('22/09/2021' asDate)monthName )asString) año: (('22/09/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1002.25 "pesos"! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 02:12:39'!
test009_UnUsuarioRealizaUnaLlamadaProvincial_InternacionalYLocal

	|  consumoTotal |
	
	usuario1 llamadaAUbicacion: tucuman deDuracion: 5 conFecha: ('22/09/2021' asDate) aLas: 22 "horas".
	usuario1 llamadaAUbicacion: rusia deDuracion: 5 conFecha: ('21/09/2021' asDate) aLas: 13 "horas".
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('23/09/2021' asDate) aLas: 15 "horas".
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('25/09/2021' asDate)monthName )asString) año: (('25/09/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1028.25 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 02:12:21'!
test010_UnUsuarioRealizaUnaLlamadaLocalEnDiaHabilNocturno

	|  consumoTotal |
	
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('23/09/2021' asDate) aLas: 22 "horas".
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('22/09/2021' asDate)monthName )asString) año: (('22/09/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1000.5 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 02:12:07'!
test011_UnUsuarioRealizaUnaLlamadaLocalEnDiaHabilDiurno

	|  consumoTotal |
	
	
	"usuario planTelefonico: planTelefonico. "
	
	
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('23/09/2021' asDate) aLas: 15 "horas".
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('25/09/2021' asDate)monthName )asString) año: (('25/09/2021' asDate) yearNumber).
	  
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1001.0 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 02:11:47'!
test012_UnUsuarioRealizaUnaLlamadaLocalUnFinDeSemana

	|  consumoTotal |
	
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('19/12/2021' asDate) aLas: 15 "horas".
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('25/12/2021' asDate)monthName )asString) año: (('25/12/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1000.5 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 00:54:57'!
test013_UnUsuarioRealizaDosLlamadasLocales

	|  consumoTotal |
	
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('19/12/2021' asDate) aLas: 15 "horas". "la fecha dada corresponde al domingo 19 de diciembre de 2021"
	usuario1 llamadaAUbicacion: bernal deDuracion: 5 conFecha: ('21/12/2021' asDate) aLas: 15 "horas". "la fecha dada corresponde al martes 21 de diciembre de 2021"
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('12/12/2021' asDate)monthName )asString) año: (('12/12/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1001.5 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 03:30:57'!
test014_UnUsuarioRealizaUnaLlamadaLocalUnDiaHabilFueraDelHorarioDe20Centavos

	|  consumoTotal |
	
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('21/12/2021' asDate) aLas: 7 "horas".
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('25/12/2021' asDate)monthName )asString) año: (('25/12/2021' asDate) yearNumber).
	Assert  that: ((usuario1 planTelefonico) facturas)size isEqualTo: 1.
	Assert  that: consumoTotal isEqualTo: 1000.5 "pesos".! !

!SistemaDeFacturacionDeLlamadasTest methodsFor: 'as yet unclassified' stamp: 'FT 12/14/2021 03:35:51'!
test015_imprimirFacturaDeUsuarioQueRealizoDosLlamadasLocalesEnArchivoDeTexto

	|  consumoTotal |
	
	usuario1 llamadaAUbicacion: quilmes deDuracion: 5 conFecha: ('19/12/2021' asDate) aLas: 15 "horas". "la fecha dada corresponde al domingo 19 de diciembre de 2021"
	usuario1 llamadaAUbicacion: bernal deDuracion: 5 conFecha: ('21/12/2021' asDate) aLas: 15 "horas". "la fecha dada corresponde al martes 21 de diciembre de 2021"
	  consumoTotal _ (usuario1 planTelefonico) calcularConsumoPeriodoMes:  ((('12/12/2021' asDate)monthName )asString) año: (('12/12/2021' asDate) yearNumber).
	"Se imprime la factura correspondiente del usuario"
	archivoVacio _ 'FacturaUsuario.txt' asFileEntry.
	sistemaDeLlamadas  consumoTotal: consumoTotal imprimirFactura: archivoVacio .
	
	Assert that: (sistemaDeLlamadas facturaDeUsuarioCon: consumoTotal) isEqualTo: archivoVacio fileContents ! !


!classDefinition: #Archivo category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #Archivo
	instanceVariableNames: 'contenido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!Archivo methodsFor: 'accessing' stamp: 'FT 12/14/2021 01:12:57'!
fileContents

	^ contenido contents.! !


!Archivo methodsFor: 'initialization' stamp: 'FT 12/14/2021 01:11:06'!
initialize

	contenido _ ReadWriteStream on: ''.! !


!Archivo methodsFor: 'acciones' stamp: 'FT 12/14/2021 01:15:41'!
forceWriteStreamDo: aBlockClosure 
	aBlockClosure  value: contenido .! !


!classDefinition: #Factura category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #Factura
	instanceVariableNames: 'unMesDeFactura unAñoDeFactura unPlanTelefonicoDeFactura llamadasDeFactura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!Factura methodsFor: 'initialize' stamp: 'FT 12/13/2021 11:13:31'!
initializeMesFactura: mes añoFactura: año planTelefonico: planTelefonico 
	
	unMesDeFactura := mes.
	unAñoDeFactura := año.
	unPlanTelefonicoDeFactura := planTelefonico.
	llamadasDeFactura := OrderedCollection  new.! !


!Factura methodsFor: 'acciones' stamp: 'FT 12/13/2021 11:13:08'!
agregarLlamadaAFactura: unaLlamada
 
	llamadasDeFactura add: unaLlamada.! !

!Factura methodsFor: 'acciones' stamp: 'FT 12/13/2021 15:39:01'!
calcularConsumoMensual
	
	^ llamadasDeFactura sum: [:llamada| llamada calcularCosto ] ifEmpty: 0  ! !

!Factura methodsFor: 'acciones' stamp: 'FT 12/13/2021 15:40:21'!
calcularConsumoMensualMasMensualFijo
	
	
	^ (self calcularConsumoMensual) + ((self planTelefonico)mensualBase )! !


!Factura methodsFor: 'accessing' stamp: 'FT 12/13/2021 11:21:31'!
añoFactura

	^unAñoDeFactura ! !

!Factura methodsFor: 'accessing' stamp: 'FT 12/13/2021 11:21:20'!
mesFactura

	^unMesDeFactura ! !

!Factura methodsFor: 'accessing' stamp: 'FT 12/13/2021 12:40:17'!
planTelefonico
	^ unPlanTelefonicoDeFactura ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Factura class' category: 'SistemaFacturacionDeLlamadas'!
Factura class
	instanceVariableNames: ''!

!Factura class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 11:10:53'!
mesFactura: unMes añoFactura: unAño planTelefonico: unPlanTelefonico 
	
	^self new initializeMesFactura: unMes añoFactura: unAño planTelefonico: unPlanTelefonico ! !


!classDefinition: #Llamada category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #Llamada
	instanceVariableNames: 'duracionEnMinutosLlamada unDiaLlamada unMesLlamada unAñoDeLlamada unaUbicacion unaHoraDeLlamada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!Llamada methodsFor: 'initialize' stamp: 'FT 12/13/2021 17:52:48'!
initializeConDuracionDe: unaDuracionEnMinutos elDia: unDia conMes: unMes año: unAño conDestino: unPaisExtranjero yHora: unaHora 
	
	duracionEnMinutosLlamada := unaDuracionEnMinutos.
	unDiaLlamada := unDia.
	unMesLlamada := unMes.
	unAñoDeLlamada := unAño.
	unaUbicacion := unPaisExtranjero.
	unaHoraDeLlamada := unaHora.! !


!Llamada methodsFor: 'accessing' stamp: 'FT 12/13/2021 17:53:48'!
año
	^ unAñoDeLlamada ! !

!Llamada methodsFor: 'accessing' stamp: 'FT 12/14/2021 01:32:52'!
dia
	^unDiaLlamada ! !

!Llamada methodsFor: 'accessing' stamp: 'FT 12/14/2021 01:33:13'!
duracionDeLlamada
	^ duracionEnMinutosLlamada ! !

!Llamada methodsFor: 'accessing' stamp: 'FT 12/13/2021 17:53:58'!
mes
	^ unMesLlamada ! !

!Llamada methodsFor: 'accessing' stamp: 'FT 12/14/2021 01:47:02'!
ubicacionLlamada
	^ unaUbicacion ! !


!Llamada methodsFor: 'acciones' stamp: 'FT 12/13/2021 12:33:52'!
calcularCosto

	self subclassResponsibility .! !

!Llamada methodsFor: 'acciones' stamp: 'FT 12/14/2021 01:47:52'!
imprimirDatosDeLlamada: unStream 
	(self dia) printOn: unStream.
	unStream space.
	(self mes) printOn: unStream .
	unStream space.
	(self año) printOn: unStream.
	unStream space.
	unStream nextPutAll: ('conDuracionDe:').
	(self duracionDeLlamada) printOn: unStream.
	unStream space.
	unStream nextPutAll: ('a:').
	((self ubicacionLlamada) nombreUbicacion )printOn: unStream.
	unStream newLine .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Llamada class' category: 'SistemaFacturacionDeLlamadas'!
Llamada class
	instanceVariableNames: ''!

!Llamada class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 17:20:51'!
conDuracionDe: unaDuracionEnMinutos elDia: unNombre conMes: unMes año: unAño conDestino: unaUbicacion yHora: unaHora 
	
	^self new initializeConDuracionDe: unaDuracionEnMinutos elDia: unNombre conMes: unMes año: unAño conDestino: unaUbicacion yHora: unaHora ! !


!classDefinition: #LlamadaInternacional category: 'SistemaFacturacionDeLlamadas'!
Llamada subclass: #LlamadaInternacional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!LlamadaInternacional methodsFor: 'acciones' stamp: 'FT 12/13/2021 17:53:09'!
calcularCosto
	^ duracionEnMinutosLlamada * (unaUbicacion costoPorMinuto )! !


!classDefinition: #LlamadaNacional category: 'SistemaFacturacionDeLlamadas'!
Llamada subclass: #LlamadaNacional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!LlamadaNacional methodsFor: 'acciones' stamp: 'FT 12/13/2021 17:58:00'!
calcularCosto
	^ duracionEnMinutosLlamada * (unaUbicacion costoPorMinuto )! !


!classDefinition: #LlamadaLocal category: 'SistemaFacturacionDeLlamadas'!
LlamadaNacional subclass: #LlamadaLocal
	instanceVariableNames: 'unDia unMes unAño unaHora unperiodoDeLlamada costoSegunPeriodoDeLlamada nombre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!LlamadaLocal methodsFor: 'acciones' stamp: 'FT 12/14/2021 00:58:31'!
calcularCosto
		|periodoDeLlamada|
		periodoDeLlamada _ PeriodoDeLlamada conDia: unDiaLlamada yHora: unaHoraDeLlamada .
	^ duracionEnMinutosLlamada  * ((periodoDeLlamada costoSegunPeriodoCorrespondiente ) costoPorMinuto). ! !


!classDefinition: #PeriodoDeLlamada category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #PeriodoDeLlamada
	instanceVariableNames: 'diaPeriodoDeLlamada horaPeriodoDeLlamada diasHabiles diasNoHabiles'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!PeriodoDeLlamada methodsFor: 'accessing' stamp: 'FT 12/13/2021 13:32:16'!
costoPorMinuto

	self subclassResponsibility.! !

!PeriodoDeLlamada methodsFor: 'accessing' stamp: 'FT 12/14/2021 03:23:44'!
costoSegunPeriodoCorrespondiente
	|periodoCorrespondiente|
	(((self diasHabiles includes: self diaDePeriodoDeLlamada ) & (self horaPeriodoDeLlamada between: 8 and: 20))) ifTrue: [periodoCorrespondiente _ DiaHabilDiurno new].
	(((self diasHabiles includes: self diaDePeriodoDeLlamada) &(self horaPeriodoDeLlamada between: 0 and:7 ) | (self horaPeriodoDeLlamada between: 21 and: 24))) ifTrue: [periodoCorrespondiente _ DiaHabilNocturno new].
	(((self diasNoHabiles includes: self diaDePeriodoDeLlamada)&(self horaPeriodoDeLlamada between:0 and:24))) ifTrue: [periodoCorrespondiente _ FinDeSemana new].
	
	^ periodoCorrespondiente ! !

!PeriodoDeLlamada methodsFor: 'accessing' stamp: 'FT 12/13/2021 18:10:16'!
diaDePeriodoDeLlamada

	^diaPeriodoDeLlamada ! !

!PeriodoDeLlamada methodsFor: 'accessing' stamp: 'FT 12/14/2021 00:23:53'!
diasHabiles
	^ diasHabiles .! !

!PeriodoDeLlamada methodsFor: 'accessing' stamp: 'FT 12/14/2021 00:23:59'!
diasNoHabiles
	^ diasNoHabiles .! !

!PeriodoDeLlamada methodsFor: 'accessing' stamp: 'FT 12/13/2021 18:10:29'!
horaPeriodoDeLlamada

	^horaPeriodoDeLlamada ! !


!PeriodoDeLlamada methodsFor: 'initialize' stamp: 'FT 12/14/2021 00:23:44'!
initializeConDia: unDia yHora: unaHora 

	diaPeriodoDeLlamada := unDia.
	horaPeriodoDeLlamada := unaHora.
	diasHabiles := #('Monday','Tuesday','Wednesday','Thursday','Friday').
	diasNoHabiles := #('Saturday','Sunday')! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PeriodoDeLlamada class' category: 'SistemaFacturacionDeLlamadas'!
PeriodoDeLlamada class
	instanceVariableNames: ''!


!PeriodoDeLlamada class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 18:04:44'!
conDia: unDia yHora: unaHora 
	
	
	^self new initializeConDia: unDia yHora: unaHora ! !


!PeriodoDeLlamada class methodsFor: 'accessing' stamp: 'FT 12/14/2021 00:22:32'!
diasHabiles
	^ #('Monday','Tuesday','Wednesday','Thursday','Friday').! !


!classDefinition: #DiaHabilDiurno category: 'SistemaFacturacionDeLlamadas'!
PeriodoDeLlamada subclass: #DiaHabilDiurno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!DiaHabilDiurno methodsFor: 'accessing' stamp: 'FT 12/13/2021 10:33:22'!
costoPorMinuto

	^0.20! !


!classDefinition: #DiaHabilNocturno category: 'SistemaFacturacionDeLlamadas'!
PeriodoDeLlamada subclass: #DiaHabilNocturno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!DiaHabilNocturno methodsFor: 'accessing' stamp: 'FT 12/13/2021 10:33:42'!
costoPorMinuto

	^ 0.10! !


!classDefinition: #FinDeSemana category: 'SistemaFacturacionDeLlamadas'!
PeriodoDeLlamada subclass: #FinDeSemana
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!FinDeSemana methodsFor: 'accessing' stamp: 'FT 12/13/2021 10:33:52'!
costoPorMinuto

	^0.10! !


!classDefinition: #PlanTelefonico category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #PlanTelefonico
	instanceVariableNames: 'unCostoMensualBase_CHANGE_ME unCostoMensualBase llamadasRealizadas facturas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!PlanTelefonico methodsFor: 'initialize' stamp: 'FT 12/13/2021 11:01:06'!
initializeMensualBase: unCostoMensualBaseFijo 
	
	unCostoMensualBase := unCostoMensualBaseFijo.
	llamadasRealizadas  := OrderedCollection new.
	facturas := OrderedCollection new.! !


!PlanTelefonico methodsFor: 'acciones' stamp: 'FT 12/14/2021 00:20:31'!
agregarLlamada: unaLlamada 
		|factura|
	llamadasRealizadas add: unaLlamada .
	
	factura _ self facturas detect: [:x | x mesFactura = unaLlamada mes & x añoFactura = unaLlamada año] ifNone:[factura _ Factura mesFactura: unaLlamada mes añoFactura: unaLlamada año planTelefonico: self] .
	(self facturas includes: factura) ifFalse: [self facturas add: factura] . "si la factura no existe en facturas la agrega, caso contrario no lo hace, quiere decir que la factura ya se encuentra en facturas"
	factura agregarLlamadaAFactura: unaLlamada.! !

!PlanTelefonico methodsFor: 'acciones' stamp: 'FT 12/14/2021 00:18:55'!
calcularConsumoPeriodoMes: mes año: año

	|factura|
	"con esto verifico si la factura que busco por el mes y año dado existe o no"
	factura _ self facturas detect: [:unaFactura | unaFactura mesFactura = mes & unaFactura añoFactura = año] ifNone:[Error signal: 'No existe el periodo solicitado' ].
	
	^factura calcularConsumoMensualMasMensualFijo.
	 
	
	! !


!PlanTelefonico methodsFor: 'accessing' stamp: 'FT 12/14/2021 01:25:16'!
LlamadasRealizadas
	^ llamadasRealizadas ! !

!PlanTelefonico methodsFor: 'accessing' stamp: 'FT 12/13/2021 15:29:41'!
cantidadDeLlamadasRealizadas
	^ llamadasRealizadas size! !

!PlanTelefonico methodsFor: 'accessing' stamp: 'FT 12/13/2021 11:00:25'!
facturas
	^ facturas! !

!PlanTelefonico methodsFor: 'accessing' stamp: 'FT 12/13/2021 12:40:42'!
mensualBase
	^ unCostoMensualBase ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlanTelefonico class' category: 'SistemaFacturacionDeLlamadas'!
PlanTelefonico class
	instanceVariableNames: ''!

!PlanTelefonico class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 08:19:26'!
mensualBase: unCostoMensualBase 
	
	
	^self new initializeMensualBase: unCostoMensualBase ! !


!classDefinition: #SistemaDeLlamadas category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #SistemaDeLlamadas
	instanceVariableNames: 'usuariosDelSistema bonoMensualFijo totalFacturado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!SistemaDeLlamadas methodsFor: 'Accesing' stamp: 'FT 12/12/2021 15:09:28'!
cantidadDeUsuarios
	^ usuariosDelSistema size.! !

!SistemaDeLlamadas methodsFor: 'Accesing' stamp: 'FT 12/14/2021 02:09:11'!
facturaDeUsuarioCon: unConsumoTotal 
	
	|facturaDeUsuario|
	
	facturaDeUsuario  _ String streamContents: [:unStream | 
	unStream nextPutAll: ('*******************').
	unStream newLine.
	unStream nextPutAll: ('Factura de Llamadas').
	unStream newLine.
	unStream nextPutAll: ('de:').
	unStream space.
	(((self usuarios)first) nombreUsuario) printOn: unStream.
	unStream  newLine .
	unStream nextPutAll: ('*******************').
	unStream newLine.
	(((self usuarios) first)planTelefonico) LlamadasRealizadas do: [:llamada | llamada imprimirDatosDeLlamada:               unStream].
	unStream  newLine .
	unStream nextPutAll: ('*******************').
	unStream newLine.
	unStream nextPutAll: ('facturacionTotal:').
	unStream space.
	unConsumoTotal  printOn: unStream.
	unStream space.
	unStream nextPutAll: ('pesos').
	
	
	
	
	].
   ^facturaDeUsuario ! !

!SistemaDeLlamadas methodsFor: 'Accesing' stamp: 'FT 12/14/2021 01:19:59'!
usuarios
	^ usuariosDelSistema ! !


!SistemaDeLlamadas methodsFor: 'initialize' stamp: 'FT 12/13/2021 16:33:35'!
initialize

   
   usuariosDelSistema _ OrderedCollection new.
   ! !


!SistemaDeLlamadas methodsFor: 'acciones' stamp: 'FT 12/14/2021 02:02:11'!
consumoTotal: unConsumoTotal imprimirFactura: unArchivo 
	unArchivo forceWriteStreamDo: [:fileStream | fileStream nextPutAll: (self facturaDeUsuarioCon:unConsumoTotal )]..! !

!SistemaDeLlamadas methodsFor: 'acciones' stamp: 'FT 12/12/2021 15:07:42'!
registrarUsuario: unUsuario 
	usuariosDelSistema add: unUsuario .! !


!classDefinition: #Ubicacion category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #Ubicacion
	instanceVariableNames: 'conNombre conUnCostoPorMinuto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!Ubicacion methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 07:58:11'!
esLocalidad

	^self subclassResponsibility ! !

!Ubicacion methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 07:58:28'!
esPaisExtranjero

	^self subclassResponsibility ! !

!Ubicacion methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 07:58:19'!
esProvincia

	^self subclassResponsibility ! !


!Ubicacion methodsFor: 'accessing' stamp: 'FT 12/13/2021 12:37:31'!
costoPorMinuto

	self subclassResponsibility .! !

!Ubicacion methodsFor: 'accessing' stamp: 'FT 12/13/2021 19:05:23'!
nombreUbicacion

	^conNombre 
	! !


!Ubicacion methodsFor: 'initialization' stamp: 'FT 12/13/2021 18:56:48'!
initializeNombre: unNombre costoPorMinuto: costoPorMinutoLlamada 
	
	conNombre := unNombre.
	conUnCostoPorMinuto := costoPorMinutoLlamada.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ubicacion class' category: 'SistemaFacturacionDeLlamadas'!
Ubicacion class
	instanceVariableNames: 'nombre'!

!Ubicacion class methodsFor: 'accessing' stamp: 'FT 12/13/2021 08:08:46'!
nombreUbicacion
	^nombre! !


!Ubicacion class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 18:55:57'!
nombre: unNombre costoPorMinuto: costoPorMinutoLlamada 
	
	
	^self new initializeNombre: unNombre costoPorMinuto: costoPorMinutoLlamada ! !


!classDefinition: #LocalidadArg category: 'SistemaFacturacionDeLlamadas'!
Ubicacion subclass: #LocalidadArg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!LocalidadArg methodsFor: 'boolean' stamp: 'FT 12/13/2021 07:59:27'!
esLocalidad
	^true! !

!LocalidadArg methodsFor: 'boolean' stamp: 'FT 12/13/2021 07:59:02'!
esPaisExtranjero
	^false! !

!LocalidadArg methodsFor: 'boolean' stamp: 'FT 12/13/2021 07:59:36'!
esProvincia
	^false! !


!classDefinition: #PaisExtranjero category: 'SistemaFacturacionDeLlamadas'!
Ubicacion subclass: #PaisExtranjero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!PaisExtranjero methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 07:59:50'!
esLocalidad

	^false! !

!PaisExtranjero methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 08:00:14'!
esPaisExtranjero

	^true! !

!PaisExtranjero methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 08:00:01'!
esProvincia

	^false! !


!PaisExtranjero methodsFor: 'accessing' stamp: 'FT 12/13/2021 19:07:55'!
costoPorMinuto

	^conUnCostoPorMinuto ! !


!classDefinition: #Provincia category: 'SistemaFacturacionDeLlamadas'!
Ubicacion subclass: #Provincia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!Provincia methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 08:00:47'!
esLocalidad

	^false! !

!Provincia methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 08:01:04'!
esPaisExtranjero

	^false! !

!Provincia methodsFor: 'Booleanos' stamp: 'FT 12/13/2021 08:00:54'!
esProvincia

	^true! !


!Provincia methodsFor: 'accessing' stamp: 'FT 12/13/2021 19:06:01'!
costoPorMinuto
	
	^conUnCostoPorMinuto ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Provincia class' category: 'SistemaFacturacionDeLlamadas'!
Provincia class
	instanceVariableNames: ''!


!Provincia class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 08:13:36'!
nombre: unNombre costoPorMinuto: unPrecio 
	
	
	^self new initializeNombre: unNombre costoPorMinuto: unPrecio ! !


!classDefinition: #Usuario category: 'SistemaFacturacionDeLlamadas'!
Object subclass: #Usuario
	instanceVariableNames: 'unPlanDeUsuario nombreUsuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SistemaFacturacionDeLlamadas'!

!Usuario methodsFor: 'initiailize' stamp: 'FT 12/13/2021 16:10:26'!
initializeConNombre: unNombre conPlanTelefonico: planTelefonico 
	
	nombreUsuario := unNombre.
	unPlanDeUsuario := planTelefonico.! !


!Usuario methodsFor: 'acciones' stamp: 'FT 12/14/2021 03:35:00'!
llamadaAUbicacion: unaUbicacion deDuracion: unaDuracionEnMinutos conFecha: unaFecha aLas: unaHora  "Se asume que unaHora es un valor de 0 a 24" 
	|llamada |
	
	unaUbicacion esLocalidad ifTrue:
		 [ llamada _ LlamadaLocal conDuracionDe: unaDuracionEnMinutos elDia:((unaFecha dayOfWeekName)asString) conMes:((unaFecha monthName)asString) año: (unaFecha yearNumber) conDestino: unaUbicacion yHora: unaHora].
		
	
	
	unaUbicacion esProvincia  ifTrue: [llamada _ LlamadaNacional conDuracionDe: unaDuracionEnMinutos elDia:((unaFecha dayOfWeekName)asString) conMes:((unaFecha monthName)asString) año: (unaFecha yearNumber) conDestino: unaUbicacion yHora: unaHora].
	
	
	unaUbicacion esPaisExtranjero ifTrue: [llamada _ LlamadaInternacional conDuracionDe: unaDuracionEnMinutos elDia:((unaFecha dayOfWeekName)asString) conMes:((unaFecha monthName)asString) año: (unaFecha yearNumber) conDestino: unaUbicacion yHora: unaHora].
	
	
	self planTelefonico agregarLlamada: llamada.
	
	
	! !


!Usuario methodsFor: 'accessing' stamp: 'FT 12/14/2021 01:22:05'!
nombreUsuario
	
	^nombreUsuario! !

!Usuario methodsFor: 'accessing' stamp: 'FT 12/13/2021 08:43:16'!
planTelefonico

	^unPlanDeUsuario ! !

!Usuario methodsFor: 'accessing' stamp: 'FT 12/13/2021 11:23:39'!
planTelefonico: unPlanTelefonico 
	
	unPlanDeUsuario _ unPlanTelefonico .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Usuario class' category: 'SistemaFacturacionDeLlamadas'!
Usuario class
	instanceVariableNames: ''!

!Usuario class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 16:08:59'!
conNombre: unNombre conPlanTelefonico: planTelefonico 
	"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"
	
	^self new initializeConNombre: unNombre conPlanTelefonico: planTelefonico ! !

!Usuario class methodsFor: 'instance creation' stamp: 'FT 12/13/2021 08:38:50'!
conPlanTelefonico: unPlanTelefonico 
	"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"
	
	^self new initializeConPlanTelefonico: unPlanTelefonico ! !
