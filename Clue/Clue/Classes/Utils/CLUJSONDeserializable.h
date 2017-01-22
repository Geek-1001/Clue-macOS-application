//
//  CLUJSONDeserializable.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/22/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLUJSONDeserializable <NSObject>

- (instancetype)initWithJSONRepresentation:(NSDictionary *)json;

@end
