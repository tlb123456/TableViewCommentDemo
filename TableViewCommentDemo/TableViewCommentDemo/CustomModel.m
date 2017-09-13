//
//  CustomModel.m
//  TableViewCommentDemo
//
//  Created by TaoBoBo on 2017/9/6.
//  Copyright © 2017年 TaoBoBo. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#import "CustomModel.h"

@implementation CustomModel

- (CGFloat)height {
    
    if (_height == 0) {
        
        CGSize size = [self.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil].size;
        
        _height = size.height + 55.f + self.commentHeight;
        
        if (self.commentArray.count > 3) _height += 25;
    }
    return _height;
}

- (CGFloat)commentHeight {
    
    if (_commentHeight == 0) {
        
        CGFloat rowHeight = 0;
        for (int i = 0; i < self.commentArray.count; i ++) {
            
             if (i == 3) break;
            
            CGSize size = [self.commentArray[i] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
            
            rowHeight = rowHeight + size.height + 10.f;
        }
        
        _commentHeight = rowHeight;
    }
    return _commentHeight;
}

@end
