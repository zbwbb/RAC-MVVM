//
//  BaseViewController.m
//  ReactiveCocoa_01
//
//  Created by TsouMac2016 on 2018/11/20.
//  Copyright © 2018 TsouMac2016. All rights reserved.
//

#import "BaseViewController.h"
#import <ReactiveObjC.h>
#import "LoginViewModel.h"
#import <RACEXTScope.h>

@interface BaseViewController ()
@property (nonatomic, strong) UIButton *btnCommit;
@property (nonatomic, strong) RACCommand *command;
@property (nonatomic, strong) UITextField *fieldAccount;
@property (nonatomic, strong) UITextField *fieldPass;
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // add subviews
    [self addSubviews];
    // bind model
    [self bindModel];
}

#pragma mark - addSubviews

-(void)addSubviews{
    self.fieldAccount = [[UITextField alloc]initWithFrame:CGRectMake(100, 150, 200, 40)];
    _fieldAccount.textColor = [UIColor blackColor];
    _fieldAccount.backgroundColor = [UIColor whiteColor];
    _fieldAccount.layer.borderWidth = 0.5f;
    _fieldAccount.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _fieldAccount.placeholder = @"请输入账号";
    [self.view addSubview:_fieldAccount];
    //
    self.fieldPass = [[UITextField alloc]initWithFrame:CGRectMake(100, 220, 200, 40)];
    _fieldPass.textColor = [UIColor blackColor];
    _fieldPass.placeholder = @"请输入密码";
    _fieldPass.backgroundColor = [UIColor whiteColor];
    _fieldPass.layer.borderWidth = 0.5f;
    _fieldPass.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_fieldPass];
    
    self.btnCommit = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCommit.frame = CGRectMake(100, 300, 100, 40);
    _btnCommit.backgroundColor = [UIColor whiteColor];
    [_btnCommit setTitle:@"登 录" forState:UIControlStateNormal];
    [_btnCommit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _btnCommit.layer.borderWidth = 0.5f;
    _btnCommit.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_btnCommit];
    
}

#pragma mark -试图与VM的绑定
-(void)bindModel{
    @weakify(self);
    
    // 将账号输入信号与Account中的账号绑定
    RAC(self.loginViewModel.account, account) = self.fieldAccount.rac_textSignal;
    
    // 将密码输入信号与Account中的密码绑定
    RAC(self.loginViewModel.account, password) = self.fieldPass.rac_textSignal;
    
    // 登录按钮能否点击，由信号决定，信号的返回值是Bool
    RAC(self.btnCommit, enabled) = self.loginViewModel.enableSignal;
    
    // 改变登录按钮的颜色
    [self.loginViewModel.enableSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.btnCommit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [self.btnCommit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }];
    
    // 监听按钮的点击
    [[_btnCommit rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        // 执行点击事件
        [self.loginViewModel.LoginCommand execute:@"登录试试看"];
    }];
    
}

#pragma mark - getter && setter
- (LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        self.loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
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
