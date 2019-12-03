let accidents = [];

// map center
var myLatlng = new google.maps.LatLng(37.385208,-93.67223);
// map options,
var myOptions = {
  zoom: 5,
  center: myLatlng
};
// standard map
map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
// heatmap layer
heatmap = new HeatmapOverlay(map, 
  {
    // radius should be small ONLY if scaleRadius is true (or small radius is intended)
    "radius": 5,
    "maxOpacity": 1, 
    // scales the radius based on map zoom
    "scaleRadius": false, 
    // if set to false the heatmap uses the global maximum for colorization
    // if activated: uses the data maximum within the current map boundaries 
    //   (there will always be a red spot with useLocalExtremas true)
    "useLocalExtrema": false,
    // which field name in your data represents the latitude - default "lat"
    latField: 'lat',
    // which field name in your data represents the longitude - default "lng"
    lngField: 'lng',
    // which field name in your data represents the data value - default "value"
    valueField: 'count'
  }
);



document.getElementById('accident-btn').addEventListener('click', () => { 
    console.log('updating map...');
    boxes = document.getElementsByClassName('checkbox');
    boxArray = [13 * false];
    let isChecked = false;
    for(let i = 0; i < boxes.length; i++){
        boxArray[i] = boxes[i].checked;
        if(boxes[i].checked){
            isChecked = true;
        }
    }
    
    if (!isChecked){
        fetch('http://localhost:3000/', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(res => res.json())
            .then(data => {
                console.log('updated')
                let tableRef = document.getElementById('my-table');
                let mapData = {max: 8, data: [] }
                // this is for displaying the first 100 results in table format
                for(let i = 0; i < 100; i++){
                    let newRow = tableRef.insertRow();
                    accidents = data.accidents;

                    let newAccidentIDCell = newRow.insertCell();
                    let newAccidentIDText  = document.createTextNode(accidents[i].accident_id);
                    newAccidentIDCell.appendChild(newAccidentIDText);

                    let newAccidentDescriptionCell = newRow.insertCell();
                    let newDescriptionText = document.createTextNode(accidents[i].description);
                    newAccidentDescriptionCell.appendChild(newDescriptionText);
                } 
                // adds the data to an array, then passes the array all at once to the map via setData()
                // using the addData function to add each point individually is significantly slower
                for(let i = 0; i < data.accidents.length; i++){
                    let dataPoint = {
                        lat: data.accidents[i].start_lat,
                        lng: data.accidents[i].start_lng,
                        count: 1
                    }
                    mapData.data.push(dataPoint);
                }
                heatmap.setData(mapData);
            })
        }
        else
        {
            fetch('http://localhost:3000/details', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(boxArray)
                })
                .then(res => res.json())
                    .then(data => {
                        console.log(data)
                        let tableRef = document.getElementById('my-table');
                        let mapData = {max: 8, data: [] }
                        // this is for displaying the first 100 results in table format
                        for(let i = 0; i < 100; i++){
                            let newRow = tableRef.insertRow();
                            accidents = data.accidents;

                            let newAccidentIDCell = newRow.insertCell();
                            let newAccidentIDText  = document.createTextNode(accidents[i].accident_id);
                            newAccidentIDCell.appendChild(newAccidentIDText);

                            let newAccidentDescriptionCell = newRow.insertCell();
                            let newDescriptionText = document.createTextNode(accidents[i].description);
                            newAccidentDescriptionCell.appendChild(newDescriptionText);
                        } 
                        // adds the data to an array, then passes the array all at once to the map via setData()
                        // using the addData function to add each point individually is significantly slower
                        for(let i = 0; i < data.accidents.length; i++){
                            let dataPoint = {
                                lat: data.accidents[i].start_lat,
                                lng: data.accidents[i].start_lng,
                                count: 1
                            }
                            mapData.data.push(dataPoint);
                        }
                        heatmap.setData(mapData);
                    })
        }
    }
)



