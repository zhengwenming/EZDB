//
//  ChangeCardViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14/11/11.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ChangeCardViewController.h"
#import "ChangeCardCell.h"
#import "ChangeSuccessViewController.h"
#import "AddCardViewController.h"
#import "BOCOPPayDataRequest.h"
#import "BorderSetBtn.h"
#import "QueryCardListDataRequest.h"
#import "CardModel.h"
#import "ChangeCardRequest.h"
#import "LoginViewController.h"

@interface ChangeCardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //    弹出视图相关
    UIView *bottomView;
    UIView *backView;
    UITableView * popTableView;
    NSMutableArray * alreadyHaveCardsArr;
    int bottomViewHeight;
    
    NSMutableArray *modelArry; //卡信息数组
    BOOL isChangeAll;//是否勾选
    
}

@end

@implementation ChangeCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        alreadyHaveCardsArr=[NSMutableArray array];
        modelArry=[NSMutableArray array];
        isChangeAll=YES;
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self fixDataToUI];
    [self setNavBarWithtitle:@"换卡" superView:self.view backImg:kNavBackImgName homeImg:nil];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
//    [self getCardListRequest];
    [self isChangeAll];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)fixDataToUI
{
    if (_fundNameStr) {
        _fundName.text=[NSString stringWithFormat:@"  %@",_fundNameStr];
    }
    if (_sumMoneyStr) {
        _sumOfMoney.text=[NSString stringWithFormat:@"  %@",_sumMoneyStr];
    }
    if (_cardSeqStr) {
        _oldCardInfo.text=[NSString stringWithFormat:@"  %@",_cardSeqStr];
    }else{
        _oldCardInfo.text=@"  test";
    }
}

#pragma mark - 换卡完成确定事件
- (IBAction)changeCardSubmitClick:(id)sender {
    //发送新的 绑定卡信息 请求
    if (_nCardSeq.length==0) {
        [MSUtil showHudMessage:@"请选择新的银行卡" hideAfterDelay:1.5 uiview:self.view];
    } else {
//        [self changeCardRequest];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardModel * newModel=[modelArry objectAtIndex:indexPath.row];
    [_chooseCardButton setTitle:[newModel.openBank stringByAppendingFormat:@"  %@",newModel.cardTailNo] forState:UIControlStateNormal];
    [_chooseCardButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    _nCardSeq=[NSString stringWithFormat:@"%@",newModel.cardSeq];
    LOG(@"换卡页面 选择的新卡信息%@--%@",newModel.cardTailNo,newModel.openBank);
    [self hidePopView];
}

#pragma mark - 数据请求




#pragma mark - 选择开户行弹出视图相关
- (IBAction)chioceNewRedeemCard:(id)sender
{
    [self.view endEditing:YES];
    
    backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor clearColor];
    if (modelArry.count>0) {
        bottomViewHeight=270;
    }else{
        bottomViewHeight=180;
    }
    
    UIView * clearTapView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, backView.frame.size.height-bottomViewHeight)];
    clearTapView.backgroundColor=[UIColor clearColor];
    [backView addSubview:clearTapView];
    UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGesture.numberOfTapsRequired = 1;
    [clearTapView addGestureRecognizer:tapGesture];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, bottomViewHeight)];
    
    if (kDeviceVersion<7.0) {
        bottomView.backgroundColor = [UIColor whiteColor];
    }
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    v.backgroundColor = K204GrayColor;
    UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 25)];
    chooseLabel.font = [UIFont systemFontOfSize:16];
    chooseLabel.backgroundColor = [UIColor clearColor];
    chooseLabel.text = @"选择银行卡";
    chooseLabel.textColor=kBlackColor;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-80, 0, 80, 45);
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeCardPopSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    新增银行卡按钮
    UIButton * addNewBOCCard=[UIButton buttonWithType:UIButtonTypeCustom];
    [addNewBOCCard setFrame:CGRectMake(0, bottomView.frame.size.height-45, kScreenWidth, 45)];
    [addNewBOCCard setBackgroundColor:kRegBackGroudColor];
    [addNewBOCCard setTitleColor:kBlackColor forState:UIControlStateNormal];
    UIImageView * lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    [lineView setBackgroundColor:K204GrayColor];
    [addNewBOCCard addSubview:lineView];
    [addNewBOCCard setTitle:@"新增银行卡" forState:UIControlStateNormal];
    [addNewBOCCard addTarget:self action:@selector(popAddNewBOCCardBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * addImage=[[UIImageView alloc]initWithFrame:CGRectMake(85, 10, 24, 24)];
    addImage.image=[UIImage imageNamed:@"card_add"];
    [addNewBOCCard addSubview:addImage];
    
    
    //没有已绑定卡时提示信息
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, v.frame.size.height, kScreenWidth, 90)];
    label.backgroundColor=kViewBackGroudColor;
    UIImageView * errorImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 36, 18, 18)];
    errorImage.image=[UIImage imageNamed:@"ico_error.png"];
    UILabel * errorMessage=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, kScreenWidth-45-20, 70)];
    errorMessage.text=@"您尚未绑定中国银行卡借记卡，请点击新增银行卡绑定";
    errorMessage.numberOfLines=0;
    errorMessage.font=[UIFont systemFontOfSize:16];
    [label addSubview:errorMessage];
    [label addSubview:errorImage];
    
    
    //    有已绑定卡时界面
    popTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, v.frame.size.height, kScreenWidth, bottomView.frame.size.height-v.frame.size.height) style:UITableViewStylePlain];
    popTableView.dataSource = self;
    popTableView.delegate = self;
    popTableView.rowHeight = 60;
    if (kDeviceVersion>=7.0) {
        popTableView.separatorInset=UIEdgeInsetsZero;
    }
    popTableView.backgroundColor=kViewBackGroudColor;
    [popTableView registerNib:[UINib nibWithNibName:@"ChangeCardCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [v addSubview:button];
    [v addSubview:chooseLabel];
    [bottomView addSubview:v];
    
    if (modelArry.count>0) {
        [bottomView addSubview:popTableView];
    }else{
        [bottomView addSubview:label];
    }
    
    [bottomView addSubview:addNewBOCCard];
    
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.frame = CGRectMake(0, kScreenHeight-bottomViewHeight, kScreenWidth, bottomViewHeight);
        [[UIApplication sharedApplication].keyWindow addSubview:backView];
        [backView addSubview:bottomView];
    }];
    
    [self setExtraCellLineHidden:popTableView];
    
    
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self hidePopView];
}

//选择新的中行卡确认点击事件
-(void)changeCardPopSubmitBtn:(UIButton *)button
{
    [self hidePopView];
    
}
#pragma mark - 新增银行卡点击事件
-(void)popAddNewBOCCardBtn:(UIButton *)button
{
    //    跳转到新增银行卡界面
    [self hidePopView];
    GOTO_NEXTVIEWCONTROLLER(AddCardViewController,
                            @"AddCardViewController35",
                            @"AddCardViewController");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 隐藏弹出视图 手势相关
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

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView {
    
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - NBAlertViewDelegate
- (void)NBAlertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView close];
    if ([alertView tag]==111) {
        [BOCOPLogin sharedInstance].isLogin = NO;;
        GOTO_NEXTVIEWCONTROLLER(LoginViewController,
                                @"LoginViewController",
                                @"LoginViewController4");
    }
    
}
#pragma mark - 勾选 相关
- (IBAction)isChangeAllCardAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
-(void)isChangeAll
{
    if (isChangeAll) {
        [self.isChangeAllCard setSelected:YES];
    }else{
        [self.isChangeAllCard setSelected:NO];
    }
    
}

@end
