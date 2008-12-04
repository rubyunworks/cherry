
import libxml2
import urllib2

f = urllib2.urlopen("http://www.w3c.org/")
DOC = f.read()

for x in range(10):
  doc = libxml2.parseDoc(DOC)

