import Foundation

extension DateFormatter
{
    static let isoDate : DateFormatter =
    {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "es_ES")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "EEEE dd '\n' MMMM YYYY '\n'HH:mm"
        
        return formatter
    }()
}

extension Date
{
    var isoString : String
    {
        DateFormatter.isoDate.string(from: self)
    }
}
