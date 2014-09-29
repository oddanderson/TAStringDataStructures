//
//  TATrieNode.h
//  TATrieNode
//
//  Created by Todd Anderson on 9/23/14.
//  Copyright (c) 2014 ToddAnderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TATrieNode : NSObject

- (void)addSubstring:(NSString *)substring;
- (NSArray *)nodesThatStartWithSubstring:(NSString *)substring caseSensitive:(BOOL)caseSensitive;
- (BOOL)containsWord:(NSString *)word caseSensitive:(BOOL)caseSensitive;
- (BOOL)removeWord:(NSString *)word;

@end
