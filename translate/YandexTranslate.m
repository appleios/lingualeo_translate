//
//  YandexTranslate.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "YandexTranslate.h"
#import "Language.h"

#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

static NSString *const BaseURL = @"https://translate.yandex.net/api/v1.5/tr.json";
static NSString *const YandexAPIKey = @"trnsl.1.1.20150220T191132Z.8f29db8585175711.f327abba9e940da20baeb736297f8e374cb724d5";

@interface YandexTranslate ()

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;


@property (nonatomic, strong) AFHTTPSessionManager *networkManager;

@property (nonatomic) BOOL internetAccessble;

@end

@implementation YandexTranslate

+ (YandexTranslate*)sharedInstance
{
	static YandexTranslate *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [[self alloc] init];
	});
	return _sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self configureYandexTranslate];
	}
	return self;
}

- (void)configureYandexTranslate
{
	[[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
	{
		self.internetAccessble =
		(status == AFNetworkReachabilityStatusReachableViaWiFi) ||
		(status == AFNetworkReachabilityStatusReachableViaWWAN);
	}];
	[[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (NSString*)directionToString:(NSArray*)languageDirection
{
	return [NSString stringWithFormat:@"%@-%@",
			[languageDirection[0] shortName],
			[languageDirection[1] shortName]];
}

- (void)translationsForWord:(NSString*)word
					   lang:(NSArray*)languageDirection
				withSuccess:(SuccessBlock)successBlock
				 andFailure:(FailureBlock)failureBlock
{
	self.successBlock = successBlock;
	self.failureBlock = failureBlock;
	NSDictionary *params = @{
							 @"key" : YandexAPIKey,
							 @"text" : word,
							 @"lang" : [self directionToString:languageDirection],
							 @"format" : @"plain"
							 };
	
	[self.networkManager GET:@"translate"
				  parameters:params
					 success:^(NSURLSessionDataTask *task, id responseObject)
	 {
		 NSArray *translations = [responseObject valueForKey:@"text"];
	 self.successBlock(translations);
	 } failure:^(NSURLSessionDataTask *task, NSError *error) {
		 self.failureBlock(error);
	 }];
}

#pragma mark - AF -

- (AFHTTPSessionManager *)networkManager
{
	if (!_networkManager) {
		_networkManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
		_networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
	}
	return _networkManager;
}


@end
