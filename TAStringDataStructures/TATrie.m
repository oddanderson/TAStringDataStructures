//
//  TATrie.h
//  TATrie
//
//  Created by Todd Anderson on 9/23/14.
//  Copyright (c) 2014 ToddAnderson. All rights reserved.
//

#import "TATrie.h"
#import "TATrieNode.h"

@implementation TATrie {
    TATrieNode *_topNode;
}

- (id)init {
    self = [super init];
    if (self) {
        _topNode = [[TATrieNode alloc] init];
    }
    return self;
}

- (void)addWord:(NSString *)word {
    [_topNode addSubstring:word];
}

- (NSArray *)wordsThatStartWith:(NSString *)substring {
    return [self wordsThatStartWith:substring caseSensitive:NO];
}

- (NSArray *)wordsThatStartWith:(NSString *)substring caseSensitive:(BOOL)caseSensitive {
    return [_topNode nodesThatStartWithSubstring:substring caseSensitive:caseSensitive];
}

- (BOOL)containsWord:(NSString *)word caseSensitive:(BOOL)caseSensitive {
    return [_topNode containsWord:word caseSensitive:caseSensitive];
}

- (BOOL)containsWord:(NSString *)word {
    return [self containsWord:word caseSensitive:NO];
}

- (BOOL)removeWord:(NSString *)word {
    return [_topNode removeWord:word];
}

@end
