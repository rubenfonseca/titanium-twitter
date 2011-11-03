//
//  Com0x82TwitterAccountCredentialProxy.h
//  twitter
//
//  Created by Ruben Fonseca on 02/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"

#import <Accounts/Accounts.h>

@interface Com0x82TwitterAccountCredentialProxy : TiProxy {
 @private
  ACAccountCredential *credential;
}

@property (nonatomic,retain) ACAccountCredential *credential;

@end
