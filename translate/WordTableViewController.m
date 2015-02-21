//
//  WordTableViewController.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "WordTableViewController.h"
#import "AddWordViewController.h"

#import "Language+Default.h"
#import "Word.h"

#import "WordTableViewDataSource.h"
#import "TranslationTableViewController.h"
#import "WordTableViewCell.h"

static NSString *const ToAddTranslationSegueIdentifier = @"ToAddNew";
static NSString *const ToTranslationSegueIdentifier = @"ToTranslations";

@interface WordTableViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *languageDirection;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *langBarItem;

@property (nonatomic, strong) WordTableViewDataSource *dataSource;

@end

@implementation WordTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.dataSource = self.dataSource;
}

#pragma mark - Search -

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	NSPredicate *predicate = nil;
	if ([searchText length]) {
		predicate = [NSPredicate predicateWithFormat:@"(language = %@) && (string CONTAINS[c] %@)",
								  self.languageDirection[0],
								  searchText];
	}else{
		predicate = [NSPredicate predicateWithFormat:@"language = %@",
					 self.languageDirection[0]];
	}
	[self.dataSource setPredicate:predicate];
}

#pragma mark - Delegate -

#pragma mark - DataSource -

- (WordTableViewDataSource *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[WordTableViewDataSource alloc] initWithLanguageDirection:self.languageDirection andCellConfigurationBlock:^(UITableViewCell *cell, NSIndexPath *indexPath)
		{
			Word *word = [self.dataSource itemAtIndexPath:indexPath];
			[(WordTableViewCell*)cell setLanguageDirection:self.languageDirection];
			[(WordTableViewCell*)cell setWord:word];
		} andReuseIdentiferBlock:^NSString *(NSIndexPath *indexPath) {
			return @"Cell";
		}];
		
		_dataSource.tableView = self.tableView;
	}
	return _dataSource;
}

#pragma mark - Util -

- (NSArray*)languageDirection
{
	if (!_languageDirection) {
		Language *ru = [Language languageWithShortName:@"ru"];
		Language *en = [Language languageWithShortName:@"en"];
		_languageDirection = @[ru, en];
	}
	return _languageDirection;
}

#pragma mark - Actions -

- (IBAction)actionChangeLanguageDirectino:(id)sender
{
	NSArray *newDirection = @[self.languageDirection[1], self.languageDirection[0]];
	self.languageDirection = newDirection;
	
	self.langBarItem.title =
	[NSString stringWithFormat:@"%@-%@",
	 [[self.languageDirection[0] shortName] capitalizedString],
	 [[self.languageDirection[1] shortName] capitalizedString]];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language = %@", self.languageDirection[0]];
	[self.dataSource setPredicate:predicate];
}

- (IBAction)action:(id)sender
{
}

#pragma mark - Segue -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:ToAddTranslationSegueIdentifier]) {
		AddWordViewController *vc = (AddWordViewController*)[segue destinationViewController];
		if ([vc isKindOfClass:AddWordViewController.class]) {
			vc.srcLang = self.languageDirection[0];
			vc.dstLang = self.languageDirection[1];
		}
	}else if([segue.identifier isEqualToString:ToTranslationSegueIdentifier]){
		TranslationTableViewController *vc = (TranslationTableViewController*)[segue destinationViewController];
		if ([vc isKindOfClass:TranslationTableViewController.class]) {
			if ([sender isKindOfClass:WordTableViewCell.class]) {
				vc.word = [(WordTableViewCell*)sender word];    
			}
		}
	}
}

@end
