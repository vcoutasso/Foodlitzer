import Foundation

struct Fixtures {
    enum EmailAddresses {
        static let validEmails = [
            "email@example.com",
            "firstname.lastname@example.com",
            "email@subdomain.example.com",
            "firstname+lastname@example.com",
            "1234567890@example.com",
            "email@example-one.com",
            "_______@example.com",
            "email@example.name",
            "email@example.museum",
            "email@example.co.jp",
            "firstname-lastname@example.com",
        ]

        static let invalidEmails = [
            "plainaddress",
            "#@%^%#$@#$@#.com",
            "@example.com",
            "Joe Smith <email@example.com>",
            "email.example.com",
            "email@example@example.com",
            "あいうえお@example.com",
            "email@example.com (Joe Smith)",
            "email@example",
            "email@111.222.333.44444",
            #"”(),:;<>[\]@example.com"#,
            #"just”not”right@example.com"#,
            #"this\ is"really"not\allowed@example.com"#,
        ]
    }

    enum Passwords {
        static let validPasswords = [
            "ThisPasswordIsC0mpletelyValid123$!",
        ]

        static let invalidPasswords = [
            "",
            "2shorT!",
            "veryLongThatIsAlmostValid!",
            "noDIGITS",
            "alllowercase",
            "ALLUPPERCASE",
            "1234567890",
            "youAlmostGotIt1",
            "!@#$%^&&¨$@#",
            "no white spaces plz",
        ]
    }
}
