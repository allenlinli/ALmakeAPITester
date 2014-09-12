//
//  ALAPITester.h
//  ALmakeAPITester
//
//  Created by allenlin on 9/12/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAPITester : NSObject
- (NSDictionary *)diffAPI:(NSDictionary *)outputAPI withExample:(NSDictionary *)exampleAPI;
@end
