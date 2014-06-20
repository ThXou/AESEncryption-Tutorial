//
//  NSData+AES256.h
//  M3u8 Player
//
//  Created by ThXou on 08/06/14.
//  Copyright (c) 2014 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
