//
//  MOWTextField.m
//  
//
//  Created by 吴仕海 on 4/5/15.
//
//

#import "MOWTextField.h"

static UIColor *inputAccessoryViewColor;

@interface MOWTextField ()

@property (nonatomic, strong) UIToolbar *inputAccessoryView;
@end

@implementation MOWTextField

@dynamic inputAccessoryView;

+ (void)setupInputAccessoryViewColor:(UIColor *)color{
    color?inputAccessoryViewColor = color:nil;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self setInputAccessoryView:self.inputAccessoryViewInit];
}

- (UIToolbar *)inputAccessoryViewInit{
    
    if (self.inputAccessoryView) {
        return self.inputAccessoryView;
    }
    self.inputAccessoryView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    UIButton *completeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.inputAccessoryView.width - 60, 0, 60, self.inputAccessoryView.height)];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    if (inputAccessoryViewColor) {
        [completeButton setTitleColor:inputAccessoryViewColor forState:UIControlStateNormal];
    } else {
    }
    
    [completeButton addTarget:self action:@selector(closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.inputAccessoryView addSubview:completeButton];
    return self.inputAccessoryView;
}

- (void)closeKeyBoard{
    [self resignFirstResponder];
}
@end
