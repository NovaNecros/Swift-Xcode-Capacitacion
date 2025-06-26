import SwiftUI

struct ContentView : View
{
    let coreDM = CoreDataManager()
    
    @State private var nombre : String = ""
    @State private var cumReal : Date? = nil
    
    private var cumFalso : Date = Date()
    private var cumBinding : Binding<Date>
    {
        Binding<Date>(
            get: { cumReal ?? cumFalso },
            set: { fecha in cumReal = fecha }
        )
    }
    
    private func algunDato() -> Bool
    {
        return !nombre.isEmpty || cumReal != nil
    }
    private func todoDato() -> Bool
    {
        return !nombre.isEmpty && cumReal != nil
    }
    
    var body : some View
    {
        NavigationStack()
        {
            VStack(alignment: .center, spacing: 0)
            {
                Spacer()
                
                VStack(alignment: .leading, spacing: 0)
                {
                    HStack(alignment: .center, spacing: 0)
                    {
                        Image(systemName: "person.fill")
                            .font(.system(size: 28))
                            .foregroundColor(Color.pink)
                            .padding(.trailing, 15)
                        
                        Text("Nombre")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.bottom, 5)
                    
                    TextField("", text: $nombre)
                        .multilineTextAlignment(.leading)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.pink))
                        .autocorrectionDisabled(true)
                        .padding(.bottom, 40)
                    
                    HStack(alignment: .center, spacing: 0)
                    {
                        Image(systemName: "calendar")
                            .font(.system(size: 28))
                            .foregroundColor(Color.pink)
                            .padding(.trailing, 10)
                        
                        Text("Cumpleaños")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                    }
                    
                    DatePicker(
                        "",
                        selection: cumBinding,
                        displayedComponents: .date
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .frame(alignment: .center)
                    .padding()
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 15)
                {
                    Button(action:
                    {
                        withAnimation(.spring())
                        {
                            coreDM.guardar(nombre: nombre, cum: cumReal!)
                            nombre = ""
                            cumReal = nil
                        }
                    })
                    {
                        Image(systemName: "square.and.arrow.down")
                            .font(.system(size: 80))
                            .foregroundColor(todoDato() ? Color.green : Color.green.opacity(0.4))
                    }
                    .buttonStyle(ConditionalButtonStyle(isEnabled: todoDato()))
                    
                    NavigationLink(destination: Listado())
                    {
                        Image(systemName: "list.bullet.rectangle")
                            .font(.system(size: 80))
                            .foregroundColor(true ? Color.blue : Color.blue.opacity(0.4))
                    }
                    
                    Button(action:
                    {
                        withAnimation(.spring())
                        {
                            nombre = ""
                            cumReal = nil
                        }
                    })
                    {
                        Image(systemName: "trash.square")
                            .font(.system(size: 80))
                            .foregroundColor(algunDato() ? Color.red : Color.red.opacity(0.4))
                    }
                    .buttonStyle(ConditionalButtonStyle(isEnabled: algunDato()))
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview
{
    ContentView()
}
