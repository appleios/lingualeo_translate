//
//  ALManagedObjectFactory+CreateTranslation.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "ALManagedObjectFactory.h"
#import "Language.h"
@class Word;

@interface ALManagedObjectFactory (CreateLanguage)

- (Language*)createLanguageWithShortName:(NSString*)shortName;

@end
