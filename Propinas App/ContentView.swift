import SwiftUI

struct ContentView : View
{
    @State private var monto : Double = 30
    @State private var porcentaje : Double = 10.0
    
    var total : Double
    {
        return monto * (1 + porcentaje / 100)
    }
    
    var body : some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            HStack(alignment: .center, spacing: 20)
            {
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(Color.orange)
                
                Text("Propinatron 5000")
                    .font(.title)
            }
            .padding(.top, 10)
            
            Spacer()
            
            TextField("Monto", value: $monto, format: .currency(code: "MXN"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal, 50)
                .padding(.bottom, 20)
            
            HStack(alignment: .center, spacing: 20)
            {
                Text("Propina: \(porcentaje, specifier: "%.0f")%")
                    .font(.body)
                
                Slider(value: $porcentaje, in: 0...50, step: 1)
                    .padding([.leading, .trailing], 10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Text("Total: $\(total, specifier: "%.2f")")
                .font(.title)
                .frame(minWidth: 250, minHeight: 50)
                .foregroundColor(Color.white)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(Color.orange.opacity(0.8)))
                .shadow(color: Color.orange.opacity(0.6), radius: 5, x: 2, y: 2)
                .padding(.vertical, 10)
                
            
        }
        .padding()
        
    }
}

#Preview
{
    ContentView()
}
