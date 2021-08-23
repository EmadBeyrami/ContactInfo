//
//  Test_Validators.swift
//  HedvigTests
//
//  Created by Emad Bayramy on 8/23/21.
//

import XCTest
@testable import Hedvig
class TestValidators: XCTestCase {
    
    var emailValidator: EmailValidator?
    var phoneValidator: PhoneValidator?
    
    override func tearDownWithError() throws {
        emailValidator = nil
        phoneValidator = nil
        try? super.tearDownWithError()
    }
    
    override func setUp() {
        emailValidator = EmailValidator()
        phoneValidator = PhoneValidator()
    }
    
    override func tearDown() {
        emailValidator = nil
        phoneValidator = nil
    }
    
    func test_emailValidator() throws {
        // given
        guard let emailValidator = emailValidator else {
            throw UnitTestError()
        }
        
        // when
        let wrongEmailTypes = ["xxxx@.c", "xxxx@s.c", "mamad", "jrei@mai", "   ", ""]
        let correctEmailTypes = ["emad@mail.com", "xx@xyz.net", "eb@bornak.de", "emad@beyrami.co.uk"]
        
        // then
        wrongEmailTypes.forEach { email in
            let wrongEmail = emailValidator.isEmail(email)
            XCTAssertFalse(wrongEmail)
        }
        
        correctEmailTypes.forEach { email in
            let correctEmail = emailValidator.isEmail(email)
            XCTAssertTrue(correctEmail)
        }
        
    }
    
    func test_phoneValidator() throws {
        // given
        guard let phoneValidator = phoneValidator else {
            throw UnitTestError()
        }
        // when
        let wrongPhoneTypes = ["9x98c903984", "789947389573837283", "0980980984082090.2938408", "9894+093890", "  ", ""]
        let correctPhoneTypes = ["09362001311", "09905398818", "+12930499004", "+989362001311"]

        // then
        wrongPhoneTypes.forEach { number in
            let wrongEmail = phoneValidator.isMobileNumber(number)
            XCTAssertFalse(wrongEmail)
        }
        
        correctPhoneTypes.forEach { number in
            let correctEmail = phoneValidator.isMobileNumber(number)
            XCTAssertTrue(correctEmail)
        }
    }
}
