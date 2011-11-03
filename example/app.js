// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

var Twitter = require('com.0x82.twitter');
Ti.API.info("module is => " + Twitter);

var navigationWindow = Titanium.UI.createWindow();

var window = Ti.UI.createWindow({
	backgroundColor:'white',
  title: 'Twitter.framework'
});

var nav = Titanium.UI.iPhone.createNavigationGroup({
   window: window
});
navigationWindow.add(nav);
navigationWindow.open();

var data = [
  {title:"Send Simple Tweet", hasChild:true, url:'send_simple_tweet.js', header:'Composer'},
  {title:"Send Tweet with URL", hasChild:true, url:'send_tweet_with_url.js'},
  {title:"Send Tweet with Attachment", hasChild:true, url:'send_tweet_with_attachment.js'},
  {title:"Get accounts", hasChild:true, url:'get_accounts.js', header:'Accounts'},
  {title:"Create Account", hasChild:true, url:'create_account.js'},
  {title:"Get Public Timeline", hasChild:true, url:'get_public_timeline.js', header:'TWRequest'},
  {title:"Get Home Timeline (auth)", hasChild:true, url:'get_user_timeline.js'},
  {title:"Send Custom Tweet (auth)", hasChild:true, url:'send_custom_tweet.js'}
]

var tableViewOptions = {
  data: data,
  style: Ti.UI.iPhone.TableViewStyle.GROUPED
};

var tableview = Ti.UI.createTableView(tableViewOptions);
window.add(tableview);

tableview.addEventListener('click', function(e) {
  if(e.rowData.url) {
    var win = Ti.UI.createWindow({
      url: e.rowData.url,
      title: e.rowData.title,
      backgroundColor: 'white',
      Twitter: Twitter,
      nav: nav
    });

    nav.open(win, {animated:true});
  }
});
