//
//  ViewController.m
//  TableViewCommentDemo
//
//  Created by TaoBoBo on 2017/9/6.
//  Copyright © 2017年 TaoBoBo. All rights reserved.
//

#import "ViewController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "CustomModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RGBA(r, g, b, a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *identifer = @"ViewControllerTableViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"话题";
    [self createViews];
}

- (void)createViews {
    
    NSArray *nameArray = @[@"ㄗs 绝恋 oО",@"Xxづ蒾夨ㄋ",@"墙角、ˉ落泪",@"殇づ如此_惟美",@"惟美°づ",@"﹎ゞ很√想迩",@"緈幅丶谁能给",@"ˇ、遥不可及",@"泪、很累"];
    NSArray *contentArray = @[@"我曾经得过精神分裂症，但现在我们已经康复了",@"一留学生在美国考驾照，前方路标提示左转，他不是很确定，问考官：“turn left?”答：“right”于是……挂了.. ",@"有一天绿豆自杀从5楼跳下来，流了很多血，变成了红豆；一直流脓，又变成了黄豆；伤口结了疤，最后成了黑豆。",@"小明理了头发，第二天来到学校，同学们看到他的新发型，笑道：小明，你的头型好像个风筝哦！小明觉得很委屈，就跑到外面哭。哭着哭着～他就飞起来了………… ",@"小企鹅有一天问他奶奶，“奶奶奶奶，我是不是一只企鹅啊？”“是啊，你当然是企鹅。”小企鹅又问爸爸，“爸爸爸爸，我是不是一只企鹅啊？”“是啊，你是企鹅啊，怎么了?”“可是，可是我怎么觉得那么冷呢？” ",@"有一对玉米相爱了…于是它们决定结婚…结婚那天…一个玉米找不到另一个玉米了…这个玉米就问身旁的爆米花：你看到我们家玉米了吗?爆米花：亲爱的，人家穿婚纱了嘛……. ",@"一个鸡蛋去茶馆喝茶，结果它变成了茶叶蛋；一个鸡蛋跑去松花江游泳，结果它变成了松花蛋；一有个鸡蛋跑到了山东，结果变成了鲁（卤）蛋；一个鸡蛋无家可归，结果它变成了野鸡蛋；一个鸡蛋在路上不小心摔了一跤，倒在地上，结果变成了导弹；一个鸡蛋跑到人家院子里去了，结果变成了原子弹；一个鸡蛋跑到青藏高原，结果变成了氢弹；一个鸡蛋生病了，结果变成了坏蛋；一个鸡蛋嫁人了，结果变成了混蛋；一个鸡蛋跑到河里游泳，结果变成了核弹；一个鸡蛋跑到花丛中去了，结果变成了花旦；一个鸡蛋骑着一匹马，拿着一把刀，原来他是刀马旦；一个鸡蛋是母的，长的很丑，结果就变成了恐龙蛋；一个鸡蛋是公的，他老婆在外面和别的鸡蛋通奸，结果他变成了王八蛋；一个鸡蛋…… ",@"主持人问：猫是否会爬树？老鹰抢答：会！主持人：举例说明！老鹰含泪：那年，我睡熟了，猫爬上了树…后来就有了猫头鹰… ",@"从前有一个棉花糖去打了球打了很长时间.他说:好累啊,我觉得我整个人都软下来了………. "];
    
    NSArray *commentArray = @[@[@"陶波波：不要难过了，你看这世界还有很多美好的东西！”“你知道我最难过的是什么？就是这些美好的东西跟我没关系",@"小慧：维持我们节俭的，可能是我们的贫穷。"],@[@"亮亮：过去我们通过电话线上网；现在我们通过网络打电话。过去我们需要猫来上网；现在我们需要网来看猫。"],@[@"蛋蛋：激发我们看淡一切的，可能是我们的一无所有。",@"摸摸哒：我们心无旁骛，可能只是因为我们没有能力去从容。",@"哈哈：一位老人骑三轮车把一辆奔驰车刮掉了一块漆，奔驰车主下来看看后沉默了会，咬着牙说，你就赔39块钱得了。老人也沉默了会说道，小伙子，我30块钱能买一桶油漆了，都够喷你一个车的了，你可不能讹人啊！",@"小明：关键是广告商也傻，看广告的依然是买不起产品的屌丝，而买得起产品的高富帅会员从来不看广告。。。",@"鸡汤：不要难过了，你看这世界还有很多美好的东西！"],@[@"女票：女朋友对我真好，我生日给我买了一块3万的名表，就等我掏钱了。",@"男票：今天和男友吵架，当我提起他前女友，他马上说：不能首先使用核武器。",@"哈哈：女孩手里揣着显示两条红线的验孕棒，内心无比激动：“怀上了！怀上了！我得去弄死那个说我不孕的医生！害得我现在连孩子他爸是谁都不知道！”"],@[],@[],@[@"大大：十几分钟回来后发现门被锁上了。。。"],@[],@[@"小肥：亲爱的，你的意思是我如水一般，清爽单纯，温柔和顺，缠绵柔韧？",@"蘑菇：哼，你竟然忘记了！好，这下我又有理由生气了！"]];
    
    for (int i = 0; i < nameArray.count; i ++) {
        
        CustomModel *model = [[CustomModel alloc] init];
        model.name = nameArray[i];
        model.content = contentArray[i];
        NSArray *array = commentArray[i];
        model.commentArray = array;
        [self.dataArray addObject:model];
    }
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark -TableView Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomModel *model = self.dataArray[indexPath.row];
    
    return model.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -Lazy Load
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView setAllowsSelection:YES];
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:identifer];
        
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"在各种艺术形式中，恐怕在没有比笑话更短小精悍的了。笑话的短小形式和它的艺术功能密不可分。作为一种艺术，笑话当然也要写人--表现人的思想感情、塑造人的艺术形象。但它不同于小说、鼓词等一般记叙体文学。笑话展示的往往是一种性格类型，如愚昧、虚伪、贪婪等等，多半是人所共有极其普通的性格缺陷。笑话给它以集中强调，目的是为了使人们看清它丑陋的面貌。这样做就可以舍去与作者宗旨无关的人物身份和历史背景的交代。而情节上也只采取“插曲式“的事件，勿需谈事件的始末原委，仅取足以表现其性格的主要部分。笑话善于揭露矛盾，但不是把矛盾熔铸为曲折的情节，在情节的起伏波澜和人物的种种纠葛里“显现“性格。";
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = RGBA(70, 70, 70, 1);
        titleLabel.font = [UIFont systemFontOfSize:15.f];
        
        titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
        
        [_headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_headerView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        CGSize size = [titleLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil].size;
        
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, size.height + 30);
    }
    return _headerView;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
