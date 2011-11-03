//
//  Com0x82TwitterAccountCredentialProxy.m
//  twitter
//
//  Created by Ruben Fonseca on 02/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Com0x82TwitterAccountCredentialProxy.h"

#import "TiUtils.h"

@implementation Com0x82TwitterAccountCredentialProxy
@synthesize credential;

-(void)dealloc {
  RELEASE_TO_NIL(credential);
  [super dealloc];
}

-(ACAccountCredential*)credential {
  if(credential == nil) {
    NSString *token = [TiUtils stringValue:[self valueForUndefinedKey:@"oauth_token"]];
    NSString *secret = [TiUtils stringValue:[self valueForUndefinedKey:@"token_secret"]];
    
    credential = [[ACAccountCredential alloc] initWithOAuthToken:token tokenSecret:secret];
  }
  
  return credential;
}

@end
