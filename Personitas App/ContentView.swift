import SwiftUI

struct ContentView : View
{
    @State private var mostrarPersonita : Bool = false
    @State private var nombre : String = ""
    @State private var edad : String = ""
    @State private var personita = Personita()
    
    var body : some View
    {
        VStack
        {
            Text("Personita")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            
            Spacer()
            
            if mostrarPersonita
            {
                Text("\(personita.description)")
                    .font(.body)
                    .foregroundColor(.green)
                    .padding(.top, 10)
                    .transition(.opacity)
                
                Spacer()
                
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        mostrarPersonita = false
                        personita = Personita()
                    }
                })
                {
                    Text("Desvivir >:)")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color.pink.opacity(0.05)))
                        .shadow(color: Color.pink.opacity(0.8), radius: 3, x:6, y:2)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical)
            }
            else
            {
                VStack(alignment: .leading, spacing: 5)
                {
                    Text("Nombre")
                        .font(.headline)
                    
                    TextField("", text: $nombre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 5)
                {
                    Text("Edad")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    TextField("", text: $edad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        if !edad.isEmpty && !nombre.isEmpty
                        {
                            personita = Personita(nombre: nombre, edad: Int(edad) ?? -1)
                            mostrarPersonita = true
                            nombre = ""
                            edad = ""
                        }
                    }
                })
                {
                    Text("Saludar")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.pink.opacity(0.05)))
                        .shadow(color: Color.pink.opacity(0.4), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical)
            }
            
        }
        .padding()
        
        Spacer()
    }
}

#Preview
{
    ContentView()
}
