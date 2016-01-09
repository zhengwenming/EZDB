//
//  RedeemViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "RedeemViewController.h"
#import "AddCardViewController.h"
#import "ChangeCardCell.h"
#import "CardModel.h"
#import "QueryCardListDataRequest.h"
#import "BorderSetBtn.h"
#import "redeemPasswordViewController.h"
#import "BOCProtocalViewController.h"
#import "redeemRuleController.h"
#import "LoginViewController.h"

@interface RedeemViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //弹出视图 相关
    UIView *bottomView;
    UIView *backView;
    NSInteger bottomViewHeight;
    UITableView *popTableView;
    UIView *redeemPopView;
    UIView * redeemBackView ;
    UIView * redeemBottomView;
    
    NSString *cardSeq;//银行卡唯一识别码
    NSMutableString *redeemType;//赎回类型
    NSMutableString *redeemShare;//赎回份额
    NSMutableArray *modelArry;//
    NSString        *last4CardNo;
    BOOL            isSelected;

    
}

@end

@implementation RedeemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        modelArry = [NSMutableArray array];
        cardSeq = [NSMutableString string];
        redeemType = [NSMutableString string];
        redeemShare=[NSMutableString string];
        _fundCode=[NSMutableString string];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_redeemRuleButton addTarget:self action:@selector(redeemRule:) forControlEvents:UIControlEventTouchUpInside];

    [self setNavBarWithtitle:@"赎回" superView:self.view backImg:kNavBackImgName homeImg:nil];
    [_redeemRuleButton addTarget:self action:@selector(redeemRule:) forControlEvents:UIControlEventTouchUpInside];
//    [self getPopCardList];
    _fundNameLabel.text=[NSString stringWithFormat:@"  %@",_fundName];
    _allMoneyLabel.text=_allMoney;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - 各点击事件
-(void)redeemRule:(UIButton *)sender
{
    [self.view endEditing:YES];
    GOTO_NEXTVIEWCONTROLLER(redeemRuleController, @"redeemRuleController", @"redeemRuleController");
}

- (IBAction)chooseBankCardAction:(id)sender {
    [self initPopUI];
}
- (IBAction)chooseRedeemTypeAction:(id)sender {
    //    选择赎回方式
    [self initRedeemTypePopView];
}
- (IBAction)redeemAll:(id)sender {
    _redeemMoneyTF.text=_allMoney;
}

#pragma mark - 确定支付 按钮
- (IBAction)submitAction:(id)sender {
    //    确定支付 跳转到输入密码页面
    // 需对页面所填写信息进行判断
    [self.view endEditing:YES];
    if (cardSeq.length==0) {
        [MSUtil showHudMessage:@"请选择银行卡" hideAfterDelay:1.5 uiview:self.view];
    }else if(self.redeemMoneyTF.text.length==0){
        [MSUtil showHudMessage:@"请输入赎回金额" hideAfterDelay:1.5 uiview:self.view];
    }else if ([_redeemTypeButton.titleLabel.text isEqualToString:@"请选择赎回方式"]||[_redeemTypeButton.titleLabel.text isEqualToString:@""]){
        [MSUtil showHudMessage:@"请选择赎回方式" hideAfterDelay:1.5 uiview:self.view];
    }else{
        
        redeemPasswordViewController * redeemPasswordVC=[[redeemPasswordViewController alloc]initWithNibName:@"redeemPasswordViewController" bundle:nil];
        
        redeemPasswordVC.cardSeqStr=[NSString stringWithFormat:@"%@",cardSeq];
        redeemPasswordVC.fundCodeStr=[NSString stringWithFormat:@"%@",_fundCode];
        redeemPasswordVC.redeemTypeStr=[NSString stringWithFormat:@"%@",redeemType];
        redeemPasswordVC.redeemShare=[NSString stringWithFormat:@"%@",redeemShare];
        [self.navigationController pushViewController:redeemPasswordVC animated:YES];
    }

}


