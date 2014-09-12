//
//  DiffTuple.h
//  ALAPITester
//
//  Created by allenlin on 9/11/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiffTuple : NSObject
@property (assign, nonatomic) BOOL isSameStruct;
@property (strong, nonatomic) id diff;

+(DiffTuple *)tupleWithBool:(BOOL)isSameStruct diff:(id)diff;

@end
