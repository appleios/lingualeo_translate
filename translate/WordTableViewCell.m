//
//  WordTableViewCell.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "WordTableViewCell.h"
#import "Word.h"
#import "Language.h"

@interface WordTableViewCell ()

@end

@implementation WordTableViewCell

- (void)setWord:(Word *)word
{
	_word = word;

	self.textLabel.text = word.string;
	
	Word *tr = [_word.translations anyObject];
	if (tr) {
		self.detailTextLabel.text = [NSString stringWithFormat:@"%@...",tr.string];
	}else{
		tr = _word.sourceWord;
		self.detailTextLabel.text = [NSString stringWithFormat:@"%@...",tr.string];
	}
}

@end
