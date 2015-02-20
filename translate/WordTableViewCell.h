//
//  WordTableViewCell.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Word;

@interface WordTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *languageDirection;
@property (nonatomic, strong) Word* word;

@end
