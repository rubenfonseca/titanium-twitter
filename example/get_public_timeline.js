var Twitter = Ti.UI.currentWindow.Twitter;

var tableview = Ti.UI.createTableView();
Ti.UI.currentWindow.add(tableview);

var request = Twitter.createRequest({
  url: 'http://api.twitter.com/1/statuses/public_timeline.json',
  method: Twitter.REQUEST_METHOD_GET
});

request.addEventListener('success', function(e) {
  var data = [];
  for(var i=0; i < e.data.length; i++) {
    var tweet = e.data[i];
    data.push({
      title: tweet.text
    });
  }

  tableview.data = data;
});

request.addEventListener('failure', function(e) {
  alert('no');
});

request.perform();
