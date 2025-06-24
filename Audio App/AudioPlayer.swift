import Foundation
import AVFoundation

class AudioPlayer : ObservableObject
{
    private var player : AVAudioPlayer?
    @Published var isPlaying : Bool = false
    
    func cargarAudio(nombre : String, extension ext: String) -> Bool
    {
        guard let url : URL = Bundle.main.url(forResource: nombre, withExtension : ext) else
        {
            print("\(nombre).\(ext) no encontrado")
            return false
        }
        do
        {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        }
        catch
        {
            print("Error al cargar \(error):(")
            return false
        }
        
        return true
    }
    
    func play()
    {
        guard let player = player else { return }
        
        if !player.isPlaying
        {
            player.play()
            isPlaying = true
        }
    }
    
    func pause()
    {
        guard let player = player else { return }
        
        if player.isPlaying
        {
            player.pause()
            isPlaying = false
        }
    }
    
    func stop()
    {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
    }
}
