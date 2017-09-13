//
//  CustomModel.h
//  TableViewCommentDemo
//
//  Created by TaoBoBo on 2017/9/6.
//  Copyright © 2017年 TaoBoBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CustomModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *commentArray;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat commentHeight;

@end
