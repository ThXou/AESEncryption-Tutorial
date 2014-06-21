//
//  NSData+AES256.h
//  AES Encryption Tutorial
//
//  Created by ThXou on 20/06/14.
//  Copyright (c) 2014 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
