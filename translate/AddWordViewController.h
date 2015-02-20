//
//  AddWordViewController.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Language.h"

@interface AddWordViewController : UIViewController

@property (nonatomic, strong) Language *srcLang;
@property (nonatomic, strong) Language *dstLang;

@end
