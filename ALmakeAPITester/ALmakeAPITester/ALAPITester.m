//
//  ALAPITester.m
//  ALmakeAPITester
//
//  Created by allenlin on 9/12/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

#import "ALAPITester.h"
#import "DiffTuple.h"

@implementation ALAPITester

- (NSDictionary *)diffAPI:(NSDictionary *)outputAPI withExample:(NSDictionary *)exampleAPI
{
    DiffTuple *diffTuple = (DiffTuple *)[self compareStruct:[outputAPI copy] withExample:[exampleAPI copy]];
    if (diffTuple.isSameStruct) {
        return nil;
    }
    else {
        return diffTuple.diff;
    }
}

-(DiffTuple *)compareStruct:(id)output withExample:(id)example
{
    //exception handle
    if (example == nil){
        NSString *errorMsg = [NSString stringWithFormat:@"<exception!!: example is nil>"];
        NSString *outputStr = [NSString stringWithFormat:@"%@ %@",output,errorMsg];
        return [DiffTuple tupleWithBool:false diff:outputStr];
    }
    
    //error handle
    if (output == nil) {
        output = @"<error: output is nil>";
        return [DiffTuple tupleWithBool:false diff:output];
    }
    
    //main
    if (![output isKindOfClass:[example class]]) {
        NSString *errorMsg = [NSString stringWithFormat:@"<error: type should be %@>",[example class]];
        NSString *outputStr = [NSString stringWithFormat:@"%@ %@",output,errorMsg];
        return [DiffTuple tupleWithBool:false diff:outputStr];
    }
    else if ([output isKindOfClass:[NSArray class]]){
        return [self compareArray:output withExample:example];
    }
    else if ([output isKindOfClass:[NSDictionary class]]){
        return [self compareDic:output withExample:example];
    }
    else if ([output isKindOfClass:[NSString class]]){
        return [self compareStr:output withExample:example];
    }
    else if ([output isKindOfClass:[NSNumber class]]){
        return [self compareInt:output withExample:example];
    }
    
    return nil;
}

-(DiffTuple *)compareDic:(NSMutableDictionary *)output withExample:(NSMutableDictionary *)example
{
    output = [output mutableCopy];
    example = [example mutableCopy];
    
    //exception handle
    if (example.count == 0) {
        return [DiffTuple tupleWithBool:true diff:[NSString stringWithFormat:@"%@%@",output,@"<exception!! error: it has no object in template List>"]];
    }
    
    //error handle
    if (output.count == 0) {
        return [DiffTuple tupleWithBool:true diff:[NSString stringWithFormat:@"%@%@",output,@"<error: it has no key in dict>"]];
    }
    
    //main
    DiffTuple *isSameDictTuple = [DiffTuple tupleWithBool:true diff:output];
    for (NSString *key in example.allKeys) {
        if (!output[key]) {
            output[key] = [NSString stringWithFormat:@"<error: it has no key {%@} in dict>",key];
            isSameDictTuple = [DiffTuple tupleWithBool:false diff:output];
            continue;
        }
        
        DiffTuple *tuple = [self compareStruct:output[key] withExample:example[key]];
        if (!tuple.isSameStruct) {
            output[key] = tuple.diff;
            isSameDictTuple = [DiffTuple tupleWithBool:false diff:output];
        }
    }
    
    return isSameDictTuple;
}

-(DiffTuple *)compareArray:(NSMutableArray *)output withExample:(NSMutableArray *)example
{
    //exception
    if (example.count == 0) {
        return [DiffTuple tupleWithBool:true diff:[NSString stringWithFormat:@"%@ %@",output,@"<exception!! error: it has no object in template List>"]];
    }
    
    //error
    DiffTuple *isSameArrayTuple = [DiffTuple tupleWithBool:true diff:output];
    if (output.count == 0) {
        return [DiffTuple tupleWithBool:true diff:[NSString stringWithFormat:@"%@ %@",output,@"<error: it has no obj in list>"]];
    }
    
    //main
    id templateObj = [example firstObject];
    for (int i =0 ; i<output.count ; i++) {
        DiffTuple *oneTutple = [self compareStruct:output[i] withExample:templateObj];
        if (!oneTutple.isSameStruct) {
            output[i] = oneTutple.diff;
            isSameArrayTuple = [DiffTuple tupleWithBool:false diff:output];
        }
    }
    
    return isSameArrayTuple;
}

-(DiffTuple *)compareStr:(NSString *)output withExample:(NSString *)example
{
    if (output.length == 0) {
        
        return [DiffTuple tupleWithBool:false diff:[output stringByAppendingString:@"<error: should not be empty str>"]];
    }
    return [DiffTuple tupleWithBool:true diff:output];
}

-(DiffTuple *)compareInt:(NSNumber *)output withExample:(NSNumber *)example
{
    return [DiffTuple tupleWithBool:true diff:output];
}

@end
