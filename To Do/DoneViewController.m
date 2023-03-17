//
//  DoneViewController.m
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import "DoneViewController.h"
#import "Tasks.h"
#import "EditViewController.h"

@interface DoneViewController ()

@end

@implementation DoneViewController{
        
NSUserDefaults *defaults;
Tasks *task;
NSData *data;
NSData * data2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_doneTable reloadData];
    defaults = [NSUserDefaults standardUserDefaults];
    NSData *d =  [defaults objectForKey:@"Donetask"];
    _doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
}

- (void)viewWillAppear:(BOOL)animated{
    defaults = [NSUserDefaults standardUserDefaults];
    NSData *d =  [defaults objectForKey:@"Donetask"];
    _doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    [_doneTable reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_doneArr count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = [[_doneArr objectAtIndex:indexPath.row] taskName];
    cell.detailTextLabel.text = [[_doneArr objectAtIndex:indexPath.row] taskDes];
    
    if([[[_doneArr objectAtIndex:indexPath.row] taskPriority] isEqual: @0 ]){
        cell.imageView.image = [UIImage imageNamed:@"low"];
    }else if ([[[_doneArr objectAtIndex:indexPath.row] taskPriority] isEqual: @1 ]){
        cell.imageView.image = [UIImage imageNamed:@"medium"];
    }else if ([[[_doneArr objectAtIndex:indexPath.row] taskPriority] isEqual: @2 ]){
        cell.imageView.image = [UIImage imageNamed:@"high"];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    edit.indexNum = indexPath.row ;
    edit.expectedVC = 2;
    [self.navigationController pushViewController:edit animated:YES];
        
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [_doneArr removeObjectAtIndex:indexPath.row];
            
            [defaults objectForKey:@"Donetask"];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30.5;
}

@end
