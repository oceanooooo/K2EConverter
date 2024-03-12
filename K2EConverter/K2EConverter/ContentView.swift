//
//  ContentView.swift
//  K2EConverter
//
//  Created by OhSuhyun on 2024.03.12.
//

import SwiftUI
import CoreText

struct ContentView: View {
    let doubleVowels: [String: String] = [
        "hk": "ㅘ", "ho": "ㅙ", "hl": "ㅚ", "nj": "ㅝ", "np": "ㅞ", "nl": "ㅟ", "ml": "ㅢ",
            "HK": "ㅘ", "HL": "ㅚ", "NJ": "ㅝ", "NL": "ㅟ", "ML": "ㅢ"
    ]
    let otherVowels: [String: String] = [
        "k": "ㅏ", "o": "ㅐ", "i": "ㅑ", "O": "ㅒ", "j": "ㅓ", "p": "ㅔ", "u": "ㅕ",
        "P": "ㅖ", "h": "ㅗ", "y": "ㅛ", "n": "ㅜ", "b": "ㅠ", "m": "ㅡ", "l": "ㅣ",
        "K": "ㅏ", "I": "ㅑ", "J": "ㅓ", "U": "ㅕ", "H": "ㅗ", "Y": "ㅛ", "N": "ㅜ", "B": "ㅠ", "M": "ㅡ", "L": "ㅣ"
    ]
    let doubleConsonants: [String: String] = [
        "rt": "ㄳ", "sw": "ㄵ", "sg": "ㄶ", "fr": "ㄺ", "fa": "ㄻ", "fq": "ㄼ",
        "ft": "ㄽ", "fx": "ㄾ", "fv": "ㄿ", "fg": "ㅀ", "qt": "ㅄ",
        "SG": "ㄶ", "FA": "ㄻ", "FX": "ㄾ", "FV": "ㄿ", "FG": "ㅀ"
    ]
    let otherConsonants: [String: String] = [
        "r": "ㄱ", "R": "ㄲ", "s": "ㄴ", "e": "ㄷ", "E": "ㄸ", "f": "ㄹ", "a": "ㅁ",
        "q": "ㅂ", "Q": "ㅃ", "t": "ㅅ", "T": "ㅆ", "d": "ㅇ", "w": "ㅈ", "W": "ㅉ",
        "c": "ㅊ", "z": "ㅋ", "x": "ㅌ", "v": "ㅍ", "g": "ㅎ",
        "S": "ㄴ", "F": "ㄹ", "A": "ㅁ", "D": "ㅇ", "C": "ㅊ", "Z": "ㅋ", "X": "ㅌ", "V": "ㅍ", "G": "ㅎ"
    ]
    let initialConsonants = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    let medialVowels = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    let finalConsonants = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    @State private var inputText: String = ""
    @State private var convertedText: String = ""
    @State private var resultText: String = ""

    var body: some View {
        VStack {
            TextField("Enter text here", text: $inputText)
                .padding()
            Button("Convert") {
                convertedText = convertToKorean(inputString: inputText)
                resultText = convertToHangul(from: convertedText)
            }
            Text(resultText)
                .padding()
        }
        .padding()
    }

    func combineHangul(initial: String, medial: String, final: String = "") -> String? {
        guard let initialIndex = initialConsonants.firstIndex(of: initial),
              let medialIndex = medialVowels.firstIndex(of: medial),
              let finalIndex = final.isEmpty ? 0 : finalConsonants.firstIndex(of: final) else { return nil }

        let unicode = 0xAC00 + (initialIndex * 21 + medialIndex) * 28 + finalIndex
        return String(UnicodeScalar(unicode)!)
    }

    // 영어 문자열을 한글로 변환하는 함수
    func convertToKorean(inputString: String) -> String {
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
                if i > 0 && otherVowels.keys.contains(prevChar) {
                    // 이미 이중모음으로 변환 완료
                    continue
                } else {
                    if i > 0 && nextIndex < inputString.endIndex && otherVowels.keys.contains(nextChar) {
                        // i~i+1 이중모음 변환하여 temp에 저장
                        let doubleVowelKey = indexChar + nextChar
                        temp = doubleVowels[doubleVowelKey] ?? ""
                    } else {
                        // i 모음 변환하여 temp에 저장
                        temp = otherVowels[indexChar] ?? ""
                    }

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
                            continue
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

    // 주어진 문자열을 한글로 변환하는 함수
    func convertToHangul(from input: String) -> String {
        var result = ""
        var temp = "" // 연속된 자음 저장
        var isFinal = false // 종성 여부 확인

        for i in 0..<input.count {
            let index = input.index(input.startIndex, offsetBy: i)
            let nextIndex = i < input.count ? input.index(input.startIndex, offsetBy: i+1) : index
            let prevIndex = i > 0 ? input.index(input.startIndex, offsetBy: i-1) : index
            let indexChar = String(input[index])
            let nextChar = nextIndex < input.endIndex ? String(input[nextIndex]) : ""
            let prevChar = i > 0 ? String(input[prevIndex]) : ""

            if indexChar != " " {
                if medialVowels.contains(indexChar) {
                    if let resultLast = result.last {
                        if initialConsonants.contains(String(resultLast)) {   // 초성 중성 있음
                            result.removeLast()
                            temp.append(resultLast)
                            temp.append(indexChar)
                            if i < input.count-1 && finalConsonants.contains(nextChar) {
                                // 중성 뒤 자음 존재
                                if i < input.count-2 && finalConsonants.contains(String(input[input.index(input.startIndex, offsetBy: i+2)])) {
                                    // 중성 뒤 자음 2개 존재
                                } else {
                                    // 중성 뒤 마지막 자음
                                }
                            } else {
                                // 받침이 없음
                                // temp를 하나로 병합
                                let initialCharacter = String(temp[temp.startIndex])
                                let medialCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 1)])
                                let tmp = combineHangul(initial: initialCharacter, medial: medialCharacter)
                                result.append(tmp ?? "")
                                temp = ""
                            }
                        } else if finalConsonants.contains(String(resultLast)) || medialVowels.contains(String(resultLast)) {
                            result.append(indexChar)
                        } else {
                            // result의 마지막 글자가 초성, 중성, 종성 모두 해당 안됨
                        }
                    } else {
                        // 첫글자 모음
                        result.append(indexChar)
                    }
                } else {
                    if i > 0 && medialVowels.contains(prevChar) {
                        if medialVowels.contains(nextChar) {
                            result.append(indexChar)
                        } else {
                            // 받침인 경우
                            temp.append(indexChar)
                            // temp를 하나로 병합
                            let initialCharacter = String(temp[temp.startIndex])
                            let medialCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 1)])
                            let finalCharacter = String(temp[temp.index(temp.startIndex, offsetBy: 2)])
                            let tmp = combineHangul(initial: initialCharacter, medial: medialCharacter, final: finalCharacter)
                            print("tmp: \(tmp)")
                            result.append(tmp ?? "")
                            temp = ""
                        }
                    } else {
                        result.append(indexChar)
                    }
                }
            } else {
                result.append(" ")
            }
        }

        return result
    }
}


#Preview {
    ContentView()
}
