# TweetComposerView

## Description

The TweetComposerViewController class presents a view to the user to compose a tweet.

Although you may perform Twitter requests on behalf of the user, you cannot
append text, images, or URLs to tweets without the user’s knowledge. Hence, you
can set the initial text and other content before presenting the tweet to the
user but cannot change the tweet after the user views it. All of the methods
used to set the content of the tweet return a Boolean value. The methods return
`false` if the content doesn’t fit in the tweet or the view was already presented to
the user and the tweet can no longer be changed.

## Reference

### - canSendTweet()

Returns whether you can send a Twitter request.

    var composer = Twitter.createComposerView();
    if(composer.canSendTweet()) {
      alert("Can send tweet");
    } else {
      alert("Oops");
    }

### - setInitialText(text)

Sets the initial text for a tweet. Returns `true` if successful. `false` if text does not fit in the currently
available character space or the view was presented to the user.

    var composer = Twitter.createComposerView();
    composer.setInitialText("Hello Tweet");

### - addImage(blob)

Adds an image to the tweet. The argument bust be a `TiBlob` (check the example). Returns `true` if successful. `false`
if image does not fit in the currently available character space or the view was presented to the user.


    var composer = Twitter.createComposerView();
    var image = Ti.Filesystem.getFile('rails.png');
    composer.addImage(image.read()); // always use a TiBlob!

### - removeAllImages()

Removes all images from the tweet. Returns `true` if successful. `false` if the images were not removed because the
view was presented to the user.

    var composer = Twitter.createComposerView();
    composer.removeAllImages();

### - addURL(url)

Adds a URL to the tweet. Returns `true` if successful. `false` if url does not
fit in the currently available character space or the view was presented to the
user.

    var composer = Twitter.createComposerView();
    composer.addURL('http://google.com');

### - removeAllURLs()

Removes all URLs from the tweet. Returns `true` if successful. `false` if the
URLs were not removed because the view was presented to the user.

    var composer = Twitter.createComposerView();
    composer.removeAllURLs();

### - open()

Opens the Tweet sheet to the user, so he/she can personalize the message and finally send
the tweet. The view will appear in front of all the present views, and works as a modal
window.

    var composer = Twitter.createComposerView();
    composer.open();

## Events

### - complete

Sent after the user sends or cancels a Tweet. The event object contains a key `result` with
the result of the operation.

    var composer = Twitter.createComposerView();
    composer.addEventListener('complete', function(e) {
      if(e.result == Twitter.DONE)
        alert('Sent! :D');
      
      if(e.result == Twitter.CANCELLED)
        alert('Cancelled :(');
    });
    composer.open();

### 

