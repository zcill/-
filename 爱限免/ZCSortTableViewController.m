//
//  ZCSortTableViewController.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/13.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCSortTableViewController.h"
#import "ZCSortCell.h"
#import "ZCSortModel.h"

@interface ZCSortTableViewController ()
{
    NSMutableArray *_dataSource;
}

@end

@implementation ZCSortTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] init];
    
    [self downloadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZCSortCell" bundle:nil] forCellReuseIdentifier:@"ZCSortCell"];
    
}

- (void)downloadData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:CATE_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *cateDict in array) {
            
//            [ZJModelTool createModelWithDictionary:cateDict modelName:@"ZCSortModel"];
            
            ZCSortModel *model = [[ZCSortModel alloc] init];
            [model setValuesForKeysWithDictionary:cateDict];
            [_dataSource addObject:model];
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"ZCSortCell";
    ZCSortCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    ZCSortModel *model = _dataSource[indexPath.row];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.picUrl]];
    // 把icon切成圆角
    cell.iconImageView.clipsToBounds = YES;
    cell.iconImageView.layer.cornerRadius = 10;
    
    cell.titleLabel.text = model.categoryCname;
    cell.detailLabel.text = [NSString stringWithFormat:@"共有%@款应用，其中限免%@款", model.categoryCount, model.limited];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ZCSortModel *model = _dataSource[indexPath.row];
    if (self.changeSortBlock) {
        self.changeSortBlock(model.categoryId);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
