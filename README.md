# downloadManager
![image](https://github.com/liudiange/downloadManager/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%206s%20-%202017-12-01%20at%2010.03.44.png)

下载管理器，只要传递下载的url来进行下载，支持ios 和macos      （Download Manager, as long as the URL passed to download download, support ios and macos）
 
## 下载管理器实现的功能：(Download Manager to achieve the function:)
- 支持断点续传  （Support HTTP）
- 支持最大的下载任务个数 （Support the largest number of download tasks）
- 传递url进行下载  （Pass url to download）
- 可以暂停全部  （You can pause all）
- 可以暂停某一链接  （You can pause a link）
- 可以取消全部  （You can cancel all）
- 可以取消某一链接 （You can cancel a link）
- 可以恢复下载一链接 （You can resume downloading a link）
- 可以恢复全部下载 （You can resume all downloads）

## 安装 （install）
- 需要将 DownloadManager拖入工程中  （You need to drag DownloadManager into the project）
- cocoapod pod 'DownloadManager' ~>'0.0.2'
- 注意macos 暂时不支持cocoapod  （Note that macos does not currently support cocoapod）
## 使用 （use）
````objc
1.开始下载(单一) （Start downloading (single))
[[MiguDowmloadBaseManager shareManager] downloadWithUrl:@"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=6990539Z0K8&ua=Mac_sst&version=1.0"];
2.批量下载 (Batch download)
NSArray *list = @[
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=6990539Z0K8&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=63880300430&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=6005970S6G0&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=63273401896&ua=Mac_sst&version=1.0",
                      @"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=69906300114&ua=Mac_sst&version=1.0"
                      ];
    for (NSString *downloadUrl in list) {
        [[MiguDowmloadBaseManager shareManager] downloadWithUrl:downloadUrl];
    }
3.暂停全部 (Pause all)
 [[MiguDowmloadBaseManager shareManager] suspendAllRequest];
4.暂停某一链接 (Pause a link)
[[MiguDowmloadBaseManager shareManager] suspendWithUrl:@"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=69906300114&ua=Mac_sst&version=1.0"];
5.取消全部 (Cancel all)
 [[MiguDowmloadBaseManager shareManager] cancelAllRequest];
6.取消某一链接 (Cancel a link)
 [[MiguDowmloadBaseManager shareManager] downloadWithUrl:@"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=69906300114&ua=Mac_sst&version=1.0"];
7.恢复所有 (Restore all)
 [[MiguDowmloadBaseManager shareManager] resumeAllRequest];
8.恢复一首链接 (Restore a link)
 [[MiguDowmloadBaseManager shareManager] resumeWithSong:@"http://218.200.160.29/rdp2/test/mac/listen.do?contentid=69906300114&ua=Mac_sst&version=1.0"];
9.修改最大的下载的任务数量 (Modify the maximum number of downloaded tasks)
 全局搜索 MAXTASK_COUNT 修改其值  默认最大任务数量是 3   (Global search MAXTASK_COUNT modify the value of the default maximum number of tasks is 3)
````
## 期待
- 有什么bug或者我不满足的需求，欢迎 Issues我
- 请大神给我指正和建议，我将不盛荣幸。

 






