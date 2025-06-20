import SwiftUI

struct ContentView : View
{
    @State private var coche = AutoViewModel()
    @State private var mostrarBotones : Bool = false
    @State private var mostrarCoche : Bool = false
    @State private var modelo : String = ""
    @State private var marca : String = ""
    
    private let distancias : [Int] = [1, 2, 5, 10, 20, 50]
    @State private var distancia : Int = 1
    
    var body : some View
    {
        VStack(spacing : 20)
        {
            Text("Coche")
                .font(.title)
                .bold()
                .padding(.top, 40)
            
            if mostrarBotones
            {
                HStack(spacing: 20)
                {
                    Button(action:
                    {
                        withAnimation(.spring())
                        {
                            mostrarCoche = false
                            coche.avanzar(km: distancia)
                            mostrarCoche = true
                        }
                    })
                    {
                        Text("Avanzar")
                            .font(.headline)
                            .foregroundColor(.pink)
                            .padding()
                    }
                    .buttonStyle(.bordered)
                    
                    Picker("\(distancia)", selection: $distancia)
                    {
                        ForEach(distancias, id: \.self)
                        { km in
                            Text("\(km) km").tag(km)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 100)
                    .clipped()
                }
                .padding()
                
                
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        mostrarBotones = false
                        mostrarCoche = false
                        coche.borrar()
                        marca = ""
                        modelo = ""
                    }
                })
                {
                    Text("Borrar")
                        .font(.headline)
                        .foregroundColor(.pink)
                        .padding()
                }
                .buttonStyle(.bordered)
                
                if mostrarCoche
                {
                    Spacer()
                    
                    Text(coche.description)
                        .font(.body)
                        .foregroundColor(.blue)
                        .padding(.vertical, 10)
                        .transition(.opacity)
                }
            }
            else
            {
                VStack(alignment : .leading, spacing: 5)
                {
                    Text("Marca")
                        .font(.headline)
                    TextField("", text: $marca)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 5)
                {
                    Text("Modelo")
                        .font(.headline)
                    TextField("", text: $modelo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        if !marca.isEmpty && !modelo.isEmpty
                        {
                            mostrarBotones = true
                            mostrarCoche = true
                            coche.guardar(marca: marca, modelo: modelo)
                            marca = ""
                            modelo = ""
                        }
                    }
                })
                {
                    Text("Guardar")
                        .font(.headline)
                        .foregroundColor(.pink)
                        .padding()
                }
                .buttonStyle(.bordered)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview
{
    ContentView()
}
