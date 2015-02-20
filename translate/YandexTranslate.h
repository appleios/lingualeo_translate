//
//  YandexTranslate.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSArray *translations);
typedef void(^FailureBlock)(NSError *error);

@interface YandexTranslate : NSObject

+ (YandexTranslate*)sharedInstance;

- (void)translationsForWord:(NSString*)word
					   lang:(NSArray*)languageDirection
				withSuccess:(SuccessBlock)successBlock
				 andFailure:(FailureBlock)failureBlock;

@property (nonatomic, readonly) BOOL internetAccessble;

@end
