//
//  ResourcesCellView.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/24.
//  Copyright © 2019年 zb. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IPSourcesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResourcesCellView : NSTableCellView

-(void)refreshWithModel:(IPSourcesModel *)model;

@end

NS_ASSUME_NONNULL_END
