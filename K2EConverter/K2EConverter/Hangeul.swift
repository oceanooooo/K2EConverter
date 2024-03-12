//
//  TextConverterViewModel.swift
//  K2EConverter
//
//  Created by OhSuhyun on 2024.03.12.
//

import SwiftUI

struct EToK {
    // 작업 우선순위 doubleVowels -> otherVowels -> otherConsonants(초성) -> doubleConsonants -> otherConsonants(나머지)
    static let doubleVowels: [String: String] = [
        " ": " ", "hk": "ㅘ", "ho": "ㅙ", "hl": "ㅚ", "nj": "ㅝ", "np": "ㅞ", "nl": "ㅟ", "ml": "ㅢ"
    ]
    static let otherVowels: [String: String] = [
        "k": "ㅏ", "o": "ㅐ", "i": "ㅑ", "O": "ㅒ", "j": "ㅓ", "p": "ㅔ", "u": "ㅕ",
        "P": "ㅖ", "h": "ㅗ", "y": "ㅛ", "n": "ㅜ", "b": "ㅠ", "m": "ㅡ", "l": "ㅣ"
    ]
    static let doubleConsonants: [String: String] = [
        "rt": "ㄳ", "sw": "ㄵ", "sg": "ㄶ", "fr": "ㄺ", "fa": "ㄻ", "fq": "ㄼ",
        "ft": "ㄽ", "fx": "ㄾ", "fv": "ㄿ", "fg": "ㅀ", "qt": "ㅄ"
    ]
    static let otherConsonants: [String: String] = [
        "r": "ㄱ", "R": "ㄲ", "s": "ㄴ", "e": "ㄷ", "E": "ㄸ", "f": "ㄹ", "a": "ㅁ",
        "q": "ㅂ", "Q": "ㅃ", "t": "ㅅ", "T": "ㅆ", "d": "ㅇ", "w": "ㅈ", "W": "ㅉ",
        "c": "ㅊ", "z": "ㅋ", "x": "ㅌ", "v": "ㅍ", "g": "ㅎ"
    ]
    static let upperCase: [String: String] = [
        "HK": "ㅘ", "HL": "ㅚ", "NJ": "ㅝ", "NL": "ㅟ", "ML": "ㅢ",
        "SG": "ㄶ", "FA": "ㄻ", "FX": "ㄾ", "FV": "ㄿ", "FG": "ㅀ",
        "K": "ㅏ", "I": "ㅑ", "J": "ㅓ", "U": "ㅕ", "H": "ㅗ", "Y": "ㅛ", "N": "ㅜ", "B": "ㅠ", "M": "ㅡ", "L": "ㅣ",
        "S": "ㄴ", "F": "ㄹ", "A": "ㅁ", "D": "ㅇ", "C": "ㅊ", "Z": "ㅋ", "X": "ㅌ", "V": "ㅍ", "G": "ㅎ"
    ]

}

struct KToE {
    static let doubleVowels: [String: String] = [
        "ㅘ": "hk", "ㅙ": "ho", "ㅚ": "hl", "ㅝ": "nj", "ㅞ": "np", "ㅟ": "nl", "ㅢ": "ml", " ": " "
    ]
    static let doubleConsonants: [String: String] = [
        "ㄳ": "rt", "ㄵ": "sw", "ㄶ": "sg", "ㄺ": "fr", "ㄻ": "fa", "ㄼ": "fq",
        "ㄽ": "ft", "ㄾ": "fx", "ㄿ": "fv", "ㅀ": "fg", "ㅄ": "qt"
    ]
    static let otherVowels: [String: String] = [
        "ㅏ": "k", "ㅐ": "o", "ㅑ": "i", "ㅒ": "O", "ㅓ": "j", "ㅔ": "p", "ㅕ": "u",
        "ㅖ": "P", "ㅗ": "h", "ㅛ": "y", "ㅜ": "n", "ㅠ": "b", "ㅡ": "m", "ㅣ": "l"
    ]
    static let otherConsonants: [String: String] = [
        "ㄱ": "r", "ㄲ": "R", "ㄴ": "s", "ㄷ": "e", "ㄸ": "E", "ㄹ": "f", "ㅁ": "a",
        "ㅂ": "q", "ㅃ": "Q", "ㅅ": "t", "ㅆ": "T", "ㅇ": "d", "ㅈ": "w", "ㅉ": "W",
        "ㅊ": "c", "ㅋ": "z", "ㅌ": "x", "ㅍ": "v", "ㅎ": "g"
    ]

}

