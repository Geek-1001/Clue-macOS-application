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

- (void)makeWindowControllers {
    NSWindowController *windowController = [[NSWindowController alloc] initWithWindowNibName:@"Document"];
    [self addWindowController:windowController];
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
    
    NSMutableDictionary *modulesFileWrappersDictionary = [[NSMutableDictionary alloc]
                                                          initWithDictionary:[infoFileWrapper fileWrappers]];
    [modulesFileWrappersDictionary addEntriesFromDictionary:[modulesFileWrapper fileWrappers]];
    
    BOOL modulesParseResult = [self parseFileWrappersDictionary:modulesFileWrappersDictionary
                                    withRecordableModuleRootURL:moduleURL
                                          withInfoModuleRootURL:infoURL];
    // Setup unique identifier for document
    _documentId = [[NSUUID UUID] UUIDString];
    return modulesParseResult;
}

- (BOOL)parseFileWrappersDictionary:(NSDictionary <NSString *, NSFileWrapper *> *)fileWrappers
        withRecordableModuleRootURL:(NSURL *)recordableModuleRootURL
              withInfoModuleRootURL:(NSURL *)infoModuleRootURL {
    for (NSString *key in fileWrappers) {
        NSFileWrapper *file = [fileWrappers objectForKey:key];
        if (![file isRegularFile]) {
            return NO;
        }
        
        NSURL *recordableModuleFileURL = [recordableModuleRootURL URLByAppendingPathComponent:[file filename]];
        NSURL *infoModuleFileURL = [infoModuleRootURL URLByAppendingPathComponent:[file filename]];
        
        if ([[file filename] isEqualToString:@"module_video.mp4"]) {
            _video = [[CLUVideo alloc] initWithURL:recordableModuleFileURL];
        } else if ([[file filename] isEqualToString:@"info_device.json"]) {
            _deviceInfo = [[CLUDeviceInfo alloc] initWithURL:infoModuleFileURL];
        } else if ([[file filename] isEqualToString:@"module_view.json"]) {
            _viewStructure = [[CLUViewStructure alloc] initWithURL:recordableModuleFileURL];
        } else if ([[file filename] isEqualToString:@"module_network.json"]) {
            _network = [[CLUNetwork alloc] initWithURL:recordableModuleFileURL];
        } else if ([[file filename] isEqualToString:@"module_interaction.json"]) {
            _userInteractions = [[CLUUserInteractions alloc] initWithURL:recordableModuleFileURL];
        }
    }
    // View should always be present and valid in clue bug report files
    if (!_viewStructure) {
        return NO;
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
