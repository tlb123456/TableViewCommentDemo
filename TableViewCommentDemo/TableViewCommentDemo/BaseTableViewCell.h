//
//  BaseTableViewCell.h
//  TableViewCommentDemo
//
//  Created by TaoBoBo on 2017/9/6.
//  Copyright © 2017年 TaoBoBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImgView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CustomModel *model;

@property (nonatomic, assign) CGFloat tableHeight;

@end
