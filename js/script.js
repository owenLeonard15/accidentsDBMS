document.getElementById('accident-btn').addEventListener('click', () => { 
    fetch('http://localhost:3000/', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(res => res.json())
        .then(data => {
            let accidents = data.accidents;
            let tableRef = document.getElementById('my-table');
            for(let i = 0; i < data.accidents.length; i++){
                let newRow = tableRef.insertRow();

                let newAccidentIDCell = newRow.insertCell();
                let newAccidentIDText  = document.createTextNode(accidents[i].accident_id);
                newAccidentIDCell.appendChild(newAccidentIDText);

                let newAccidentDescriptionCell = newRow.insertCell();
                let newDescriptionText = document.createTextNode(accidents[i].description);
                newAccidentDescriptionCell.appendChild(newDescriptionText);
            } 
        })
    }
)