File file = new File("/root/out.txt")
file.write('''
A
Multiline 
Text
That you can use in a groovy script
''')
file.append("appended line at the end\n")
println file.text