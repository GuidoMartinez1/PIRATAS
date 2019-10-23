class VictimaDeSaqueo{
	
	method nivelDeEbriedadMinimo()
	
	method puedeSerSaqueadoPor(unPirata){
		return unPirata.nivelDeEbriedad() > self.nivelDeEbriedadMinimo()
	}
}

class BarcoPirata inherits VictimaDeSaqueo{
	
	var property capacidad
	var property tripulantes
	var property mision
	
	override method nivelDeEbriedadMinimo(){
		return 90
	}
	
	method puedeFormarParte(unPirata){
		return self.tieneLugarParaUnoMas() && mision.esUtil(unPirata)
	}
	
	method tieneLugarParaUnoMas() {
		return capacidad > tripulantes.size()
	}
	
	method incorporarPirata(unPirata){
		if(self.puedeFormarParte(unPirata)){
			tripulantes.add(unPirata)
		}
	}
	
	method cambiarDeMision(nuevaMision){
		mision = nuevaMision
		//FALTA 
	}
	
	method pirataMasEbrio(){
		return tripulantes.map{unPirata => unPirata.nivelDeEbriedad()}.max()
	}
	
	method tieneSuficienteTripulacion(){
		return tripulantes.size() <= capacidad * 0.9		
	}
	
	method anclarA(unaCiudadCostera){
		tripulantes.forEach{ unPirata => unPirata.tomarUnTrago()}
		tripulantes.remove(self.pirataMasEbrio())
		unaCiudadCostera.habitantes().add(self.pirataMasEbrio())
	}
	
	method esTemible(){
		return self.puedeRealizarMision()
	}
	
	method puedeRealizarMision(){
		return self.tieneSuficienteTripulacion() && mision.puedeHacerse(self)	
	}
	
	method esVulnerableA(unBarco){
		return tripulantes.size() <= unBarco.tripulantes().size()/2
	}
	
	method conocerEspias(){
		return tripulantes.filter{unPirata => unPirata.esEspia()} 
	}
	
	method cantidadDeTripulantesPasadosDeGrog(){
		return self.obtenerBorrachos().size()
	}
	
	method obtenerBorrachos() {
		return tripulantes.filter{unPirata => unPirata.estaPasadoDeGrog(90)}
	}
	
	method cantidadDeItemsDistintos(){
		return self.obtenerBorrachos().map{unPirata => unPirata.items()}.asSet().size()
	}
	
	method borrachoConMasMonedas(){
		return self.obtenerBorrachos().max{ unPirata, otroPirata => unPirata.monedas()>otroPirata.monedas()}.first()
	}
	
	method tripulanteQueMasInvito(){
		return tripulantes.max{unPirata => unPirata.cantidadInvitadosSatisfactorios()}
	}
}

class CiudadCostera inherits VictimaDeSaqueo{
	
	var property habitantes
	
	override method nivelDeEbriedadMinimo(){
		return 50
	}
	
	method esVulnerableA(unBarco){
		return (habitantes.size() >= unBarco.tripulantes().size()*0.4) || (unBarco.tripulantes.all{unPirata => unPirata.estaPasadoDeGrog(90)})
	}
}