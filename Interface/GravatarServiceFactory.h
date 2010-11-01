//
//  GravatarServiceFactory.h
//  gravtarlib
//
//  Created by Magnus Ernstsson on 10/22/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GravatarService.h"
#import "GravatarServiceDelegate.h"

/**
 * Service factory class for the gravatar services.
 */
@interface GravatarServiceFactory : NSObject {
}

/**
 * Creates and returns an initialized GravatarService that will return a
 * UIImage using the delegate method gravatarServiceDone:withImage if
 * successful. If the service failed during execution
 * gitHubService:didFailWithError: will be called instead.
 * Can be cancelled using cancelRequest. If cancelled, no more message will be
 * sent to the delegate.
 * @param gravatarId The precalculated gravatar id to get a UIImage from.
 * @param defaultImage The default image to use if a gravatar is not registered.
 *                     One of the predefiend gravatarServerImages can be used
 *                     or a url could be specified.
 * @param size The size of the requested image. Images are always square.
 *             Needs to be between 1 and 512 pixels.
 * @param delegate The delegate object for the service.
 * @return The service for the request.
 */
+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
defaultImage:(NSString *)defaultImage
size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate;

/**
 * Creates and returns an initialized GravatarService that will return a
 * default sized UIImage using the delegate method gravatarServiceDone:withImage
 * if successful. If the service failed during execution
 * gitHubService:didFailWithError: will be called instead.
 * Can be cancelled using cancelRequest. If cancelled, no more message will be
 * sent to the delegate.
 * @param gravatarId The precalculated gravatar id to get a UIImage from.
 * @param defaultImage The default image to use if a gravatar is not registered.
 *                     One of the predefiend gravatarServerImages can be used
 *                     or a url could be specified.
 * @param delegate The delegate object for the service.
 * @return The service for the request.
 */
+(id<GravatarService>)requestUIImageByGravatarId:(NSString *)gravtarId
defaultImage:(NSString *)defaultImage
delegate:(id<GravatarServiceDelegate>)delegate;

/**
 * Creates and returns an initialized GravatarService that will return a
 * UIImage using the delegate method gravatarServiceDone:withImage if
 * successful. If the service failed during execution
 * gitHubService:didFailWithError: will be called instead.
 * Can be cancelled using cancelRequest. If cancelled, no more message will be
 * sent to the delegate.
 * @param email The email address to get a UIImage from.
 * @param defaultImage The default image to use if a gravatar is not registered.
 *                     One of the predefiend gravatarServerImages can be used
 *                     or a url could be specified.
 * @param size The size of the requested image. Images are always square.
 *             Needs to be between 1 and 512 pixels.
 * @param delegate The delegate object for the service.
 * @return The service for the request.
 */
+(id<GravatarService>)requestUIImageByEmail:(NSString *)email
defaultImage:(NSString *)defaultImage
size:(NSInteger)size
delegate:(id<GravatarServiceDelegate>)delegate;

/**
 * Creates and returns an initialized GravatarService that will return a
 * default sized UIImage using the delegate method gravatarServiceDone:withImage
 * if successful. If the service failed during execution
 * gitHubService:didFailWithError: will be called instead.
 * Can be cancelled using cancelRequest. If cancelled, no more message will be
 * sent to the delegate.
 * @param email The email address to get a UIImage from.
 * @param defaultImage The default image to use if a gravatar is not registered.
 *                     One of the predefiend gravatarServerImages can be used
 *                     or a url could be specified.
 * @param delegate The delegate object for the service.
 * @return The service for the request.
 */
+(id<GravatarService>)requestUIImageByEmail:(NSString *)email
defaultImage:(NSString *)defaultImage
delegate:(id<GravatarServiceDelegate>)delegate;

@end
