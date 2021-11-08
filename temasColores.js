var coloresAcento = {};
coloresAcento["1"]={'color':'#76a82c','fondo':'#f5ebdf','nombre':'Clasico'};
coloresAcento["2"]={'color':'#FF5C58','fondo':'#FCD2D1','nombre':'Rosado'};
coloresAcento["3"]={'color':'#7027A0','fondo':'#1DB9C3','nombre':'Celeste'};
coloresAcento["4"]={'color':'#E26A2C','fondo':'#FFD07F','nombre':'Naranja'};
coloresAcento["5"]={'color':'#191A19','fondo':'#D8E9A8','nombre':'Verde Manzana'};
coloresAcento["6"]={'color':'#64C9CF','fondo':'#DF711B','nombre':'Naranja Violento'};
coloresAcento["7"]={'color':'#193498','fondo':'#1597E5','nombre':'Azul'};
coloresAcento["8"]={'color':'#FEE440','fondo':'#212121','nombre':'Peñarol'};



function cantidadTemasDisponibles(){
    var count = Object.keys(coloresAcento).length;
    return count;
}

function retornaNombreTema(idTema){
    return coloresAcento[idTema].nombre;
}
