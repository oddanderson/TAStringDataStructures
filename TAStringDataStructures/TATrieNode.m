//
//  TATrieNode.h
//  TATrieNode
//
//  Created by Todd Anderson on 9/23/14.
//  Copyright (c) 2014 ToddAnderson. All rights reserved.
//

#import "TATrieNode.h"

@interface TATrieNode ()
@property (nonatomic, getter = isFinal) BOOL final;
@end

@implementation TATrieNode {
    NSMutableDictionary *_children;
}

- (id)init {
    self = [super init];
    if (self) {
        _children = [NSMutableDictionary new];
    }
    return self;
}

- (void)addSubstring:(NSString *)substring {
    
    if (substring.length == 0) {
        _final = YES;
        return;
    }
    
    NSString *firstChar = [substring substringToIndex:1];
    TATrieNode *nextChild = [_children objectForKey:firstChar];
    if (!nextChild) {
        nextChild = [[TATrieNode alloc] init];
        [_children setObject:nextChild forKey:firstChar];
    }
    [nextChild addSubstring:[substring substringFromIndex:1]];
}

- (NSArray *)nodesThatStartWithSubstring:(NSString *)substring caseSensitive:(BOOL)caseSensitive {
    
    NSMutableString *compiledWord = [[NSMutableString alloc] init];
    NSMutableArray *array = [NSMutableArray new];
    [self _addNodesThatStartWithSubstring:substring toArray:array compiledWord:compiledWord caseSensitive:caseSensitive];
    return array;
}

- (void)_addNodesThatStartWithSubstring:(NSString *)substring
                                toArray:(NSMutableArray *)array
                           compiledWord:(NSMutableString *)word
                          caseSensitive:(BOOL)caseSensitive {
    if (substring.length == 0) {
        if (self.isFinal) {
            [array addObject:word];
        }
        [self _addAllChildNodesToArray:array compiledWord:word];
        return;
    }
    NSString *firstChar = [substring substringToIndex:1];
    NSString *newSubstring = [substring substringFromIndex:1];
    if (caseSensitive) {
        [self _recursivelyAddNodesThatStartWithSubstring:newSubstring
                                                 toArray:array
                                            compiledWord:word
                                           caseSensitive:caseSensitive
                                          firstCharacter:firstChar];
    } else {
        NSString *lowercaseChar = [firstChar lowercaseString];
        NSString *uppercaseChar = [firstChar uppercaseString];
        [self _recursivelyAddNodesThatStartWithSubstring:newSubstring
                                                 toArray:array
                                            compiledWord:word
                                           caseSensitive:caseSensitive
                                          firstCharacter:lowercaseChar];
        [self _recursivelyAddNodesThatStartWithSubstring:newSubstring
                                                 toArray:array
                                            compiledWord:word
                                           caseSensitive:caseSensitive
                                          firstCharacter:uppercaseChar];

    }
    
}

- (void)_recursivelyAddNodesThatStartWithSubstring:(NSString *)substring
                                           toArray:(NSMutableArray *)array
                                      compiledWord:(NSString *)compiledWord
                                     caseSensitive:(BOOL)caseSensitive
                                    firstCharacter:(NSString *)firstChar {
    TATrieNode *nextChild = [_children objectForKey:firstChar];
    if (nextChild) {
        NSMutableString *newWord = [[NSMutableString alloc] initWithString:compiledWord];
        [newWord appendString:firstChar];
        [nextChild _addNodesThatStartWithSubstring:substring toArray:array compiledWord:newWord caseSensitive:caseSensitive];
    }
}

- (void)_addAllChildNodesToArray:(NSMutableArray *)array compiledWord:(NSMutableString *)word {
    for (NSString *value in _children.allKeys) {
        TATrieNode *child = _children[value];
        NSMutableString *newWord = [[NSMutableString alloc] initWithString:word];
        [newWord appendString:value];
        if (child.isFinal) {
            [array addObject:newWord];
        }
        [child _addAllChildNodesToArray:array compiledWord:newWord];
    }
}

- (BOOL)containsWord:(NSString *)word caseSensitive:(BOOL)caseSensitive {
    if (caseSensitive) {
        return [self _containsExactWord:word];
    } else {
        return [self _containsCaseInsensitiveWord:word];
    }
}

- (BOOL)_containsExactWord:(NSString *)word {
    if (!word.length) {
        if (_final) {
            return YES;
        }
        return NO;
    }
    NSString *firstChar = [word substringToIndex:1];
    TATrieNode *child = [_children objectForKey:firstChar];
    return [child _containsExactWord:[word substringFromIndex:1]];
}

- (BOOL)_containsCaseInsensitiveWord:(NSString *)word {
    if (!word.length) {
        if (_final) {
            return YES;
        }
        return NO;
    }
    NSString *firstChar = [word substringToIndex:1];
    NSString *lowercaseChar = [firstChar lowercaseString];
    NSString *uppercaseChar = [firstChar uppercaseString];
    NSString *substring = [word substringFromIndex:1];
    TATrieNode *lowercaseChild = [_children objectForKey:lowercaseChar];
    TATrieNode *uppercaseChild = [_children objectForKey:uppercaseChar];
    BOOL containsLowercase = [lowercaseChild _containsCaseInsensitiveWord:substring];
    BOOL containsUppercase = [uppercaseChild _containsCaseInsensitiveWord:substring];
    return containsLowercase || containsUppercase;
}

- (BOOL)removeWord:(NSString *)word {
    
    TATrieNode *leafNode = [self _nodeForString:word];
    if (!leafNode || !leafNode.isFinal) {
        return NO; //does not exist
    }
    leafNode.final = NO;
    if (leafNode->_children.allKeys.count) {
        return YES;
    }
    TATrieNode *parentNode = [self _nodeForString:[word substringToIndex:word.length - 1]];
    for (NSInteger index = word.length - 1; index >= 0; index--) {
        if (leafNode->_children.allKeys.count) {
            break;
        }
        if (leafNode.isFinal) {
            break;
        }
        NSString *lastChar = [word substringWithRange:NSMakeRange(index, 1)];
        [parentNode->_children removeObjectForKey:lastChar];
        leafNode = parentNode;
        parentNode = [self _nodeForString:[word substringToIndex:index - 1]];
    }
    return YES;
}

- (TATrieNode *)_nodeForString:(NSString *)string {
    if (string.length == 0) {
        return self;
    }
    NSString *firstChar = [string substringToIndex:1];
    TATrieNode *nextChild = _children[firstChar];
    if (nextChild) {
        return [nextChild _nodeForString:[string substringFromIndex:1]];
    } else {
        return nil;
    }
}


@end
