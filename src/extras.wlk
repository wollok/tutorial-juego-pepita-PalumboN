import pepita.*
import wollok.game.*

object nido {

	var property position = game.at(7, 8)

	method image() = "nido.png"

	method teEncontro(ave) {
		game.stop()
	}
}

object silvestre {

	method image() = "silvestre.png"

	method position() = game.at(self.xSegunPepita(), 0)

	method xSegunPepita() = pepita.position().x().max(3)
}

