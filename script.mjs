
WorkerScript.onMessage = function(message) {

    var xhr = new XMLHttpRequest

    var ipstring=""


    var moneda=""

    // Listen to the readyStateChanged signal
    xhr.onreadystatechange = function() {
        // If the state changed to DONE, we can parse the response
        if (xhr.readyState === XMLHttpRequest.DONE) {
            // The responseText looks like this {"ip":"xxx.xxx.xxx.xxx"}
            // Parse the responseText string to JSON format
            var responseJSON = JSON.parse(xhr.responseText)
            // Read the ip property of the response
            //var ip = responseJSON.ip
            //var ip = responseJSON.rates.USD.buy

            var ip = responseJSON
            // Display the ip in the AppText item
            // console.log(ip)
            ipstring=ip

            /* message.model.clear();

            message.model.append(responseJSON.rates.USD);
            message.model.append(responseJSON.rates.ARS);
            message.model.append(responseJSON.rates.EUR);
            message.model.append(responseJSON.rates.BRL);

            message.model.sync();*/


            if(message==="dolares"){
                responseJSON.rates.USD['tipito']=message;
                moneda=responseJSON.rates.USD;
            }else if(message==="euros"){
                responseJSON.rates.EUR['tipito']=message;
                moneda=responseJSON.rates.EUR;
            }
            else if(message==="argentinos"){
                responseJSON.rates.ARS['tipito']=message;
                moneda=responseJSON.rates.ARS;
            }
            else if(message==="reales"){
                responseJSON.rates.BRL['tipito']=message;
                moneda=responseJSON.rates.BRL;
            }else{
                moneda=null;
            }



            //ipText.text = "IP: " + ip

        }
    }

    // Define the target of your request
    //xhr.open("GET", "https://api.ipify.org?format=json",false)

    xhr.open("GET", "https://cotizaciones-brou.herokuapp.com/api/currency/latest",false)


    // Execute the request
    xhr.send()


    //WorkerScript.sendMessage({ 'reply': 'Mouse is at ' + message.x + ',' + message.y })
    WorkerScript.sendMessage({ 'monedas': moneda })

}

/*function readConfigFile() {

    var xobj = new XMLHttpRequest();
    xobj.open('GET', 'File:///home/cristian/QtProyects/threads/pepe.json', false);
    xobj.onreadystatechange = function () {
          if (xobj.readyState === 4 && xobj.status === 200) {
              console.log("ok");
            console.log(JSON.parse(xobj.responseText).name);
            //callback(xobj.responseText.);
          }
    };
    xobj.send(null);
 }*/
