# twitter Module

## Description

Tap into the new iOS5 Twitter.framework

## Installation

[http://wiki.appcelerator.org/display/tis/Using+Titanium+Modules]()

## Changelog

See [here](changelog.html)

## Accessing the twitter Module

To access this module from JavaScript, you would do the following:

	var Twitter = require("com.0x82.twitter");

The Twitter variable is a reference to the Module object.	

### iOS5 module only

This is an iOS5 module only! If you try to require it on an iOS < = 4 device,
it will throw an exception. So you should include some sort of code on
your application to check in which version of iOS are you running, and then
decide to use or not use this module

    function isiOS5Plus()
    {
      // add iphone specific tests
      if (Titanium.Platform.name == 'iPhone OS')
      {
        var version = Titanium.Platform.version.split(".");
        var major = parseInt(version[0],10);
    
        if (major >= 5)
        {
          return true;
        }
      }
      return false;
    }  

## Reference

Please visit the following links to see the different classes of the application:

- [TweetComposerView](tweet_composer_view.html)
- [Account](account.html)
- [AccountCredential](account_credential.html)
- [AccountStore](account_store.html)
- [Request](request.html)

### Events

#### update

The 'update' event is fired on the Twitter module eveytime something changes about Twitter
authentication. The event is sent with the following param:

- *canSendTweet*: a boolean value (true/false) indicating if you are now able to send a tweet
  on behalf the user

Example usage:

    Twitter.addEventListener('update', function(e) {
      if(e.canSendTweet)
        alert('Now we can send tweets :D');
      else
        alert('You are not allowed to send tweets, please check your authorization');
    });

### Constants

#### Twitter.DONE

#### Twitter.CANCELLED

Used when the [TweetComposerView](tweet_composer_view.html) finished sending a tweet.

#### Twitter.REQUEST_METHOD_GET

#### Twitter.REQUEST_METHOD_POST

#### Twitter.REQUEST_METHOD_DELETE

Used on [Request](request.html) to specify the type of request to be made to Twitter

## Usage

Please see the example directory, since it contains several examples of all the API.

## Author

Rúben Fonseca, (C) 2011
