//
//  ViewController.m
//  iclouddocapp
//
//  Created by Ahmad Alobaid on 2/4/17.
//  Copyright © 2017 Ahmad Alobaid. All rights reserved.
//

#import "ViewController.h"
#import "MyDocument.h"
#import <Photos/Photos.h>
//this import is only used for the method getCroppedData
//#import <AssetsLibrary/AssetsLibrary.h>
@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UITextView *myTextView;
    @property (weak, nonatomic) IBOutlet UITextField *myTextInput;
    @property (weak, nonatomic) IBOutlet UIButton *myGetButton;
    @property (weak, nonatomic) IBOutlet UIButton *mySendButton;
    @property (weak, nonatomic) IBOutlet UIImageView *myImageView;
    @property (weak, nonatomic) IBOutlet UIButton *myImagePickerButton;
    @property (weak, nonatomic) IBOutlet UIButton *myLoadImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *myStoredImageView;


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
            } else {
                NSLog(@"Save failed.");
            }
        }];
    }
}

- (IBAction)myLoadImageButtonIsClicked:(id)sender {
    NSLog(@"Load button is clicked");
    NSFileManager* fileManager = [NSFileManager defaultManager];
    id currentiCloudToken = fileManager.ubiquityIdentityToken;
    NSLog(@"%@", currentiCloudToken);
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
    } else {
        NSLog(@"No iCloud access");
    }
    NSLog(@"before writing");
    NSURL * file_url = [ubiq URLByAppendingPathComponent:@"image1.JPG"];
    NSLog(@"file url: %@", file_url.absoluteString);
    if (![fileManager fileExistsAtPath:[file_url path]]){
        NSLog(@"The file does not exists");
    }
    else{
        NSLog(@"The file is there");
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: file_url];
        self.myStoredImageView.image = [UIImage imageWithData: imageData];
    }
    NSArray *dirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:ubiq error:nil];
    int i;
    for(i=0;i<dirFiles.count;i++){
        NSLog(@"file: %@", dirFiles[i]);
    }

}


- (IBAction)myChooseImageButtonIsClicked:(id)sender {
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:self.myImagePickerButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    self.myImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"picked image: %@", [info objectForKey:UIImagePickerControllerReferenceURL]);
    NSFileManager* fileManager = [NSFileManager defaultManager];
    id currentiCloudToken = fileManager.ubiquityIdentityToken;
    NSLog(@"%@", currentiCloudToken);
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
    } else {
        NSLog(@"No iCloud access");
    }
    NSURL * file_url = [ubiq URLByAppendingPathComponent:@"image1.JPG"];
    //The below few commented lines are commented to try to use the new PHAssets photo to get NSData from the URL to be used in Qt
    //instead of getting the image data from the imageview, I want to get it from the info
    //NSData * imageData = UIImageJPEGRepresentation(self.myImageView.image, 1.0);
    //NSData * imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0);
    //[imageData writeToURL:file_url atomically:true];

    //The below lines are used to test how to get the image data from assets url so I can use a similar approach in Qt
    NSURL *for_photo_ass = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSLog(@"photo ass: %@", for_photo_ass);
    NSArray *array = @[for_photo_ass];
    NSLog(@"numer of matching assets %lu", [PHAsset fetchAssetsWithALAssetURLs:array options:nil].count);
    PHAsset * phasset = [PHAsset fetchAssetsWithALAssetURLs:array options:nil].firstObject;
    PHImageManager * phimage_manager = [PHImageManager defaultManager];
    [phimage_manager requestImageDataForAsset:phasset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        NSLog(@"inside the manager");
        [imageData writeToURL:file_url atomically:true];
        //this is to print the actual url, this is not needed for this app, but to see how to get it for the qt app
        NSURL * uu = [info objectForKey:UIImagePickerControllerReferenceURL];
        NSLog(@"*******\n\n\n\nThe absolute url: %@\n\n\n*******",[uu host]);

    }];
    }

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//does not work
//this function is used to get NSData from assets url
//from https://github.com/donobono/DoImagePickerController/blob/7ffcdd17dc866649f0e32e0220b64e314eee5b7e/ImagePicker/DoImagePicker/AssetHelper.m and http://stackoverflow.com/questions/22193322/how-i-can-get-nsdata-for-image-or-video-files-using-asset-url
//- (NSData *)getCroppedData:(NSURL *)urlMedia
//{
//    __block NSData *iData = nil;
//    __block BOOL bBusy = YES;
//    
//    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
//    {
//        ALAssetRepresentation *representation = myasset.defaultRepresentation;
//        long long size = representation.size;
//        NSMutableData *rawData = [[NSMutableData alloc] initWithCapacity:size];
//        void *buffer = [rawData mutableBytes];
//        [representation getBytes:buffer fromOffset:0 length:size error:nil];
//        iData = [[NSData alloc] initWithBytes:buffer length:size];
//        bBusy = NO;
//    };
//    
//    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
//    {
//        NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
//    };
//    ALAssetsLibrary * _assetsLibrary = [[ALAssetsLibrary alloc] init];
//    [_assetsLibrary assetForURL:urlMedia
//                    resultBlock:resultblock
//                   failureBlock:failureblock];
//    
//    while (bBusy)
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    
//    return iData;
//}


@end
