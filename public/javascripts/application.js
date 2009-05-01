Application = Class.create({
  initialize: function() {
    this.initAddressChooser('business', {street: 'address'});
  },
  initAddressChooser: function(object, options) {
    // Init options
    options = $H({
      street: 'street',
      submit: 'submit',
      lat: 'lat',
      lng: 'lng',
      current_lat: 'current_lat',
      current_lng: 'current_lng',
      suggests: 'suggests'
    }).merge(options);
    
    // Check if current lat/lng are defined to use them
    var current_lat, current_lng;
    if ((current_lat = $(object+'_'+options.get('current_lat'))) && (current_lng = $(object+'_'+options.get('current_lng'))))
      current_lng.insert({after: '<input type="hidden" id="'+object+'_'+options.get('lat')+'" name="'+object+'['+options.get('lat')+']" value="'+current_lat.value+'" /><input type="hidden" id="'+object+'_'+options.get('lng')+'" name="'+object+'['+options.get('lng')+']" value="'+current_lng.value+'" />'});
    
    var street, submit;
    if (!(street = $(object+'_'+options.get('street'))) || !(submit = $(object+'_'+options.get('submit')))) return;
    
    // BEGIN AUTOCOMPLETE SETTINGS AND HACKS :)
    // Create a local autocomplete without data. Data will be added dynamically according to map suggestions
    var autocomplete = new Autocompleter.Local(street, options.get('suggests'), [],
      {
        afterUpdateElement: function(element, selectedElement) {
          var index = selectedElement.up().immediateDescendants().indexOf(selectedElement);
          widget.showPlacemark(index);
        },
        selector: function(instance) {
          instance.changed = false;
          return "<ul><li>" + instance.options.array.join('</li><li>') + "</li></ul>";
        }
      }
    );
    
    // Do not observe keyboard event
    autocomplete.onObserverEvent = function() {}
    
    // Wrap render to update map with selected placemarks
    autocomplete.render = autocomplete.render.wrap(function(method) {
      method();
      widget.showPlacemark(this.index);
    });
    // END AUTOCOMPLETE SETTINGS AND HACKS :)
    
    widget = new Maptimize.AddressChooser.Widget(
      { onInitialized: function(widget) {
          // Add default controls
          widget.getMap().setUIToDefault();
    
          widget.initMap();
    
          // Observe 'suggests:started' to display spinner and disable submit button
          widget.addEventListener('suggests:started', function() {
            street.addClassName('spinner');
          });
          
          // Observe 'suggests:found' to hide spinner and enable submit button if a placemark has been found
          widget.addEventListener('suggests:found', function(placemarks) {
            street.removeClassName('spinner');
            street.focus();
          
            // Reset autocomplete suggestions to new placemarks
            autocomplete.options.array.clear();
            if (placemarks && placemarks.length > 0) {
              for (var i = 0; i < placemarks.length; i++) {
                autocomplete.options.array.push(widget.getAddress(placemarks[i]));
              }
              // For autocomplete update
              autocomplete.getUpdatedChoices();
              autocomplete.show();
            }
            else {
              autocomplete.hide();
            }
          });
          
          street.focus();
        },
        street: object+'_'+options.get('street'),
        lat: object+'_'+options.get('lat'),
        lng: object+'_'+options.get('lng')
      }
    );

    return(this);
  }
});