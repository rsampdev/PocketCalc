//
//  Calculator.m
//  PocketCalc
//
//  Created by Rodney Sampson on 8/25/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (instancetype)init {
    self = [super init];
    if (self) {
        _firstOperand = 0;
        _secondOperand = 0;
        _sign = @"";
    }
    return self;
}

- (NSInteger)addThis:(NSInteger)firstNumber plus:(NSInteger)secondNumber {
    return firstNumber + secondNumber;
}

- (NSInteger)subtractThis:(NSInteger)firstNumber minus:(NSInteger)secondNumber {
    return firstNumber - secondNumber;
}

- (NSInteger)multiplyThis:(NSInteger)firstNumber times:(NSInteger)secondNumber {
    return firstNumber * secondNumber;
}

- (NSInteger)divideThis:(NSInteger)firstNumber by:(NSInteger)secondNumber {
    return firstNumber / secondNumber;
}

- (void)setMathSign:(NSString *)sign {
    if ([sign isEqual:@"+"] || [sign isEqual:@"-"] || [sign isEqual:@"*"] || [sign isEqual:@"/"]) {
        self.sign = sign;
    }
}

- (void)allClear {
    self.firstOperand = 0;
    self.secondOperand = 0;
    self.sign = @"";
}

- (void)clear {
    if (self.firstOperand != 0 && self.secondOperand == 0) {
        self.firstOperand = 0;
    } else {
        self.secondOperand = 0;
    }
}

@end
