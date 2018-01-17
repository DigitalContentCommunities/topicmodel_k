import xlrd
book = xlrd.open_workbook("terms_all.xls")

sh = book.sheet_by_index(0)

import itertools

## magic happens

mapper = [
    [],
    [None] * 25,
    [None] * 28,
    [None] * 33,
    [None] * 34
 ]

for c in range( 1, 5):
    for r in range( sh.nrows ):

        topic = sh.cell_value(rowx=r, colx=c)
        if 'Topic' in topic:
            topic = int( topic.split('Topic')[1] ) - 1 ## python indexing
            label = sh.cell_value(rowx=r, colx=0)

            mapper[c][topic] = r ## label these by row IDs to ensure uniformity

print "topics <- list()"

for entry in mapper:
    entry = map( str, entry )
    print "topics[[", len( entry ), "]] = c(", ','.join( entry ) , ")"
