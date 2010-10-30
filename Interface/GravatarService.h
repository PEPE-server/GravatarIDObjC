//
//  GravatarService.h
//  gravtarlib
//
//  Created by Magnus Ernstsson on 10/22/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GravatarService <NSObject>

@property (readonly, copy) NSString *email;
@property (readonly, copy) NSString *gravatarid;

-(void)cancelRequest;

@end

extern NSString * const GravatarServerErrorDomain;

typedef enum {
  GravatarServerServerError = 1,
  GravatarServerConnectionError = 2,
} GravatarServerError;

extern NSString * const gravatarServerImageDefault;
extern NSString * const gravatarServerImage404;
extern NSString * const gravatarServerImageMysteryMan;
extern NSString * const gravatarServerImageIdenticon;
extern NSString * const gravatarServerImageMonsterId;
extern NSString * const gravatarServerImageWavatar;
extern NSString * const gravatarServerImageRetro;
