//
//  THXAppDelegate.h
//  AES Encryption Tutorial
//
//  Created by ThXou on 19/06/14.
//  Copyright (c) 2014 ThXou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@end
