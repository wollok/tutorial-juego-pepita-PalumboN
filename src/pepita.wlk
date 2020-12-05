import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var position = game.origin()

	method position() = position
	method position(nuevaPosicion) { position = nuevaPosicion }

	method image() {
		return  if (self.estaEnElNido()) "pepita-grande.png" else 
				if (self.estaConSilvestre() or self.estaCansada()) "pepita-gris.png"
				else "pepita.png"
	}

	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
	}
	
	method comeComidaQueEstaDebajo() {
		const comidaAComer = self.comidaDebajo()
		self.come(comidaAComer)
		game.removeVisual(comidaAComer)
	}
	
	method comidaDebajo() {
		const comidas = game.colliders(self) // Acá pueden venir objetos que no son comidas, ojo!
		if (comidas.isEmpty()) self.error("No hay comida acá!")
		return comidas.last() // Esto tira un error horrible cuando la lista está vacía :s
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		self.validarMovimientoHacia(nuevaPosicion)
		self.vola(position.distance(nuevaPosicion))
		position = nuevaPosicion
		if (self.estaCansada()) self.perder()
	}
	
	method perder() {
		game.say(self, "Perdí :(")
		game.schedule(2000, { game.stop() })
	}
	
	method validarMovimientoHacia(nuevaPosicion) {
		if (not self.estaDentroDeLaPantalla(nuevaPosicion)) self.error("No puedo salir de la pantalla")
		if (self.estaCansada()) self.error("No tengo más energía!")
	}
	
	method caerSiEstasEnElAire() {
		const posAbajo = position.down(1)
		if (posAbajo.y() >= 0) {			
			position = posAbajo  
		}
	}	
	
	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}
	
	method estaConSilvestre() {
		return position == silvestre.position() 
	}
	
	// TODO: Esto o podría saber game (o un objeto más de ese estilo)
	method estaDentroDeLaPantalla(unaPosicion) = 
		unaPosicion.x().between(0, game.width() - 1) and 
		unaPosicion.y().between(0, game.height() - 1)


	
}

