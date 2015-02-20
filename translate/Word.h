//
//  Word.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Language, Word;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * string;
@property (nonatomic, retain) Language *language;
@property (nonatomic, retain) NSSet *translations;
@property (nonatomic, retain) Word *sourceWord;
@end

@interface Word (CoreDataGeneratedAccessors)

- (void)addTranslationsObject:(Word *)value;
- (void)removeTranslationsObject:(Word *)value;
- (void)addTranslations:(NSSet *)values;
- (void)removeTranslations:(NSSet *)values;

@end
