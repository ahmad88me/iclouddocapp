//
//  ViewController.m
//  iclouddocapp
//
//  Created by Ahmad Alobaid on 2/4/17.
//  Copyright © 2017 Ahmad Alobaid. All rights reserved.
//

#import "ViewController.h"
#import "MyDocument.h"

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UITextView *myTextView;
    @property (weak, nonatomic) IBOutlet UITextField *myTextInput;
    @property (weak, nonatomic) IBOutlet UIButton *myGetButton;
    @property (weak, nonatomic) IBOutlet UIButton *mySendButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)myGetButtonIsClicked:(id)sender {
    NSLog(@" Get button is clicked");
    NSFileManager* fileManager = [NSFileManager defaultManager];
    id currentiCloudToken = fileManager.ubiquityIdentityToken;
    NSLog(@"%@", currentiCloudToken);
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
        // TODO: Load document...
    } else {
        NSLog(@"No iCloud access");
    }
    NSLog(@"before writing");
    NSURL * file_url = [ubiq URLByAppendingPathComponent:@"text.txt"];
    NSLog(@"file url: %@", file_url.absoluteString);
    MyDocument *doc = [[MyDocument alloc] initWithFileURL:file_url];
    //self.myTextView.text = @"testing the testview";
    if (![fileManager fileExistsAtPath:[file_url path]]){
        NSLog(@"The file does not exists");
        [doc saveToURL:file_url forSaveOperation: UIDocumentSaveForCreating completionHandler:^(BOOL success){
             if (success) {
                 NSLog(@"File created.");
             } else {
                 NSLog(@"Failed to create the file.");
             }
         }];
    }
    else{
        NSLog(@"The file is there");
        [doc readFromURL:file_url error:nil];
        self.myTextView.text = doc.documentText;
        NSLog(@"content: %@", doc.documentText);
    }
}

- (IBAction)mySendButtonIsClicked:(id)sender {
    NSLog(@" Send button is clicked");
    NSFileManager* fileManager = [NSFileManager defaultManager];
    id currentiCloudToken = fileManager.ubiquityIdentityToken;
    NSLog(@"%@", currentiCloudToken);
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
        // TODO: Load document...
    } else {
        NSLog(@"No iCloud access");
    }
    NSString * file_dir = ubiq.absoluteString;
    NSString * file_name = @"test.txt";
    file_dir = [file_dir stringByAppendingString:file_name];
    NSLog(@"file dir: %@", file_dir);
    NSString * content = @"2nd";
    NSLog(@"%@", self.myTextInput.text);
    content = self.myTextInput.text;
    NSLog(@"before writing");
    NSURL * file_url = [ubiq URLByAppendingPathComponent:@"text.txt"];
    NSLog(@"file url: %@", file_url.absoluteString);
    MyDocument *doc = [[MyDocument alloc] initWithFileURL:file_url];
    if (![fileManager fileExistsAtPath:[file_url path]]){
        NSLog(@"The file does not exists");
        [doc saveToURL:file_url forSaveOperation: UIDocumentSaveForCreating completionHandler:^(BOOL success){
            if (success) {
                NSLog(@"File created.");
            } else {
                NSLog(@"Failed to create the file.");
            }
        }];
        
    }
    else{
        NSLog(@"The file is there");
        doc.documentText = content;
        [doc saveToURL:file_url forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
            if (success) {
                NSLog(@"Save succeeded.");
                //NSLog(@"Content: %@", doc.documentText);
            } else {
                NSLog(@"Save failed.");
            }
        }];
    }


    
    
    
    

    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
