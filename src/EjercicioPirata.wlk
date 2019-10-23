class Pirata{
	
	var property items
	var property monedas
	var property nivelDeEbriedad
	var property invitadoPor
	var property invitados
	
	method tieneItem(unItem){
		return items.contains(unItem)
	}
	
	method tomarUnTrago(){
		nivelDeEbriedad += 5
		if(monedas<1){
			//TIRAR ERROR
		}
		else{
			monedas--
		}
	}
	
	method estaPasadoDeGrog(nivelDeEbriedadMinimo){
		return nivelDeEbriedad > nivelDeEbriedadMinimo		
	}
	
	method cantidadInvitadosSatisfactorios(){
		return invitados.filter{ invitado => invitado.invitadoPor() == self}.size()
	}
	
	method esEspia(){
		return self.estaPasadoDeGrog(90).negate() && self.tieneItem('permisoDeLaCorona')
	}
}