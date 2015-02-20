//
//  WordTableViewDataSource.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "ALTableViewDataSourceWithFetchedResultsController.h"

@interface WordTableViewDataSource : ALTableViewDataSourceWithFetchedResultsController

- (instancetype)initWithLanguageDirection:(NSArray*)languageDirection
				andCellConfigurationBlock:(ALTableViewCellConfigurationBlock)cellConfigurationBlock
				   andReuseIdentiferBlock:(ALTableViewCellReuseIdentiferBlock)reuseIdentifierBlock;

@end
