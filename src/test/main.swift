let ihandle = try! FileHandle(path: "./main.swift", mode: .ReadOnly)
while let line = ihandle.readLine() {
    print(line)
}
ihandle.close()

let ihandle2 = try! FileHandle(path: "./main.swift", mode: .ReadOnly)
let data = ihandle2.read(bytes: 22)
print(data)
ihandle2.close()

let ohandle = try! FileHandle(path: "./test.txt", mode: .WriteOnly)
print("Got here")
for line in [
        "Hello\n",
        "My name is\n",
        "Bob\n"] {
    ohandle.writeLine(line)
}

ohandle.close()
