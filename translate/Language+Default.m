//
//  Language+Default.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "Language+Default.h"
#import "ALManagedObjectFactory+CreateLanguage.h"

#import <ALCoreDataManager+Singleton.h>
#import <ALManagedObjectFactory+Singleton.h>

@implementation Language (Default)

+ (Language*)languageWithShortName:(NSString*)shortName
{
	NSManagedObjectContext *managedObjectContext = [ALCoreDataManager defaultManager].managedObjectContext;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Language"
											  inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	// Specify criteria for filtering which objects to fetch
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shortName = %@", shortName];
	[fetchRequest setPredicate:predicate];
	// Specify how the fetched objects should be sorted
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"shortName"
																   ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
	
	fetchRequest.fetchLimit = 1;
	
	NSError *error = nil;
	NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest
																  error:&error];
	if (fetchedObjects == nil) {
		NSLog(@"%@",error);
		abort();
	}
	
	Language *lang = [fetchedObjects firstObject];
	if (!lang) {
		lang = [[ALManagedObjectFactory defaultFactory] createLanguageWithShortName:shortName];
	}
	
	return lang;
}

@end
