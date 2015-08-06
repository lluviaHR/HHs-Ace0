
   var layer;

    function init() {
        var url = 'https://lnh248.cartodb.com/api/v2/viz/7a6c5e76-3bdb-11e5-b57d-0e853d047bba/viz.json';
        

        var visualizacion = cartodb.createVis("map", url)
            
            .done(function(vis, layers) {
                layer = layers[1];
                 layers[1].getSubLayer(2).hide(); 
          layers[1].getSubLayer(3).hide();
          layers[1].getSubLayer(4).hide();
          })
        .error(function(err) {
          console.log(err);
            });
    }

    function showLayer(layerToShow) {

        //turn off all layers
        layer.getSubLayers().forEach(function(i) {
            i.hide()
        });

        switch (layerToShow.id) {
            case "population":
                layer.getSubLayer(2).show();
                break;
            case "languages":
                layer.getSubLayer(3).show();
                break;
            case "services":
                layer.getSubLayer(4).show();
                break; 
            case "HHS":
                layer.getSubLayer(0).show();
                layer.getSubLayer(1).show();
                break; 
        }
           
        return true;

    
    }

    
