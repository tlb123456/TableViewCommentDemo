//
//  BaseTableViewCell.m
//  TableViewCommentDemo
//
//  Created by TaoBoBo on 2017/9/6.
//  Copyright © 2017年 TaoBoBo. All rights reserved.
//
#import "Masonry.h"
#import "BaseTableViewCell.h"
#import "TextTableViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RGBA(r, g, b, a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface BaseTableViewCell ()<UITableViewDelegate,UITableViewDataSource>

/** 查看更多 */
@property (nonatomic, strong) UIButton *moreButton;

@end

static NSString *identifer = @"BaseTableViewCellTableViewCell";

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.tableView];
        [self.contentView addSubview:self.moreButton];
        
        [self createViews];
    }
    return self;
}

- (void)createViews {
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.iconImgView.mas_right).mas_offset(10);
        make.top.mas_equalTo(17);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(5);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.contentLabel.mas_left);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(10);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-5);
    }];
}

#pragma mark -TableView Delegate DataSoucre
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.model.commentArray.count > 3) {
        
        return 3;
    }
    
    return self.model.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sizeSting = self.model.commentArray[indexPath.row];
    CGSize size = [sizeSting boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    return size.height + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.contentLabel.attributedText = [self attributeStringWithString:self.model.commentArray[indexPath.row]];
    return cell;
}

- (NSAttributedString *)attributeStringWithString:(NSString *)content {
    
    NSMutableAttributedString *attrubuteString = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],NSForegroundColorAttributeName:RGBA(91, 91, 91, 1)}];
    
    NSString *firstString = [content componentsSeparatedByString:@"："].firstObject;
    [attrubuteString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:NSMakeRange(0, firstString.length + 1)];
    return attrubuteString;
}

- (void)moreButtonAction:(UIButton *)sender {
    
    NSLog(@"查看更多");
}

- (void)setModel:(CustomModel *)model {
    
    _model = model;
    if (model) {
        
        self.nameLabel.text = model.name;
        self.contentLabel.text = model.content;
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(model.commentHeight);
        }];
        
        if (model.commentArray.count > 3) self.moreButton.hidden = NO;
        else self.moreButton.hidden = YES;
        
        [self.tableView reloadData];
    }
}


#pragma mark -Lazy Load
- (UIImageView *)iconImgView {
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = [UIColor grayColor];
        _iconImgView.layer.cornerRadius = 20.f;
        _iconImgView.clipsToBounds = YES;
    }
    return _iconImgView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
        _nameLabel.textColor = [UIColor blueColor];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = RGBA(70, 70, 70, 1);
        _contentLabel.font = [UIFont systemFontOfSize:15.f];
        _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 75;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:identifer];
        
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (UIButton *)moreButton {
    
    if (!_moreButton) {
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_moreButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_moreButton setContentEdgeInsets:UIEdgeInsetsMake(2, 5, 2, 5)];
        [_moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _moreButton;
}

@end
