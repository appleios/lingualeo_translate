//
//  ALManagedObjectFactory+CreateWord.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "ALManagedObjectFactory.h"

@class Word;
@class Language;

@interface ALManagedObjectFactory (CreateWord)

- (Word*)createWordWithString:(NSString*)string
				   inLanguage:(Language*)language;

@end
