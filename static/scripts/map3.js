window.onload = function() {

    var vizjson = 'https://hhsaccelerator.cartodb.com/u/intern2/api/v2/viz/ff7743c0-3031-11e5-8426-0e4fddd5de28/viz.json';
   
    // Choose center and zoom level
    var options = {
                center: [40.707, -73.94], // NY
                zoom: 11,
                layer_selector:true,
                force_mobile: true
            }
    
    // Instantiate map on specified DOM element
    var map_object = new L.Map("map", options);
    
    // Add a basemap to the map object just created
    L.tileLayer("https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_nolabels/{z}/{x}/{y}.png", {
        attribution: 'Cartodb'
        }).addTo(map_object);
     
    cartodb.createLayer(map_object, vizjson).addTo(map_object);   

}


/*window.onload = function () {
    var url = 'https://hhsaccelerator.cartodb.com/u/intern2/api/v2/viz/ff7743c0-3031-11e5-8426-0e4fddd5de28/viz.json';
    // Instantiate new map object, place it in 'map' element
    var map_object = new L.Map('map', {
        center: [40.707, -73.94], // NY
        zoom: 11
        //40.727, -74.0059
    });

    // For storing the sublayers
    var sublayers = [];

    // Pull tiles from OpenStreetMap
    // Add a basemap to the map object just created
    L.tileLayer("https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_nolabels/{z}/{x}/{y}.png", {
        attribution: 'Cartodb'
        }).addTo(map_object);

    // Add data layer to your map
    cartodb.createLayer(map_object, url)
        .addTo(map_object)
        .done(function(layer) {
           for (var i = 0; i < layer.getSubLayerCount(); i++) {
               sublayers[i] = layer.getSubLayer(i);
           } 
        })
        .error(function(err) {
            console.log("error: " + err);
        });
    
    var sublayer0Shown = true;
    $("#sublayer0").on('click', function() {
        if (sublayer0Shown) {
            sublayers[0].hide();
        } else {
         sublayers[0].show();
        }
        sublayer0Shown = !sublayer0Shown; 
    
        });

     var sublayer0Shown = true;
    $("#sublayer0").on('click', function() {
        if (sublayer0Shown) {
            sublayers[0].hide();
        } else {
         sublayers[0].show();
        }
        sublayer0Shown = !sublayer0Shown; 
    
        });
    }*/