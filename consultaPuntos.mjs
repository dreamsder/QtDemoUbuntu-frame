

var jsonData = {};
var jsonDatosSocio = {};

WorkerScript.onMessage = function(mensaje) {

    consultaDePuntos(mensaje);
    consultaDatosSocio(mensaje);
    //console.log(jsonDatosSocio.nombre)
    jsonData["nombre"]=jsonDatosSocio.nombre;
    WorkerScript.sendMessage({ 'result':  jsonData})
}




function consultaDePuntos(mensaje){

    var symbol = "MSFT";
    var xmlhttp = new XMLHttpRequest();
    var resultado="";



    xmlhttp.open("POST", "http://192.168.250.153/wsplus/wsplus.php?wsdl",false);
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState != 4) return;
        if(xmlhttp.status == 200){



            //resultado =

            //  console.log(xmlhttp.responseText);


            console.log(xmlhttp.status)
            console.log(xmlhttp.statusText)


            if (xmlhttp.responseXML.documentElement!== null) {
                var doc = xmlhttp.responseXML.documentElement;


                if (doc.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0] !== undefined) {
                    // Si tengo una respuesta 00
                    if(doc.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].nodeValue==="00"){
                        resultado=parseInt(doc.childNodes[0].childNodes[0].childNodes[1].childNodes[2].childNodes[0].nodeValue);
                        jsonData["status"]="OK";
                    }else{
                        jsonData["status"]="ERROR";
                        resultado="-999";
                    }
                }else{
                    jsonData["status"]="ERROR";
                    resultado="-999";
                }


            }else{
                jsonData["status"]="ERROR";
                resultado="-999";
            }








            jsonData["documento"]=mensaje.doc;
            jsonData["tipodoc"]=mensaje.tipoDoc;
            jsonData["puntos"]=resultado;



        }
    }


    xmlhttp.setRequestHeader("SOAPAction", "http://www.webserviceX.NET/GetQuote");
    xmlhttp.setRequestHeader("Content-Type", "text/xml");


    var xml ='<?xml version="1.0" encoding="utf-8"?>' +
            '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wst="http://www.objetos.com.uy/wstataplus/">'+
            '<soapenv:Header/>'+
            '<soapenv:Body>'+
            '<wst:ConsultaPuntosSocioEntrada>'+
            '<Documento>'+
            '<TipoDocumento>'+mensaje.tipoDoc+'</TipoDocumento>'+
            '<NroDocumento>'+mensaje.doc+'</NroDocumento>'+
            '</Documento>'+
            '</wst:ConsultaPuntosSocioEntrada>'+
            '</soapenv:Body>'+
            '</soapenv:Envelope>';


    xmlhttp.send(xml);



}



function consultaDatosSocio(mensaje){

    var xmlhttp = new XMLHttpRequest();
    var resultado="";
    xmlhttp.open("POST", "http://192.168.250.253/wsplus/wsplus.php?wsdl",false);
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState == 4) {

            //             console.log(xmlhttp.responseText);




            if (xmlhttp.responseXML.documentElement!== undefined) {

                var doc = xmlhttp.responseXML.documentElement;

                // Si tengo una respuesta 00
                if(doc.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].nodeValue==="00"){
                    var nombre="Sin nombre ";
                    var apellido= "";


                    if (doc.childNodes[0].childNodes[0].childNodes[1].childNodes[0].childNodes[0] !== undefined) {
                        nombre = doc.childNodes[0].childNodes[0].childNodes[1].childNodes[0].childNodes[0].nodeValue;
                    }
                    if (doc.childNodes[0].childNodes[0].childNodes[1].childNodes[1].childNodes[0] !== undefined) {
                        apellido = doc.childNodes[0].childNodes[0].childNodes[1].childNodes[1].childNodes[0].nodeValue;
                    }

                    resultado=nombre + " "+apellido;
                    jsonDatosSocio["status"]="OK";
                }else{
                    jsonDatosSocio["status"]="ERROR";
                    resultado="Sin nombre";
                }
            }else{
                jsonDatosSocio["status"]="ERROR";
                resultado="Sin nombre";
            }



            jsonDatosSocio["nombre"]=resultado;

        }//12252881
    }


    xmlhttp.setRequestHeader("SOAPAction", "http://www.webserviceX.NET/GetQuote");
    xmlhttp.setRequestHeader("Content-Type", "text/xml");

    var xml ='<?xml version="1.0" encoding="utf-8"?>' +
            '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wst="http://www.objetos.com.uy/wstataplus/">'+
            '<soapenv:Header/>'+
            '<soapenv:Body>'+
            '<wst:ConsultaDatosSociosEntrada>'+
            '<Documento>'+
            '<TipoDocumento>'+mensaje.tipoDoc+'</TipoDocumento>'+
            '<NroDocumento>'+mensaje.doc+'</NroDocumento>'+
            '</Documento>'+
            '</wst:ConsultaDatosSociosEntrada>'+
            '</soapenv:Body>'+
            '</soapenv:Envelope>';


    xmlhttp.send(xml);



}
