//
//  ViewController.m
//  PocketCalc
//
//  Created by Rodney Sampson on 8/25/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import <math.h>
#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()

@property (nonatomic, strong) Calculator * calc;

@property (nonatomic, strong) IBOutlet UILabel * display;

@property (nonatomic, strong) IBOutlet UILabel * signDisplay;

@property (nonatomic, strong) IBOutlet UIButton * clearAndAllClearButton;

- (void)updateDisplay:(NSString *)value;

- (IBAction)numberButtonPressed:(UIButton *)sender;

- (IBAction)setSign:(UIButton *)sender;

- (IBAction)convertToPositiveOrNegative:(UIButton *)sender;

- (IBAction)clearAndAllClear:(UIButton *)sender;

- (IBAction)calculateResult:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calc = [[Calculator alloc] init];
    self.display.adjustsFontSizeToFitWidth = true;
    //[self.clearAndAllClearButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)updateDisplay:(NSString *)newValue {
    if ([newValue isEqualToString: @"NAN"] == NO && [newValue isEqualToString: @"CLEAR"] == NO) {
        if ([newValue isEqualToString: @"⁺∕₋"] == YES) {
            if ([self.signDisplay.text isEqualToString: @""] == YES) {
                self.calc.firstOperand = self.calc.firstOperand * -1;
                self.display.text = [NSString stringWithFormat:@"%@", @(self.calc.firstOperand)];
            } else {
                self.calc.secondOperand = self.calc.secondOperand * -1;
                self.display.text = [NSString stringWithFormat:@"%@", @(self.calc.secondOperand)];
            }
        } else if ([self.signDisplay.text isEqualToString: @""] == YES) {
            self.display.text = [NSString stringWithFormat:@"%@%@", self.display.text, newValue];
            self.calc.firstOperand = [NSString stringWithFormat:@"%@%@", @(self.calc.firstOperand), newValue].integerValue;
        } else {
            self.display.text = [NSString stringWithFormat:@"%@%@", self.display.text, newValue];
            self.calc.secondOperand = [NSString stringWithFormat:@"%@%@", @(self.calc.secondOperand), newValue].integerValue;
        }
    } else if([newValue isEqualToString: @"NAN"] == YES) {
        self.display.text = @"Error";
    } else if([newValue isEqualToString: @"CLEAR"] == YES) {
        self.display.text = @"";
    }
}

- (IBAction)numberButtonPressed:(UIButton *)sender {
    if ([self.clearAndAllClearButton.currentTitle isEqualToString:@"C"] == NO) {
        [self.clearAndAllClearButton setTitle:@"C" forState:UIControlStateNormal];
    }
    
    [self updateDisplay: [NSString stringWithFormat:@"%@", @(sender.titleLabel.text.integerValue)]];
}

- (IBAction)setSign:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString: @"+"]) {
        [self.calc setMathSign:@"+"];
    } else if ([sender.currentTitle isEqualToString: @"-"]) {
        [self.calc setMathSign:@"-"];
    } else if ([sender.currentTitle isEqualToString: @"×"]) {
        [self.calc setMathSign:@"*"];
    } else if ([sender.currentTitle isEqualToString: @"÷"]) {
        [self.calc setMathSign:@"/"];
    }
    
    self.calc.secondOperand = 0;
    [self.display setText:@""];
    [self.signDisplay setText: [NSString stringWithFormat: @"%@", sender.currentTitle]];
}

- (IBAction)convertToPositiveOrNegative:(UIButton *)sender {
    
    BOOL isNegative = [self.display.text containsString:@"-"];
    
    if (isNegative == NO) {
        self.display.text = [NSString stringWithFormat:@"%@%@", @"-", self.display.text];
    } else if (isNegative == YES) {
        self.display.text = [self.display.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }

    [self updateDisplay:@"⁺∕₋"];
}

- (IBAction)clearAndAllClear:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString: @"AC"] == YES) {
        [self.calc allClear];
        self.signDisplay.text = @"";
    } else if([sender.currentTitle isEqualToString: @"C"] == YES) {
        [self.calc clear];
        [self.clearAndAllClearButton setTitle:@"AC" forState:UIControlStateNormal];
    }
    
    [self updateDisplay:@"CLEAR"];
}

- (IBAction)calculateResult:(UIButton *)sender {
    NSInteger calculationResult = 0;
    NSInteger firstNumber = self.calc.firstOperand;
    NSInteger secondNumber = self.calc.secondOperand;
    NSString * sign = self.calc.sign;
    
    if ([sign isEqualToString: @""] == NO) {
        if ([sign isEqual:@"+"]) {
            calculationResult = [self.calc addThis:firstNumber plus:secondNumber];
        } else if ([sign isEqual:@"-"]) {
            calculationResult = [self.calc subtractThis:firstNumber minus:secondNumber];
        } else if ([sign isEqual:@"*"]) {
            calculationResult = [self.calc multiplyThis:firstNumber times:secondNumber];
        } else if ([sign isEqual:@"/"]) {
            if (secondNumber == 0) {
                calculationResult = 0;
            } else {
                calculationResult = [self.calc divideThis:firstNumber by:secondNumber];
            }
        }
        
        self.display.text = @"";
        self.calc.firstOperand = calculationResult;
        
        if ([self.signDisplay.text isEqualToString: @"÷"] && calculationResult == 0) {
            [self updateDisplay:@"NAN"];
        } else {
            [self.display setText:[NSString stringWithFormat:@"%@", @(calculationResult)]];
        }
        
        [self.clearAndAllClearButton setTitle:@"AC" forState:UIControlStateNormal];
        
        self.signDisplay.text = @"";
    }
}

@end
