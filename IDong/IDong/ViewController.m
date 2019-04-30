//
//  ViewController.m
//  IDong
//
//  Created by 蒋伟 on 2019/4/30.
//  Copyright © 2019 中国人寿. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = [self bundleSeedID];
    NSLog(@"-----%@", str);
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)saveUserID:(id)sender {
    
    
    
    NSUserDefaults *groupDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.jiangwei.i"];
    [groupDefaults setObject:self.textField.text forKey:@"group.cn.jiangwei.userid"];
    
}

- (IBAction)saveAccount:(id)sender {
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Ixilie_User" accessGroup:@"3BPVDYRLER.cn.jiangwei.i"];
    
    NSString *username = self.userTextField.text;
    NSString *password = self.passwordTextField.text;
    [wrapper setObject:username forKey:(id)kSecAttrAccount];
    [wrapper setObject:password forKey:(id)kSecValueData];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
}

- (NSString *)bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:kSecClassGenericPassword, kSecClass,@"bundleSeedID", kSecAttrAccount,@"", kSecAttrService,(id)kCFBooleanTrue, kSecReturnAttributes,nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)status = SecItemAdd((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:kSecAttrAccessGroup];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];CFRelease(result);return bundleSeedID;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
