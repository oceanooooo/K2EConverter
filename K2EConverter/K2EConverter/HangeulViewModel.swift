//
//  TextConverterViewModel.swift
//  K2EConverter
//
//  Created by OhSuhyun on 2024.03.12.
//

import Foundation

class HangeulViewModel: ObservableObject {
    @Published var convertedText: String = ""
    @Published var resultText: String = ""

    private let doubleVowels: [String: String] = [
        "hk": "ㅘ", "ho": "ㅙ", "hl": "ㅚ", "nj": "ㅝ", "np": "ㅞ", "nl": "ㅟ", "ml": "ㅢ",
            "HK": "ㅘ", "HL": "ㅚ", "NJ": "ㅝ", "NL": "ㅟ", "ML": "ㅢ"
    ]
    private let otherVowels: [String: String] = [
        "k": "ㅏ", "o": "ㅐ", "i": "ㅑ", "O": "ㅒ", "j": "ㅓ", "p": "ㅔ", "u": "ㅕ",
        "P": "ㅖ", "h": "ㅗ", "y": "ㅛ", "n": "ㅜ", "b": "ㅠ", "m": "ㅡ", "l": "ㅣ",
        "K": "ㅏ", "I": "ㅑ", "J": "ㅓ", "U": "ㅕ", "H": "ㅗ", "Y": "ㅛ", "N": "ㅜ", "B": "ㅠ", "M": "ㅡ", "L": "ㅣ"
    ]
    private let doubleConsonants: [String: String] = [
        "rt": "ㄳ", "sw": "ㄵ", "sg": "ㄶ", "fr": "ㄺ", "fa": "ㄻ", "fq": "ㄼ",
        "ft": "ㄽ", "fx": "ㄾ", "fv": "ㄿ", "fg": "ㅀ", "qt": "ㅄ",
        "SG": "ㄶ", "FA": "ㄻ", "FX": "ㄾ", "FV": "ㄿ", "FG": "ㅀ"
    ]
    private let otherConsonants: [String: String] = [
        "r": "ㄱ", "R": "ㄲ", "s": "ㄴ", "e": "ㄷ", "E": "ㄸ", "f": "ㄹ", "a": "ㅁ",
        "q": "ㅂ", "Q": "ㅃ", "t": "ㅅ", "T": "ㅆ", "d": "ㅇ", "w": "ㅈ", "W": "ㅉ",
        "c": "ㅊ", "z": "ㅋ", "x": "ㅌ", "v": "ㅍ", "g": "ㅎ",
        "S": "ㄴ", "F": "ㄹ", "A": "ㅁ", "D": "ㅇ", "C": "ㅊ", "Z": "ㅋ", "X": "ㅌ", "V": "ㅍ", "G": "ㅎ"
    ]
    private let initialConsonants = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    private let medialVowels = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    private let finalConsonants = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    func convertInput(_ input: String) {
        convertedText = convertToKorean(inputString: input)
        resultText = convertToHangul(from: convertedText)
    }

