
$(document).ready(function() {
  console.log(Mapnificent.isBrowserSupported())
  var position = {"lat": 51, "lng": 0}
  var guess = {"lat":51.52,"lng":-0.14};
  var map = new google.maps.Map(document.getElementById("map"), {
      mapTypeId: google.maps.MapTypeId.ROADMAP
      , zoom: 12
      , center: new google.maps.LatLng(51.51,-0.13)
  });
  var mapnificent, urbanDistance, positions = {};

  $(document).ready(function(){
      
      if(typeof console === "undefined"){
          alert("Please switch on DevTools/Firebug for console!");
          console = {
              log: function(){},
              error: function(){}
          };
      }
      /* 
       This is the UrbanDistance's (i.e. the public transport layer) UI function.
       This function gets called during the setup process and you can easily setup your UI in there 
       Parameters:
          mapnificent: the mapnificent instance, responsible for how to draw on the map
          that: the urbanDistance layer object, responsible for handling the public transport travel time calculation and drawing
          $: jQuery for your convenience, scoped to this function, shortcut to window
          undefined: the real undefined value, only 4 arguments are passed
          
      */
      var UrbanDistanceUI = function(mapnificent, that, $, window, undefined){
        window.blooo = that;
          console.log(that)
          /* that.bind binds a function to an event of the layer 
              setup is called when the setup of the layer is complete
              and before the loading of necessary data. 
          */
          that.bind("setup", function(){
              /* There are many options for the public transport layer 
              They can be read with .getOption and set with .setOption */
              var color = that.getOption("color");
              that.setOption("color", true);
              /* you must display this copyright notice somewhere on your page */
              $("#copyright").html(that.getOption("copyright"));
              console.log("setup done");
          });
          
          
          /* 
          loadProgress binds to the data loading progress,
          you will receive one parameter: a percentage */
          that.bind("loadProgress", function(progress){
              
              $('#loading').text(progress);
              if(progress >= 100){
                  $('#loading').text("Almost done...");
              }
          });
          
          /*
          fires when the data has finished loading */
          that.bind("dataLoaded", function(event){
            console.log(event);
              $('#loading').text("Done!");
              var geopos = {lat:51.51,lng:-0.13}, time = 15 * 60;
              
              /* adds a position to the map at the specificed location.
              Time can be left out for the default time (15 minutes) */
              var pos = that.addPosition(geopos, time); // time in seconds!
              /* The call returns a position object that you can store.
              You can store it by it's index pos.index */
              positions[pos.index] = {position: pos, latlng: geopos};
              /* You only created a position, you need to start the
               calculation process explicitly */
              pos.startCalculation();
          });
          
          /* fires when a calculation has started, receives position as parameter */
          that.bind("calculationStarted", function(position){
              $('#loading').text("Starting calculation: 0.0%");
          });
          
          /* fires when there is a calculation progress, receives position as parameter */
          that.bind("calculationUpdated", function(position){
              /* estimating the progress is not an exact since 
              the option value "estimatedMaxCalculateCalls" is 
              an estimated upper bound of position.calculationProgress
              */
              var percent = position.calculationProgress /
                  that.getOption("estimatedMaxCalculateCalls") * 100;
              $('#loading').text("Calculating: "+percent+"%");
          });
          
          /*fires when the calculation is done */
          that.bind("calculationDone", function(position){
              $('#loading').text("Calculation Done!");
              console.log("done");
              /* you need to trigger a redraw of the canvas yourself at appropriate moments */
              mapnificent.trigger("redraw");
              /* see getBlobs function further down */
              getBlobs();
          });
          
          console.log(that.search.detectBlobs());
          console.log(that.isHighlighted(1500,1500))

          var movePosition = function(index, pos){
              /* you can move your position with the .move method of a position
              it takes an geo object {lat: X, lng:Y} as first parameter.
              last parameter indicates if positionMoved should be triggered */
              var result = positions[index].position.move(pos, true);
              /* result indicates if the position is in range of the current city data
                 if it is not, positionMoved has not been triggered, regardless of second parameter
                 it it is true, postionMoved has been triggered (it already executed)
                 the latlng field of the position is set regardless of anything
                 */
              if (!result){
                  console.log("moved outside of range!");
              }
          };

          /* triggered when a position moved inside the range */
          that.bind("positionMoved", function(pos){
              positions[pos.index].latlng = pos.latlng;
              console.log("position move to ", pos.latlng);
          });
          
          var removePosition = function(index){
              /* you can call removePosition on the UB layer with an index 
              to remove this position. This will also stop all ongoing calculations */
              that.removePosition(index);
          };
          
          /* fires after successful removal */
          that.bind("positionRemoved", function(index){
              console.log("position removed");
              delete startPositions[index];
              mapnificent.trigger("redraw");
          });
          
          var getBlobs = function(){
              /* A blob is a currently visible*, highlighted area that is 
              separate from other highlighted areas. The blob contains the 
              maxbounds in canvas coordinates, and some other information */
              
              var blobs = that.search.detectBlobs();
              console.log("blobs");
              console.log(blobs);
              my_blob=blobs[2]
              console.log(my_blob)
          };
      };
      
      /* is Mapnificent properly loaded and is current browser supported (simple check) */
      if(typeof Mapnificent !== "undefined" && Mapnificent.isBrowserSupported()){
          /* load Mapnificent options for these coordinates */
          Mapnificent.forCoordinates({lat:51.51,lng:-0.13}, function(options){
              if(options == null){
                  /* if null, there is no Mapnificent data for this point */
                  return;
              }
              /* if there are options, you can instantiate a new Mapnificent instance */
              mapnificent = Mapnificent(options);
              window.ha = mapnificent;
              console.log('MAPNIFICENT')
              console.log(mapnificent)
              /* add the "urbanDistance" layer with the UI function */
              mapnificent.addLayer("urbanDistance", UrbanDistanceUI);
              /* you can bind to the initDone event of mapnificent */
              mapnificent.bind("initDone", function(){
                  // mapnificent.hide();
              });
              /* finally add mapnificent to your map by passing the Google Maps instance */
              mapnificent.addToMap(map);
     
              /* adds a position to the map at the specificed location.
              Time can be left out for the default time (15 minutes) */
          });
      }
  });

})


