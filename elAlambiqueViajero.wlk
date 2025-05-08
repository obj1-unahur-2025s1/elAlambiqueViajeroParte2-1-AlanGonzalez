object luke{
    var cantidadViajes = 0
    var recuerdo = null
    var vehiculo = alambiqueVeloz

    method cantidadViajes() = cantidadViajes 

    method viajar(lugar){
        if (lugar.puedeLlegar(vehiculo)) {
            cantidadViajes = cantidadViajes + 1
            recuerdo = lugar.recuerdoTipico()
            vehiculo.desgaste()
        }
    }
    method recuerdo() = recuerdo
    method vehiculo(nuevo) {vehiculo = nuevo}
}


object paris{
    method recuerdoTipico() = "Llavero Torre Eiffel"
    method puedeLlegar(movil) =  movil.puedeFuncionar() 
    
}

object buenosAires{
    method recuerdoTipico() = "Mate"
    method puedeLlegar(auto) =  auto.rapido() 
}

object bagdad {
    var recuerdo = "bidon de petroleo"
    method recuerdoTipico() = recuerdo
    method recuerdo(nuevo) {recuerdo = nuevo }
    method puedeLlegar(cualquierCosa) = true
}

object lasVegas{
    var homenaje = paris
    method homenaje(lugar) {homenaje = lugar}
    method recuerdoTipico() = homenaje.recuerdoTipico()
    method puedeLlegar(vehiculo) = homenaje.puedeLlegar(vehiculo)
}

object hurlingham{
    method puedeLlegar(vehiculo) =
    vehiculo.puedeFuncionar() and vehiculo.rapido() and vehiculo.patenteValida()
    method recuerdoTipico() = "sticker de la Unahur"
}


object alambiqueVeloz {
    var combustible = 20
    const consumoPorViaje = 10
    const patente = "AB123JK"
    method puedeFuncionar() = combustible >= consumoPorViaje
    method desgaste() {
        combustible = combustible - consumoPorViaje
    }
    method rapido() = true
    method patenteValida() = patente.take(1) == "A"
    method sufrirViaje() {
        self.desgaste()
        return 100 - combustible
    }
    
}


object antigualla {
    const gangsters = ["Alfredo", "Carlos", "Javier", "Ricardo", "Sofia", "Miguel", "Eduardo"]
    method puedeFuncionar() = gangsters.size() > 0
    method rapido() = gangsters.sum({g=>g.size()}) > 20
    method desgaste(){
        if(!gangsters.isEmpty()){
        gangsters.remove(gangsters.first())
        }
    }
    method patenteValida() = chatarra.rapido() 
    method sufrirViaje() {
        self.desgaste()
        return gangsters.sum({g=>g.size()})
    }

}
object chatarra {
    var cañones = 10
    var municiones = "ACME"
    method puedeFuncionar() = municiones == "ACME" and cañones.between(6,12)
    method rapido() = municiones.size() < cañones
    method desgaste(){
        cañones = (cañones / 2).roundUp(0)
        if (cañones < 5 )
        municiones = municiones + " Obsoleto"
    }
    method patenteValida() = municiones.take(4) == "ACME"
    method cañones() = cañones
    method sufrirViaje() {
        self.desgaste()
        return cañones * 3 + 1
    }

}

object convertible{
    var convertido = antigualla
    method puedeFuncionar() = convertido.puedeFuncionar() 
    method rapido() = convertido.rapido()
    method desgaste(){
        convertido.desgaste() 
    }
    method convertir(vehiculo){
        convertido = vehiculo
    }
    method patenteValida() = convertido.patenteValida()
    method sufrirViaje() {
        self.desgaste()
        return convertido.sufrirViaje()
    }
 
}

object moto{
    method rapido() = true
    method puedeFuncionar() = not self.rapido()
    method desgaste() { }
    method patenteValida() = false
    method sufrirViaje() = 20
}


object vehiculoTramposo {
    const vehiculosDañados = []
    var combustible = 150
    method combustible() = combustible
    method puedeFuncionar() = combustible.between(50, 150)
    method dañadosVehiculos(vehiculo) = vehiculosDañados.add(vehiculo)
    method rapido() = false
    method desgaste() {combustible = (combustible - vehiculosDañados.size()).max(0)} 
    method patenteValida() = true
    method sufrirViaje() {
        self.desgaste()
        return combustible
    }
}
//El vehículo conducido por Pierre Nodoyuna y Patán si bien es más rápido que muchos otros, 
//siempre intentan hacer trampas o perjudicar a los otros corredores y terminan tardando más en llegar a la meta.


object vehiculoCambiaForma {
    const vehiculos = []
    var vehiculo = moto
    method convertir(auto) { vehiculo = auto 
        vehiculos.add(auto)
    }
    method combustible() = vehiculo.combustible()
    method puedeFuncionar() = vehiculo.puedeFuncionar()
    method rapido() = vehiculo.rapido()
    method desgaste() = vehiculo.desgaste()
    method patenteValida() = vehiculo.patenteValida()
    method sufrirViaje() = vehiculo.sufrirViaje()
}




//El profesor Locovich usa un vehículo que va cambiando de forma y simula ser otros. 
//Implementarlo con una lista de posibles vehículos en los que se puede convertir sucesivamente y permitir que lo haga antes que comience la carrera.