// Load libraries
google.load("maps", "2");
google.load("prototype", "1.6.0.3");

// on page load complete, initialize the application
google.setOnLoadCallback(function() {
  document.body.writeAttribute('onunload', 'GUnload()');
  new Application;
});
