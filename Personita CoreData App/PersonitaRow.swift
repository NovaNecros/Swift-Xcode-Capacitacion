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
            .month(.wide)
            .day(.twoDigits)
    }
    
    var body : some View
    {
        HStack(spacing: 5)
        {
            Text(personita.nombre ?? ":(")
                .font(.system(size: 14))
                .bold()
                .frame(minWidth: 100, alignment: .leading)
            
            Text(personita.id?.uuidString.prefix(8) ?? "-")
                .font(.caption.monospaced())
                .foregroundColor(Color.secondary)
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            if let cum = personita.cum
            {
                Text(cum, format: fechFormatter)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
            }
            else
            {
                Text("No nació")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
            }
        }
        .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
        .padding(.vertical, 8)
    }
}
