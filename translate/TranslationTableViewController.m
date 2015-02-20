//
//  TranslationTableViewController.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "TranslationTableViewController.h"
#import "TranslationTableViewDataSource.h"
#import "Word.h"

@interface TranslationTableViewController ()

@property (nonatomic, strong) TranslationTableViewDataSource *dataSource;

@end

@implementation TranslationTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.dataSource = self.dataSource;
	
	self.title = self.word.string;
}

- (TranslationTableViewDataSource *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[TranslationTableViewDataSource alloc] initWithWord:self.word
					   andCellConfigurationBlock:^(UITableViewCell *cell, NSIndexPath *indexPath)
					   {
						   Word *word = [self.dataSource itemAtIndexPath:indexPath];
						   cell.textLabel.text = word.string;
					   } andReuseIdentiferBlock:^NSString *(NSIndexPath *indexPath) {
						   return @"Cell";
					   }];
		
		_dataSource.tableView = self.tableView;
	}
	return _dataSource;
}



@end
