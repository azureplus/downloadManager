//
//  ViewController.m
//  DownloadManager
//
//  Created by 刘殿阁 on 2017/11/17.
//  Copyright © 2017年 刘殿阁. All rights reserved.
//

#import "ViewController.h"
#import "MiguDowmloadBaseManager.h"
#import "downloadCell.h"

// 这个链接是第三首歌曲的链接
#define  TEST_URL @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=6005970S6G0&ua=Mac_sst&version=1.0"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

static NSString * const CELL_ID = @"cell_id";
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建tableview
    [self setUpTableView];
    // 创建观察者
    [self addObseerverAction];
}
#pragma mark - 方法的响应

/**
 *
 *  创建tabkeivew
 */
- (void)setUpTableView {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"downloadCell" bundle:nil] forCellReuseIdentifier:CELL_ID];
    
}
/**
 *
 *  全部下载
 */
- (IBAction)downloadAllAction:(id)sender {
    NSArray *customCacheName = @[@"上海滩.mp3",@"大长今.mp3",@"日子.mp3",@"想一想.mp3",@"哈哈.mp3"];
    [self.dataArray removeAllObjects];
    NSArray *list = @[
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=6990539Z0K8&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=63880300430&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=6005970S6G0&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=63273401896&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=69906300114&ua=Mac_sst&version=1.0"
                      ];
    // 指定最大任务数量
    [MiguDowmloadBaseManager shareManager].maxTaskCount = 2;
    
//    for (NSString *downloadUrl in list) {
//        [[MiguDowmloadBaseManager shareManager] downloadWithUrl:downloadUrl withCustomCacheName:nil];
//    }
    for (NSInteger index = 0; index < list.count; index ++) {
        [[MiguDowmloadBaseManager shareManager] downloadWithUrl:list[index] withCustomCacheName:customCacheName[index]];
    }
    
    [self.dataArray addObjectsFromArray:[MiguDowmloadBaseManager shareManager].downloadArray];
    [self.tableView reloadData];
    
    if ([MiguDowmloadBaseManager shareManager].downloadArray.count == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"歌曲已经都下载完了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
/**
 *
 *   单曲下载
 */
- (IBAction)singleAction:(id)sender {
    [self.dataArray removeAllObjects];
    
    // 指定最大任务数量 需要在下载歌曲前指定否则不起作用
    [MiguDowmloadBaseManager shareManager].maxTaskCount = 2;
    
    //  第一首歌曲
    [[MiguDowmloadBaseManager shareManager] downloadWithUrl:TEST_URL withCustomCacheName:@"小不点.mp3"];
    [self.dataArray addObjectsFromArray:[MiguDowmloadBaseManager shareManager].downloadArray];
    [self.tableView reloadData];
    
    if ([MiguDowmloadBaseManager shareManager].downloadArray.count == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"歌曲已经都下载完了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
/**
 *
 *  添加通知观察者
 */
- (void)addObseerverAction {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAction:) name:DownloadFinish object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAction:) name:CancelAllSong object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAction:) name:CancelOneSong object:nil];
}
/**
 *
 *  更新ui
 */
- (void)changeAction:(NSNotification *)info {
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[MiguDowmloadBaseManager shareManager].downloadArray];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
/**
 *
 *  取消全部
 */
- (IBAction)cancleAllAction:(UIButton *)sender {
    [[MiguDowmloadBaseManager shareManager] cancelAllRequest];
    
}
/**
 *
 *  取消某一首歌曲
 */
- (IBAction)cancleOneAction:(UIButton *)sender {
    [[MiguDowmloadBaseManager shareManager] cancelWithUrl:TEST_URL];
}
/**
 *
 *   暂停全部
 */

- (IBAction)suspendAllAction:(id)sender {
    
    [[MiguDowmloadBaseManager shareManager] suspendAllRequest];
}
/**
 *
 *   暂停某一首歌曲
 */
- (IBAction)suspendOneAction:(id)sender {
    [[MiguDowmloadBaseManager shareManager] suspendWithUrl:TEST_URL];
}
/**
 *
 *  恢复全部
 */
- (IBAction)resumeAllAction:(id)sender {
    [[MiguDowmloadBaseManager shareManager] resumeAllRequest];
}
/**
 *
 *  恢复某一首歌曲
 */
- (IBAction)resumeOneAction:(id)sender {
    
    [[MiguDowmloadBaseManager shareManager] resumeWithUrl:TEST_URL];
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MiguDownloadItem *item = self.dataArray[indexPath.row];
    downloadCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    cell.item = item;
    return cell;
}



@end
