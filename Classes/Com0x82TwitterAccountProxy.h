//
//  Com0x82TwitterAccountProxy.h
//  twitter
//
//  Created by Ruben Fonseca on 02/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"
#import "Com0x82TwitterAccountCredentialProxy.h"

#import <Accounts/Accounts.h>

@interface Com0x82TwitterAccountProxy : TiProxy {
  @private
  ACAccount *account;
}

@property(nonatomic,readwrite,assign) NSString *description;
@property(nonatomic,readwrite,assign) NSString *identifier;
@property(nonatomic,readwrite,assign) NSString *username;
@property(nonatomic,readwrite,assign) Com0x82TwitterAccountCredentialProxy *credential;

@property (nonatomic, readonly) ACAccount *account;

-(id)initWithAccount:(ACAccount *)account;

@end
