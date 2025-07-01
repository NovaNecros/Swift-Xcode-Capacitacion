import SwiftUI

struct ContentView : View
{
    let cdm = CoreDataManager()
    
    @State private var titulo : String
    @State private var director : String
    @State private var duracion : String
    @State private var rating : Int
    
    init()
    {
        self.titulo = ""
        self.director = ""
        self.duracion = ""
        self.rating = -1
    }
    
    init(peli : Pelicula)
    {
        self.titulo = peli.titulo ?? ""
        self.director = peli.director ?? ""
        self.duracion = String(peli.duracion)
        self.rating = Int(peli.rating)
    }
    
    var body : some View
    {
        NavigationStack()
        {
            VStack(alignment: .center, spacing: 0)
            {
                tituloPantalla
                    .padding([.horizontal, .top])
                
                Spacer()
                
                VStack(alignment: .center, spacing: 32)
                {
                    TextField("Nombre de la película", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 24)
                    
                    TextField("Director", text: $director)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 24)
                    
                    TextField("Duración (minutos)", text: $duracion)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 24)
                    
                    StarRatingView(rating: $rating, size: 32, spacing: 8)
                        .padding(.horizontal,24)
                        .padding(.top)
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 30)
                {
                    Button(action:
                    {
                        if todoDato()
                        {
                            withAnimation(.spring())
                            {
                                cdm.guardar(titulo: titulo, director: director, duracion: Int(duracion) ?? 0, rating: rating)
                                
                                limpiarDatos()
                            }
                        }
                    })
                    {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(todoDato() ? Color.green : Color.green.opacity(0.4))
                    }
                    .buttonStyle(ConditionalButtonStyle(isEnabled: todoDato()))
                    
                    NavigationLink(destination: Listado())
                    {
                        Image(systemName: "list.bullet.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(Color.blue)
                    }
                    
                    Button(action:
                    {
                        withAnimation(.spring())
                        {
                            limpiarDatos()
                        }
                    })
                    {
                        Image(systemName: "toilet.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(algunDato() ? Color.red : Color.red.opacity(0.4))
                    }
                    .buttonStyle(ConditionalButtonStyle(isEnabled: algunDato()))
                }
                .padding([.horizontal, .bottom])
            }
            .padding()
        }
    }
    
    private var tituloPantalla : some View
    {
        HStack()
        {
            Image(systemName: "movieclapper.fill")
                .font(.system(size: 24))
                .foregroundColor(Color.red)
            
            Text("Letterboxd at Home")
                .font(.title2)
                .bold()
                .padding(.horizontal)
            
            Image(systemName: "popcorn.fill")
                .font(.system(size: 24))
                .foregroundColor(.yellow)
        }
    }
    
    func limpiarDatos()
    {
        self.titulo = ""
        self.director = ""
        self.duracion = ""
        self.rating = -1
    }
    
    func algunDato() -> Bool
    {
        return !titulo.isEmpty || !director.isEmpty || !duracion.isEmpty || rating > 0
    }
    
    func todoDato() -> Bool
    {
        return !titulo.isEmpty && !director.isEmpty && !duracion.isEmpty && rating > 0
    }
}

#Preview
{
    ContentView()
}
