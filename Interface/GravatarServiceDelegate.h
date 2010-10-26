//
//  GravatarServiceDelegate.h
//  github
//
//  Created by Magnus Ernstsson on 10/4/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GravatarService;

@protocol GravatarServiceDelegate
-(void)gravatarServiceDone:(id<GravatarService>)gravatarService
                 withImage:(UIImage *)image;

-(void)gravatarService:(id<GravatarService>)gravatarService
      didFailWithError:(NSError *)error;
@end
