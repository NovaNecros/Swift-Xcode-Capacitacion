import SwiftUI

struct ContentView : View
{
    let n : Int = 10
    private var colores : [Color] = [.pink, .black]
    
    @State private var invertir : Bool = false
    @State private var isAnimating : Bool = false
    
    private let timer = Timer.publish(every: 1/6, on: .main, in: .common).autoconnect()
    
    var body : some View
    {
        NavigationStack()
        {
            ZStack
            {
                Color.pink
                    .opacity(0.2)
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 0)
                {
                    NavigationLink(destination: SecondView())
                    {
                        ZStack
                        {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 300))
                                .foregroundColor(nil)
                                .shadow(color: Color.black.opacity(100), radius: 50, x: 0, y: 0)
                            
                            ForEach(0..<n)
                            { i in
                                Image(systemName: "heart.fill")
                                    .font(.system(size: CGFloat(300-300*i/n)))
                                    .foregroundStyle(colores[(i+(invertir ? 1 : 0))%2])
                                    .padding(.bottom, 0)
                            }
                        }
                        .onReceive(timer)
                        { _ in
                            guard isAnimating else { return }
                            
                            withAnimation(.easeInOut(duration: 1/30))
                            {
                                invertir.toggle()
                            }
                        }
                        
                    }
                    .padding()
                }
                .padding()
                
                VStack(alignment: .center, spacing: 0)
                {
                    Spacer()
                    
                    Button(action:
                            {
                        withAnimation(.spring())
                        {
                            isAnimating.toggle()
                        }
                    })
                    {
                        Image(systemName: isAnimating ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size : 64))
                            .foregroundColor(isAnimating ? Color.yellow : Color.green)
                            .background(Circle().stroke(Color.white, lineWidth: 4)
                                .fill(Color.white))
                            .shadow(color: isAnimating ? Color.yellow : Color.green, radius: 2, x: 0, y: 0)
                    }
                    .padding(.bottom, 20)
                }
                .padding()
            }
        }
    }
}

#Preview
{
    ContentView()
}
