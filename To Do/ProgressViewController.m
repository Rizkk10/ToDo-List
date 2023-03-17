//
//  ProgressViewController.m
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import "ProgressViewController.h"
#import "Tasks.h"
#import "EditViewController.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController{
    
    NSUserDefaults *defaults;
    Tasks *task;
    NSData *data;
    NSData * data2;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [_progTable reloadData];
    defaults = [NSUserDefaults standardUserDefaults];
    NSData *d =  [defaults objectForKey:@"Protask"];
    _proArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];

    
    
}
- (void)viewWillAppear:(BOOL)animated{
    defaults = [NSUserDefaults standardUserDefaults];
    NSData *d =  [defaults objectForKey:@"Protask"];
    _proArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    [_progTable reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_proArr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"prograssCell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = [[_proArr objectAtIndex:indexPath.row] taskName];
    cell.detailTextLabel.text = [[_proArr objectAtIndex:indexPath.row] taskDes];
    
    if([[[_proArr objectAtIndex:indexPath.row] taskPriority] isEqual: @0 ]){
        cell.imageView.image = [UIImage imageNamed:@"low"];
    }else if ([[[_proArr objectAtIndex:indexPath.row] taskPriority] isEqual: @1 ]){
        cell.imageView.image = [UIImage imageNamed:@"medium"];
    }else if ([[[_proArr objectAtIndex:indexPath.row] taskPriority] isEqual: @2 ]){
        cell.imageView.image = [UIImage imageNamed:@"high"];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    edit.indexNum = indexPath.row;
    edit.expectedVC = 1;
    [self.navigationController pushViewController:edit animated:YES];
        
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [_proArr removeObjectAtIndex:indexPath.row];
            
            [defaults objectForKey:@"Protask"];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
}


@end
