//
//  NSString+Help.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSString+WQHash.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@implementation NSString (WQHash)
//TODO:-- -DES加密
-(NSString *)encryptUseDESInkey:(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [self UTF8String];
    NSUInteger dataLength = [self length];
    unsigned char buffer[1024];
    memset(buffer, 0,sizeof(char));
    //向量
    /**
     * DES一共就有4个参数参与运作：明文、密文、密钥、向量。为了初学者容易理解，可以把4个参数的关系写成：密文=明文+密钥+向量；明文=密文-密钥-向量。
     
     为什么要向量这个参数呢？因为如果有一篇文章，有几个词重复，那么这个词加上密钥形成的密文，仍然会重复，这给破解者有机可乘，破解者可以根据重复的内容，猜出是什么词，然而一旦猜对这个词，那么，他就能算出密钥，整篇文章就被破解了！加上向量这个参数以后，每块文字段都会依次加上一段值，这样，即使相同的文字，加密出来的密文，也是不一样的，算法的安全性大大提高！
     
     ** iv向量改成你需要的  key就是你们自己选好的key值 例如 39D}!Az5
     */
   const char *iv = [key cStringUsingEncoding:NSASCIIStringEncoding];
   const char *ASCIIKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
//    Byte iv[] = {8,9,4,2,3,0xe,9,8};
//
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus =CCCrypt(kCCEncrypt,
                                         kCCAlgorithmDES,
                                         kCCOptionPKCS7Padding,
                                         ASCIIKey,
                                         kCCKeySizeDES,
                                         iv,
                                         textBytes,
                                         dataLength,
                                         buffer,
                                         1024,
                                         &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength]encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

//TODO: -- -DES解密
- (NSString *)decryptUseDESInkey:(NSString*)key{
    NSData * cipherData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    unsigned char buffer[1024];
    memset(buffer, 0,sizeof(char));
    size_t numBytesDecrypted = 0;
    const char *iv = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *ASCIIKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          ASCIIKey,
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
-(NSString *)md5String{
    const char *data = self.UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), buffer);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5 @"XXXXXXXXXXXXXXXX"
        [result appendFormat:@"%02X", buffer[i]];
    }
    return result;
}
/**小写 md5 加密 */
-(NSString *)md5LowercaseString{
    const char *data = self.UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), buffer);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5 @"XXXXXXXXXXXXXXXX"
        [result appendFormat:@"%02x", buffer[i]];
    }
    return result;
}
- (NSString*) sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

-(NSData *)encryptUseAES128Inkey:(NSString *)key{
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    long int newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);
    return nil;

    
}

+(NSData *)decryptAES128:(NSData *)data withKey:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
//    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSData *result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return result;
    }
    free(buffer);
    return nil;
    
}


@end
