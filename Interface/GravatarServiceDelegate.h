//
//  GravatarServiceDelegate.h
//  github
//
//  Created by Magnus Ernstsson on 10/4/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GravatarService.h"

/**
 * Service delegate protocol used by the gravatar services to return responses
 * asyncronosly.
 */
@protocol GravatarServiceDelegate

/**
 * Called when the gravatar service is successfully done.
 * Will not be called if the service is cancelled using cancelRequest.
 * Will not be called after gravatarService:didFailWithError: has been called.
 * @param gravatarService The completed service.
 * @param image The UIImage containing the requested image data.
 */
-(void)gravatarServiceDone:(id<GravatarService>)gravatarService
                 withImage:(UIImage *)image;

/**
 * Called if an error occurs in the gravatar service.
 * Will not be called if the service is cancelled using cancelRequest.
 * Will not be called after gravatarServiceDone:withImage: has been called.
 * @param gravatarService The service returning the error.
 * @param error The error that occured, according to GravatarServerError. 
 */
-(void)gravatarService:(id<GravatarService>)gravatarService
      didFailWithError:(NSError *)error;
@end
