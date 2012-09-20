#import "Com0x82TwitterTweetComposerViewProxy.h"
#import "TiUtils.h"
#import "TiBase.h"
#import "TiApp.h"

@implementation Com0x82TwitterTweetComposerViewProxy

-(id)init {
    if(self = [super init]) {
			if(IOS6_OR_LATER) {
				SLComposeViewController *c = [[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter] retain];
				
				c.completionHandler = ^(SLComposeViewControllerResult result) {
					if([self _hasListeners:@"complete"]) {
						[self fireEvent:@"complete" withObject:@{ @"result" : @(result) }];
					}
					
					[[TiApp controller] dismissViewControllerAnimated:YES completion:nil];
				};
				
				tweetComposeViewController = c;
			} else {
        TWTweetComposeViewController *c = [[TWTweetComposeViewController alloc] init];
				
				c.completionHandler = ^(TWTweetComposeViewControllerResult result) {
					if([self _hasListeners:@"complete"]) {
							NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:NUMINT(result), @"result", nil];
					
							[self fireEvent:@"complete" withObject:args];
					}
					
					[[TiApp controller] dismissViewControllerAnimated:YES completion:nil];
				};
				
				tweetComposeViewController = c;
			}
				
			
    }
    
    return self;
}

-(void)dealloc {
    RELEASE_TO_NIL(tweetComposeViewController);
    [super dealloc];
}

/// @name Checking Status

/** Returns whether you can send a Twitter request.
 
    var composer = Twitter.createComposerView();
    if(composer.canSendTweet()) {
      alert("Can send tweet");
    } else {
      alert("Oops");
    }
 
 @returns `true` if Twitter is accessible and at least one account is setup; otherwise, `false`.
 */
-(id)canSendTweet:(id)args {
	return IOS6_OR_LATER ? @([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) : @([TWTweetComposeViewController canSendTweet]);
}

/// @name Composing Tweets

/** Sets the initial text for a tweet.
 
    var composer = Twitter.createComposerView();
    composer.setInitialText("Hello Tweet");
 
 @param text The text to add to the tweet.
 @return `true` if successful. `false` if text does not fit in the currently available character space or the view was presented to the user.
 */
-(id)setInitialText:(id)text {
    dispatch_sync(dispatch_get_main_queue(), ^(void) {
			if(IOS6_OR_LATER)
				retSetInitialText = [(SLComposeViewController *)tweetComposeViewController setInitialText:text];
			else
        retSetInitialText = [(TWTweetComposeViewController *)tweetComposeViewController setInitialText:[TiUtils stringValue:text]];
    });
    
    return NUMBOOL(retSetInitialText);
}

/** Adds an image to the tweet.
 
    var composer = Twitter.createComposerView();
    var image = Ti.Filesystem.getFile('rails.png');
    composer.addImage(image.read()); // always use a TiBlob!
 
 If you want to remove any image from the tweet, use the method removeAllImages:
 
 @param args The image blob to add to the Tweet
 @return `true` if successful. `false` if image does not fit in the currently available character space or the view was presented to the user.
 */
-(id)addImage:(id)args {
    TiBlob *blob;
    
    ENSURE_ARG_AT_INDEX(blob, args, 0, TiBlob);
    UIImage *image = [blob image];
    
    dispatch_sync(dispatch_get_main_queue(), ^(void) {
			if(IOS6_OR_LATER)
				retAddImage = [(SLComposeViewController *)tweetComposeViewController addImage:image];
			else
        retAddImage = [(TWTweetComposeViewController *)tweetComposeViewController addImage:image];
    });
    
    return NUMBOOL(retAddImage);
}

/** Removes all images from the tweet.
 
 @return `true` if successful. `false` if the images were not removed because the view was presented to the user.
 */
-(id)removeAllImages:(id)args {
    dispatch_sync(dispatch_get_main_queue(), ^(void) {
			if(IOS6_OR_LATER)
				retRemoveAllImages = [(SLComposeViewController *)tweetComposeViewController removeAllImages];
			else
        retRemoveAllImages = [(TWTweetComposeViewController *)tweetComposeViewController removeAllImages];
    });
    
    return NUMBOOL(retRemoveAllImages);
}

-(id)addURL:(id)args {
    NSString *urlString = [TiUtils stringValue:[args objectAtIndex:0]];
    
    dispatch_sync(dispatch_get_main_queue(), ^(void) {
			if(IOS6_OR_LATER)
				retAddURL = [(SLComposeViewController *)tweetComposeViewController addURL:[NSURL URLWithString:urlString]];
			else
        retAddURL = [(TWTweetComposeViewController *)tweetComposeViewController addURL:[NSURL URLWithString:urlString]];
    });
    
    return NUMBOOL(retAddURL);
}

-(id)removeAllURLs:(id)arg {
    dispatch_sync(dispatch_get_main_queue(), ^(void) {
			if(IOS6_OR_LATER)
				retRemoveAllURLs = [(SLComposeViewController *)tweetComposeViewController removeAllURLs];
			else
        retRemoveAllURLs = [(TWTweetComposeViewController *)tweetComposeViewController removeAllURLs];
    });
    
    return NUMBOOL(retRemoveAllURLs);
}

-(void)open:(id)arg {
    ENSURE_UI_THREAD_0_ARGS
	
	[[TiApp app] showModalController:tweetComposeViewController animated:YES];
}

@end
