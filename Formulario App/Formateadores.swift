import Foundation

extension DateFormatter
{
    static let isoDate : DateFormatter =
    {
        let formatter = DateFormatter()
        
        formatter.locale    = Locale(identifier: "en_US_POSIX")
        formatter.calendar  = Calendar(identifier: .gregorian)
        formatter.timeZone  = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        
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

extension String
{
    func validEmail() -> Bool
    {
        let patron = "[A-Z0-9-a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", patron).evaluate(with: self)
    }
}
