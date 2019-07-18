//
//  WeblistSourcesViewCell.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/7/18.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WebSourcesModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface WeblistSourcesViewCell : NSTableCellView

//刷新Web资源
-(void)refreshWithWebModel:(WebSourcesModel *)model;

@end

NS_ASSUME_NONNULL_END
