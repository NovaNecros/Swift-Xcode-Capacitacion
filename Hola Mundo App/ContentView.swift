import SwiftUI

struct ContentView : View
{
    @State private var mostrar : Bool = false
    
    var body : some View
    {
        VStack(spacing: 20)
        {
            if mostrar
            {
                Image(systemName: "heart.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.black)
                    .transition(.scale)
                    .padding(.top, 10)
                
                Text("Hola Mundo <3")
                    .font(.largeTitle)
                    .foregroundColor(.pink)
                    .padding()
            }

            Button(action:
            {
                withAnimation(.spring())
                {
                    mostrar = !mostrar
                }
            })
            {
                Text("Apachurráme")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.pink.opacity(0.8)))
                    .shadow(color: Color.pink.opacity(0.4), radius: 8, x: 0, y: 4)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

#Preview
{
    ContentView()
}