#pragma mark - 选择赎回方式
-(void)redeemType:(UIButton *)button
{
    //    根据button tag 区分选择了哪个按钮  1010 是普通赎回
    //    1011是快速赎回
    switch (button.tag) {
        case 1010:
            [_redeemTypeButton setTitle:@"普通赎回" forState:UIControlStateNormal];
            redeemType=[NSMutableString stringWithString:@"2"];
            break;
        case 1011:
            [_redeemTypeButton setTitle:@"快速赎回" forState:UIControlStateNormal];
            redeemType=[NSMutableString stringWithString:@"1"];
            break;
            
        default:
            break;
    }
    [_redeemTypeButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [self hideRedeemPopView];
    
}

#pragma mark - 新增银行卡 点击事件
-(void)popAddNewBOCCardBtn:(UIButton *)button
{
    //    跳转到新增银行卡界面
    [self hidePopView];
    GOTO_NEXTVIEWCONTROLLER(AddCardViewController, @"AddCardViewController", @"AddCardViewController");
    

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
    [self.chooseBankCardButton setTitle:[last4CardNo stringByAppendingFormat:@"  尾号%@",cardSeq]forState:UIControlStateNormal];
    [self.chooseBankCardButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
}

#pragma mark - 选择赎回方式 弹出视图 相关
-(void)initRedeemTypePopView
{
    [self.view endEditing:YES];
    
    redeemBackView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    redeemBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 125)];
    [redeemBackView setBackgroundColor:[UIColor clearColor]];
    [redeemBackView setUserInteractionEnabled:YES];
    
    UIView * clearTapView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, redeemBackView.frame.size.height-redeemBottomView.frame.size.height)];
    [clearTapView setBackgroundColor:[UIColor clearColor]];
    [redeemBackView addSubview:clearTapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForHiding:)];
    [clearTapView addGestureRecognizer:tap];
    
    redeemPopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    redeemPopView.backgroundColor = [UIColor lightGrayColor];
    UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 120, 25)];
    chooseLabel.font = [UIFont systemFontOfSize:16];
    chooseLabel.backgroundColor = [UIColor clearColor];
    chooseLabel.text = @" 选择赎回方式";
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(kScreenWidth-80, 0, 80, 45)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(redeemPopSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [redeemPopView addSubview:button];
    [redeemPopView addSubview:chooseLabel];
    [redeemBottomView addSubview:redeemPopView];
    
    //    普通赎回 按钮
    UIButton * redeemCommonButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 40)];
    [redeemCommonButton setTitle:@"普通赎回" forState:UIControlStateNormal];
    [redeemCommonButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [redeemCommonButton setBackgroundColor:[UIColor whiteColor]];
    redeemCommonButton.tag=1010;
    [redeemCommonButton addTarget:self action:@selector(redeemType:) forControlEvents:UIControlEventTouchUpInside];
    [redeemBottomView addSubview:redeemCommonButton];
    
    UIImageView * lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    
    lineView.backgroundColor=K204GrayColor;
    //    快速赎回 按钮
    UIButton * redeemFastButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 85, kScreenWidth, 40)];
    [redeemFastButton setBackgroundColor:[UIColor whiteColor]];
    [redeemFastButton setTitle:@"快速赎回" forState:UIControlStateNormal];
    [redeemFastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    redeemFastButton.tag=1011;
    [redeemFastButton addTarget:self action:@selector(redeemType:) forControlEvents:UIControlEventTouchUpInside];
    [redeemBottomView addSubview:redeemFastButton];
    [redeemFastButton addSubview:lineView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        redeemBottomView.frame = CGRectMake(0, kScreenHeight-125, kScreenWidth, 130);
        [[UIApplication sharedApplication].keyWindow addSubview:redeemBackView];
        [redeemBackView addSubview:redeemBottomView];
    }];
    
}
#pragma mark - 选择银行卡 弹出视图 UI
-(void)initPopUI
{
    //选择支付方式
    [self.view endEditing:YES];
    backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor clearColor];
    if (kScreenHeight>480) {
        bottomViewHeight=270;
    }else{
        bottomViewHeight=270;
        
    }
    
    UIView * clearTapView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, backView.frame.size.height-bottomViewHeight)];
    clearTapView.backgroundColor=[UIColor clearColor];
    [backView addSubview:clearTapView];
    UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGesture.numberOfTapsRequired = 1;
    [clearTapView addGestureRecognizer:tapGesture];
    
    
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, bottomViewHeight)];
    bottomView.backgroundColor=[UIColor whiteColor];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    v.backgroundColor = [UIColor lightGrayColor];
    UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 25)];
    chooseLabel.font = [UIFont systemFontOfSize:16];
    chooseLabel.backgroundColor = [UIColor clearColor];
    chooseLabel.text = @"选择银行卡";
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(kScreenWidth-80, 0, 80, 45)];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(redeemPopSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    新增银行卡按钮
    
    UIButton * addNewBOCCard=[UIButton buttonWithType:UIButtonTypeCustom];
    addNewBOCCard.frame=CGRectMake(0, bottomView.frame.size.height-45, kScreenWidth, 45);
    UIImageView * lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    
    lineView.backgroundColor=[UIColor grayColor];
    [addNewBOCCard addSubview:lineView];
    [addNewBOCCard setBackgroundColor:kRegBackGroudColor];
    [addNewBOCCard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addNewBOCCard setTitle:@"新增银行卡" forState:UIControlStateNormal];
    [addNewBOCCard addTarget:self action:@selector(popAddNewBOCCardBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * addImage=[[UIImageView alloc]initWithFrame:CGRectMake(85, 10, 24, 24)];
    addImage.image=[UIImage imageNamed:@"card_add"];
    [addNewBOCCard addSubview:addImage];
    
    
    //    有已绑定卡时界面
    popTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,v.frame.origin.y+v.frame.size.height, kScreenWidth, bottomView.frame.size.height-v.frame.size.height-addNewBOCCard.frame.size.height) style:UITableViewStylePlain];
    popTableView.dataSource = self;
    popTableView.delegate = self;
    popTableView.backgroundColor=[UIColor whiteColor];
    popTableView.rowHeight = 60;
    if (kDeviceVersion>=7.0) {
        popTableView.separatorInset=UIEdgeInsetsZero;
        
    }
    popTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [popTableView registerNib:[UINib nibWithNibName:@"ChangeCardCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [v addSubview:button];
    [v addSubview:chooseLabel];
    [bottomView addSubview:v];
    
    [bottomView addSubview:popTableView];
    
    [bottomView addSubview:addNewBOCCard];
    
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.frame = CGRectMake(0, kScreenHeight-bottomViewHeight, kScreenWidth, bottomViewHeight);
        [[UIApplication sharedApplication].keyWindow addSubview:backView];
        [backView addSubview:bottomView];
    }];
    
    
    [self setExtraCellLineHidden:popTableView];
    
    
    
}
#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView close];
    if ([alertView tag]==111) {
        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                                @"LoginViewController",
                                @"LoginViewController4");
    }
}
#pragma mark - 弹出视图相关
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView {
    
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


-(void)tapForHiding:(UITapGestureRecognizer *)tap
{
    [self hideRedeemPopView];
}
-(void)hidePopView
{
    
    [UIView animateWithDuration:0.3 animations:^{
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
-(void)hideRedeemPopView
{
    [UIView animateWithDuration:0.3 animations:^{
        redeemBottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 130);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [redeemBottomView removeFromSuperview];
            [redeemBackView removeFromSuperview];
            redeemBackView = nil;
            redeemBottomView = nil;
        }
    }];
    
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    [self hidePopView];
}

//选择新卡确认点击事件
-(void)redeemPopSubmitBtn:(UIButton *)button
{
    [self hidePopView];
    [self hideRedeemPopView];
    
}


@end
