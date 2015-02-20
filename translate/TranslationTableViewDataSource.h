//
//  TranslationTableViewDataSource.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "ALTableViewDataSourceWithFetchedResultsController.h"

@class Word;

@interface TranslationTableViewDataSource : ALTableViewDataSourceWithFetchedResultsController

- (instancetype)initWithWord:(Word*)word
   andCellConfigurationBlock:(ALTableViewCellConfigurationBlock)cellConfigurationBlock
	  andReuseIdentiferBlock:(ALTableViewCellReuseIdentiferBlock)reuseIdentifierBlock;

@end
