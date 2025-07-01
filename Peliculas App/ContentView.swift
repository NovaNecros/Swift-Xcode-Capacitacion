import SwiftUI

struct ContentView : View
{
    let cdm = CoreDataManager()
    let generos : [String] = ["Acción", "Comedia", "Ciencia Ficción", "Fantasía", "Romance", "Terror"]
    let clasificaciones : [String] = ["AA", "A", "B", "B15", "C"]
    
    @State private var titulo : String
    @State private var director : String
    @State private var genero : String
    @State private var clasificacion : String
    @State private var duracion : Double
    @State private var estrenoReal : Date?
    @State private var rating : Int
    
    private var estrenoFalso : Date = Date()
    private var estrenoBinding : Binding<Date>
    {
        Binding<Date>(
            get: { estrenoReal ?? estrenoFalso },
            set: { fecha in estrenoReal = fecha }
        )
    }
    
    private var fechaFormatter : Date.FormatStyle
    {
        Date.FormatStyle()
            .year(.defaultDigits)
            .month(.abbreviated)
            .day(.twoDigits)
    }
    
    init()
    {
        self.titulo = ""
        self.director = ""
        self.genero = ""
        self.clasificacion = ""
        self.duracion = 0.0
        self.estrenoReal = nil
        self.rating = -1
    }
    
    init(peli : Pelicula)
    {
        self.titulo = peli.titulo ?? ""
        self.director = peli.director ?? ""
        self.genero = peli.genero ?? ""
        self.clasificacion = peli.clasificacion ?? ""
        self.duracion = Double(peli.duracion)
        self.estrenoReal = peli.estreno
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
                
                VStack(alignment: .center, spacing: 24)
                {
                    TextField("Nombre de la película", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                    
                    TextField("Director", text: $director)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                    
                    Picker(
                        selection: $genero,
                        label: Text("Género")
                    )
                    {
                        ForEach(generos, id: \.self)
                        { g in
                            Text("\(g)")
                        }
                    }
                    .pickerStyle(PalettePickerStyle())
                    
                    Picker(
                        selection: $clasificacion,
                        label: Text("Clasificación")
                    )
                    {
                        ForEach(clasificaciones, id: \.self)
                        { c in
                            Text("\(c)")
                        }
                    }
                    .pickerStyle(PalettePickerStyle())
                    .padding(.vertical, 16)
                    
                    Text("Duración: \(duracion, specifier: "%.0f") minutos")
                        .font(.system(size: 18))
                    
                    Slider(
                        value: $duracion,
                        in: 0...300,
                        step: 1
                    )
                    .padding(.horizontal, 16)
                    
                    HStack(alignment: .center, spacing: 0)
                    {
                        Text("Fecha de estreno:")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.leading)
                        
                        DatePicker(
                            "",
                            selection: estrenoBinding,
                            displayedComponents: .date
                        )
                        .datePickerStyle(CompactDatePickerStyle())
                            
                    }
                    
                    StarRatingView(rating: $rating, size: 32, spacing: 8)
                        .padding(.top)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 30)
                {
                    Button(action:
                    {
                        if todoDato()
                        {
                            withAnimation(.spring())
                            {
                                cdm.guardar(titulo: titulo, director: director, genero: genero, clasificacion: clasificacion, duracion: duracion, estreno: estrenoReal!, rating: rating)
                                
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
        self.genero = ""
        self.clasificacion = ""
        self.duracion = 0.0
        self.estrenoReal = nil
        self.rating = -1
    }
    
    func algunDato() -> Bool
    {
        return !titulo.isEmpty ||
        !director.isEmpty ||
        !genero.isEmpty ||
        !clasificacion.isEmpty ||
        duracion > 0 ||
        estrenoReal != nil ||
        rating > 0
    }
    
    func todoDato() -> Bool
    {
        return !titulo.isEmpty &&
        !director.isEmpty &&
        !genero.isEmpty &&
        !clasificacion.isEmpty &&
        duracion > 0 &&
        estrenoReal != nil &&
        rating > 0
    }
}

#Preview
{
    ContentView()
}
