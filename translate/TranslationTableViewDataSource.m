//
//  TranslationTableViewDataSource.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "TranslationTableViewDataSource.h"
#import "Language.h"
#import "Word.h"

#import <ALCoreDataManager+Singleton.h>

@implementation TranslationTableViewDataSource

- (instancetype)initWithWord:(Word*)word
   andCellConfigurationBlock:(ALTableViewCellConfigurationBlock)cellConfigurationBlock
	  andReuseIdentiferBlock:(ALTableViewCellReuseIdentiferBlock)reuseIdentifierBlock
{
	NSManagedObjectContext *managedObjectContext = [ALCoreDataManager defaultManager].managedObjectContext;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Word"
											  inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sourceWord = %@", word];
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
