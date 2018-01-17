import csv
import os

import xlwt

book = xlwt.Workbook()
sh = book.add_sheet('raw')

files = os.listdir('.')

files = filter( lambda x: x.startswith('terms-') and x.endswith('.csv'), files )

for i, k in enumerate( files ):

    print k

    d = csv.DictReader( open(k, 'r') )

    for j, row in enumerate( d ):

        print k, j, row

        terms = []

        for a in range(1, 11):

            a = 'V' + str(a)

            terms.append( row[a] )

        ##

        terms = sorted( terms )

        text = ','.join( terms ) + ' '  + row['']
        text = text.decode('utf8')

        sh.write(j, i, text)

book.save('terms_all.xls')
