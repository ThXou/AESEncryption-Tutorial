//
//  THXAppDelegate.m
//  AES Encryption Tutorial
//
//  Created by ThXou on 19/06/14.
//  Copyright (c) 2014 ThXou. All rights reserved.
//

#import "THXAppDelegate.h"
#import "NSData+AES256.h"
#import "User.h"


// la clave que usaremos para la encriptación
#define kEncryptionKey @"8gdUOnr42F"


@implementation THXAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // procedemos a encriptar el texto e imprimir el resultado
    
    NSString *textToEncrypt = @"contraseñasupersecreta";
    NSData *textData = [textToEncrypt dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [textData AES256EncryptWithKey:kEncryptionKey];
    NSString *base64EncryptedPassword = [encryptedData base64EncodedStringWithOptions:0];
    NSLog(@"Contraseña Encriptada: %@", base64EncryptedPassword);
    
    
    // creamos el objeto modelo y lo guardamos
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                               inManagedObjectContext:self.managedObjectContext];
    user.username = @"ThXou";
    user.password = base64EncryptedPassword;
    [self saveContext];
    
    
    // ahora recuperamos el objeto que guardamos antes
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray *users = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    
    // desencriptamos el texto guardado y lo mostramos en pantalla
    
    User *encryptedUser = users[0];
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:encryptedUser.password options:0];
    NSData *decryptedData = [decodedData AES256DecryptWithKey:kEncryptionKey];
    NSString *decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    NSLog(@"Contraseña Desencriptada: %@", decryptedString);
    
    
    return YES;
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}



#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AES_Encryption_Tutorial" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *documentsDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsDir URLByAppendingPathComponent:@"AES_Encryption_Tutorial.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}



@end
