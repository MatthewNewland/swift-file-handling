import Glibc

extension String {
    var withTrimmedNewline: String {
        if characters.last! == "\n" {
            var result = self
            result.characters = result.characters.dropLast(1)
            return result
        } else {
            return self
        }
    }
}

public struct FileHandle {
    
    public static var stdin = FileHandle(filePointer: Glibc.stdin)
    public static var stdout = FileHandle(filePointer: Glibc.stdout)
    public static var stderr = FileHandle(filePointer: Glibc.stderr)

    public enum Mode {
        case ReadOnly
        case WriteOnly
        case Append
    }

    private var fp: UnsafeMutablePointer<FILE>

    private static func cmodeFromMode(mode: Mode) -> String {
        switch mode {
        case .ReadOnly:
            return "r"
        case .WriteOnly:
            return "w"
        case .Append:
            return "a"
        }
    }

    public init(path: String, mode: FileHandle.Mode) throws {
        self.fp = fopen(path, FileHandle.cmodeFromMode(mode: mode))
    }

    public init(filePointer: UnsafeMutablePointer<FILE>) {
        self.fp = filePointer
    }

    public func readLine(stripNewlines: Bool = true) -> String? {
        var input: UnsafeMutablePointer<Int8>?
        var lim = 0
        let read = getline(&input, &lim, fp)
        defer { input!.deallocateCapacity(lim) } 
        if read > 0 {
            var result = String(cString: input!)
            if stripNewlines{
                result = result.withTrimmedNewline 
            }
            return result
        } else {
            return nil
        }
    }

    public func read(bytes: Int = 1) -> String {
        var input = UnsafeMutablePointer<Int8>(allocatingCapacity: bytes + 1)
        defer { input.deallocateCapacity(bytes + 1) }
        fread(input, 1, bytes, fp)
        input[bytes] = 0  // Set to 0 so that String(cString:) doesn't fail when it calls strlen().
        let result = String(cString: input)
        return result
    }

    public func close() {
        fclose(self.fp)
    }

    public func write(data: String) {
        let length = data.utf8.count
        fwrite(data, 1, length, fp)
    }

    public func writeLine(_ line: String) {
        write(data: line)
        if line.characters.last! != "\n" {
            write(data: "\n")
        }
    }

    public var lines: AnyIterator<String> {
        return AnyIterator {
            return self.readLine()
        }
    }
}

