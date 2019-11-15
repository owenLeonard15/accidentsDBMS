const express = require('express')
const app = express()
const cors = require('cors')
const port = 3000

var mysql = require('mysql')
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'ap'
})
app.use(cors())

connection.connect()

app.get('/', (req, res) => {
  let invoices = []
  connection.query('SELECT * FROM invoices LIMIT 50', function (err, result) {
    if (err) throw err
    for(let i = 0; i < 50; i++){
      invoices.push(result[i])
    }
    res.send(JSON.stringify({"status" : 200, "error": null, "invoices": invoices}))
  })
  }
)

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

