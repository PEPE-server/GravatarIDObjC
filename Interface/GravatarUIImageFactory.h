//
//  PWSGravatarFactory.h
//  github
//
//  Created by Magnus Ernstsson on 10/4/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GravatarService.h"

@protocol GravatarServiceDelegate;

@interface GravatarUIImageFactory : NSObject <GravatarService> {
  id<GravatarServiceDelegate> delegate;
  NSMutableData *receivedData;
  NSURLConnection *connection;
}

@property (assign) id<GravatarServiceDelegate> delegate;
@property (retain) NSMutableData *receivedData;
@property (retain) NSURLConnection *connection;

+(GravatarUIImageFactory *)gravatarUIImageFactoryWithDelegate:
(id<GravatarServiceDelegate>) delegate;

-(void)requestUIImageByGravatarId:(NSString *)gravatarId size:(NSInteger)size;

-(void)requestUIImageByGravatarId:(NSString *)gravatarId;

-(void)requestUIImageByEmail:(NSString *)gravatarId size:(NSInteger)size;

-(void)requestUIImageByEmail:(NSString *)gravatarId;

@end
