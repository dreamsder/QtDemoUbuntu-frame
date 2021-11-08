WorkerScript.onMessage = function(message) {

    var d = new Date();

    WorkerScript.sendMessage({ 'hora': d.toLocaleDateString("es-UY")+" - "+d.toLocaleTimeString("es-UY")})

}
