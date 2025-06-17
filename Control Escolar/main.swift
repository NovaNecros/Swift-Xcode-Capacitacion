import Foundation

let electro : Materia = Materia(id : 1, nombre : "Electromagnetismo")
let desarrollo : Materia = Materia(id : 2, nombre : "Desarrollo de Aplicaciones")
let geometria : Materia = Materia(id : 3, nombre : "Geometria Diferencial")
let materias : [Materia] = [electro, desarrollo, geometria]

let abi : Alumno = Alumno(id : 1, nombre : "abi")
let morgan : Alumno = Alumno(id : 2, nombre : "Morgan")
let mar : Alumno = Alumno(id : 3, nombre : "Mariana")
let jessi : Alumno = Alumno(id : 4, nombre : "Jessica")

electro.inscribir(alumno : morgan)
electro.inscribir(alumno : mar)
desarrollo.inscribir(alumno : abi)
desarrollo.inscribir(alumno : mar)
desarrollo.inscribir(alumno : morgan)
geometria.inscribir(alumno : morgan)
geometria.inscribir(alumno : jessi)

electro.calificar(alumno : morgan, cali: 10)
electro.calificar(alumno : mar, cali: 9)
desarrollo.calificar(alumno : abi, cali: 8)
desarrollo.calificar(alumno : mar, cali: 9)
desarrollo.calificar(alumno : morgan, cali: 10)
geometria.calificar(alumno : morgan, cali: 10)
geometria.calificar(alumno : jessi, cali: 7)

print(abi)
print(morgan)
print(mar)
print(jessi)
print()

print("\(electro) \nPromedio:\t\(electro.promedio)\n")
print("\(desarrollo) \nPromedio:\t\(desarrollo.promedio)\n")
print("\(geometria) \nPromedio:\t\(geometria.promedio)\n")
print()
