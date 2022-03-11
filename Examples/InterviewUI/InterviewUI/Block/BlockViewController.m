//
//  BlockViewController.m
//  InterviewUI
//
//  Created by rakeyang on 2022/3/11.
//

#import "BlockViewController.h"

typedef void(^Blockify)(NSString *str);

@interface BlockViewController ()

@property (nonatomic, retain) Blockify block1;
@property (nonatomic, strong) Blockify block2;
@property (nonatomic, copy) Blockify block3;

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBlock1:^(NSString *str) {
        
    }];
    
    NSLog(@"retain: %@", self.block1);
    
    [self setBlock2:^(NSString *str) {
        
    }];
    NSLog(@"strong: %@", self.block2);
    
    [self setBlock3:^(NSString *str) {
        
    }];
    NSLog(@"copy: %@", self.block3);
    
    int n = 1;
    Blockify blockA = ^(NSString *str) {
        NSLog(@"%d", n);
    };
    
    NSLog(@"strong+var: %@", blockA);
    
    Blockify blockB = ^(NSString *str) {
        NSLog(@"%d", n);
    };
    
    NSLog(@"copy+var: %@", [blockB copy]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
