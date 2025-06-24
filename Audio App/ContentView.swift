import SwiftUI

struct ContentView : View
{
    @StateObject private var audio = AudioPlayer()
    @State private var audioCargado : Bool = false
    @State private var canStop : Bool = false
    
    var body : some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            Text(":b")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top, 30)
                .padding(.horizontal, 20)
            
            Spacer()
            
            if(!audioCargado)
            {
                Button(action:
                {
                    audioCargado = audio.cargarAudio(nombre: "tralalero", extension: "mp3")
                })
                {
                    Text("Cargar Audio")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(minWidth: 200, minHeight: 40)
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            else
            {
                Image("tralala")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 5)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 50)
                {
                    Button(action:
                    {
                        audio.isPlaying ? audio.pause() : audio.play()
                        canStop = true
                    })
                    {
                        Image(systemName: audio.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 100))
                                .foregroundColor(audio.isPlaying ? Color.yellow.opacity(0.8) : Color.green.opacity(0.8))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    if canStop
                    {
                        Button(action:
                        {
                            audio.stop()
                            canStop = false
                        })
                        {
                            Image(systemName: "stop.circle.fill")
                                .font(.system(size: 100))
                                .foregroundColor(Color.red.opacity(0.8))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .padding()
    }
}

#Preview
{
    ContentView()
}
