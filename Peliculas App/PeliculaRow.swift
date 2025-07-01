import SwiftUI

struct PeliculaRow : View
{
    let peli : Pelicula
    let isSelected : Bool
    
    init(peli : Pelicula, isSelected : Bool = false)
    {
        self.peli = peli
        self.isSelected = isSelected
    }
    
    var body : some View
    {
        HStack(spacing: 5)
        {
            Text(peli.id?.uuidString.prefix(8) ?? "-")
                .font(.caption.monospaced())
                .foregroundColor(Color.secondary)
                .frame(width: 40)
                .multilineTextAlignment(.center)
            
            Text(peli.titulo ?? ":(")
                .font(.system(size: 14))
                .bold()
                .frame(width: 80)
                .multilineTextAlignment(.leading)
            
            Text(peli.director ?? ":(")
                .font(.system(size: 14))
                .frame(width: 80)
                .multilineTextAlignment(.leading)
            
            Text("\(peli.duracion)")
                .font(.system(size: 14))
                .frame(width: 70)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            StarRatingView(rating: .constant(Int(peli.rating)), size: 5, spacing: 0, editable: false)
        }
        .background(isSelected ? Color.yellow.opacity(0.2) : Color.clear)
        .padding(.vertical, 8)
    }
}
