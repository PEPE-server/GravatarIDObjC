//
//  GravatarUIImageFactory.m
//  github
//
//  Created by Magnus Ernstsson on 10/4/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GravatarUIImageFactory.h"
#import "GravatarServiceDelegate.h"
#import <CommonCrypto/CommonDigest.h>

@implementation GravatarUIImageFactory

#pragma mark -
#pragma mark Memory and member management

//Copy
@synthesize email, gravatarid;

//Retain
@synthesize delegate, receivedData, connection;

//Assign
@synthesize cancelling, failSent;

-(void)cleanUp {
  
  self.connection = nil;
  self.delegate = nil;
  self.receivedData = nil;
}

-(void)dealloc {
  
  self.gravatarid = nil;
  self.email = nil;
  [self cleanUp];
  [super dealloc];
}

-(void)setConnection:(NSURLConnection *)newConnection {
  
  @synchronized(self) {
    
    if (connection != newConnection) {
      
      [connection cancel];
      [connection release];
      connection = [newConnection retain];
    }
  }
}

#pragma mark -
#pragma mark Internal implementation
#pragma mark - Class 

+(NSString *)md5:(NSString *)str {
  
  const char *cStr = [str UTF8String];
  unsigned char result[16];
  CC_MD5( cStr, strlen(cStr), result );
  
  return [NSString stringWithFormat:
          @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
          result[0], result[1], result[2], result[3], 
          result[4], result[5], result[6], result[7],
          result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]
          ]; 
}

+(NSString *)calculateGravatarId:(NSString *)anEmail {
  
  return [[GravatarUIImageFactory
           md5:[[anEmail
                 stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]]
                lowercaseString]] lowercaseString];
}

#pragma mark - Instance

-(void)handleErrorWithCode:(GravatarServerError)code {
  
  if (!self.cancelling && !self.failSent) {
    
    self.failSent = YES;
    
    [self.delegate gravatarService:self
                  didFailWithError:[NSError
                                    errorWithDomain:GravatarServerErrorDomain
                                    code:code
                                    userInfo:nil]];
    
    [self cleanUp];
  }
}

-(void)makeRequest:(NSString *)request {
  
  NSURLRequest *theRequest = [NSURLRequest
                              requestWithURL:[NSURL URLWithString:request]
                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                              timeoutInterval:60.0];
  
  self.connection = [NSURLConnection connectionWithRequest:theRequest
                                                  delegate:self];
  
  if (self.connection) {
    
    self.receivedData = [NSMutableData data];
    
  }
}

-(GravatarUIImageFactory *) initWithGravatarDelegate:
(id<GravatarServiceDelegate>)newDelegate {
  
  self = [super init];
  
  if (self) {
    
    self.cancelling = NO;
    self.failSent = NO;
    self.delegate = newDelegate;
  }
  return self;
}

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
  
  [self.receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  
  [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error {
  
  [self handleErrorWithCode:GravatarServerConnectionError];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  [self.delegate gravatarServiceDone:self
                           withImage:[UIImage imageWithData:self.receivedData]];
  
  [self cleanUp];
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Instance

-(void)cancelRequest {
  
  self.cancelling = YES;
  [self cleanUp];
}

-(void)requestUIImageByEmail:(NSString *)anEmail
                defaultImage:(NSString *)defaultImage {
  
  if (!anEmail) {
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:@"Email must not be nil"
                                 userInfo:nil];
  }
  
  self.email = anEmail;
  
  [self requestUIImageByGravatarId:[GravatarUIImageFactory
                                    calculateGravatarId:anEmail]
                      defaultImage:defaultImage];
}

-(void)requestUIImageByEmail:(NSString *)anEmail
                defaultImage:(NSString *)defaultImage
                        size:(NSInteger)size {
  
  if (!anEmail) {
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:@"Email must not be nil"
                                 userInfo:nil];
  }
  
  self.email = anEmail;
  
  [self requestUIImageByGravatarId:[GravatarUIImageFactory
                                    calculateGravatarId:anEmail]
                              defaultImage:defaultImage
                              size:size];
}

-(void)requestUIImageByGravatarId:(NSString *)gravatarId
                     defaultImage:(NSString *)defaultImage
                             size:(NSInteger)size {
  
  if (!gravatarId) {
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:@"GravatarId must not be nil"
                                 userInfo:nil];
  }
  
  self.gravatarid = gravatarId;
  
  if ((size > 0) && (size < 512)) {
    
    if (defaultImage) {
      
      [self makeRequest:
       [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=%i&d=%@",
        gravatarId, size, defaultImage]];
      
    } else {
      
      @throw [NSException exceptionWithName:NSInvalidArgumentException
                                     reason:@"Default image must not be nil"
                                   userInfo:nil];
    }
  } else {
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:@"Size should be between 0 and 512"
                                 userInfo:nil];
  }
}

-(void)requestUIImageByGravatarId:(NSString *)gravatarId
                     defaultImage:(NSString *)defaultImage {
  
  if (!gravatarId) {
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:@"GravatarId must not be nil"
                                 userInfo:nil];
  }
  
  self.gravatarid = gravatarId;
  
  if (defaultImage) {
    
    [self makeRequest:
     [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@&d=%@",
      gravatarId, defaultImage]];
    
  } else {
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:@"Default image must not be nil"
                                 userInfo:nil];
  }
}

#pragma mark - Class

NSString * const GravatarServerErrorDomain = @"GravatarServerErrorDomain";

NSString * const gravatarServerImageDefault = @"";
NSString * const gravatarServerImage404 = @"404";
NSString * const gravatarServerImageMysteryMan = @"mm";
NSString * const gravatarServerImageIdenticon = @"identicon";
NSString * const gravatarServerImageMonsterId = @"monsterid";
NSString * const gravatarServerImageWavatar = @"wavatar";
NSString * const gravatarServerImageRetro = @"retro";

+(GravatarUIImageFactory *)gravatarUIImageFactoryWithDelegate:
(id<GravatarServiceDelegate>)delegate {
  
  return [[[GravatarUIImageFactory alloc]
           initWithGravatarDelegate:delegate] autorelease]; 
}

@end
