//
//  HomeView.swift
//  LMessenger
//
//  Created by 유연수 on 10/4/24.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer()
                    .frame(height: 24)
                
                profileView
                    .padding(.bottom, 30)
                
                searchButton
                    .padding(.bottom, 24)
                
                HStack {
                    Text("친구")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.bkText)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 24)
                
                // TODO: 친구목록
                if viewModel.users.isEmpty {
                    Spacer(minLength: 89)
                    
                    emptyView
                } else {
                    ForEach(viewModel.users, id: \.id) { user in
                        HStack(spacing: 8) {
                            Image("person")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(.circle)
                            Text(user.name)
                                .font(.system(size:12))
                                .foregroundColor(.bkText)
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
            .toolbar {
                Image(.bookmark)
                Image(.notifications)
                Image(.personAdd)
                Button {
                    // TODO:
                } label: {
                    Image(.settings)
                }
            }
        }
    }
    
    var profileView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(viewModel.myUser?.name ?? "이름")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.bkText)
                
                Text(viewModel.myUser?.description ?? "상태 메시지 입력")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.greyDeep)
            }
            
            Spacer()
            
            Button {
                // TODO: 프로필 이미지 변경
            } label: {
                Image(.person)
                    .resizable()
                    .frame(width: 52, height:  52)
                    .clipShape(.circle)
            }
        }
        .padding(.horizontal, 30)
    }
    
    var searchButton: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 36)
                .background(Color.greyCool)
                .cornerRadius(5)
            
            HStack {
                Text("검색")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.greyLightVer2)
                
                Spacer()
            }
            .padding(.leading, 20)
        }
        .padding(.horizontal, 30)
    }
    
    var emptyView: some View {
        VStack {
            VStack(spacing: 3) {
                Text("친구를 추가해보세요.")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.bkText)
                Text("큐알코드나 검색을 이용해서 친구를 추가해보세요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.greyDeep)
            }
            .padding(.bottom, 30)
            
            Button {
                // TODO: 친구 추가
            } label: {
                Text("친구추가")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.bkText)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 24)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyLight)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
}
