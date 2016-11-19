//
//  Document.m
//  Clue
//
//  Created by Ahmed Sulaiman on 11/5/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUDocument.h"

@interface CLUDocument ()

@end

@implementation CLUDocument

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    NSError *error;
    NSFileWrapper *reportFileWrapper = [[NSFileWrapper alloc] initWithURL:url
                                                                  options:NSFileWrapperReadingImmediate
                                                                    error:&error];
    if (error) {
        return NO;
    }
    if (![reportFileWrapper isDirectory]) {
        return NO;
    }
    
    NSDictionary <NSString *, NSFileWrapper *> *fileWrappers = [reportFileWrapper fileWrappers];
    NSFileWrapper *infoFileWrapper = [fileWrappers objectForKey:@"Info"];
    NSFileWrapper *modulesFileWrapper = [fileWrappers objectForKey:@"Modules"];
    
    if (!infoFileWrapper || !modulesFileWrapper) {
        return NO;
    }
    
    NSURL *infoURL = [url URLByAppendingPathComponent:[infoFileWrapper filename] isDirectory:YES];
    NSURL *moduleURL = [url URLByAppendingPathComponent:[modulesFileWrapper filename] isDirectory:YES];
    
    NSDictionary <NSString *, NSFileWrapper *> *infoFileWrappers = [infoFileWrapper fileWrappers];
    NSDictionary <NSString *, NSFileWrapper *> *modulesFileWrappers = [modulesFileWrapper fileWrappers];
    
    // TODO: parse other modules files
    for (NSString *key in modulesFileWrappers) {
        NSFileWrapper *moduleFile = [modulesFileWrappers objectForKey:key];
        if (![moduleFile isRegularFile]) {
            return NO;
        }
        
        NSURL *moduleFileURL = [moduleURL URLByAppendingPathComponent:[moduleFile filename]];
        if ([[moduleFile filename] isEqualToString:@"module_video.mp4"]) {
            // TODO: handle video file
        }
    }
    return YES;
}

- (BOOL)isEntireFileLoaded {
    return NO;
}

+ (BOOL)canConcurrentlyReadDocumentsOfType:(NSString *)typeName {
    return YES;
}

+ (BOOL)autosavesInPlace {
    return NO;
}

- (BOOL)hasUndoManager {
    return NO;
}

@end
