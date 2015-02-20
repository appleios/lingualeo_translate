//
//  StyledTextField.m
//  Panoramio
//
//  Created by Aziz U. Latypov on 2/19/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "StyledTextField.h"

@implementation StyledTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self configureStyledTextField];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self configureStyledTextField];
	}
	return self;
}

- (void)configureStyledTextField
{
	self.layer.cornerRadius = 3.f;
	self.layer.borderWidth = 1.f;
	self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
	
	self.borderStyle = UITextBorderStyleNone;
	
	self.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
	return [self insetsRect:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	return [self insetsRect:bounds];
}

- (CGRect)insetsRect:(CGRect)bounds
{
	return CGRectInset(bounds, 10, 2);
}

@end
