//
//  GravatarServiceFactory.m
//  gravtarlib
//
//  Created by Magnus Ernstsson on 10/22/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GravatarServiceFactory.h"
#import "GravatarUIImageFactory.h"

@implementation GravatarServiceFactory

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
                                    defaultImage:(NSString *)defaultImage
                                            size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                                  gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByGravatarId:gravtarId
                         defaultImage:defaultImage
                                 size:size];
  
	return service;
}

+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
                                    defaultImage:(NSString *)defaultImage
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                              gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByGravatarId:gravtarId
                         defaultImage:defaultImage];
  
	return service;  
}

+(id<GravatarService>)requestUIImageByEmail:(NSString *)gravtarId
                               defaultImage:(NSString *)defaultImage
                                       size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                              gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByEmail:gravtarId
                    defaultImage:defaultImage
                            size:size];
  
	return service;
}

+(id<GravatarService>)requestUIImageByEmail:(NSString *)gravtarId
                               defaultImage:(NSString *)defaultImage
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                              gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByEmail:gravtarId
                    defaultImage:defaultImage];
  
	return service;
}

@end
