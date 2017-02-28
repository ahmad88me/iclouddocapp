//
//  ViewController.h
//  iclouddocapp
//
//  Created by Ahmad Alobaid on 2/4/17.
//  Copyright © 2017 Ahmad Alobaid. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface ViewController : UIViewController
@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}

@end

