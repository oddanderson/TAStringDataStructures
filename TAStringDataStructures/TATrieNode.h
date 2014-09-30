//
//  TATrieNode.h
//  TATrieNode
//
//  Created by Todd Anderson on 9/23/14.
//  Copyright (c) 2014 ToddAnderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TATrieNode : NSObject

- (void)addSubstring:(NSString *)substring withObject:(id)object;
- (NSArray *)nodesThatStartWithSubstring:(NSString *)substring caseSensitive:(BOOL)caseSensitive returnWords:(BOOL)returnWords;
- (BOOL)containsWord:(NSString *)word caseSensitive:(BOOL)caseSensitive;
- (BOOL)removeWord:(NSString *)word;
- (id)objectForWord:(NSString *)word;

@end
