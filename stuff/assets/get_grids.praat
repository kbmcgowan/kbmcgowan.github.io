# this simple script:
#    WARNING!!! clears the praat object window
#       -- this is a bug and I should fix it, sorry.
#
#    prompts the user for runtime information
#    walks through all sound files in a given directory
#         opens a related textgrid, if it exists or
#         creates one if it does not
#    returns control to the user
#
# ASSUMPTION: textgrid and snd files are named in the form:
#                   FileName.snd and FileName.TextGrid
# where 'FileName' is the base filename common between them and
# 'snd' is the appropriate sound extension.
#
# Kevin McGowan <clunis@umich.edu>
# February 2008

# first remove any objects from the object window
select all
if numberOfSelected() > 0
    Remove
endif

# change these as needed
form Open or Create TextGrids for sound files
    sentence Type    wav
    sentence Directory /Users/clunis/Desktop/QRP/airflow/
    sentence Tiers V L
    sentence Extension wav
endform

# get a list of all sound files in the given Directory
Create Strings as file list... files 'directory$'/'type$'/*.'extension$'
n = Get number of strings
old = 0
new = 0
printline 'n' files in 'directory$'/'type$'

# step through the list of files
for i to n
    select Strings files
    fileName$ = Get string... i
    file$ = fileName$ - ".'extension$'"

    snd$ = "'directory$'/'type$'/'file$'.'extension$'"
    grid$ = "'directory$'/'type$'/'file$'.TextGrid"

#    Open long sound file... 'snd$'
    Read from file... 'snd$'

    if fileReadable ( grid$ )
        # open the textgrid file if it exists and is readable
        old = old + 1
        Read from file... 'grid$'
    else
        # otherwise, create the textgrid file 
        new = new + 1
        To TextGrid... "'tiers$'"
        Write to text file... 'grid$'
    endif
endfor

printline opened 'old' TextGrids and created 'new'
# we don't need the list of files anymore
select Strings files
Remove

