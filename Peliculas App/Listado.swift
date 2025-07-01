import SwiftUI
import CoreData

struct Listado : View
{
    @Environment(\.dismiss) private var dismiss
    
    @State private var peliculas = [Pelicula]()
    @State private var selected : Pelicula? = nil
    @State private var key : String = ""
    @State private var order : Bool = true
    
    private var cdm = CoreDataManager()
    
    var body : some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            tituloPantalla
                .padding([.horizontal, .top])
            
            Spacer()
            
            List()
            {
                Section(header: encabezado)
                {
                    ForEach(peliculas)
                    { (peli : Pelicula) in
                        PeliculaRow(peli: peli, isSelected: peli == selected)
                            .contentShape(Rectangle())
                            .onTapGesture()
                            {
                                withAnimation(.spring())
                                {
                                    selected = peli
                                }
                            }
                    }
                }
                .listStyle(.insetGrouped)
                .onAppear()
                {
                    withAnimation(.spring())
                    {
                        peliculas = cdm.leer()
                    }
                }
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 30)
            {
                Button(action:
                {
                    withAnimation(.spring())
                    {
                        dismiss()
                    }
                })
                {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .rotationEffect(Angle(degrees: 180))
                        .font(.system(size: 55))
                        .foregroundStyle(Color.blue)
                }
                .buttonStyle(PlainButtonStyle())

                
                Button(
                    role: .destructive,
                    action: borrar
                )
                {
                    Image(systemName: "minus.circle.fill")
                        .rotationEffect(Angle(degrees: 180))
                        .font(.system(size: 60))
                        .foregroundStyle(Color.red.opacity(selected == nil ? 0.4 : 1))
                }
                .buttonStyle(ConditionalButtonStyle(isEnabled: selected != nil))
            }
            .padding([.horizontal, .bottom])
        }
        .padding()
        .navigationBarBackButtonHidden(true)
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
    
    private var encabezado : some View
    {
        HStack()
        {
            Text("Nombre")
                .frame(width: 120)
                .multilineTextAlignment(.leading)
                .onTapGesture()
                {
                    reorder(key: "nombre")
                }
            
            Text("ID")
                .frame(width: 100)
                .multilineTextAlignment(.center)
                .onTapGesture()
                {
                    withAnimation(.spring())
                    {
                        if key == "id"
                        {
                            order.toggle()
                        }
                        else
                        {
                            key = "id"
                            order = true
                        }
                        
                        peliculas = cdm.leer(key: key, order: order)
                    }
                }
            
            Spacer()
            
            Text("Rating")
                .multilineTextAlignment(.trailing)
                .onTapGesture()
                {
                    reorder(key: "rating")
                }
        }
    }
    
    private func borrar()
    {
        guard let peli = selected else { return }
        
        withAnimation(.spring())
        {
            cdm.borrar(peli)
            peliculas = cdm.leer(key: key, order: order)
            selected = nil
        }
    }
    
    private func reorder(key : String)
    {
        withAnimation(.spring())
        {
            if self.key == key
            {
                order.toggle()
            }
            else
            {
                self.key = key
                order = true
            }
            
            peliculas = cdm.leer(key: key, order: order)
        }
    }
}

#Preview
{
    Listado()
}

