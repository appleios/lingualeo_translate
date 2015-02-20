//
//  YandexTranslate.h
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSArray *images);
typedef void(^FailureBlock)(NSError *error);

@interface YandexTranslate : NSObject

@end
