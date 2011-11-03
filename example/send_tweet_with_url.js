var Twitter = Ti.UI.currentWindow.Twitter;

var button = Ti.UI.createButton({
  title: 'Show composer with URL',
  left: 10,
  right: 10,
  height: 40
});

button.addEventListener('click', function(e) {
  var composer = Twitter.createTweetComposerView();
  composer.addURL('http://google.com');
  composer.addURL('http://apple.com');
  composer.open();
});

Ti.UI.currentWindow.add(button);
