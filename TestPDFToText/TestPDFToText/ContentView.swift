//
//  ContentView.swift
//  TestPDFToText
//
//  Created by 현수빈 on 6/21/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = "This is top secret."
    @State var password: String = ""
    
    private let fileName = "test.pdf"
    
    private let encoder = EncodeManager()
    private let decoder = DecoderManager()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        TextEditor(text: $text)
                            .frame(height: 300)
                        
                        TextField(text: $password, label: {
                            Text("비밀번호 입력")
                        })
                        
                        Button(action: {
                            
                            encoder.execute(
                                password: password,
                                text: text,
                                fileName: fileName
                            )
                            
                            // Example usageif
                            let result = decoder.excute(
                                fileName: fileName,
                                password: password
                            )
                            print(result)
                            
                        }, label: {
                            Text("입력 완료")
                        })
                    }
                }
            }
            .navigationTitle("암호화 PDF로 내보내기")
        }
    }
}
