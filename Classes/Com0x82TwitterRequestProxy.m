//
//  Com0x82TwitterRequestProxy.m
//  twitter
//
//  Created by Ruben Fonseca on 02/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Com0x82TwitterRequestProxy.h"
#import "Com0x82TwitterAccountProxy.h"

#import <Twitter/Twitter.h>

@implementation Com0x82TwitterRequestProxy

-(void)dealloc {
  RELEASE_TO_NIL(request);
  [super dealloc];
}

-(void)perform:(id)arg {
	[self rememberSelf];
	
	if(IOS6_OR_LATER) {
		[(SLRequest*)[self request] performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
				
				if ([urlResponse statusCode] == 200) {
					// Parse the responseData, which we asked to be in JSON format for this request, into an NSDictionary using NSJSONSerialization.
					NSError *jsonParsingError = nil;
					NSDictionary *output = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
					NSString *rawOutput = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
					
					NSDictionary *success_args = @{ @"status" : @([urlResponse statusCode]), @"data" : output, @"raw" : rawOutput };
					[self fireEvent:@"success" withObject:success_args];
				}
				else {
					NSMutableDictionary *failure_args = [NSMutableDictionary dictionary];
					
					[failure_args setValue:NUMINT([urlResponse statusCode]) forKey:@"status"];
					if(error) {
						[failure_args setValue:[error localizedDescription] forKey:@"error"];
					}
					
					[self fireEvent:@"failure" withObject:failure_args];
				}
			
			[self forgetSelf];
		}];
	} else {
		[(TWRequest*)[self request] performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
				
				if ([urlResponse statusCode] == 200) {
					// Parse the responseData, which we asked to be in JSON format for this request, into an NSDictionary using NSJSONSerialization.
					NSError *jsonParsingError = nil;
					NSDictionary *output = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
					NSString *rawOutput = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
					
					NSDictionary *success_args = @{ @"status" : @([urlResponse statusCode]), @"data" : output, @"raw" : rawOutput };
					[self fireEvent:@"success" withObject:success_args];
				}
				else {
					NSMutableDictionary *failure_args = [NSMutableDictionary dictionary];
					
					[failure_args setValue:NUMINT([urlResponse statusCode]) forKey:@"status"];
					if(error) {
						[failure_args setValue:[error localizedDescription] forKey:@"error"];
					}
					
					[self fireEvent:@"failure" withObject:failure_args];
				}
			
			[self forgetSelf];
		}];
	}
	
}

-(void)addMultiPartData:(id)value {
  ENSURE_DICT([value objectAtIndex:0]);
  NSDictionary *args = [value objectAtIndex:0];
  
  NSData *data = [(TiBlob*)[args objectForKey:@"data"] data];
	NSString *fileName = [[(TiBlob *)[args objectForKey:@"data"] nativePath] lastPathComponent];
  NSString *string = [TiUtils stringValue:@"name" properties:args];
  NSString *type = [TiUtils stringValue:@"type" properties:args def:[(TiBlob*)[args objectForKey:@"data"] mimeType]];
  
	if(IOS6_OR_LATER) {
		
  	[(SLRequest *)[self request] addMultipartData:data withName:string type:type filename:fileName];
	} else {
  	[(TWRequest *)[self request] addMultiPartData:data withName:string type:type];
	}
}

-(TWRequest *)request {
  if(request == nil) {
    NSURL *url = [NSURL URLWithString:[TiUtils stringValue:[self valueForUndefinedKey:@"url"]]];
    NSDictionary *params = [self valueForUndefinedKey:@"params"];
		
		if(IOS6_OR_LATER) {
			SLRequestMethod requestMethod = [TiUtils intValue:[self valueForUndefinedKey:@"method"]];
			request = [[SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:requestMethod URL:url parameters:params] retain];
		} else {
			TWRequestMethod requestMethod = [TiUtils intValue:[self valueForUndefinedKey:@"method"]];
			request = [[TWRequest alloc] initWithURL:url parameters:params requestMethod:requestMethod];
		}
  
    if([self valueForUndefinedKey:@"account"]) {
      Com0x82TwitterAccountProxy *account = (Com0x82TwitterAccountProxy *)[self valueForUndefinedKey:@"account"];
			
			if(IOS6_OR_LATER) {
				[(SLRequest *)request setAccount:account.account];
			} else {
      	[(TWRequest *)request setAccount:account.account];
			}
    }
  }
  
  return request;
}

@end
