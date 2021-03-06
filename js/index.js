const express = require('express');
const app = express();
const cors = require('cors');
const port = 3000;

var mysql = require('mysql')
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'us_accidents'
})

app.use(cors());
app.use(express.json());

connection.connect();

app.get('/', (req, res) => {
  let accidents = []
  connection.query('SELECT accident_id, description, start_lat, start_lng from accidents INNER JOIN location USING(accident_id)', function (err, result) {
    if (err) throw err
    for(let i = 0; i < result.length; i++){
      accidents.push(result[i])
    }
    res.send(JSON.stringify({"status" : 200, "error": null, "accidents": accidents}))
  })
})


app.post('/input', (req, res) => {
  let input = req.body;
  
  input.forEach(row => {
      connection.query(`CALL insertRecord(
        '${row.ID}', '${row.report_source}', '${row.TMC}', '${row.Severity}', '${row.Start_Time}', 
        '${row.End_Time}', '${row.Start_Lat}', '${row.Start_Lng}',
        '${row.Distance}', '${row.Description}', '${row.House_Number}', '${row.Street}', '${row.Side}',
        '${row.City}', '${row.County}', '${row.State}', '${row.Zipcode}', '${row.Country}', '${row.Timezone}',
        '${row.Airport_Code}', '${row.Weather_Timestamp}', '${row.Temperature}', '${row.Wind_Chill}', 
        '${row.Humidity}', '${row.Pressure}', '${row.Visibility}', '${row.Wind_Direction}', '${row.Wind_Speed}',
        '${row.Precipitation}', '${row.Weather_Condition}', '${row.Amenity}', '${row.Bump}', '${row.Crossing}',
        '${row.Give_Way}', '${row.Junction}', '${row.No_Exit}', '${row.Railway}', '${row.Roundabout}',
        '${row.Station}', '${row.is_stop}', '${row.Traffic_Calming}', '${row.Traffic_Signal}', 
        '${row.Turning_Loop}')`,
           function (err, result) {
              if (err) throw err
        });
  });
  res.send(JSON.stringify({"status" : 200, "error": null, "value": "file upload successful"}));
})


app.post('/details', (req, res) => {
  let input = req.body;
  let accidents = []

  connection.query(`CALL getLocInfo (${input[0]}, ${input[1]}, ${input[2]}, ${input[3]}, ${input[4]}, 
    ${input[5]}, ${input[6]}, ${input[7]}, ${input[8]}, ${input[9]}, ${input[10]}, ${input[11]}, ${input[12]})`, 
      function (err, result){
        if (err) throw err
        for(let i = 0; i < result.length; i++){
          accidents.push(result[i])
        }
        res.send(JSON.stringify({"status" : 200, "error": null, "accidents": accidents}));
      })
})


app.listen(port, () => console.log(`Example app listening on port ${port}!`))

