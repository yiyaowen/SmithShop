//
//  RenderController.h
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/6.
//

@import MetalKit;

@interface RenderController : NSObject<MTKViewDelegate>

- (nonnull instancetype) initWithMetalKitView: (nonnull MTKView *) mtkView;

@end