    // 영어 문자열을 한글로 변환하는 함수
    private func convertToKorean(inputString: String) -> String {
        var resultString = "" // 최종 결과 문자열
        var tempString = "" // 변환된 문자열을 임시 저장하는 변수

        for i in 0..<inputString.count {
            let index = inputString.index(inputString.startIndex, offsetBy: i)
            let nextIndex = i < inputString.count ? inputString.index(inputString.startIndex, offsetBy: i+1) : index
            let prevIndex = i > 0 ? inputString.index(inputString.startIndex, offsetBy: i-1) : index
            let indexChar = String(inputString[index])
            let nextChar = nextIndex < inputString.endIndex ? String(inputString[nextIndex]) : ""
            let prevChar = i > 0 ? String(inputString[prevIndex]) : ""
            var temp = ""

            // 모음일 경우
            if otherVowels.keys.contains(indexChar) {
                if i > 0 && otherConsonants.keys.contains(prevChar) {
                    // MARK: 중성 = 앞에 초성 있음
                    if i < inputString.count-1 && otherVowels.keys.contains(nextChar) {
                        // MARK: 현재 연속 모음 중 첫번째 모음 (자-모-모, 자-이중모)
                        // i-1을 pop하여 자음 변환 후 append
                        if tempString.count > 0 {
                            if let tempConsonant = tempString.popLast(), let initial = otherConsonants[String(tempConsonant)] {
                                tempString.append(initial)
                            }
                        }
                        let doubleVowelKey = indexChar + nextChar
                        if doubleVowels.keys.contains(doubleVowelKey) {
                            // 이중모음 가능
                            temp = doubleVowels[doubleVowelKey] ?? ""
                            tempString.append(temp)
                        } else {
                            temp = otherVowels[indexChar] ?? ""
                            tempString.append(temp)
                            temp = otherVowels[nextChar] ?? ""
                            tempString.append(temp)
                        }
                        continue
                    } else {
                        // MARK: 일반 모음
                        temp = otherVowels[indexChar] ?? ""
                        // i-1을 pop하여 자음 변환 후 append
                        if tempString.count > 0 {
                            if let tempConsonant = tempString.popLast(), let initial = otherConsonants[String(tempConsonant)] {
                                tempString.append(initial)
                            }
                        }
                        // temp를 append
                        tempString.append(temp)
                    }
                } else {
                    // 앞에 초성 없음 (앞에 모음 or 기타문자)
                    let pprevIndex = i > 1 ? inputString.index(inputString.startIndex, offsetBy: i-2) : index
                    let pprevChar = i > 1 ? String(inputString[pprevIndex]) : ""
                    if i > 1 && otherConsonants.keys.contains(pprevChar) && otherVowels.keys.contains(prevChar) {
                        temp = otherVowels[indexChar] ?? ""
                        // 자-모-(모) -> 처리완료
                    } else {
                        // 단일 모음 (단, 자음 없이는 이중모음을 만들지 않는다)
                        temp = otherVowels[indexChar] ?? ""
                        tempString.append(temp)
                    }
                }
            } else {
                // 모음이 아닌 경우
                tempString.append(indexChar)
            }
        }

        for j in 0..<tempString.count {
            let index = tempString.index(tempString.startIndex, offsetBy: j)
            let nextIndex = j < tempString.count ? tempString.index(tempString.startIndex, offsetBy: j+1) : index
            let prevIndex = j > 0 ? tempString.index(tempString.startIndex, offsetBy: j-1) : index
            let indexChar = String(tempString[index])
            let nextChar = nextIndex < tempString.endIndex ? String(tempString[nextIndex]) : ""
            let prevChar = j > 0 ? String(tempString[prevIndex]) : ""
            var char = ""

            // 변환되지 않은 문자의 경우
            if otherConsonants.keys.contains(indexChar) {
                if j > 0 {
                    if otherConsonants.keys.contains(prevChar) {
                        // 겹받침 여부 조건문
                        let doubleConsonantsKey = prevChar + indexChar
                        if let temp = doubleConsonants[doubleConsonantsKey] {
                            // 이미 겹받침으로 변환 완료
                        } else {
                            // 단독 초성 글자
                            char = otherConsonants[indexChar] ?? ""
                            resultString.append(char)
                        }
                    } else {
                        if nextIndex < tempString.endIndex && otherConsonants.keys.contains(nextChar) {
                            // 겹받침 여부 조건문
                            let doubleConsonantsKey = indexChar + nextChar
                            if let temp = doubleConsonants[doubleConsonantsKey] {
                                resultString.append(temp)
                            } else {
                                char = otherConsonants[indexChar] ?? ""
                                resultString.append(char)
                            }
                        } else {
                            char = otherConsonants[indexChar] ?? ""
                            resultString.append(char)
                        }
                    }
                }
            } else {
                // 변환된 문자의 경우
                resultString.append(indexChar)
            }
        }

        // 결과 문자열 반환
        return resultString
    }

