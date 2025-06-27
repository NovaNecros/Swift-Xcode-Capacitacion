import SwiftUI
import CoreData

struct Listado : View
{
    @StateObject private var coreDM = CoreDataManager()
    @State private var personitas : [Personita] = []
    @State private var selected : Personita? = nil
    @State private var key : String = ""
    @State private var order : Bool = true
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var body : some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            List()
            {
                Section(header: header)
                {
                    ForEach(personitas)
                    { (p : Personita) in
                        PersonitaRow(personita: p, isSelected: p == selected)
                            .contentShape(Rectangle())
                            .onTapGesture()
                            {
                                withAnimation(.spring())
                                {
                                    selected = p                                    
                                }
                            }
                    }
                }
                .listStyle(.insetGrouped)
                .onAppear()
                {
                    withAnimation(.spring())
                    {
                        personitas = coreDM.leer()
                    }
                }
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 30)
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
    
    private var header : some View
    {
        HStack()
        {
            Text("Nombre")
                .frame(width: 80)
                .multilineTextAlignment(.leading)
                .onTapGesture()
                {
                    withAnimation(.spring())
                    {
                        if key == "nombre"
                        {
                            order.toggle()
                        }
                        else
                        {
                            key = "nombre"
                            order = true
                        }
                        
                        personitas = coreDM.leer(key: key, order: order)
                    }
                }
        
            Text("ID")
                .frame(width: 80)
                .multilineTextAlignment(.center)
                .onTapGesture()
                {
                    withAnimation(.spring())
                    {
                        if key == "id"
                        {
                            order.toggle()
                        }
                        else
                        {
                            key = "id"
                            order = true
                        }
                        
                        personitas = coreDM.leer(key: key, order: order)
                    }
                }
        
        Spacer()
        
            Text("Cumpleaños")
                .frame(width: 120)
                .multilineTextAlignment(.trailing)
                .onTapGesture()
                {
                    withAnimation(.spring())
                    {
                        if key == "cum"
                        {
                            order.toggle()
                        }
                        else
                        {
                            key = "cum"
                            order = true
                        }
                        
                        personitas = coreDM.leer(key: key, order: order)
                    }
                }
        }
    }
    
    private func borrar()
    {
        guard let persona = selected else { return }
        
        withAnimation(.spring())
        {
            coreDM.borrar(persona)
            personitas = coreDM.leer(key: key, order: order)
            selected = nil
        }
    }
}

#Preview
{
    Listado()
}
