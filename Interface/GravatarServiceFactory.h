//
//  GravatarServiceFactory.h
//  gravtarlib
//
//  Created by Magnus Ernstsson on 10/22/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GravatarService;
@protocol GravatarServiceDelegate;

@interface GravatarServiceFactory : NSObject {

}

+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
defaultImage:(NSString *)defaultImage
size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate;

+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
defaultImage:(NSString *)defaultImage
delegate:(id<GravatarServiceDelegate>)delegate;

+(id<GravatarService>)requestUIImageByEmail:(NSString *)gravtarId
defaultImage:(NSString *)defaultImage
size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate;

+(id<GravatarService>)requestUIImageByEmail:(NSString *)gravtarId
defaultImage:(NSString *)defaultImage
delegate:(id<GravatarServiceDelegate>)delegate;

@end
