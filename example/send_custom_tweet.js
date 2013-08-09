var Twitter = Ti.UI.currentWindow.Twitter;
var account = null;

var status = Ti.UI.createTextField({
  value: "Hello. This is a tweet",
  borderStyle: Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
  height: 40,
  width: 300,
  left: 10,
  top: 10
});
Ti.UI.currentWindow.add(status);

var button = Ti.UI.createButton({
  title: 'Send custom tweet',
  left: 10,
  right: 10,
  width: 300,
  height: 40,
  top: 120
});
Ti.UI.currentWindow.add(button);

var button2 = Ti.UI.createButton({
  title: 'Send custom tweet with image',
  left: 10,
  right: 10,
  width: 300,
  height: 40,
  top: 180
});
Ti.UI.currentWindow.add(button2);

button.addEventListener('click', function(e) {
  var request = Twitter.createRequest({
    url: 'http://api.twitter.com/1/statuses/update.json',
    method: Twitter.REQUEST_METHOD_POST, 
    params: {
      status: status.value
    },
    account: account
  });

  request.addEventListener('success', function(e) {
    alert('tweet sent :)');
  });
  request.addEventListener('failure', function(e) {
    alert(e.error);
  });
  request.perform();
});

button2.addEventListener('click', function(e) {
  var request = Twitter.createRequest({
    url: 'https://upload.twitter.com/1/statuses/update_with_media.json',
    method: Twitter.REQUEST_METHOD_POST, 
    params: {
      possibly_sensitive: "true",
      status: status.value
    },
    account: account
  });

  var image = Ti.Filesystem.getFile('rails.png');
  request.addMultiPartData({
    data: image.read(), // must be a TiBlob
    name: "media[]",
    type: "image/png"
  });

  request.addEventListener('success', function(e) {
    alert('tweet with image sent :)');
  });
  request.addEventListener('failure', function(e) {
    alert(e.status + " ---> " + e.error);
  });
  request.perform();
});

var store = Twitter.createAccountStore();
store.grantPermission({
  granted: function(e) {
    var accounts = store.accounts();

    if(accounts.length == 0) {
      alert('No twitter accounts configured');
    } else {
      account = accounts[0];
      button.enabled = true;
    }
  }, 
  failure: function(e) {
    alert('Permission denied');
  }
});
