#import "Com0x82TwitterModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@implementation Com0x82TwitterModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"a497fdc6-34d1-44ac-bed6-0dfbde939f9b";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.0x82.twitter";
}

#pragma mark Lifecycle

-(void)startup
{
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
  
  NSString *className = @"TWTweetComposeViewController";
  if(NSClassFromString(className) == nil) {
    [self throwException:@"The Twitter module only works on iOS5 and later" subreason:@"You are running an older version of iOS" location:CODELOCATION];
    return;
  }
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_canTweetStatus) name:ACAccountStoreDidChangeNotification object:nil];
}

#pragma Public APIs
- (void)_canTweetStatus {
  BOOL canTweet = [TWTweetComposeViewController canSendTweet];
    
  if([self _hasListeners:@"update"]) {
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:NUMBOOL(canTweet), @"canSendTweet", nil];
        
    [self fireEvent:@"update" withObject:args];
  }
}

MAKE_SYSTEM_PROP(DONE, TWTweetComposeViewControllerResultDone);
MAKE_SYSTEM_PROP(CANCELLED, TWTweetComposeViewControllerResultCancelled);

MAKE_SYSTEM_PROP(REQUEST_METHOD_GET, TWRequestMethodGET);
MAKE_SYSTEM_PROP(REQUEST_METHOD_POST, TWRequestMethodPOST);
MAKE_SYSTEM_PROP(REQUEST_METHOD_DELETE, TWRequestMethodDELETE);

@end
