var Twitter = Ti.UI.currentWindow.Twitter;

var button = Ti.UI.createButton({
  title: 'Show tweet composer',
  left: 10,
  right: 10,
  height: 40
});

button.addEventListener('click', function(e) {
  var composer = Twitter.createTweetComposerView()
  composer.addEventListener('complete', function(e) {
    // compare e.result with Twitter.CANCELLED or Twitter.DONE
    // to proceed with your logic
  });
  composer.setInitialText("Hello world :)");
  composer.open();
});

Ti.UI.currentWindow.add(button);
