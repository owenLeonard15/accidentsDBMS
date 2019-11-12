const express = require('express')
const app = express()
const port = 3000

var mysql = require('mysql')
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'ap'
})

connection.connect()

connection.query('SELECT invoice_number FROM invoices WHERE invoice_id = 1', function (err, result) {
  if (err) throw err

  console.log('The invoice number is: ', result[0].invoice_number)
})

connection.end()

app.get('/', (req, res) => res.send('Hello World!'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

