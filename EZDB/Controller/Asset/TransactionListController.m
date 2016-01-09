//
//  TransactionListController.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-12.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "TransactionListController.h"
#import "TransactionCell.h"
#import "TransactionDetailController.h"
#import "PickerView.h"
#import "QueryHistoryListRequest.h"
#import "TransactionModel.h"

#define kLEFTBTN 100
#define kRIGHTBTN 101
@interface TransactionListController (){
    UITableView *transactionTableView;
    NSMutableArray *dataSource;
    NSMutableArray *typeArray;
    NSMutableArray *monthArray;
    NSMutableArray *accountArray;
    NSMutableArray *productArry;
    NSString *formatterStr;
    PickerView *picker1;
    
}

@end

@implementation TransactionListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (index==2){
        
    }
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];
//
//}
- (void)viewDidLoad
{
    dataSource = [[NSMutableArray alloc]init];
    typeArray= [NSMutableArray arrayWithObjects:@"赎回",@"购买", nil];
    productArry = [NSMutableArray arrayWithObjects:@"交易1",@"交易2",@"交易3",@"交易4",@"交易5", nil];
    monthArray =[NSMutableArray arrayWithObjects:@"2014年1月",@"2014年2月",@"2014年3月",@"2014年4月",@"2014年5月",@"2014年6月",@"2014年7月",@"2014年8月",@"2014年9月",@"2014年10月",@"2014年11月",@"2014年12月", nil];
    accountArray =[NSMutableArray arrayWithObjects:@"6227 0031 3102 0167 298",@"6227 0031 3102 0167 268",@"6227 0031 3102 0167 238",@"6227 0031 3102 0167 218", nil];
    [super viewDidLoad];
    [self initTableView];
    if (IS_IPHONE4) {
        picker1 = [[PickerView alloc]initWithFrame:CGRectMake(0, 180-30, self.view.frame.size.width, 400)];
        
    }else if (IS_IPHONE5){
        picker1 = [[PickerView alloc]initWithFrame:CGRectMake(0, 295-30, self.view.frame.size.width, 400)];
        
    }
    [picker1.sureBtn addTarget:self action:@selector(IamSure:) forControlEvents:UIControlEventTouchUpInside];
    [picker1.leftBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    picker1.leftBtn.tag = kLEFTBTN;
    [picker1.rightBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    picker1.rightBtn.tag = kRIGHTBTN;
    picker1.picker.backgroundColor = [UIColor lightGrayColor];
    picker1.picker.dataSource = self;
    picker1.picker.delegate = self;
    

}

-(void)changePicker:(UIButton *)sender{
    
    
    
    if (sender.tag==1000) {
        //交易类型
        
        
        if (self.typeBtn.isSelected) {
            [picker1 removeFromSuperview];
            self.typeBtn.selected = NO;
            transactionTableView.userInteractionEnabled = YES;
            
        }else{
            self.typeBtn.selected = YES;
            self.monthBtn.selected = NO;
            self.accountBtn.selected = NO;
            self.transactionBtn.selected = NO;
            [self.view addSubview:picker1];
            transactionTableView.userInteractionEnabled = NO;
            [picker1.leftBtn setImage:[UIImage imageNamed:@"ico_back_white.png"] forState:UIControlStateNormal];
            [picker1.rightBtn setImage:[UIImage imageNamed:@"ico_next.png"] forState:UIControlStateNormal];
            
        }
        
        
        
    }else if (sender.tag==1001){
        //交易时间
        if (self.monthBtn.isSelected) {
            [picker1 removeFromSuperview];
            transactionTableView.userInteractionEnabled = YES;
            
            self.monthBtn.selected = NO;
        }else{
            self.typeBtn.selected = NO;
            self.monthBtn.selected = YES;
            self.accountBtn.selected = NO;
            self.transactionBtn.selected = NO;
            [self.view addSubview:picker1];
            transactionTableView.userInteractionEnabled = NO;
            [picker1.leftBtn setImage:[UIImage imageNamed:@"ico_back_black.png"] forState:UIControlStateNormal];
            [picker1.rightBtn setImage:[UIImage imageNamed:@"ico_next.png"] forState:UIControlStateNormal];
            
        }
        
    }else if (sender.tag == 1002){
        //交易账户
        if (self.accountBtn.isSelected) {
            [picker1 removeFromSuperview];
            self.accountBtn.selected = NO;
            transactionTableView.userInteractionEnabled = YES;
            
        }else{
            self.typeBtn.selected = NO;
            self.monthBtn.selected = NO;
            self.accountBtn.selected = YES;
            self.transactionBtn.selected = NO;
            [self.view addSubview:picker1];
            transactionTableView.userInteractionEnabled = NO;
            [picker1.leftBtn setImage:[UIImage imageNamed:@"ico_back_black.png"] forState:UIControlStateNormal];
            [picker1.rightBtn setImage:[UIImage imageNamed:@"ico_next_white.png"] forState:UIControlStateNormal];
            
            
        }
        
    }else if (sender.tag==1003){
        //产品类型
        if (self.transactionBtn.isSelected) {
            [picker1 removeFromSuperview];
            self.transactionBtn.selected = NO;
            transactionTableView.userInteractionEnabled = YES;
            
        }else{
            self.typeBtn.selected = NO;
            self.monthBtn.selected = NO;
            self.accountBtn.selected = NO;
            self.transactionBtn.selected = YES;
            [self.view addSubview:picker1];
            transactionTableView.userInteractionEnabled = NO;
            [picker1.leftBtn setImage:[UIImage imageNamed:@"ico_back_black.png"] forState:UIControlStateNormal];
            [picker1.rightBtn setImage:[UIImage imageNamed:@"ico_next.png"] forState:UIControlStateNormal];
            
        }
    }
    picker1.titleLabel.text = sender.titleLabel.text;
    [picker1.picker reloadAllComponents];
}

-(void)IamSure:(UIButton *)sender{
    [picker1 removeFromSuperview];
    transactionTableView.userInteractionEnabled = YES;
    
    if (self.typeBtn.isSelected) {
        //全部产品
        NSString *title = [typeArray objectAtIndex:[picker1.picker selectedRowInComponent:0]];
        [MSUtil showHudMessage:title hideAfterDelay:1.5 uiview:self.view];
    }else if (self.monthBtn.isSelected){
        //全部月份
        NSString *title = [monthArray objectAtIndex:[picker1.picker selectedRowInComponent:0]];
        [MSUtil showHudMessage:title hideAfterDelay:1.5 uiview:self.view];
    }else if (self.accountBtn.isSelected){
        //全部账户
        NSString *title = [accountArray objectAtIndex:[picker1.picker selectedRowInComponent:0]];
        [MSUtil showHudMessage:title hideAfterDelay:1.5 uiview:self.view];
    }else if (self.transactionBtn.isSelected){
        //全部交易
        NSString *title = [productArry objectAtIndex:[picker1.picker selectedRowInComponent:0]];
        [MSUtil showHudMessage:title hideAfterDelay:1.5 uiview:self.view];
    }
    
}
-(void)BtnAction:(UIButton *)sender{
    if (sender.tag==kLEFTBTN) {
        //picker1左
        if ([picker1.titleLabel.text isEqualToString:@"交易类型"]) {
            
            [picker1.picker reloadAllComponents];
            
        }else if ([picker1.titleLabel.text isEqualToString:@"产品类型"]){
            
            [self  changePicker:self.typeBtn];
            
        }else if ([picker1.titleLabel.text isEqualToString:@"交易时间"]){
            
            [self  changePicker:self.transactionBtn];
            
            
        }else if ([picker1.titleLabel.text isEqualToString:@"交易账户"]){
            
            [self  changePicker:self.monthBtn];
            
        }
        
    }else if (sender.tag==kRIGHTBTN){
        if ([picker1.titleLabel.text isEqualToString:@"交易类型"]) {
            
            [self  changePicker:self.transactionBtn];
            
            
        }else if ([picker1.titleLabel.text isEqualToString:@"产品类型"]){
            
            [self  changePicker:self.monthBtn];
            
            
        }else if ([picker1.titleLabel.text isEqualToString:@"交易时间"]){
            [self  changePicker:self.accountBtn];
            
            
        }else if ([picker1.titleLabel.text isEqualToString:@"交易账户"]){
            [picker1.picker reloadAllComponents];
            
        }
    }
    
}

- (void)initTableView
{
    transactionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 34+10, kScreenWidth, kScreenHeight-34-64-46) style:UITableViewStylePlain];
    transactionTableView.dataSource = self;
    transactionTableView.delegate =self;
    transactionTableView.rowHeight = 130;
    transactionTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [transactionTableView registerNib:[UINib nibWithNibName:@"TransactionCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:transactionTableView];
    
    [self.typeBtn addTarget:self action:@selector(changePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.typeBtn setTitle:@"交易类型" forState:UIControlStateNormal];
    [self.typeBtn setTitle:@"交易类型" forState:UIControlStateSelected];
    self.typeBtn.tag = 1000;
    
    
    
    [self.monthBtn addTarget:self action:@selector(changePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.monthBtn setTitle:@"交易时间" forState:UIControlStateNormal];
    [self.monthBtn setTitle:@"交易时间" forState:UIControlStateSelected];
    self.monthBtn.tag = 1001;
    
    [self.accountBtn addTarget:self action:@selector(changePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.accountBtn setTitle:@"交易账户" forState:UIControlStateNormal];
    [self.accountBtn setTitle:@"交易账户" forState:UIControlStateSelected];
    self.accountBtn.tag = 1002;
    
    [self.transactionBtn addTarget:self action:@selector(changePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.transactionBtn setTitle:@"产品类型" forState:UIControlStateNormal];
    [self.transactionBtn setTitle:@"产品类型" forState:UIControlStateSelected];
    self.transactionBtn.tag = 1003;
    
}


#pragma mark
#pragma mark pickerview delegate

/* return cor of pickerview*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.typeBtn.isSelected) {
        return typeArray.count;
        
    }else if (self.monthBtn.isSelected){
        return monthArray.count;
    }else if (self.accountBtn.isSelected){
        return  accountArray.count;
    }else if (self.transactionBtn.isSelected){
        return productArry.count;
    }
    else{
        return 0;
    }
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.typeBtn.isSelected) {
        return [typeArray objectAtIndex:row];
        
    }else if(self.monthBtn.isSelected){
        return [monthArray objectAtIndex:row];
    }else if (self.accountBtn.isSelected){
        return [accountArray objectAtIndex:row];
    }else if (self.transactionBtn.isSelected){
        return [productArry objectAtIndex:row];
        
    }else{
        return nil;
    }
    
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // NSLog(@"font %@ is selected.",row);
    if (self.typeBtn.isSelected) {
        NSString *name=[typeArray objectAtIndex:row];
        NSLog(@"%@",name);
    }else if(self.monthBtn.isSelected){
        NSString *name=[monthArray objectAtIndex:row];
        NSLog(@"%@",name);
    }
    else if (self.accountBtn.isSelected){
        NSString *name=[accountArray objectAtIndex:row];
        NSLog(@"%@",name);
    }
    else if(self.transactionBtn.isSelected){
        NSString *name=[productArry objectAtIndex:row];
        NSLog(@"%@",name);
    }
    else{
        
    }
    
}

#pragma mark
#pragma mark tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return dataSource.count;
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (cell==nil) {
        cell = [[TransactionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row%2==1) {
        cell.backgroundColor = kViewBackGroudColor;
    }
    else if (indexPath.row%2==0){
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [picker1 removeFromSuperview];
    transactionTableView.userInteractionEnabled = YES;
    TransactionDetailController *detailVC = [[TransactionDetailController alloc]init];

    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
