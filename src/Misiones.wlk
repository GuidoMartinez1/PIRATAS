class Mision{
	
	method esUtil(unPirata){
		return true
	}
	
}

object busquedaDelTesoro inherits Mision {
	
	override method esUtil(unPirata){
		return self.condicionPiratil(unPirata)
	}
	
	method condicionPiratil(unPirata){
		return (unPirata.monedas() <= 5) && (unPirata.tieneItem('brujula') || unPirata.tieneItem('mapa') || unPirata.tieneItem('grogXD'))
	}
	
	method puedeHacerse(unBarco){
		return unBarco.tripulantes.any{unPirata => unPirata.tieneItem('llaveDeCofre')}
	}
}

class ConvertirseEnUnaLeyenda inherits Mision{
	
	var itemObligatorio
	
	override method esUtil(unPirata){
		return unPirata.tieneItem(itemObligatorio) && unPirata.items().size() >= 10
	}
	
	method puedeHacerse(unBarco){
		return true
	}
	
}

class Saqueo inherits Mision {
	
	var victima
	var numeroDeMonedasDeterminada
	
	override method esUtil(unPirata){
		return unPirata.moneda() < numeroDeMonedasDeterminada && victima.puedeSerSaqueadoPor(unPirata)
	}
	
	method puedeHacerse(unBarco){
		return victima.esVulnerableA(unBarco)
	}
}