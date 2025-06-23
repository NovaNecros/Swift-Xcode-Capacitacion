import SwiftUI

struct ContentView : View
{
    @State private var mostrarFormulario : Bool = true
    @State private var fechaSeleccionada : Bool = false
    @State private var correoValido : Bool = true
    @State private var telefonoValido : Bool = true
    
    @State private var nombre : String = ""
    @State private var apellidoP : String = ""
    @State private var apellidoM : String = ""
    @State private var correo : String = ""
    @State private var telefono : String = ""
    @State private var fecha : Date = Date()
    @State private var personita = Usuario()
    
    var body : some View
    {
        VStack
        {
            Text("Registro")
                .font(.largeTitle)
                .bold()
                .padding(.top, 10)
            
            Spacer()
            
            if mostrarFormulario
            {
            
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("Nombre*")
                        .font(.headline)
                    
                    TextField("", text: $nombre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("Apellido Paterno*")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    TextField("", text: $apellidoP)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("Apellido Materno")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    TextField("", text: $apellidoM)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("Fecha de Nacimiento*")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    DatePicker("",
                               selection: $fecha,
                               displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .onChange(of: fecha,
                    {
                        fechaSeleccionada = true
                    })
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black.opacity(0.5), lineWidth: 1))
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("Correo Electrónico*")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    TextField("", text: $correo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(correoValido ? Color.green : Color.red, lineWidth: 1))
                        .onChange(of: correo,
                        {
                            correoValido = correo.isEmpty || correo.validEmail()
                        })
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("Teléfono")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    TextField("", text: $telefono)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(telefonoValido ? Color.green : Color.red, lineWidth: 1))
                        .onChange(of: telefono, perform:
                        { nuevo in
                            let numeros = nuevo.filter { $0.isNumber }
                            let limitado = String(numeros.prefix(10))
                            if telefono != limitado
                            {
                                telefono = limitado
                            }
                            
                            telefonoValido = limitado.isEmpty || limitado.count == 10
                        })
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 60)
                {
                    Button(action:
                    {
                        withAnimation(.spring())
                        {
                            if validarUsuario()
                            {
                                personita = Usuario(nombre: nombre, apellidoP: apellidoP, apellidoM: apellidoM, fecha: fecha, correo: correo, telefono: telefono)
                                
                                mostrarFormulario = false
                            }
                        }
                    })
                    {
                        Text("Enviar")
                            .font(.headline)
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.green.opacity(0.15)))
                            .shadow(color: Color.green.opacity(0.4), radius: 8, x: 0, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical)
                    
                    Button(action:
                    {
                        withAnimation(.spring())
                        {
                            eliminarUsuario()
                        }
                    })
                    {
                        Text("Limpiar \nDatos")
                            .font(.headline)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.red.opacity(0.15)))
                            .shadow(color: Color.red.opacity(0.4), radius: 8, x: 0, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical)
                }
                .padding()
            }
            else
            {
                Text("\(personita.description)")
                    .font(.title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .transition(.opacity)
                
                Spacer()
                
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        eliminarUsuario()
                    }
                })
                {
                    Text("Volver")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue.opacity(0.15)))
                        .shadow(color: Color.blue.opacity(0.4), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
            }
        }
        .padding()
    }
    
    func eliminarUsuario()
    {
        personita = Usuario()
        nombre = ""
        apellidoP = ""
        apellidoM = ""
        fecha = Date()
        correo = ""
        telefono = ""
        
        mostrarFormulario = true
        fechaSeleccionada = false
    }
    
    func validarUsuario() -> Bool
    {
        return !nombre.isEmpty &&
        !apellidoP.isEmpty &&
        fechaSeleccionada &&
        correoValido && !correo.isEmpty
    }
}

#Preview
{
    ContentView()
}
