/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"

#import <Twitter/Twitter.h>

@interface Com0x82TwitterTweetComposerViewProxy : TiProxy {
@private
		id tweetComposeViewController;

    BOOL retSetInitialText;
    BOOL retAddImage;
    BOOL retAddURL;
    BOOL retRemoveAllURLs;
    BOOL retRemoveAllImages;
}

@end
