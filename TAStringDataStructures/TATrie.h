//
//  TATrie.h
//  TATrie
//
//  Created by Todd Anderson on 9/23/14.
//  Copyright (c) 2014 ToddAnderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TATrie : NSObject

/**
 * Add a word to the trie.
 */
- (void)addWord:(NSString *)word;

/**
 * Does addWord, but allows you to set an object to the word similar to a dictionary
 */
- (void)setObject:(id)object forWord:(NSString *)word;

/**
 * Get all words that start with the given string. Case sensitive = NO
 */
- (NSArray *)wordsThatStartWith:(NSString *)substring;

/**
 * Get all words that start with the given string.
 */
- (NSArray *)wordsThatStartWith:(NSString *)substring caseSensitive:(BOOL)caseSensitive;

/**
 * Get all objects for words that start with the given string. Case sensitive = NO
 */
- (NSArray *)objectsForWordsThatStartWith:(NSString *)substring;

/**
 * Get all objects for words that start with the given string.
 */
- (NSArray *)objectsForWordsThatStartWith:(NSString *)substring caseSensitive:(BOOL)caseSensitive;

/**
 * Remove a word from the trie. Assumes case does not matter. Returns true if it found word
 */
- (BOOL)removeWord:(NSString *)word;

/**
 * Explicitly do not support removing word that is case insensitive.  This is not a deterministic removal
 * therefore there is no value in removing a word that may not meet user expectations.  The edge case of concern: same
 * word exists in different case patterns.  Cannot possibly know which to remove.  If this is needed, you can
 * implement your own variation, but make sure to account for this case
 */
//- (BOOL)removeWord:(NSString *)word caseSensitive:(BOOL)caseSensitive;

/*
 * Returns true if the word is in the trie. Case sensitive indicates whether lower/uppercase matters
 */
- (BOOL)containsWord:(NSString *)word caseSensitive:(BOOL)caseSensitive;

/**
 * Returns true if the Trie contains the specified word.  Case sensitive = NO
 */
- (BOOL)containsWord:(NSString *)word;

/**
 * Returns the object for the word, case sensitive = YES
 */
- (id)objectForWord:(NSString *)word;

@end