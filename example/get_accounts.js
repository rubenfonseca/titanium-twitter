var Twitter = Ti.UI.currentWindow.Twitter;

var tableview = Ti.UI.createTableView();

var store = Twitter.createAccountStore();

function load_accounts() {
  Ti.API.warn("Done loading accounts");
  var accounts = store.accounts();

  var data = [];
  for(var i=0; i<accounts.length; i++) {
    var account = accounts[i];
    data.push({
      title: account.username + " [" + account.description + "]",
      account: account
    });

    tableview.data = data;
  }
}

store.grantPermission({
  granted: function(e) {
    load_accounts();
  }, 
  denied: function(e) {
    Ti.API.error("Error: " + e.error);
    alert('Permission denied');
  }
});

tableview.addEventListener('click', function(e) {
  alert(e.rowData.account.identifier);
});

Ti.UI.currentWindow.add(tableview);
