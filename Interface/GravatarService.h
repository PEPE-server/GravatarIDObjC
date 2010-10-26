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
  GravatarServerInternalError = 1,
  GravatarServerOutOfMemoryError = 2,
  GravatarServerServerError = 3,
  GravatarServerArgumentError = 4,
  GravatarServerConnectionError = 5,
} GravatarServerError;