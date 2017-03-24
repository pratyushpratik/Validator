//
//  Validator.swift
//  Bar Finder
//
//  Created by Shivang Mishra on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//


import Foundation
class Validator {
    
    static let `default` : Validator = {
        let instance = Validator()
        return instance
    }()

    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidAlphaNumericField(testStr: String) -> Bool {
        
        let pattern = "^[a-zA-Z0-9]*$"
        return checkRegexPattern(pattern: pattern, field: testStr) || testStr == ""
    }
    
    func checkRegexPattern(pattern: String, field: String) -> Bool {
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {return false}
        return regex.firstMatch(in: field, options: [], range: NSMakeRange(0, field.characters.count)) != nil
    }
    
    func isStringOfLength(str : String, len : Int) -> Bool {
        return str.characters.count == len
    }
    
    func isStringlessthanLength(str : String, len : Int) -> Bool {
        return str.characters.count < len
    }
    
    func isBirthdayValid(DOB : String) -> Bool {
        
        let birthday = DateTimeManager.shared.toDate(from: DOB, usingFormat: DateFormat.mmddyyyy.rawValue)
        let now = DateTimeManager.shared.toDateFromCurrentDate(usingFormat: DateFormat.mmddyyyy.rawValue)
        let ageComponents : DateComponents = Calendar.current.dateComponents([.year], from: birthday ?? Date(), to: now ?? Date())
        let age: Int = ageComponents.year ?? 0
        if age > 0 {
            return true
        }
        return false
    }
    
    func checkTextSufficientComplexity(text : String) -> Bool {
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        let specialresult = texttest2.evaluate(with: text)
        
        return capitalresult && numberresult && specialresult
    }
}
