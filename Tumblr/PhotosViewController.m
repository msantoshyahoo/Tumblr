//
//  ViewController.m
//  Tumblr
//
//  Created by  Santosh Sharanappa Mandi on 1/25/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoItemTableViewCell.h"
#import "PhotoItem.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PhotosViewController () <UITableViewDataSource>
@property (nonatomic,strong) NSArray<PhotoItem *> *photoItems;
@property (weak, nonatomic) IBOutlet UITableView *photosTableView;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosTableView.dataSource = self;
    [self fetchPhotos];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPhotos {
    NSString *apiKey = @"Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV";
    NSString *urlString =
    [@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=" stringByAppendingString:apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSDictionary *responses = responseDictionary[@"response"];
                                                    NSArray *responsePosts = responses[@"posts"];
                                                    //NSLog(@"Response: %@", responsePosts);

                                                    NSMutableArray *posts = [NSMutableArray array];
                                                    for (NSDictionary *post in responsePosts) {
                                                        PhotoItem *photoItem = [[PhotoItem alloc] initWithDictionary:post];
                                                        [posts addObject: photoItem];
                                                        //NSLog(@"photo id = %@ %@", photoItem.postid, photoItem.url);
                                                    }
                                                    self.photoItems = posts;
                                                    [self.photosTableView reloadData];
                                                    
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    PhotoItem *photoItem = [self.photoItems objectAtIndex:indexPath.row];
    //NSLog(@"photoItem = %@ %ld", photoItem, indexPath.row);
    PhotoItemTableViewCell *photoItemTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"photoItemTableViewCell" forIndexPath:indexPath];
    NSLog(@"row number:@%ld %@", indexPath.row, photoItemTableViewCell);
    photoItemTableViewCell.postid.text = @"test";
    [photoItemTableViewCell.photo setImageWithURL: photoItem.url];
    return photoItemTableViewCell;
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return self.photoItems.count;
}



@end
