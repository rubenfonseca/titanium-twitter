/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "Com0x82TwitterAccountStoreProxy.h"
#import "Com0x82TwitterAccountProxy.h"
#import "TiUtils.h"

@implementation Com0x82TwitterAccountStoreProxy

-(id)init {
  if(self = [super init]) {
    accountStore = [[ACAccountStore alloc] init];
    accountType  = [[accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter] retain];
  }
  
  return self;
}

-(void)dealloc {
  RELEASE_TO_NIL(accountStore);
  RELEASE_TO_NIL(accountType);
  
  RELEASE_TO_NIL(saveSuccessCallback);
  RELEASE_TO_NIL(saveFailureCallback);
  
  RELEASE_TO_NIL(permissionGrantedCallback);
  RELEASE_TO_NIL(permissionDeniedCallback);
  
  [super dealloc];
}

-(void)grantPermission:(id)array {
  NSDictionary *args = [array objectAtIndex:0];
  
  id granted = [args objectForKey:@"granted"];
  id denied = [args objectForKey:@"denied"];
  
  permissionGrantedCallback = [granted retain];
  permissionDeniedCallback = [denied retain];
  
	if(IOS6_OR_LATER) {
		[accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
			if(granted) {
				if(permissionGrantedCallback)
					[self _fireEventToListener:@"granted" withObject:nil listener:permissionGrantedCallback thisObject:nil];
			} else {
				if(permissionDeniedCallback)
					[self _fireEventToListener:@"denied" withObject:@{@"error": [error localizedDescription]} listener:permissionDeniedCallback thisObject:nil];
			}
			
			RELEASE_TO_NIL(permissionGrantedCallback);
			RELEASE_TO_NIL(permissionDeniedCallback);
		}];
	} else {
		[accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
			if(granted) {
				if(permissionGrantedCallback)
					[self _fireEventToListener:@"granted" withObject:nil listener:permissionGrantedCallback thisObject:nil];
			} else {
				if(permissionDeniedCallback)
					[self _fireEventToListener:@"denied" withObject:@{@"error": [error localizedDescription]} listener:permissionDeniedCallback thisObject:nil];
			}
			
			RELEASE_TO_NIL(permissionGrantedCallback);
			RELEASE_TO_NIL(permissionDeniedCallback);
		}];
	}
}

-(id)accounts:(id)args {
  NSArray *accounts = [accountStore accountsWithAccountType:accountType];
  
  NSMutableArray *retArray = [NSMutableArray array];
  for(ACAccount *account in accounts) {
    Com0x82TwitterAccountProxy *accountProxy = [[Com0x82TwitterAccountProxy alloc] initWithAccount:account];
    [retArray addObject:accountProxy];
    [accountProxy release];
  }
  
  return retArray;
}

-(id)accountWithIdentifier:(id)arg {
  NSString *identifier = [TiUtils stringValue:[arg objectAtIndex:0]];
  
  ACAccount *account = [accountStore accountWithIdentifier:identifier];
  if(account) {
    return [[[Com0x82TwitterAccountProxy alloc] initWithAccount:account] autorelease];
  } else {
    return nil;
  }
}

-(void)saveAccount:(id)args {
  Com0x82TwitterAccountProxy *accountProxy;
  ENSURE_ARG_AT_INDEX(accountProxy, args, 0, Com0x82TwitterAccountProxy);
  
  NSDictionary *dict = [args objectAtIndex:1];
  id success = [dict objectForKey:@"success"];
  id failure = [dict objectForKey:@"failure"];
  
  saveSuccessCallback = [success retain];
  saveFailureCallback = [failure retain];
  
  [accountStore saveAccount:accountProxy.account withCompletionHandler:^(BOOL success, NSError *error) {
    if(success) {
      [self _fireEventToListener:@"success" withObject:nil listener:saveSuccessCallback thisObject:nil];
    } else {
      NSMutableDictionary *event = TiCreateNonRetainingDictionary();
      if(error) {
        [event setObject:[error localizedDescription] forKey:@"error"];
      }
      
      [self _fireEventToListener:@"failure" withObject:event listener:saveFailureCallback thisObject:nil];
    }
    
    RELEASE_TO_NIL(saveSuccessCallback);
    RELEASE_TO_NIL(saveFailureCallback);
  }];
}

@end
