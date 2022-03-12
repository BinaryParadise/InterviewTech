//
//  ClassViewController.m
//  InterviewUI
//
//  Created by rakeyang on 2022/3/12.
//

#import "ClassViewController.h"
#import "Yunyun.h"
#import <objc/runtime.h>

@interface ClassViewController ()

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Yunyun *yun = Yunyun.new;
    Class cls = yun.class;
    NSLog(@"name: %s", class_getName(cls));
    NSLog(@"ver: %d", class_getVersion(cls));
    NSLog(@"instance_size: %ld", class_getInstanceSize(cls));
    NSLog(@"metaClass: %@", object_getClass(cls));
    NSLog(@"class_isMetaClass: %d", class_isMetaClass(cls));
    NSLog(@"super_class: %@", class_getSuperclass(cls));
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
