//
//  Com0x82TwitterRequestProxy.h
//  twitter
//
//  Created by Ruben Fonseca on 02/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"
#import "TiUtils.h"

@interface Com0x82TwitterRequestProxy : TiProxy {
  
  @private
  id request;
}

-(id)request;

@end
