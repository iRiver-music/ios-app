import SwiftUI

struct CustomNavigationView<FirstView: View, SecondView: View>: View {
    @State private var isShowingSecondView = false

    var firstView: FirstView
    var secondView: SecondView

    var body: some View {
        NavigationView {
            VStack {
                // 使用手势捕捉左滑事件
                VStack {
                    Spacer()
                    firstView // 第一层视图
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity) // 让第一层视图填充整个VStack的宽度

                    Spacer()
                }
            }
//            .navigationTitle("Swipe Left")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                // 使用NavigationLink在需要时触发视图切换
                NavigationLink(destination: secondView, isActive: $isShowingSecondView) {
                    EmptyView()
                }
            )
        }
    }
}

struct CustomNavigationView2<Content: View>: View {
    @Binding var isActive: Bool
    let destination: Content
    
    var body: some View {
        NavigationView {
            ZStack {
                if isActive {
                    destination
                        .navigationBarBackButtonHidden(true)
                        .onDisappear {
                            isActive = false // Reset the isActive state when the destination view disappears
                        }
                }
            }
        }
    }
}
