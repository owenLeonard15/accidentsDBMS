const express = require('express')
const app = express()
const cors = require('cors')
const port = 3000

var mysql = require('mysql')
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'us_accidents'
})
app.use(cors())

connection.connect()

app.get('/', (req, res) => {
  let accidents = []
  connection.query('SELECT * FROM accidents INNER JOIN location ON accidents.accident_id = location.accident_id LIMIT 200000', function (err, result) {
    if (err) throw err
    for(let i = 0; i < result.length; i++){
      accidents.push(result[i])
    }
    res.send(JSON.stringify({"status" : 200, "error": null, "accidents": accidents}))
  })
  console.log(accidents.length);
  }
)



app.listen(port, () => console.log(`Example app listening on port ${port}!`))