    // 한글 문자열을 한글자로 병합하는 함수
    private func convertToHangul(from input: String) -> String {
        var result = ""
        var temp = "" // 연속된 자음 저장

        for i in 0..<input.count {
            let index = input.index(input.startIndex, offsetBy: i)
            let nextIndex = i < input.count ? input.index(input.startIndex, offsetBy: i+1) : index
            let prevIndex = i > 0 ? input.index(input.startIndex, offsetBy: i-1) : index
            let indexChar = String(input[index])
            let nextChar = nextIndex < input.endIndex ? String(input[nextIndex]) : ""
            let prevChar = i > 0 ? String(input[prevIndex]) : ""

            // indexChar = 자음
            if finalConsonants.contains(indexChar) {
                // MARK: 자음 분기점 1 -> y:초성1 n:분기점2
                if i < input.count-1 && medialVowels.contains(nextChar) {
                    // MARK: 초성 1
                    // 이전 temp 처리: temp를 하나로 병합 후 result에 삽입
                    if temp.count > 0 && temp.count < 4 {
                        var initialCharacter = ""
                        var medialCharacter = ""
                        var finalCharacter = ""
                        initialCharacter = String(temp[temp.startIndex])    // 초성
                        if temp.count > 1 {
                            medialCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 1)])    // 중성
                            if temp.count > 2 {
                                finalCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 2)]) // 종성
                            }
                        }
                        let combineChar = combineHangul(initial: initialCharacter, medial: medialCharacter, final: finalCharacter)
                        if temp.count == 1 {
                            result.append(temp)
                        } else {
                            result.append(combineChar ?? "")
                        }
                        temp = ""
                    }
                    temp.append(indexChar)  // 초성 1 temp에 삽입
                } else {
                    // MARK: 자음 분기점 2 -> y:분기점3 n:초성2
                    if i > 0 && medialVowels.contains(prevChar) {
                        let pprevIndex = i > 1 ? input.index(input.startIndex, offsetBy: i-2) : index
                        let pprevChar = i > 1 ? String(input[pprevIndex]) : ""
                        // MARK: 자음 분기점 3 -> y:종성 n:초성3(단독초성)
                        if i > 1 && initialConsonants.contains(pprevChar) {
                            // MARK: 종성
                            temp.append(indexChar)  // 종성 temp에 삽입
                        } else {
                            // MARK: 초성 3 = 단독초성
                            // 이전 temp 처리: temp를 하나로 병합 후 result에 삽입
                            if temp.count > 0 && temp.count < 4 {
                                var initialCharacter = ""
                                var medialCharacter = ""
                                var finalCharacter = ""
                                initialCharacter = String(temp[temp.startIndex])    // 초성
                                if temp.count > 1 {
                                    medialCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 1)])    // 중성
                                    if temp.count > 2 {
                                        finalCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 2)]) // 종성
                                    }
                                }
                                let combineChar = combineHangul(initial: initialCharacter, medial: medialCharacter, final: finalCharacter)
                                if temp.count == 1 {
                                    result.append(temp)
                                } else {
                                    result.append(combineChar ?? "")
                                }
                                temp = ""
                            }
                            temp.append(indexChar)  // 초성 3 temp에 삽입
                        }
                    } else {
                        // MARK: 초성 2
                        // 이전 temp 처리: temp를 하나로 병합 후 result에 삽입
                        if temp.count > 0 && temp.count < 4 {
                            var initialCharacter = ""
                            var medialCharacter = ""
                            var finalCharacter = ""
                            initialCharacter = String(temp[temp.startIndex])    // 초성
                            if temp.count > 1 {
                                medialCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 1)])    // 중성
                                if temp.count > 2 {
                                    finalCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 2)]) // 종성
                                }
                            }
                            let combineChar = combineHangul(initial: initialCharacter, medial: medialCharacter, final: finalCharacter)
                            if temp.count == 1 {
                                result.append(temp)
                            } else {
                                result.append(combineChar ?? "")
                            }
                            temp = ""
                        }
                        temp.append(indexChar)  // 초성 2 temp에 삽입
                    }
                }
            } else if medialVowels.contains(indexChar) {
                // MARK: 중성 분기점 -> y:중성 n:단일모음
                if i > 0 && initialConsonants.contains(prevChar) {
                    // MARK: 중성
                    temp.append(indexChar)
                } else {
                    // MARK: 단일모음
                    result.append(indexChar)  // 단일모음 temp에 삽입
                }
            } else {
                // 기타문자 전 temp 처리: temp를 하나로 병합 후 result에 삽입
                if temp.count > 0 && temp.count < 4 {
                    var initialCharacter = ""
                    var medialCharacter = ""
                    var finalCharacter = ""
                    initialCharacter = String(temp[temp.startIndex])    // 초성
                    if temp.count > 1 {
                        medialCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 1)])    // 중성
                        if temp.count > 2 {
                            finalCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 2)]) // 종성
                        }
                    }
                    let combineChar = combineHangul(initial: initialCharacter, medial: medialCharacter, final: finalCharacter)
                    if temp.count == 1 {
                        result.append(temp)
                    } else {
                        result.append(combineChar ?? "")
                    }
                    temp = ""
                }
                // 한글 이외: 숫자, 띄어쓰기, 특수문자 등 (단, ㅃㅉㄸ는 왜인지 모르게 한글 이외 취급을 받고 있었다)
                if temp.count == 0 && indexChar == "ㅃ" || indexChar == "ㅉ" || indexChar == "ㄸ" {
                    temp = indexChar
                } else {
                    result.append(indexChar)
                }
            }
            if i == input.count-1 {
                // 마지막 temp 처리: temp를 하나로 병합 후 result에 삽입
                if temp.count > 0 && temp.count < 4 {
                    var initialCharacter = ""
                    var medialCharacter = ""
                    var finalCharacter = ""
                    initialCharacter = String(temp[temp.startIndex])    // 초성
                    if temp.count > 1 {
                        medialCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 1)])    // 중성
                        if temp.count > 2 {
                            finalCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 2)]) // 종성
                        }
                    }
                    let combineChar = combineHangul(initial: initialCharacter, medial: medialCharacter, final: finalCharacter)
                    if temp.count == 1 {
                        result.append(temp)
                    } else {
                        result.append(combineChar ?? "")
                    }
                    temp = ""
                }
            }
        }

        return result
    }

    // 초성 중성 종성 병합 함수
    private func combineHangul(initial: String = "", medial: String = "", final: String = "") -> String? {
        var initialIndex = 0
        var medialIndex = 0
        var finalIndex = 0

        if !initial.isEmpty, let index = initialConsonants.firstIndex(of: initial) {
            initialIndex = index
        }
        if !medial.isEmpty, let index = medialVowels.firstIndex(of: medial) {
            medialIndex = index
        }
        if !final.isEmpty, let index = finalConsonants.firstIndex(of: final) {
            finalIndex = index
        }

        let unicode = 0xAC00 + (initialIndex * 21 + medialIndex) * 28 + finalIndex
        return String(UnicodeScalar(unicode)!)
    }
}
