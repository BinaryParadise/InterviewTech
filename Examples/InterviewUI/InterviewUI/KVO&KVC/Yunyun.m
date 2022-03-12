//
//  Yunyun.m
//  InterviewUI
//
//  Created by rakeyang on 2022/3/12.
//

#import "Yunyun.h"

@implementation Yunyun

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *elements = @[@186, @1, @59, @3284, @458, @8];
        id obj = [elements valueForKeyPath:@"@count"];
        NSLog(@"kvc: %@", obj);
    }
    return self;
}

@end
