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

+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
                                            size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                                  gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByGravatarId:gravtarId
                                 size:size];
  
	return service;
}

+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                              gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByGravatarId:gravtarId];
  
	return service;  
}

+(id<GravatarService>)requestUIImageByEmail:(NSString *)gravtarId
                                       size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                              gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByEmail:gravtarId
                            size:size];
  
	return service;
}

+(id<GravatarService>)requestUIImageByEmail:(NSString *)gravtarId
delegate:(id<GravatarServiceDelegate>)delegate {
  
	GravatarUIImageFactory *service = [GravatarUIImageFactory
                              gravatarUIImageFactoryWithDelegate:delegate];
  
	[service requestUIImageByEmail:gravtarId];
  
	return service;
}

@end
