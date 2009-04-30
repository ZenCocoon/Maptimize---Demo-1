Application = Class.create({
  initialize: function() {
    this.initAddressChooser('business_address', 'business_submit', 'business_lat', 'business_lng');
  },
  initAddressChooser: function(addressId, submitId, latId, lngId) {
    var address, submit;
    if (!(address = $(addressId)) || !(submit = $(submitId))) return;
    
    // BEGIN AUTOCOMPLETE SETTINGS AND HACKS :)
    // Create a local autocomplete without data. Data will be added dynamically according to map suggestions
    var autocomplete = new Autocompleter.Local(addressId, 'suggests', [],
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
            address.addClassName('spinner');
            submit.disabled = true;
          });
          
          // Observe 'suggests:found' to hide spinner and enable submit button if a placemark has been found
          widget.addEventListener('suggests:found', function(placemarks) {
            submit.disabled = false;
            address.removeClassName('spinner');
            address.focus();
          
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
          
          submit.disabled = true;
          address.focus();
        },
        street: addressId,
        lat: latId,
        lng: lngId
      }
    );

    return(this);
  }
});