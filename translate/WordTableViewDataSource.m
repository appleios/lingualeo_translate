//
//  WordTableViewDataSource.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "WordTableViewDataSource.h"
#import "Language.h"
#import "Word.h"

#import <ALCoreDataManager+Singleton.h>

@implementation WordTableViewDataSource

- (instancetype)initWithLanguageDirection:(NSArray*)languageDirection
				andCellConfigurationBlock:(ALTableViewCellConfigurationBlock)cellConfigurationBlock
			  andReuseIdentiferBlock:(ALTableViewCellReuseIdentiferBlock)reuseIdentifierBlock
{
	NSManagedObjectContext *managedObjectContext = [ALCoreDataManager defaultManager].managedObjectContext;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Word"
											  inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];

	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"languange = %@", languageDirection[0]];
	[fetchRequest setPredicate:predicate];

	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"string"
																   ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

	self = [super initWithFetchRequest:fetchRequest
				  managedObjectContext:managedObjectContext
				cellConfigurationBlock:cellConfigurationBlock
				andReuseIdentiferBlock:reuseIdentifierBlock];
	if (self) {
		
	}
	return self;
}

@end
