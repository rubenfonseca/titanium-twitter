var Twitter = Ti.UI.currentWindow.Twitter;

var button = Ti.UI.createButton({
  title: 'Show composer with Image',
  left: 10,
  right: 10,
  height: 40
});

button.addEventListener('click', function(e) {
  var image = Ti.Filesystem.getFile('rails.png');

  var composer = Twitter.createTweetComposerView();
  composer.addImage(image.read()); // must be a TiBlob
  composer.open();
});

Ti.UI.currentWindow.add(button);
