//
//  NSData+WQHash.h
//  AFNetworking
//
//  Created by WangQiang on 2018/9/17.
//

#import <Foundation/Foundation.h>

@interface NSData (WQHash)
 
- (NSData *)aes128_encrypt:(NSString *)key;
- (NSData *)aes128_decrypt:(NSString *)key;
@end
