import Glibc


public class FileHandle {

    public enum Mode {
        case ReadOnly
        case WriteOnly
        case Append
    }

    private let path: String
    private let mode: Mode
    private let fd: UnsafeMutablePointer<FILE>

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
        self.path = path
        self.fd = fopen(path, FileHandle.cmodeFromMode(mode: mode))
        self.mode = mode
    }

    public func readLine(stripNewlines: Bool = true) -> String? {
        func stripNewline(_ str: inout String) {
            if str.characters.last! == "\n" { 
                str.characters = str.characters[str.characters.startIndex..<str.characters.endIndex.predecessor()]
            }
        }
        var input: UnsafeMutablePointer<Int8>?
        var lim = 0
        let read = getline(&input, &lim, fd)
        defer { input!.deallocateCapacity(1) } 
        if read > 0 {
            var result = String(cString: input!)
            if stripNewlines{
                stripNewline(&result)
            }
            return result
        } else {
            return nil
        }
    }
}

