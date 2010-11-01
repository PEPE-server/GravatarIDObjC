//
//  GravatarService.h
//  gravtarlib
//
//  Created by Magnus Ernstsson on 10/22/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Service protocol implemented by all GitHub services returned by the GitHub
 * service factories.
 */
@protocol GravatarService <NSObject>

/**
 * Property containing for the requested email address, if email is requested.
 */
@property (readonly, copy) NSString *email;

/**
 * Property containing for the requested gravatar id.
 */
@property (readonly, copy) NSString *gravatarid;

/**
 * Cancelles the request to the service. If cancelled, no more message will be
 * sent to the delegate.
 */
-(void)cancelRequest;

@end

/**
 * Error domain string used when gravtarService:didFailWithError: is called.
 */
extern NSString * const GravatarServerErrorDomain;

typedef enum {
  GravatarServerServerError = 1, /**< Error recieved from the server */
  GravatarServerConnectionError = 2, /**< Error connecting to server */
} GravatarServerError;

/**
 * Default default gravatar image.
 * See the gravatar API documentation for details.
 */
extern NSString * const gravatarServerImageDefault;

/**
 * 404 default gravatar image.
 * See the gravatar API documentation for details.
 */
extern NSString * const gravatarServerImage404;

/**
 * MysteryMan default gravatar image.
 * See the gravatar API documentation for details.
 */
extern NSString * const gravatarServerImageMysteryMan;

/**
 * Identicon default gravatar image.
 * See the gravatar API documentation for details.
 */
extern NSString * const gravatarServerImageIdenticon;

/**
 * Monster default gravatar image.
 * See the gravatar API documentation for details.
 */
extern NSString * const gravatarServerImageMonsterId;

/**
 * Wavatar default gravatar image.
 * See the gravatar API documentation for details.
 */
extern NSString * const gravatarServerImageWavatar;

/**
 * Retro default gravatar image.
 * See the gravatar API documentation for details.
 */
extern NSString * const gravatarServerImageRetro;
