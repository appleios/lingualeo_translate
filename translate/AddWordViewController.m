//
//  AddWordViewController.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "AddWordViewController.h"
#import "StyledTextField.h"

#import "YandexTranslate.h"
#import <MBProgressHUD/MBProgressHUD.h>

#import <ALManagedObjectFactory+Singleton.h>
#import <ALCoreDataManager/ALCoreDataManager+Singleton.h>
#import "ALManagedObjectFactory+CreateWord.h"
#import "Word.h"

@interface AddWordViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet StyledTextField *wordTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *translations;
@property (weak, nonatomic) IBOutlet UIWebView *bottomWebView;

@end

@implementation AddWordViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if (![YandexTranslate sharedInstance].internetAccessble) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", @"")
														message:NSLocalizedString(@"INTERNET_CONNECTION_APPEARS_TO_BE_OFFLINE_CONINUE", @"")
													   delegate:self
											  cancelButtonTitle:NSLocalizedString(@"NO", @"")
											  otherButtonTitles:NSLocalizedString(@"CONTINE", @""),nil];
		alert.tag = 100;
		[alert show];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 100) {
		if (buttonIndex == 0) {
			[self back];
		}
	}
}

- (IBAction)loadTranslation:(id)sender {
	if (self.wordTextField.text.length) {
		
		[MBProgressHUD showHUDAddedTo:self.view
							 animated:YES];
		[[YandexTranslate sharedInstance] translationsForWord:self.wordTextField.text
														 lang:@[self.srcLang, self.dstLang]
												  withSuccess:^(NSArray *translations)
		 {
			 self.translations = [translations copy];
			 [self.tableView reloadData];
			 
			 [MBProgressHUD hideAllHUDsForView:self.view
									  animated:YES];
			 
		 } andFailure:^(NSError *error) {
			 [MBProgressHUD hideAllHUDsForView:self.view
									  animated:YES];
			 
			 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", @"")
															 message:NSLocalizedString(@"FAILED_TO_RETRIEVE_TRANSLATIONS", @"")
															delegate:nil
												   cancelButtonTitle:NSLocalizedString(@"OK", @"")
												   otherButtonTitles:nil];
			 [alert show];
		 }];
	}
}

- (IBAction)save:(id)sender {
	if (self.wordTextField.text.length && self.translations.count) {
		Word *srcWord = [[ALManagedObjectFactory defaultFactory] createWordWithString:self.wordTextField.text
																		   inLanguage:self.srcLang];
		for (NSString *t in self.translations) {
			Word *w = [[ALManagedObjectFactory defaultFactory] createWordWithString:t
																		 inLanguage:self.dstLang];
			w.sourceWord = srcWord;
		}
		
		[[ALCoreDataManager defaultManager] saveContext];
		
		[self back];

	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", @"")
														message:NSLocalizedString(@"WORD_AND_TRANSLATIONS_SHOULD_EXIST", @"")
													   delegate:nil
											  cancelButtonTitle:NSLocalizedString(@"OK", @"")
											  otherButtonTitles:nil];
		[alert show];
	}
}

- (IBAction)cancel:(id)sender {
	[self back];
}

- (void)back
{
	[self.wordTextField resignFirstResponder];
	[self.presentingViewController dismissViewControllerAnimated:YES
													 completion:NULL];
}

#pragma - TB DS & Delegate

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return self.translations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.textLabel.text = self.translations[indexPath.row];
	return cell;
}

@end
