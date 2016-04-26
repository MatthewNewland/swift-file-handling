let ihandle = try! FileHandle(path: "./main.swift", mode: .ReadOnly)
while let line = ihandle.readLine() {
    print(line)
}
ihandle.close()

let ohandle = try! FileHandle(path: "./test.txt", mode: .WriteOnly)
for line in [
        "Hello\n",
        "My name is\n",
        "Bob\n"] {
    ohandle.write(data: line)
}

ohandle.close()
