#import "Com0x82TwitterAccountProxy.h"

#import "TiUtils.h"

@implementation Com0x82TwitterAccountProxy
@synthesize description, identifier, username, credential;

-(id)initWithAccount:(ACAccount *)otherAccount {
  if(self = [super init]) {
    account = [otherAccount retain];
  }
  
  return self;
}

-(void)dealloc {
  RELEASE_TO_NIL(account);
  [super dealloc];
}

-(ACAccount *)account {
    if(account == nil) {
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *accountType  = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        account = [[ACAccount alloc] initWithAccountType:accountType];
        
        RELEASE_TO_NIL(accountStore);
    }
    
  return account;
}

#pragma mark Properties
// @name Accessing Properties

/** A human readable description of the account
 
 This property is available if the user grants the application access
 to this account; otherwise, it is `null`.
 
    var accountStore = ....
    var account = accountStore.accounts()[0];
    Ti.API.log(account.description);

 @return A human readable description of the account
 */
-(id)description {
  return [self account].accountDescription;
}

/** A unique identifier for this account.
 
    var accountStore = ...
    var account = accountStore.accounts()[0];
    Ti.API.log(account.identifier);
 
  @return A String with the unique identifier
 */
-(id)identifier {
  return [self account].identifier;
}

/** The username for this account
 
  This property needs to be set before the account is saved. After the account
  is saved, this property is available if the user grants the application
  access to this account; otherwise, it is `null`.
 
    var accountStore = ...
    var account = accountStore.accounts()[0];
    Ti.API.log(account.username);

  @return The username for this account
 */
-(id)username {
  return [self account].username;
}

/** 
 */
-(id)credential {
  Com0x82TwitterAccountCredentialProxy *retCredential = [[[Com0x82TwitterAccountCredentialProxy alloc] init] autorelease];
  retCredential.credential = [self account].credential;
  
  return retCredential;
}

/**
 *
 */
-(void)setUsername:(id)arg {
  [self account].username = [TiUtils stringValue:arg];
}

/**
 *
 */
-(void)setCredential:(id)arg {
  ENSURE_TYPE(arg, Com0x82TwitterAccountCredentialProxy);
  [self account].credential = [(Com0x82TwitterAccountCredentialProxy *)arg credential];
}

@end
