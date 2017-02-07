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
    NSLog(@"%@", self.myTextView.text);
    NSFileManager* fileManager = [NSFileManager defaultManager];
    id currentiCloudToken = fileManager.ubiquityIdentityToken;
    NSLog(@"%@", currentiCloudToken);
    
    NSURL *ubiq = [[NSFileManager defaultManager]
                   URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
        // TODO: Load document...
    } else {
        NSLog(@"No iCloud access");
    }
    BOOL b;
    NSLog(@"checking another file manager");
    NSFileManager* ns_filemanager = [NSFileManager defaultManager];
    NSLog(@"after ns_filemanager is defined");
    NSString * file_dir = ubiq.absoluteString;
    NSString * file_name = @"test.txt";
    
    file_dir = [file_dir stringByAppendingString:file_name];
    NSLog(@"file dir: %@", file_dir);
    NSString * content = @"this is a test text";
    NSData *fileContents = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"before writing");
    
    NSURL * url = [ubiq URLByAppendingPathComponent:@"text.txt"];
    
    NSURL *file_url = url;//[NSURL URLWithString:[file_dir stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"file url: %@", file_url.absoluteString);
    MyDocument *doc = [[MyDocument alloc] initWithFileURL:file_url];
    
    
    self.myTextView.text = @"testing the testview";
    
    if (![fileManager fileExistsAtPath:[file_url path]]){
        NSLog(@"The file does not exists");
        [doc saveToURL:file_url forSaveOperation: UIDocumentSaveForCreating completionHandler:^(BOOL success){
             if (success) {
                 NSLog(@"Save succeeded.");
             } else {
                 NSLog(@"Save failed.");
             }
         }];
        
    }
    else{
        NSLog(@"The file is there");
        [doc saveToURL:file_url forSaveOperation: UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
             if (success) {
                 NSLog(@"Save succeeded.");
             } else {
                 NSLog(@"Save failed.");
             }
         }];
    }

    
    
//    b=[ns_filemanager createFileAtPath:file_dir contents:fileContents attributes:nil];
//    NSLog(@"file creation: %d", b);
//    fileContents = [ns_filemanager contentsAtPath:file_dir];
//    NSLog(@"file content read: %@", fileContents);
    
    
    
    //[ns_filemanager createFileAtPath:file_dir :fileContents:nil];
    //[ns_filemanager init];
    //[ns_filemanager createFileAtPath :file_dir :(NSData *)file_name :nil];
    
    
//    NSString * content = @"this is a test text";
//    NSData *fileContents = [content dataUsingEncoding:NSUTF8StringEncoding];
//    BOOL b = [[NSFileManager defaultManager] createFileAtPath:file_dir
//                                            contents:fileContents
//                                          attributes:nil];
//    NSLog(@"writing is: %d", b);
    
    
    
    //NSString * errorString=[[NSString alloc] initWithString:@"error string"];
    //NSString *matter = [[NSString alloc] initWithString:@"Hello iPhone"];
    //[matter writeToFile:file_dir atomically:NO encoding:NSUTF8StringEncoding error:&errorString];
    //[matter release];
    //NSLog(@" error string: %@", errorString);
    
//    fileContents = [[NSFileManager defaultManager] contentsAtPath:file_dir];
//    NSLog(@" file content: %@", fileContents);
//    content = (NSString * ) fileContents;
//    NSLog(@" content: %@", content);
//    
    
//    dispatch_async (dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
//        NSURL *myContainer;
//        myContainer = [[NSFileManager defaultManager]
//                       URLForUbiquityContainerIdentifier: nil];
//        if (myContainer != nil) {
//            // Your app can write to the iCloud container
//            NSLog(@"Container is found");
//            dispatch_async (dispatch_get_main_queue (), ^(void) {
//                // On the main thread, update UI and state as appropriate
//            });
//        }
//    });
    
}
- (IBAction)mySendButtonIsClicked:(id)sender {
    NSLog(@" Send button is clicked");
    NSLog(@"%@", self.myTextInput.text);
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    id currentiCloudToken = fileManager.ubiquityIdentityToken;
    NSLog(@"%@", currentiCloudToken);
    
    NSURL *ubiq = [[NSFileManager defaultManager]
                   URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
    } else {
        NSLog(@"No iCloud access");
    }
    NSLog(@"icloud");
    
    NSDate * content;
    NSString * file_dir = ubiq.absoluteString;
    NSString * file_name = @"test.txt";
    file_dir = [file_dir stringByAppendingString:file_name];
    NSLog(@"%@", file_dir);
    content = [[NSFileManager defaultManager] contentsAtPath:file_dir];
    NSLog(@"content is read");
    NSLog(@"%@", content);
    
    
    
    
    
    //From the same source as the below two functions came from
    // Let's get the root directory for storing the file on iCloud Drive
//    [self rootDirectoryForICloud:^(NSURL *ubiquityURL) {
//        NSLog(@"1. ubiquityURL = %@", ubiquityURL);
//        if (ubiquityURL) {
//            
//            // We also need the 'local' URL to the file we want to store
//            NSURL *localURL = [self localPathForResource:@"demo" ofType:@"txt"];
//            NSLog(@"2. localURL = %@", localURL);
//            
//            // Now, append the local filename to the ubiquityURL
//            ubiquityURL = [ubiquityURL URLByAppendingPathComponent:localURL.lastPathComponent];
//            NSLog(@"3. ubiquityURL = %@", ubiquityURL);
//            
//            // And finish up the 'store' action
//            NSError *error;
//            if (![[NSFileManager defaultManager] setUbiquitous:YES itemAtURL:localURL destinationURL:ubiquityURL error:&error]) {
//                NSLog(@"Error occurred: %@", error);
//            }
//        }
//        else {
//            NSLog(@"Could not retrieve a ubiquityURL");
//        }
//    }];
    
    
    
    
    
}


//The below three function are from: http://stackoverflow.com/questions/27051437/save-ios-8-documents-to-icloud-drive
- (void)rootDirectoryForICloud:(void (^)(NSURL *))completionHandler {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *rootDirectory = [[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil]URLByAppendingPathComponent:@"Documents"];
        
        if (rootDirectory) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:rootDirectory.path isDirectory:nil]) {
                NSLog(@"Create directory");
                [[NSFileManager defaultManager] createDirectoryAtURL:rootDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(rootDirectory);
        });
    });
}
    
- (NSURL *)localPathForResource:(NSString *)resource ofType:(NSString *)type {
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *resourcePath = [[documentsDirectory stringByAppendingPathComponent:resource] stringByAppendingPathExtension:type];
    return [NSURL fileURLWithPath:resourcePath];
}
    
    
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
