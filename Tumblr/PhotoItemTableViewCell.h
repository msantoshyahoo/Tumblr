//
//  PhotoItemTableViewCell.h
//  Tumblr
//
//  Created by  Santosh Sharanappa Mandi on 1/25/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *postid;

@end
