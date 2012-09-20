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
	
  NSString *className;
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
		className = @"SLComposeViewController";
	else
		className = @"TWTweetComposeViewController";
	
  if(NSClassFromString(className) == nil) {
    [self throwException:@"The Twitter module only works on iOS5 and later" subreason:@"You are running an older version of iOS" location:CODELOCATION];
    return;
  }
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_canTweetStatus) name:ACAccountStoreDidChangeNotification object:nil];
}

#pragma Public APIs
- (void)_canTweetStatus {
  BOOL canTweet;
	
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
		canTweet = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
	else
		canTweet = [TWTweetComposeViewController canSendTweet];
    
  if([self _hasListeners:@"update"]) {
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:NUMBOOL(canTweet), @"canSendTweet", nil];
        
    [self fireEvent:@"update" withObject:args];
  }
}

-(NSNumber*)DONE {
	if(IOS6_OR_LATER)
		return NUMINT(SLComposeViewControllerResultDone);
	else
		return NUMINT(TWTweetComposeViewControllerResultDone);
}

-(NSNumber *)CANCELLED {
	if(IOS6_OR_LATER)
		return NUMINT(SLComposeViewControllerResultCancelled);
	else
		return NUMINT(TWTweetComposeViewControllerResultCancelled);
}

-(NSNumber *)REQUEST_METHOD_GET {
	return @(IOS6_OR_LATER ? SLRequestMethodGET : TWRequestMethodGET);
}

-(NSNumber *)REQUEST_METHOD_POST {
	return @(IOS6_OR_LATER ? SLRequestMethodPOST : TWRequestMethodPOST);
}

-(NSNumber *)REQUEST_METHOD_DELETE {
	return @(IOS6_OR_LATER ? SLRequestMethodDELETE : TWRequestMethodDELETE);
}

@end
