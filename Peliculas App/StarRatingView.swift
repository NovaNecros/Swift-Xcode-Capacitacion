import SwiftUI

struct StarRatingView : View
{    
    @Binding public var rating : Int
    @State public var n : Int
    @State public var size : Double
    @State public var spacing : Double
    @State public var editable : Bool
    
    init(rating : Binding<Int> = .constant(-1), n : Int = 5, size : Double = 32, spacing : Double = 8, editable : Bool = true)
    {
        self._rating = rating
        self.n = n
        self.size = size
        self.spacing = spacing
        self.editable = editable
    }
    
    var body : some View
    {
        HStack(spacing: spacing)
        {
            ForEach(1...n, id: \.self)
            { idx in
                Image(systemName: idx <= rating ? "star.fill" : "star")
                    .font(.system(size: size))
                    .foregroundColor(idx <= rating ? .yellow : .gray)
                    .onTapGesture
                    {
                        if editable
                        {
                            withAnimation(.easeInOut)
                            {
                                rating = idx
                            }
                        }
                    }
            }
        }
    }
}
