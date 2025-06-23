import SwiftUI

struct ContentView : View
{
    @State private var fechaHora : Date = Date()
    @State private var mostrarCalendario : Bool = true
    
    var body : some View
    {
        VStack(alignment: .center, spacing: 20)
        {
            Text("Fecha y Hora")
                .font(.largeTitle)
                .padding(.top, 10)
            
            Spacer()
            
            if mostrarCalendario
            {
                DatePicker(
                    "",
                    selection: $fechaHora,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black.opacity(0.5))
                )
                        
                Spacer()
                
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        mostrarCalendario = false
                    }
                })
                {
                    Text("Mostrar Fecha")
                        .font(.headline)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .frame(minWidth: 200, minHeight: 50)
                        .foregroundColor(.blue)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.2)))
                        .shadow(color: Color.blue.opacity(0.2), radius: 8, x: 3, y: 2)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 20)
            }
            else
            {
                Text(fechaHora.isoString)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.top, 4)
                
                Spacer()
                
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        mostrarCalendario = true
                    }
                })
                {
                    Text("Limpiar")
                        .font(.headline)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .frame(minWidth: 200, minHeight: 50)
                        .foregroundColor(.red)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red.opacity(0.2))
                            .shadow(color: Color.red.opacity(0.1), radius: 2, x: 3, y: 2))
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 20)
            }
        }
        .padding()
    }
}

#Preview
{
    ContentView()
}
