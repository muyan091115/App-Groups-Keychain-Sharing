//
//  ViewController.m
//  iChe
//
//  Created by 蒋伟 on 2019/4/30.
//  Copyright © 2019 中国人寿. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)getUserid:(id)sender {
    
    NSUserDefaults *groupDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.jiangwei.i"];
    self.label.text = [groupDefaults objectForKey:@"group.cn.jiangwei.userid"];
    
}

- (IBAction)getAccount:(id)sender {
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Ixilie_User" accessGroup:@"3BPVDYRLER.cn.jiangwei.i"];
    NSString *username = [wrapper objectForKey:(id)kSecAttrAccount];
    NSString *password = [wrapper objectForKey:(id)kSecValueData];
    
    self.userLabel.text = username;
    self.passwordLabel.text = password;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
