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
        HStack()
        {
            Text(peli.titulo ?? ":(")
                .font(.system(size: 14))
                .bold()
                .frame(width: 120)
                .multilineTextAlignment(.leading)
            
            Text(peli.id?.uuidString.prefix(8) ?? "-")
                .font(.caption.monospaced())
                .foregroundColor(Color.secondary)
                .frame(width: 100)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            StarRatingView(rating: .constant(Int(peli.rating)), size: 11, spacing: 2, editable: false)
                .multilineTextAlignment(.trailing)
        }
        .background(isSelected ? Color.yellow.opacity(0.2) : Color.clear)
        .padding(.vertical, 8)
    }
}
