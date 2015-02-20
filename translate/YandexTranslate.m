//
//  YandexTranslate.m
//  translate
//
//  Created by Aziz U. Latypov on 2/21/15.
//  Copyright (c) 2015 Aziz U. Latypov. All rights reserved.
//

#import "YandexTranslate.h"

#import <AFNetworking/AFHTTPSessionManager.h>

static NSString *const BaseURL = @"http://www.panoramio.com/map/";

@interface YandexTranslate ()

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;


@property (nonatomic, strong) AFHTTPSessionManager *networkManager;

@end

@implementation YandexTranslate

+ (YandexTranslate*)sharedInstance {
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
}

- (void)translationsForWord:(NSString*)word
				withSuccess:(SuccessBlock)successBlock
				 andFailure:(FailureBlock)failureBlock
{
	self.successBlock = successBlock;
	self.failureBlock = failureBlock;
	NSDictionary *params = @{
							 @"order" : @"upload_date",
							 @"set" : @"public",
							 @"from" : @(0),
							 @"to" : @(count),
							 @"minx" : @(self.currentLocation.longitude - SPAN),
							 @"miny" : @(self.currentLocation.latitude  - SPAN),
							 @"maxx" : @(self.currentLocation.longitude + SPAN),
							 @"maxy" : @(self.currentLocation.latitude  + SPAN)
							 };
	
	[self.networkManager GET:@"get_panoramas.php"
				  parameters:params
					 success:^(NSURLSessionDataTask *task, id responseObject)
	 {
		 self.successBlock([responseObject valueForKey:@"photos"]);
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
