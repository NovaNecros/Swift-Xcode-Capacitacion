import SwiftUI

struct ContentView : View
{
    let n : Int = 3
    
    @State private var opcion : Int = 0
    @State private var fechas : [Date] = Array(repeating: Date(), count: 3)
    
    let colores : [Color] = [.green, .yellow, .red]

    private var dateFormatter : DateFormatter
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        return formatter
    }
        
    var body : some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            HStack(alignment: .center, spacing: 20)
            {
                Text("Errm, ackshually")
                    .font(.title)
                
                Image(systemName: "hand.point.up.fill")
                    .font(.system(size: 32))
                    .foregroundColor(colores[opcion])
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 2, y: 2)
            }
            .padding(.top, 10)
            
            Picker(selection: $opcion, label: Text(""))
            {
                ForEach(0..<n)
                {
                    Text("Opción \($0+1)")
                        .tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.top, 40)
            .pickerStyle(SegmentedPickerStyle())
            
            if opcion >= 0 && opcion < n
            {
                HStack(alignment: .center, spacing: 0)
                {
                    Image(systemName: "clock.fill")
                        .imageScale(.large)
                        .foregroundColor(colores[opcion])
                    
                    Text("Opción \(opcion+1)")
                        .padding()
                }
                .padding(.top, 80)
                
                DatePicker(
                    "",
                    selection: $fechas[opcion],
                    displayedComponents: .date
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding(.horizontal)
                .padding(.top, 40)
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 30)
            {
                Text("\(dateFormatter.string(from: fechas[opcion]))")
                    .font(.title2)
                    .frame(minWidth: 250, minHeight: 40)
                    .foregroundColor(Color.black)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(colores[opcion].opacity(0.4)))
                    .shadow(color: colores[opcion].opacity(0.8), radius: 3, x:4, y:2)
                
                Button(action:
                {
                    for i in 0..<n
                    {
                        fechas[i] = Date()
                    }
                    
                    opcion = 0
                })
                {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(colores[opcion].opacity(0.6))
                        .rotationEffect(.init(degrees: 45))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .padding()
    }
}

#Preview
{
    ContentView()
}
