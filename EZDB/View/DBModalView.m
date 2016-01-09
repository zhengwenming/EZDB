//
//  DBModalView.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "DBModalView.h"

@implementation DBModalView

+ (instancetype)shareModal
{
    static DBModalView *modal = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modal = [[DBModalView alloc]init];
    });
    return modal;
}

- (void)showModalInView:(UIView *)superView title:(NSString *)title shouldHideBlackView:(BOOL)hided
{
    if (superView) {
        if (!_actView) {
            _actView = [[UIActivityIndicatorView alloc]init];
        }
        if (!hided) {
            [_actView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        }
        else {
            _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        }
        
        if (IS_IPHONE5) {
            
            _actView.frame = CGRectMake(50, 55, 30, 30);
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, 120, 40)];
            _titleLabel.text = title;
            if (kDeviceVersion>=7.0) {
                _mView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-300)/2, (kScreenHeight-148)/2, 300, 148)];

            }else{
                _mView = [[UIView alloc]initWithFrame:CGRectMake(10, 190, kScreenWidth-10*2, kScreenHeight-150*2)];
            }

        }else if(IS_IPHONE4){
            _actView.frame = CGRectMake(50, 45, 30, 30);
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 40, 120, 40)];
            _titleLabel.text = title;
            if (kDeviceVersion>=7.0) {
                
                _mView = [[UIView alloc]initWithFrame:CGRectMake(10, 210, 300, 120)];
            }else{
                _mView = [[UIView alloc]initWithFrame:CGRectMake(10, 190, 300, 120)];
            }
        }
        _mView.backgroundColor = [UIColor whiteColor];
        _mView.layer.cornerRadius = 5.0;
        _mView.alpha = 1;
        _mView.hidden = hided;
        
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_backView setBackgroundColor:[UIColor darkGrayColor] ];
        [_backView setAlpha:0.8];

        [superView addSubview:_backView];
        [superView addSubview:_mView];
        
        [_mView addSubview:_titleLabel];
        [_mView addSubview:_actView];
        [_actView startAnimating];
    }
}

- (void)collapseModalView
{

    [_actView stopAnimating];
    [_actView removeFromSuperview];
    [_backView removeFromSuperview];
    [_mView removeFromSuperview];
}


@end
