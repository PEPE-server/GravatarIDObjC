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

@synthesize delegate, receivedData, connection;

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

-(GravatarUIImageFactory *) initWithGravatarDelegate:
(id<GravatarServiceDelegate>)newDelegate {
  
  if (self = [super init]) {
    
    self.delegate = newDelegate;
  }
  return self;
}

+(GravatarUIImageFactory *)gravatarUIImageFactoryWithDelegate:
(id<GravatarServiceDelegate>)delegate {
  
  return [[[GravatarUIImageFactory alloc]
           initWithGravatarDelegate:delegate] autorelease]; 
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
  } else {
    
    [self.delegate gravatarService:self didFailWithError:nil];
  }
}

-(NSString *)calculateGravatarId:(NSString *)email {
 
  return [GravatarUIImageFactory
          md5:[[email
                stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]]
               lowercaseString]];
}

-(void)requestUIImageByGravatarId:(NSString *)gravatarId size:(NSInteger) size {
  
  if ((size > 0) && size < 512) {
    
    [self makeRequest:
    [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=%i",
     gravatarId, size]];
  } else {
      
    [self.delegate gravatarService:self didFailWithError:nil];
  }
}

-(void)requestUIImageByEmail:(NSString *)email {

  [self requestUIImageByGravatarId:[self calculateGravatarId:email]];
}

-(void)requestUIImageByEmail:(NSString *)email size:(NSInteger)size {

  [self requestUIImageByGravatarId:[self calculateGravatarId:email] size:size];
}

-(void)requestUIImageByGravatarId:(NSString *)gravatarId {
  
  [self makeRequest:
   [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@",
    gravatarId]];
}

-(void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
  
  [self.receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  
  [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error {
  
  [self.delegate gravatarService:self didFailWithError:error];
  self.receivedData = nil;
  self.connection = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  [self.delegate gravatarServiceDone:self
                           withImage:[UIImage imageWithData:self.receivedData]];
  
  self.receivedData = nil;
  self.connection = nil;
}

-(void)cancelRequest {

  self.connection = nil;
  self.receivedData = nil;
}

-(void)setConnection:(NSURLConnection *)newConnection {
  
  [connection cancel];
  [connection release];
  connection = [newConnection retain];
}

-(void)dealloc {
  
  self.receivedData = nil;
  self.connection = nil;
  [super dealloc];
}

@end
