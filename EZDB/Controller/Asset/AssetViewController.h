//
//  AssetViewController.h
//  EZDB
//
//  Created by wenming.zheng on 14-10-16.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AssetViewController : STViewController<UITableViewDelegate,
                                                UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *assetTableView;

@end
