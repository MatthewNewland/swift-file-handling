print("readLine() test:\n\n")
let ihandle = try! FileHandle(path: "./main.swift", mode: .ReadOnly)
while let line = ihandle.readLine() {
    print(line)
}
ihandle.close()

print("\n\nread(bytes:) test:\n\n")
let ihandle2 = try! FileHandle(path: "./main.swift", mode: .ReadOnly)
let data = ihandle2.read(bytes: 22)
print(data)
ihandle2.close()

print("\n\nwriteLine(_:) test\n\n")
let ohandle = try! FileHandle(path: "./test.txt", mode: .WriteOnly)
print("Got here")
for line in [
        "Hello",
        "My name is",
        "Bob"] {
    ohandle.writeLine(line)
}

ohandle.close()

let ihandle3 = try! FileHandle(path: "./test.txt", mode: .ReadOnly)
for line in ihandle3.lines {
    print(line)
}

for line in FileHandle.stdin.lines {
    print(line)
}

