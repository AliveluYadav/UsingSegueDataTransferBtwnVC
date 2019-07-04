//
//  ContactDetailsVC.m
//  DataTransferBtwnVC
//
//  Created by Alivelu Ravula on 2/26/18.
//  Copyright © 2018 Alivelu Ravula. All rights reserved.
//

#import "ContactDetailsVC.h"
#import "ViewController.h"
#import "AccountDetailsVC.h"
#import "UIView+Toast.h"

@interface ContactDetailsVC ()

@end

@implementation ContactDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender

{
    
    if([identifier isEqualToString:@"CDtoAD"])
        
    {
        
        if(self.mobileNumTF.text.length==0 && self.emailIdTF.text.length==0 && self.whatAppTF.text.length==0)
            
        {
            
            [self.view makeToast:@"please fill all the above details" duration:3.0 position:CSToastPositionCenter];
            
            return NO;
            
        }else if (self.mobileNumTF.text.length==0 || self.mobileNumTF.text.length<10 || (self.mobileNumTF.text.integerValue<6000000000) || (self.mobileNumTF.text.integerValue>9999999999))  {
            
            [self.view makeToast:@"  Enter valid mobile number" duration:3.0 position:CSToastPositionCenter];
            
            return NO;
            
        }else if(![self validateEmail:self.emailIdTF.text] ){
            
            [self.view makeToast:@"enter valid email id  " duration:3.0 position:CSToastPositionCenter];
            
            return NO;
            
        }else if (self.whatAppTF.text.length==0 || self.whatAppTF.text.length<10 || (self.whatAppTF.text.integerValue<6000000000) || (self.whatAppTF.text.integerValue>9999999999))  {
            
            [self.view makeToast:@" Enter valid whatsApp number" duration:3.0 position:CSToastPositionCenter];
            
            return NO;
            
        }
        
    }
    
    return YES;
    
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL returnValue=NO;
    if(textField==self.mobileNumTF)
    {
        returnValue=YES;
    }
    else if (textField==self.emailIdTF)
    {
        if(self.mobileNumTF.text.integerValue>=6000000000 && self.mobileNumTF.text.integerValue<=9999999999)
        {
            returnValue=YES;
        }
        else
            [self.view makeToast:@"Mobilenumber should have 10 digits and start with 6,7,8,9"
                        duration:3.0
                        position:CSToastPositionCenter];
    }
    else if(textField==self.whatAppTF)
    {
        if(self.mobileNumTF.text.integerValue>=6000000000 && self.mobileNumTF.text.integerValue<=9999999999 && [self validateEmail:self.emailIdTF.text] )
        {
            returnValue=YES;
        }
        else
            [self.view makeToast:@"Enter valid emailID"
                        duration:3.0
                        position:CSToastPositionCenter];
    }
    return returnValue;
}
- (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField==self.whatAppTF)
    {
        if(self.whatAppTF.text.integerValue>=6000000000 && self.whatAppTF.text.integerValue<=9999999999)
            
        {
            
        }
        else
            [self.view makeToast:@"whatsApp should have 10 digits and start with 6,7,8,9"
                        duration:3.0
                        position:CSToastPositionCenter];
        
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==self.mobileNumTF||textField==self.whatAppTF)
    {
        if(string.length==0)
        {
            return YES;
        }
        
        NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
        if([string rangeOfCharacterFromSet:set].location==NSNotFound )
        {
            [self.view makeToast:@"Please Enter Numbers Only"
                        duration:3.0
                        position:CSToastPositionCenter];
            
            return NO;
        }
    }
    return YES;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CDtoAD"])
    {
        
        AccountDetailsVC * accountDetails = segue.destinationViewController;
    
        [self.personalDetailsArr addObject:self.mobileNumTF.text];
        [self.personalDetailsArr addObject:self.emailIdTF.text];
        [self.personalDetailsArr addObject:self.whatAppTF.text];
        
        
       accountDetails.contactDetailsArr = [[NSMutableArray alloc]init];
        
        [accountDetails.contactDetailsArr addObject:self.personalDetailsArr];
        NSLog(@"%@",accountDetails.contactDetailsArr);
        
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
