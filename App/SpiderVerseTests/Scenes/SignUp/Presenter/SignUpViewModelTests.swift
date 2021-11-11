@testable import SpiderVerse
import XCTest

final class SignUpViewModelTests: XCTestCase {
    // MARK: - System under test

    private let sut = SignUpViewModel()

    func testIsValidEmailShouldAllowValidAddresses() {
        // Given
        let validList = Fixtures.EmailAddresses.validEmails
        let resultStub = [Bool](repeating: true, count: validList.count)
        var actualResult = [Bool]()

        // When
        validList.forEach {
            let isValid = sut.isValid(email: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(resultStub, actualResult)
    }

    func testIsValidEmailShouldForbidInvalidAddresses() {
        // Given
        let invalidList = Fixtures.EmailAddresses.invalidEmails
        let resultStub = [Bool](repeating: false, count: invalidList.count)
        var actualResult = [Bool]()

        // When
        invalidList.forEach {
            let isValid = sut.isValid(email: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(resultStub, actualResult)
    }

    func testIsValidPasswordShouldAllowValidPasswords() {
        // Given
        let validList = Fixtures.Passwords.validPasswords
        let resultStub = [Bool](repeating: true, count: validList.count)
        var actualResult = [Bool]()

        // When
        validList.forEach {
            let isValid = sut.isValid(password: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(resultStub, actualResult)
    }

    func testIsValidPasswordShouldForbidInvalidPasswords() {
        // Given
        let invalidList = Fixtures.Passwords.invalidPasswords
        let resultStub = [Bool](repeating: false, count: invalidList.count)
        var actualResult = [Bool]()

        // When
        invalidList.forEach {
            let isValid = sut.isValid(password: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(resultStub, actualResult)
    }
}
