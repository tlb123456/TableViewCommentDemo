//
//  TextTableViewCell.m
//  TableViewCommentDemo
//
//  Created by TaoBoBo on 2017/9/6.
//  Copyright © 2017年 TaoBoBo. All rights reserved.
//

#import "TextTableViewCell.h"
#import "Masonry.h"
#define RGBA(r, g, b, a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation TextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = RGBA(247, 247, 247, 1);
        [self createViews];
    }
    return self;
}

- (void)createViews {
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(5);
    }];
    
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.textColor = RGBA(91, 91, 91, 1);
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 80;
    }
    return _contentLabel;
}

@end
