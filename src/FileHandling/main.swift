var lineNo = 1
for line in FileUtils.iterateFileByLine(#file) {
    print("Line \(lineNo): line")
    lineNo += 1
}
