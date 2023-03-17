//
//  ViewController.m
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import "ViewController.h"
#import "Tasks.h"
#import "AddViewController.h"
#import "EditViewController.h"
#import "ProgressViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
      Tasks *task;
    NSData * data2;
}
static NSUserDefaults *defaults;
static NSMutableArray *taskTodoArr ;

+ (void)initialize{
    
    taskTodoArr = [NSMutableArray new];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:taskTodoArr];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"task"];
 
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    data2 =[NSDate new];
    data2 = [defaults objectForKey:@"task"];
    taskTodoArr = [[NSKeyedUnarchiver unarchiveObjectWithData:data2] mutableCopy];
    [self.todoTableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated{
	    
    [self.todoTableView reloadData];
    NSData  *data3 = [defaults objectForKey:@"task"];
    taskTodoArr = [[NSKeyedUnarchiver unarchiveObjectWithData:data3] mutableCopy];
    [self.todoTableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [taskTodoArr count];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[taskTodoArr objectAtIndex:indexPath.row] taskName];
    cell.detailTextLabel.text = [[taskTodoArr objectAtIndex:indexPath.row] taskDes];
    
    if([[[taskTodoArr objectAtIndex:indexPath.row] taskPriority] isEqual: @0 ]){
        cell.imageView.image = [UIImage imageNamed:@"low"];
    }else if ([[[taskTodoArr objectAtIndex:indexPath.row] taskPriority] isEqual: @1 ]){
        cell.imageView.image = [UIImage imageNamed:@"medium"];
    }else if ([[[taskTodoArr objectAtIndex:indexPath.row] taskPriority] isEqual: @2 ]){
        cell.imageView.image = [UIImage imageNamed:@"high"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    edit.indexNum = indexPath.row ;
    edit.expectedVC = 0;
    //edit.editTaskName.text = [[taskTodoArr objectAtIndex:indexPath.row] taskName];
    [self.navigationController pushViewController:edit animated:YES];
        
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [taskTodoArr removeObjectAtIndex:indexPath.row];
            
            [defaults objectForKey:@"task"];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
}


- (IBAction)addNewTaskBtn:(id)sender {
    
    AddViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
   
    [self.navigationController pushViewController:add animated:YES];
   
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        data2 = [defaults objectForKey:@"task"];
        taskTodoArr = [[NSKeyedUnarchiver unarchiveObjectWithData:data2] mutableCopy];
        
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
        data2 = [defaults objectForKey:@"task"];
        taskTodoArr = [[NSKeyedUnarchiver unarchiveObjectWithData:data2] mutableCopy];
        taskTodoArr = [taskTodoArr filteredArrayUsingPredicate:predicate];
    }
    [_todoTableView reloadData];
}
@end
