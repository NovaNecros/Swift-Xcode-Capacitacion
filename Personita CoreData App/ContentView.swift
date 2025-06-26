import SwiftUI

struct ContentView : View
{
    let coreDM = CoreDataManager()
    
    @State private var nombre : String = ""
    @State private var cumNullable : Date? = nil
    
    private var cum : Date = Date()
    private var cumBinding : Binding<Date>
    {
        Binding<Date>(
            get: { cumNullable ?? cum },
            set: { fecha in cumNullable = fecha }
        )
    }
    
    func algunDato() -> Bool
    {
        return !nombre.isEmpty || cumNullable != nil
    }
    func todoDato() -> Bool
    {
        return !nombre.isEmpty && cumNullable != nil
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
                            .foregroundColor(.pink)
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
                            .foregroundColor(.pink)
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
                    .padding(.leading, 20)
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 15)
                {
                    Button(action:
                    {
                        withAnimation(.spring())
                        {
                            if(todoDato())
                            {
                                coreDM.guardar(nombre: nombre, cum: cum)
                                nombre = ""
                                cumNullable = nil
                            }
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
                            cumNullable = nil
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
