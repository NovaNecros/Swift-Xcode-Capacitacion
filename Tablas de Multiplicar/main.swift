import Foundation

print("Base:")

let base : Int! = Int(readLine() ?? "10")

for i in 1...base
{
    for j in 1...base
    {
        print(String(i*j, radix : base).uppercased(), terminator: "\t")
    }
    print()
}
