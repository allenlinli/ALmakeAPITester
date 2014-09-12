//
//  DiffTuple.m
//  ALAPITester
//
//  Created by allenlin on 9/11/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

#import "DiffTuple.h"

@implementation DiffTuple

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        _isSameStruct = false;
        _diff = [[NSDictionary alloc] init];
    }
    
    return self;
}

+(DiffTuple *)tupleWithBool:(BOOL)isSameStruct diff:(id)diff
{
    DiffTuple *tuple = [[DiffTuple alloc] init];
    tuple.isSameStruct = isSameStruct;
    tuple.diff = diff;
    
    return tuple;
}

@end