struct Hangeul {
    static let englishToHangul: [String: Character] = [
        " ": " ", "r": "ㄱ", "R": "ㄲ", "rt": "ㄳ", "s": "ㄴ", "sw": "ㄵ", "sg": "ㄶ", "e": "ㄷ", "E": "ㄸ",
        "f": "ㄹ", "fr": "ㄺ", "fa": "ㄻ", "fq": "ㄼ", "ft": "ㄽ", "fx": "ㄾ", "fv": "ㄿ", "fg": "ㅀ",
        "a": "ㅁ", "q": "ㅂ", "Q": "ㅃ", "qt": "ㅄ", "t": "ㅅ", "T": "ㅆ", "d": "ㅇ", "w": "ㅈ", "W": "ㅉ",
        "c": "ㅊ", "z": "ㅋ", "x": "ㅌ", "v": "ㅍ", "g": "ㅎ",
        "k": "ㅏ", "o": "ㅐ", "i": "ㅑ", "O": "ㅒ", "j": "ㅓ", "p": "ㅔ", "u": "ㅕ", "P": "ㅖ",
        "h": "ㅗ", "hk": "ㅘ", "ho": "ㅙ", "hl": "ㅚ", "y": "ㅛ", "n": "ㅜ", "nj": "ㅝ", "np": "ㅞ", "nl": "ㅟ",
        "b": "ㅠ", "m": "ㅡ", "ml": "ㅢ", "l": "ㅣ"
    ]
    static let hangulToEnglish: [Character: String] = [
        " ": " ", "ㄱ": "r", "ㄲ": "R", "ㄳ": "rt", "ㄴ": "s", "ㄵ": "sw", "ㄶ": "sg", "ㄷ": "e", "ㄸ": "E",
        "ㄹ": "f", "ㄺ": "fr", "ㄻ": "fa", "ㄼ": "fq", "ㄽ": "ft", "ㄾ": "fx", "ㄿ": "fv", "ㅀ": "fg",
        "ㅁ": "a", "ㅂ": "q", "ㅃ": "Q", "ㅄ": "qt", "ㅅ": "t", "ㅆ": "T", "ㅇ": "d", "ㅈ": "w", "ㅉ": "W",
        "ㅊ": "c", "ㅋ": "z", "ㅌ": "x", "ㅍ": "v", "ㅎ": "g",
        "ㅏ": "k", "ㅐ": "o", "ㅑ": "i", "ㅒ": "O", "ㅓ": "j", "ㅔ": "p", "ㅕ": "u", "ㅖ": "P", 
        "ㅗ": "h", "ㅘ": "hk", "ㅙ": "ho", "ㅚ": "hl", "ㅛ": "y", "ㅜ": "n", "ㅝ": "nj", "ㅞ": "np", "ㅟ": "nl",
        "ㅠ": "b", "ㅡ": "m", "ㅢ": "ml", "ㅣ": "l"
    ]

    static let initialConsonants = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    static let medialVowels = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    static let finalConsonants = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    static func translateToHangul(from englishCharacter: String) -> Character? {
        return englishToHangul[englishCharacter]
    }
    static func translateToEnglish(from hangulCharacter: Character) -> String? {
        return hangulToEnglish[hangulCharacter]
    }

    static func decompose(_ character: Character) -> (initial: String, medial: String, final: String)? {
        guard let unicode = character.unicodeScalars.first?.value else { return nil }
        guard unicode >= 0xAC00 && unicode <= 0xD7A3 else { return nil }

        let index = Int(unicode - 0xAC00)
        let initialIndex = index / (21 * 28)
        let medialIndex = (index % (21 * 28)) / 28
        let finalIndex = index % 28

        return (initialConsonants[initialIndex], medialVowels[medialIndex], finalConsonants[finalIndex])
    }

    static func combine(initial: String, medial: String, final: String = "") -> Character? {
        guard let initialIndex = initialConsonants.firstIndex(of: initial),
              let medialIndex = medialVowels.firstIndex(of: medial),
              let finalIndex = final.isEmpty ? 0 : finalConsonants.firstIndex(of: final) else { return nil }

        let unicode = 0xAC00 + (initialIndex * 21 + medialIndex) * 28 + finalIndex
        return Character(UnicodeScalar(unicode)!)
    }
}
