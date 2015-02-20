//
//  ALManagedObjectFactory+CreateTranslation.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "ALManagedObjectFactory+CreateLanguage.h"
#import "Word.h"

@implementation ALManagedObjectFactory (CreateLanguage)

- (Language*)createLanguageWithShortName:(NSString*)shortName
{
	Language *product = (Language*)[self createObjectForEntityClass:Language.class];
	product.shortName = shortName;
	return product;
}


@end
