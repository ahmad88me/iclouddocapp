//
//  AppDelegate.h
//  iclouddocapp
//
//  Created by Ahmad Alobaid on 2/4/17.
//  Copyright © 2017 Ahmad Alobaid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

