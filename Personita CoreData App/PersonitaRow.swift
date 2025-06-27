import SwiftUI

struct PersonitaRow : View
{
    let personita : Personita
    let isSelected : Bool
    
    init(personita : Personita)
    {
        self.personita = personita
        isSelected = false
    }
    
    init(personita : Personita, isSelected : Bool)
    {
        self.personita = personita
        self.isSelected = isSelected
    }
    
    private var fechFormatter : Date.FormatStyle
    {
        Date.FormatStyle()
            .year(.defaultDigits)
            .month(.abbreviated)
            .day(.twoDigits)
    }
    
    var body : some View
    {
        HStack(spacing: 5)
        {
            Text(personita.nombre ?? ":(")
                .font(.system(size: 14))
                .bold()
                .frame(width: 80)
                .multilineTextAlignment(.leading)
            
            Text(personita.id?.uuidString.prefix(8) ?? "-")
                .font(.caption.monospaced())
                .foregroundColor(Color.secondary)
                .frame(width: 80)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            if let cum = personita.cum
            {
                Text(cum, format: fechFormatter)
                    .font(.system(size: 12))
                    .foregroundColor(Color.black)
                    .frame(width: 120)
                    .multilineTextAlignment(.trailing)
            }
            else
            {
                Text("No nació")
                    .font(.system(size: 12))
                    .foregroundColor(Color.red)
                    .frame(width: 120)
                    .multilineTextAlignment(.trailing)
            }
        }
        .background(isSelected ? Color.yellow.opacity(0.2) : Color.clear)
        .padding(.vertical, 8)
    }
}
