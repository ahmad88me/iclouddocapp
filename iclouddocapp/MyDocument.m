//
//  MyDocument.m
//  iclouddocapp
//
//  Created by Ahmad Alobaid on 2/7/17.
//  Copyright © 2017 Ahmad Alobaid. All rights reserved.
//

#import "MyDocument.h"


@implementation MyDocument

    @synthesize documentText=_documentText;
    
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError {
    if ([contents length] > 0) {
        self.documentText = [[NSString alloc] initWithData:(NSData *)contents encoding:NSUTF8StringEncoding];
    } else {
        self.documentText = @"";
    }
    return YES;
}

- (id)contentsForType:(NSString *)typeName error:(NSError **)outError {
    if (!self.documentText) {
        self.documentText = @"";
    }
    NSData *docData = [self.documentText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    return docData;
}
    
@end
