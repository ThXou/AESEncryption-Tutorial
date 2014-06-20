//
//  User.h
//  AES Encryption Tutorial
//
//  Created by ThXou on 20/06/14.
//  Copyright (c) 2014 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;

@end
