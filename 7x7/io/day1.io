"Io Language Day 1 Self Study from Seven Languages in Seven weeks" println
"===Start===" println

# Io Example Problems
# http://iolanguage.org/scm/io/docs/IoTutorial.html
# http://en.wikibooks.org/wiki/Programming:Io
# http://ozone.wordpress.com/2006/03/15/blame-it-on-io/


# Io Community that will answer questions
# http://stackoverflow.com/questions/tagged/iolanguage
# http://groups.yahoo.com/neo/groups/iolanguage/info

# Io Style Guide with Io idioms
# http://iolanguage.org/scm/io/docs/IoGuide.html

"Evaluate 1+1" println
1 + 1 print
"" println

"Evaluate 1+\"1\"" println
e := try(1+"1")
e println
"Strong type as it generates an exception" println

if (0 and true,"0 is true" println,"0 is false" println)
if ("" and true,"empty string is true" println,"empty string is false" println)
if (nil and true,"nil is true" println,"nil is false" println)

"===End===" println
