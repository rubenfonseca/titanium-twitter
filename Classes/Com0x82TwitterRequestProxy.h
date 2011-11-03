//
//  Com0x82TwitterRequestProxy.h
//  twitter
//
//  Created by Ruben Fonseca on 02/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"
#import "TiUtils.h"

#import <Twitter/Twitter.h>

@interface Com0x82TwitterRequestProxy : TiProxy {
  
  @private
  TWRequest *request;
}

-(TWRequest *)request;

@end
