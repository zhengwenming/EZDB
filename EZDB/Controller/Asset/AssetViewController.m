//
//  AssetViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "AssetViewController.h"
#import "ProfitListController.h"
#import "TransactionListController.h"
#import "TransactionDetailController.h"
#import "RedeemViewController.h"
#import "AssetCell.h"
#import "PopMenu.h"
#import "BankView.h"
#import "QueryFundProperty.h"



//#define kFOOTERHIGHT 120
@interface AssetViewController (){
    NSMutableArray *dataSource;
    NSMutableArray *stateArray;
    CGFloat footerHight;
    UILabel *yesterdayProfit;
    UILabel *totalProfitNum;
    UILabel *allAssetNum;
}

@end
@implementation AssetViewController
@synthesize assetTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];


}
- (void)viewDidLoad
{
    footerHight = 0;
        dataSource = [NSMutableArray array];
    stateArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
    [super viewDidLoad];
    [self initUI];
    [self setNavBar];
    
    //查询持仓信息
//    [self queryFundProperty];
    [self initTableHeaderView];
//    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];

}

- (void)setNavBar
{
    [self setNavBarWithtitle:@"我的资产" superView:self.view backImg:nil homeImg:nil];
}
- (void)initUI
{
    
    if (kDeviceVersion>=7.0) {
        assetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49) style:UITableViewStyleGrouped];
        
    }else{
        assetTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44-49-20) style:UITableViewStyleGrouped];
    }
    
    self.view.backgroundColor = kViewBackGroudColor;
    assetTableView.backgroundColor = [UIColor clearColor];
    assetTableView.delegate =self;
    assetTableView.dataSource =self;
    assetTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    assetTableView.backgroundColor = kViewBackGroudColor;
    assetTableView.backgroundView = nil;
    [assetTableView registerNib:[UINib nibWithNibName:@"AssetCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:assetTableView];
    
   
}
-(void)initTableHeaderView{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    contentView.backgroundColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
    UILabel *yesterdayTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 140, 30)];
    yesterdayTitle.backgroundColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
    yesterdayTitle.text = @"昨日总收益(元)";
    yesterdayTitle.font = [UIFont  systemFontOfSize:12];
    
    yesterdayTitle.textColor = [UIColor whiteColor];
    [contentView addSubview:yesterdayTitle];
    yesterdayProfit  = [[UILabel alloc]initWithFrame:CGRectMake(0, yesterdayTitle.frame.origin.y+20, kScreenWidth, 80)];
   
    yesterdayProfit.backgroundColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
    yesterdayProfit.text = @"100";
    yesterdayProfit.textAlignment = NSTextAlignmentCenter;
    yesterdayProfit.textColor = [UIColor whiteColor];
    yesterdayProfit.font = [UIFont  systemFontOfSize:48];
    [contentView addSubview:yesterdayProfit];
    //line
    UIView *alineView = [[UIView alloc]initWithFrame:CGRectMake(0, yesterdayProfit.frame.origin.y+90, kScreenWidth, 0.5)];
    alineView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:alineView];
    
    UIView *blineView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, alineView.frame.origin.y,0.5, contentView.frame.size.height-alineView.frame.origin.y)];
    blineView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:blineView];
    
    
    UILabel *allAsset = [[UILabel alloc]initWithFrame:CGRectMake(20, alineView.frame.origin.y+10, 120, 20)];
    allAsset.text = @"总资产(元)";
    allAsset.backgroundColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
    
    allAsset.font = [UIFont  systemFontOfSize:12];
    allAsset.textColor = [UIColor whiteColor];
    [contentView addSubview:allAsset];
    allAssetNum = [[UILabel alloc]initWithFrame:CGRectMake(allAsset.frame.origin.x, allAsset.frame.origin.y+allAsset.frame.size.height, allAsset.frame.size.width, allAsset.frame.size.height)];
    allAssetNum.text = @"1200";
    allAssetNum.backgroundColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
    allAssetNum.font = [UIFont  systemFontOfSize:19];
    allAssetNum.textColor = [UIColor whiteColor];
    [contentView addSubview:allAssetNum];
    
    
    
    UILabel *totalProfit = [[UILabel alloc]initWithFrame:CGRectMake(blineView.frame.origin.x+20, allAsset.frame.origin.y, allAsset.frame.size.width, allAsset.frame.size.height)];
    totalProfit.backgroundColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
    
    totalProfit.textColor = [UIColor whiteColor];
    totalProfit.font = [UIFont  systemFontOfSize:12];
    totalProfit.text = @"累计总收益(元)";
    [contentView addSubview:totalProfit];
    totalProfitNum = [[UILabel alloc]initWithFrame:CGRectMake(totalProfit.frame.origin.x, totalProfit.frame.origin.y+totalProfit.frame.size.height, totalProfit.frame.size.width+20, totalProfit.frame.size.height)];
    totalProfitNum.textColor = [UIColor whiteColor];
    totalProfitNum.backgroundColor = [UIColor colorWithRed:11/256.0 green:81/256.0 blue:135/256.0 alpha:1];
    totalProfitNum.font = [UIFont  systemFontOfSize:19];
    totalProfitNum.text = @"100";

    [contentView addSubview:totalProfitNum];
    
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, contentView.frame.size.height-35, contentView.frame.size.width, 35)];
    bottomLabel.textColor =[UIColor blackColor];
    bottomLabel.font = [UIFont systemFontOfSize:15];
    bottomLabel.backgroundColor = kViewBackGroudColor;
    bottomLabel.text = @"     您现在持有的基金产品";
    [contentView addSubview:bottomLabel];
    
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, bottomLabel.frame.origin.y+bottomLabel.frame.size.height, bottomLabel.frame.size.width, 1)];
    lineIV.image = [UIImage imageNamed:@"line_dotted.png"];
    [contentView addSubview:lineIV];
    assetTableView.tableHeaderView = contentView;
}
-(void)showMore:(UIButton *)sender{
        
        //判断状态值
        if ([stateArray[sender.tag] isEqualToString:@"1"]){
            //修改
            footerHight = 190;
            [stateArray replaceObjectAtIndex:sender.tag withObject:@"0"];
        }else{
            footerHight =0;
            [stateArray replaceObjectAtIndex:sender.tag withObject:@"1"];
        }
        [assetTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - 赎回点击事件
-(void)redeemMoney:(UIButton *)sender{
    NSLog(@"赎回");

//    UIButton * button=(UIButton *)sender;
    RedeemViewController * redeemVC=[[RedeemViewController alloc]initWithNibName:@"RedeemViewController" bundle:nil];
    
    redeemVC.fundName=[NSString stringWithFormat:@"广发基金%d",sender.tag];
    redeemVC.allMoney=[NSString stringWithFormat:@"%d0000.00元",sender.tag];
    redeemVC.fundCode=[NSString stringWithFormat:@"%@",@"此处传入需要赎回基金的唯一识别码"];
    [self.navigationController pushViewController:redeemVC animated:YES];
}
#pragma mark
#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AssetCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (cell==nil) {
        cell = [[AssetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSLog(@"test");
    }
//    FundPropertyModel *model = dataSource[indexPath.section];
//    if (model) {
//        cell.titleLabel.text = model.fundName;
//        cell.moneyInCtrl.text = [NSString stringWithFormat:@"持有额(元):%@",model.totalVol];
//        cell.yesdayProfitLabel.text = model.lastdayIncome;
//        cell.totalProfitLabel.text = model.totalIncome;
//    }
    cell.moreBtn.tag = indexPath.section;
    cell.redeemBtn.tag = indexPath.section+100;
    [cell.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [cell.moreBtn addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
    [cell.redeemBtn addTarget:self action:@selector(redeemMoney:) forControlEvents:UIControlEventTouchUpInside];
    cell.bottomView.backgroundColor = kRegBackGroudColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cell.contentView.backgroundColor = kViewBackGroudColor;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 143;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    BankView *bank_BOC = [[BankView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 40)];
    [contentView addSubview:bank_BOC];
    //分割线
    UIImageView *lineIV = [[UIImageView  alloc]initWithFrame:CGRectMake(0, bank_BOC.frame.origin.y+bank_BOC.frame.size.height+10, bank_BOC.frame.size.width, 1)];
    lineIV.image  = [UIImage imageNamed:@"line_dotted.png"];
    [contentView addSubview:lineIV];
    
    BankView *bank_ABC = [[BankView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, 40)];
    bank_ABC.logoIV.image = [UIImage imageNamed:@"ico_abc.png"];
    [contentView addSubview:bank_ABC];
    contentView.layer.cornerRadius = 2;
    contentView.backgroundColor = [UIColor whiteColor];
    if ([stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        return contentView;
        
    }else{
        //如果是闭合，返回0
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        return 120;
        
    }else{
        //如果是闭合，返回0
        return 0;
    }
//    return footerHight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    assetTableView = nil;
    dataSource = nil;
    assetTableView.delegate = nil;
    assetTableView.dataSource = nil;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
