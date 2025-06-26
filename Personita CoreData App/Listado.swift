import SwiftUI
import CoreData

struct Listado : View
{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var selected : Personita?
    
    let coreDM = CoreDataManager()
    let personitas : [Personita]
    
    init()
    {
        personitas = coreDM.leerTodas()
    }
    
    var body : some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            List()
            {
                Section(header:
                    HStack()
                    {
                        Text("Nombre")
                        .frame(minWidth: 100, alignment: .center)
                    
                    Text("ID").frame(width: 80, alignment: .center)
                    
                    Spacer()
                    
                    Text("Cumpleaños")
                        .frame(alignment: .center)
                    }
                )
                {
                    ForEach(personitas)
                    { (p : Personita) in
                        PersonitaRow(personita: p, isSelected: p == selected)
                            .contentShape(Rectangle())
                            .onTapGesture
                            {
                                selected = p
                            }
                    }
                }
                .listStyle(.insetGrouped)
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 15)
            {
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        dismiss()
                    }
                })
                {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 80))
                        .rotationEffect(.init(degrees: 45))
                        .foregroundColor(Color.blue.opacity(0.85))
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(
                    role: .destructive,
                    action: borrar
                )
                {
                    Image(systemName: "trash.square.fill")
                        .font(.system(size: 80))
                        .foregroundColor(selected != nil ? Color.red : Color.red.opacity(0.4))
                }
                .buttonStyle(ConditionalButtonStyle(isEnabled: selected != nil))
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
    
    private func borrar()
    {
        guard let persona = selected else { return }
        viewContext.delete(persona)
        do
        {
            try viewContext.save()
            selected = nil
        }
        catch
        {
            print("Error borrando \n \(error)")
        }
    }
}

#Preview
{
    Listado()
}
