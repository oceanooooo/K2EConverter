//
//  ContentView.swift
//  K2EConverter
//
//  Created by OhSuhyun on 2024.03.12.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HangeulViewModel()
    @State private var inputText: String = ""

    var body: some View {
        /*
         VStack {
         TextField("Enter text here", text: $inputText)
         .padding()
         Button("Convert") {
         viewModel.convertInput(inputText)
         }
         Text(viewModel.resultText)
         .padding()
         }
         .padding()
         */
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("한영자판 변환문제 수정")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 12)
            Divider()
                .padding(.bottom, 24)
            Text("영어 자판으로 입력한 문장")
                .font(.headline)
            // Text input area
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
                VStack(alignment: .leading) {
                    TextEditor(text: $inputText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    HStack {
                        Spacer()
                        Button(action: {
                            // Clear text
                            inputText = ""
                            viewModel.convertInput(inputText)
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            HStack {
                Spacer()
                Image(systemName: "arrow.down")
                    .foregroundColor(.blue)
                    .font(.title2)
                Spacer()
            }
            .padding()
            Text("한글 자판으로 수정한 문장")
                .font(.headline)
            // Text output area
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
                VStack(alignment: .leading) {
                    Text(viewModel.resultText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    HStack {
                        Spacer()
                        Button(action: {
                            // Copy text
                            UIPasteboard.general.string = viewModel.resultText
                        }) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }

            Spacer()

            // Translation button
            Button(action: {
                // Perform translation
                viewModel.convertInput(inputText)
            }) {
                Capsule()
                    .frame(height: 48)
                    .overlay {
                        Text("변환하기")
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 48)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
