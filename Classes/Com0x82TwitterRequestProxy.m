//
//  Com0x82TwitterRequestProxy.m
//  twitter
//
//  Created by Ruben Fonseca on 02/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Com0x82TwitterRequestProxy.h"
#import "Com0x82TwitterAccountProxy.h"

@implementation Com0x82TwitterRequestProxy

-(void)dealloc {
  RELEASE_TO_NIL(request);
  [super dealloc];
}

-(void)perform:(id)arg {
  [[self request] performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
    
		if ([urlResponse statusCode] == 200) {
			// Parse the responseData, which we asked to be in JSON format for this request, into an NSDictionary using NSJSONSerialization.
			NSError *jsonParsingError = nil;
			NSDictionary *output = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
      
      NSDictionary *success_args = [NSDictionary dictionaryWithObjectsAndKeys:NUMINT([urlResponse statusCode]), @"status", output, @"data", nil];
      [self fireEvent:@"success" withObject:success_args];
		}
		else {
      NSDictionary *failure_args = TiCreateNonRetainingDictionary();
      
      [failure_args setValue:NUMINT([urlResponse statusCode]) forKey:@"status"];
      
      if(error) {
        [failure_args setValue:[error localizedDescription] forKey:@"error"];
      }
      
      [self fireEvent:@"failure" withObject:failure_args];
		}
  }];
}

-(void)addMultiPartData:(id)value {
  ENSURE_DICT([value objectAtIndex:0]);
  NSDictionary *args = [value objectAtIndex:0];
  
  NSData *data = [(TiBlob*)[args objectForKey:@"data"] data];
  NSString *string = [TiUtils stringValue:@"name" properties:args];
  NSString *type = [TiUtils stringValue:@"type" properties:args def:[(TiBlob*)[args objectForKey:@"data"] mimeType]];
  
  [[self request] addMultiPartData:data withName:string type:type];
}

-(TWRequest *)request {
  if(request == nil) {
    NSURL *url = [NSURL URLWithString:[TiUtils stringValue:[self valueForUndefinedKey:@"url"]]];
    TWRequestMethod requestMethod = [TiUtils intValue:[self valueForUndefinedKey:@"method"]];
    NSDictionary *params = [self valueForUndefinedKey:@"params"];
    
    request = [[TWRequest alloc] initWithURL:url parameters:params requestMethod:requestMethod];
  
    if([self valueForUndefinedKey:@"account"]) {
      Com0x82TwitterAccountProxy *account = (Com0x82TwitterAccountProxy *)[self valueForUndefinedKey:@"account"];
      [request setAccount:account.account];
    }
  }
  
  return request;
}

@end
