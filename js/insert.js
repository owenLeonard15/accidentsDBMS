
document.getElementById('submitFile').addEventListener('click', () => { 
    let inFile = document.getElementById('inFile').files[0]
    if(inFile){
       let reader = new FileReader();
       reader.onload = function(event){
           let data = event.target.result;
           let workbook = XLSX.read(data, {
               type: 'binary'
           });
           // for each sheet in the workbook
           workbook.SheetNames.forEach(function(sheetName){
               let XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
               let json_object = JSON.stringify(XL_row_object);
               //use this to show the json on the web page
               //document.getElementById("jsonObject").innerHTML = json_object;
               fetch('http://localhost:3000/input', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: json_object
                    })
                    .then(res => res.json())
                        .then(data => {console.log(data)})
                    })
       };


       reader.onerror = function(event) {
           console.error("file could not be read! Code " + event.target.error.code);
       };

       reader.readAsBinaryString(inFile);
    }
})


    
