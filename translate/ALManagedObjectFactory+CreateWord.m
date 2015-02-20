//
//  ALManagedObjectFactory+CreateWord.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "ALManagedObjectFactory+CreateWord.h"
#import "Word.h"
#import "Language.h"

@implementation ALManagedObjectFactory (CreateWord)

- (Word*)createWordWithString:(NSString*)string
				   inLanguage:(Language*)language
{
	Word *product = (Word*)[self createObjectForEntityClass:Word.class];
	product.string = string;
	product.language = language;
	return product;
}

@end
