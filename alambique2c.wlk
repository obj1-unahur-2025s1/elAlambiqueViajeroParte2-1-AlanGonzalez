import elAlambiqueViajero.*



object inscripcion {
const vehiculos = [alambiqueVeloz, moto, convertible, antigualla, chatarra, vehiculoTramposo, vehiculoCambiaForma]
const inscriptos = []
const rechazados = []
var ciudad = paris
method vehiculos() = vehiculos
method agregarVehiculo(nuevo) = vehiculos.add(nuevo)
method nuevaCiudad(ciudadNueva) {ciudad = ciudadNueva}

method inscripciones() { vehiculos.forEach({v=> self.procesarVehiculos(v)})}
method procesarVehiculos(vehiculo) {
    if (ciudad.puedeLlegar(vehiculo)){
        inscriptos.add(vehiculo)
    }
    else {
        rechazados.add(vehiculo)
    }
}
method inscriptos() = inscriptos
method rechazados() = rechazados

method nuevaCarrera() {
    const nueva = rechazados + inscriptos
    rechazados.clear()
    rechazados.addAll(nueva.filter({v=>not ciudad.puedeLlegar(v)}))
    const disponibles = nueva.filter({v=> ciudad.puedeLlegar(v)})
    inscriptos.clear()
    inscriptos.addAll(disponibles)
}

method ganar() {
    inscriptos.forEach({v=>v.sufrirViaje()})
    return vehiculos.min({v=>v.sufrirViaje()})
}




}


//Los requisitos para participar de las carreras en cada ciudad son los mismos que para viajar a ella (Como en la parte 1, 
//el requisito para ingresar a Paris es que el vehículo pueda circular, lo que en el caso del Alambique Veloz 
//sigue siendo que tenga el tanque lleno, pero para los demás vehículos la forma de determinarlo es diferente; en Buenos Aires, 
//que el vehículo sea considerado rápido y de manera similar en las otras ciudades)



//Cuando llega el momento oportuno, se le avisa a todos los vehículos anotados que vayan a la ciudad, lo cual implica que todos sufran las consecuencias del viaje 
//(de la misma forma que la parte 1) El objetivo central es obtener al ganador de la carrera, que es el vehículo que completa la carrera en menos tiempo.


//La inscripción
//Los vehículos que quieran participar de la carrera deben inscribirse en el centro de inscripción. 
//Cuando el centro recibe un vehículo verifica si puede o no competir en la ciudad donde acontecerá la carrera, 
//si no puede no lo inscribe pero lo deja en una lista de rechazados. Puede ocurrir que durante el periodo de inscripción, antes que comience la carrera, 
//haya una replanificación que implique cambiar la ciudad donde acontecerá la carrera. 
//Si esto ocurre se vuelve a verificar que todos los vehículos anotados estén en condiciones de competir en la nueva ciudad, descartando a los que no lo estén 
//y eventualmente incorporando a los que fueron rechazados anteriormente pero que puedan participar en la nueva sede.