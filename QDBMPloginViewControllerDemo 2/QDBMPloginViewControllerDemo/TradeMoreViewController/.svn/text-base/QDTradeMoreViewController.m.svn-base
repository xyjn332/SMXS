//
//  QDTradeMoreViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/15.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeMoreViewController.h"
#import "QDTradeMoreCollectionViewCell.h"

@interface QDTradeMoreViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *colletionView;

@end

@implementation QDTradeMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [QDTool adjustIOS7NavigationController:self];
    
    [self initializeData];
    
    [self createUI];
    
}


#pragma mark - initializeData

- (void)initializeData{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:8];
    
    [_dataSource addObjectsFromArray:@[
                                      @{@"IMG":@"more_icon_fund", @"TITLE":@"基金"},
                                      @{@"IMG":@"more_icom_multi account", @"TITLE":@"多账户"},
                                      @{@"IMG":@"more_icon_multi bank", @"TITLE":@"多银行"},
                                      @{@"IMG":@"more_icon_passwd", @"TITLE":@"密码"},
                                      @{@"IMG":@"more_cash management", @"TITLE":@"理财金融"},
                                      @{@"IMG":@"more_purchase of new shares", @"TITLE":@"新股认购"}
                                      ]];
}

#pragma mark - createUI
- (void)createUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = AdjustHeight(26);
    flowLayout.minimumInteritemSpacing =AdjustWidth(30);
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _colletionView.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0f);
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    [_colletionView registerClass:[QDTradeMoreCollectionViewCell class] forCellWithReuseIdentifier:@"cellIddentifier"];
//    [_colletionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ResuableView"];

    [self.view addSubview:_colletionView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.colletionView.frame = self.view.bounds;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - UIColletionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIddentifier";
    QDTradeMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.logoImgButton.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"IMG"]];
    cell.titleLabel.text = self.dataSource[indexPath.row][@"TITLE"];
    
    UIView *selectView = [[UIView alloc] initWithFrame:cell.bounds];
    selectView.backgroundColor = UIColorFromRGBA(0x909090, 0.9f);
    cell.selectedBackgroundView = selectView;
    
    
    return cell;
}

//- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ResuableView" forIndexPath:indexPath];
//    headView.backgroundColor = [UIColor redColor];
//    return headView;
//}
#pragma mark - UIColletionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"you choose %@", self.dataSource[indexPath.row][@"TITLE"]);
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}




#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(AdjustWidth(63), AdjustHeight(71));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdjustHeight(26), AdjustWidth(25), AdjustHeight(5), AdjustWidth(25));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
