import SwiftUI

struct Listado : View
{
    let coreDM = CoreDataManager()
    let personitas : [Persona]
    
    init()
    {
        personitas = coreDM.leerTodas()
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body : some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            ScrollView()
            {
                LazyVStack(alignment: .leading, spacing: 20)
                {
                    ForEach(0..<personitas.count)
                    { i in
                        Text("\(personitas[i].nombre ?? ":(")")
                            .font(.headline)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.1)))
                            .padding()
                    }
                }
                .padding()
            }
            
            Spacer()
            
            Button(action:
            {
                withAnimation(.spring())
                {
                    dismiss()
                }
            })
            {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.system(size: 100))
                    .rotationEffect(.init(degrees: 45))
                    .foregroundColor(Color.blue.opacity(0.85))
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview
{
    Listado()
}
