//
//  PurchaseViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "PurchaseViewController.h"
#import "BorderSetBtn.h"
#import "AddCardViewController.h"
#import "BOCProtocalViewController.h"
#import "LoginViewController.h"
#import "QueryCardListDataRequest.h"
#import "SetPayPwdViewController.h"
#import "CardModel.h"
#import "ChangeCardCell.h"
#import "SignFundDataRequest.h"
#import "CheckIfSignedRequest.h"
#import "SubsSucViewController.h"
@interface PurchaseViewController ()
{
    BOOL            isSigned;
    BOOL            isSelected;
    int             bottomViewHeight;
    UIView          *bottomView;
    UIView          *backView;
    UITableView     *popTableView;
    
    NSMutableArray  *modelArry;
    NSMutableString *cardNoStr;
    NSString        *last4CardNo;
    NSString        *cardSeq;

}
@end

@implementation PurchaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        modelArry = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarWithtitle:kPurchaseTitle superView:self.view backImg:kNavBackImgName homeImg:nil];
    [self fixExistInfo];//填充已有信息
    [self setUI];
//    [self getPopCardList];
   
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];

}

//如果从未支付订单进入此页面 则会有两项信息 无需选择和输入
- (void)fixExistInfo
{
    if (_sumOfMoney) {
        [_moneyTf setText:_sumOfMoney];
        [_moneyTf setUserInteractionEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setUI
- (void)setUI
{
    if (isSigned) {
        [self.signBtn setSelected:YES];
    }else{
        [self.signBtn setSelected:NO];
    }
    
    [self.proName setTitleColor:kBLueColor forState:UIControlStateNormal];
    [self.proName setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    
    [self.protocol setTitleColor:kBLueColor forState:UIControlStateNormal];
    [self.protocol setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    
    [self.moneyTf setDelegate:self];
    [self.moneyTf setKeyboardType:UIKeyboardTypeNumberPad];
}
#pragma mark - 勾选
- (IBAction)chooseTreaty:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
#pragma mark -  checProDetail  基金详情查询
- (IBAction)checProDetail:(UIButton *)sender
{
    //基金详情查询
}
#pragma mark -  checkProvision   基金条款
- (IBAction)checkProvision:(UIButton *)sender
{
    //基金条款
    BOCProtocalViewController *bocVc = [[BOCProtocalViewController alloc]init];
    [bocVc setNavTitle:kPurchaseTitle ];
    [bocVc._protocolLabel setText:@"基金投资人须知"];
    [self.navigationController pushViewController:bocVc animated:YES];
}
#pragma mark - purchase submit  确定购买按钮
- (IBAction)submitPress:(BorderSetBtn *)sender
{

        SubsSucViewController *pvc = [[SubsSucViewController alloc]initWithNibName:@"SubsSucViewController" bundle:nil];

        [self.navigationController pushViewController:pvc animated:YES];
}


#pragma mark -  choose bank card  选择银行卡POPview 相关
- (IBAction)chooseBankCard:(UIButton *)sender
{
    [self initPopUI];
}

- (void)initPopUI
{
    //选择支付方式
    [self.view endEditing:YES];
    
    backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    if (kScreenHeight>480) {
        bottomViewHeight=270;
    }else{
        bottomViewHeight=270;
    }
    
    UIView * clearTapView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, backView.frame.size.height-bottomViewHeight)];
    [clearTapView setBackgroundColor:[UIColor clearColor]];
    [backView addSubview:clearTapView];
    UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tapGesture setNumberOfTapsRequired:1];
    [clearTapView addGestureRecognizer:tapGesture];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, bottomViewHeight)];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    [v setBackgroundColor:K204GrayColor];
    UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 25)];
    [chooseLabel setFont:[UIFont systemFontOfSize:16]];
    [chooseLabel setBackgroundColor:[UIColor clearColor]];
    [chooseLabel setText:@"选择银行卡"];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(kScreenWidth-80, 0, 80, 45)];
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(purchasePopSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    新增银行卡按钮
    UIButton * addNewBOCCard=[UIButton buttonWithType:UIButtonTypeCustom];
    [addNewBOCCard setFrame:CGRectMake(0, bottomView.frame.size.height-45, kScreenWidth, 45)];
    UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    [lineView setImage:[UIImage imageNamed:@"line_real"]];
    [lineView setBackgroundColor:kViewBackGroudColor];
    
    
    [addNewBOCCard addSubview:lineView];
    [addNewBOCCard setBackgroundColor:kViewBackGroudColor];
    [addNewBOCCard setTitleColor:kBlackColor forState:UIControlStateNormal];
    [addNewBOCCard setTitle:@"新增银行卡" forState:UIControlStateNormal];
    [addNewBOCCard addTarget:self action:@selector(popAddNewBOCCardBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *addImage=[[UIImageView alloc]initWithFrame:CGRectMake(85, 10, 22, 22)];
    [addImage setImage:[UIImage imageNamed:@"card_add"]];
    [addNewBOCCard addSubview:addImage];
    
    
    //    有已绑定卡时界面
    popTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,v.frame.origin.y+v.frame.size.height, kScreenWidth, bottomView.frame.size.height-v.frame.size.height-addNewBOCCard.frame.size.height) style:UITableViewStylePlain];
    
    [popTableView setDataSource:self];
    [popTableView setDelegate:self];
    [popTableView setRowHeight:60];
    if (kDeviceVersion>=7.0) {
        [popTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [popTableView setBackgroundColor:kViewBackGroudColor];
    [popTableView setBackgroundView:nil];
    [popTableView registerNib:[UINib nibWithNibName:@"ChangeCardCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [v addSubview:button];
    [v addSubview:chooseLabel];
    [bottomView addSubview:v];
    [bottomView addSubview:popTableView];
    [bottomView addSubview:addNewBOCCard];
    
    [UIView animateWithDuration:0.3 animations:^{
        [bottomView setFrame:CGRectMake(0, kScreenHeight-bottomViewHeight, kScreenWidth, bottomViewHeight)];
        [[UIApplication sharedApplication].keyWindow addSubview:backView];
        [backView addSubview:bottomView];
    }];
    
    [self setExtraCellLineHidden:popTableView];
    
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self hidePopView];
}

//选择新卡确认点击事件
- (void)purchasePopSubmitBtn:(UIButton *)button
{
    [self hidePopView];
}

#pragma mark - 新增银行卡 点击事件
- (void)popAddNewBOCCardBtn:(UIButton *)button
{
    [self hidePopView];
    GOTO_NEXTVIEWCONTROLLER(AddCardViewController,
                            @"AddCardViewController35",
                            @"AddCardViewController");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeCardCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.cardNicknameLabel.text = @"2222";
    cell.bankNameLabel.text = @"中国银行";

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hidePopView];
    isSelected = YES;

    last4CardNo = @"中国银行";
    cardSeq = @"2222";
    [self.chooseCard setTitle:[last4CardNo stringByAppendingFormat:@"  尾号%@",cardSeq]forState:UIControlStateNormal];
    [self.chooseCard setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

}



#pragma mark -  UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!isSelected) {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"确定", nil];
        [self showNBAlertWithAletTag:112 Title:@"温馨提示" content:@"请先选择银行卡" btnArray:arr];
        return NO;
    }else
        return YES;
}
#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag]==111) {
        [alertView close];
        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                                @"LoginViewController",
                                @"LoginViewController4");
    }else if([alertView tag]==112){
        [alertView close];
    }else if([alertView tag]==113){
        switch (buttonIndex) {
            [alertView close];
            case 0:
                GOTO_NEXTVIEWCONTROLLER(SetPayPwdViewController,
                                        @"SetPayPwdViewController",
                                        @"SetPayPwdViewController4");
                break;
            case 1:
                [alertView close];
                break;
            default:
                break;
        }
    }
}

#pragma mark -其它
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)hidePopView
{
    [UIView animateWithDuration:0.5 animations:^{
        bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, bottomViewHeight);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [bottomView removeFromSuperview];
            [backView removeFromSuperview];
            bottomView = nil;
            backView = nil;
        }
    }];
}

@end
