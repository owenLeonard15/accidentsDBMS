document.getElementById('invoice-btn').addEventListener('click', () => { 
    fetch('http://localhost:3000/', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(res => res.json())
        .then(data => {
            let invoices = data.invoices;
            let tableRef = document.getElementById('my-table');
            for(let i = 0; i < data.invoices.length; i++){
                let newRow = tableRef.insertRow();

                let newInvoiceIDCell = newRow.insertCell();
                let newInvoiceIDText  = document.createTextNode(invoices[i].invoice_id);
                newInvoiceIDCell.appendChild(newInvoiceIDText);

                let newVendorIDCell = newRow.insertCell();
                let newVendorIDText = document.createTextNode(invoices[i].vendor_id);
                newVendorIDCell.appendChild(newVendorIDText);

                let newInvoiceNoCell = newRow.insertCell();
                let newInvoiceNoText = document.createTextNode(invoices[i].invoice_number);
                newInvoiceNoCell.appendChild(newInvoiceNoText);


            } 
        })
    }
)