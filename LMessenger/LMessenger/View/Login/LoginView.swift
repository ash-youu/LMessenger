//
//  LoginView.swift
//  LMessenger
//
//  Created by 유연수 on 10/2/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("로그인")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.bkText)
                    .padding(.top, 80)
                
                Spacer()
                    .frame(height: 18)
                
                Text("아래 제공되는 서비스로 로그인을 해주세요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.greyDeep)
            }
            .padding(.leading, 30)
            
            Spacer()
            
            Button {
                authViewModel.send(action: .googleLogin)
            } label: {
                Text("Google로 로그인")
            }.buttonStyle(LoginButtonStyle(textColor: .bkText,
                                           borderColor: .greyLight))
            
            SignInWithAppleButton { request in
                authViewModel.send(action: .appleLogin(request))
            } onCompletion: { result in
                authViewModel.send(action: .appleLoginCompletion(result))
            }
            .frame(height: 40)
            .padding(.horizontal, 15)
            .cornerRadius(5)
        }
        .navigationBarBackButtonHidden()
        .toolbar(content:  {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image("back")
                }
            }
        })
        .overlay {
            if authViewModel.isLoading {
                ProgressView()
            }
        }
    }
}

#Preview {
    LoginView()
}
