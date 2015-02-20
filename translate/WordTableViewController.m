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

static NSString *const ToAddTranslationSegueIdentifier = @"ToAddNew";
static NSString *const ToTranslationSegueIdentifier = @"ToTranslation";

@interface WordTableViewController ()

@property (nonatomic, strong) NSArray *languageDirection;

@property (nonatomic, strong) WordTableViewDataSource *dataSource;

@end

@implementation WordTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.dataSource = self.dataSource;
}

- (WordTableViewDataSource *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[WordTableViewDataSource alloc] initWithLanguageDirection:self.languageDirection andCellConfigurationBlock:^(UITableViewCell *cell, NSIndexPath *indexPath)
		{
			Word *word = [self.dataSource itemAtIndexPath:indexPath];
			cell.textLabel.text = word.string;
			
			cell.detailTextLabel.text = @"...";
		} andReuseIdentiferBlock:^NSString *(NSIndexPath *indexPath) {
			return @"Cell";
		}];
		
		_dataSource.tableView = self.tableView;
	}
	return _dataSource;
}

- (NSArray*)languageDirection
{
	if (!_languageDirection) {
		Language *ru = [Language languageWithShortName:@"ru"];
		Language *en = [Language languageWithShortName:@"en"];
		_languageDirection = @[ru, en];
	}
	return _languageDirection;
}

- (NSString*)directionToString:(NSArray*)languageDirection
{
	return [NSString stringWithFormat:@"%@-%@",languageDirection[0],languageDirection[1]];
}

- (IBAction)actionChangeLanguageDirectino:(id)sender
{
	NSArray *newDirection = @[self.languageDirection[1], self.languageDirection[0]];
	self.languageDirection = newDirection;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:ToAddTranslationSegueIdentifier]) {
		AddWordViewController *vc = (AddWordViewController*)[segue destinationViewController];
		if ([vc isKindOfClass:AddWordViewController.class]) {
			vc.srcLang = self.languageDirection[0];
			vc.dstLang = self.languageDirection[1];
		}
	}else if([segue.identifier isEqualToString:ToTranslationSegueIdentifier]){
		
	}
}

@end
