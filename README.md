## installation:

1. download the latest released `h5parser.mltbx` file
2. open MATLAB and drag the downloaded file to whereever your current folder is opened in MATLAB
3. double click on the toolbox
4. profit

## usage:
---
`parse('name_of_h5_file.h5')`
`parseTable('name_of_h5_file.h5')`

OR

`parse('name_of_h5_file.h5', true)`
`parseTable('name_of_h5_file.h5', true)`

for safer (but slower parsing) if there exists intermittent data throughout the file and not all data exists at all points in time
___

`parse('name_of_h5_file.h5')`

Parses into a struct with a Data and Timestamp field

---

`parseTable('name_of_h5_file.h5')`

Parses into a Table with a Data and Timestamp field (Christine reccommends this)

---
`parseAsDouble('name_of_h5_file.h5')`

Parses into a struct with a Data and Timestamp field, ALL numeric values are parsed to Double

---
`parseTableAsDouble('name_of_h5_file.h5')`

Parses into a Table with a Data and Timestamp field, ALL numeric values are parsed to Double 
