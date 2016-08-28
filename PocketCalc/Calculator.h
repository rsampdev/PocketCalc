//
//  Calculator.h
//  PocketCalc
//
//  Created by Rodney Sampson on 8/25/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

@property (nonatomic) NSInteger * result;
@property (nonatomic) NSInteger firstOperand;
@property (nonatomic) NSInteger secondOperand;
@property (nonatomic) NSString * sign;

- (NSInteger)addThis:(NSInteger)firstNumber plus:(NSInteger)secondNumber;

- (NSInteger)subtractThis:(NSInteger)firstNumber minus:(NSInteger)secondNumber;

- (NSInteger)multiplyThis:(NSInteger)firstNumber times:(NSInteger)secondNumber;

- (NSInteger)divideThis:(NSInteger)firstNumber by:(NSInteger)secondNumber;

- (void)setMathSign:(NSString *)sign;

- (void)allClear;

- (void)clear;

@end
