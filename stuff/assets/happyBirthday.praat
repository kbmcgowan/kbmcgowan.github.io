# plays a little song.  could surely be improved.
# 16 July 2013, Kevin B. McGowan <kbmcgowan@stanford.edu>

song$ = "196.00, 196.00, 220.0, 196.00, 261.63, 246.94, 1, 196.00, 196.00, 220.0, 196.00, 293.66, 261.63, 1, 196.00, 196.00, 392.00, 329.63, 261.63, 246.94, 220.0, 1, 349.23, 349.23, 329.63, 261.63, 293.66, 261.63"

@split( song$, "," )
for note from 1 to split.length
    @playNote( number( split.array$[note] ))
endfor

procedure playNote( .note )
    .noteID = do ( "Create Sound as pure tone...", "note", 1, 0, 0.25,
            ...44100, .note, 0.2, 0.01, 0.01 )
    do( "Play" )
    removeObject( .noteID )
endproc

# split proc written by Jose J. Atria (28 February 2012)
procedure split( .str$, .sep$ )
    .length = 0
    repeat
        .strlen = length( .str$ )
        .sep = index( .str$, .sep$ )
        if .sep > 0
            .part$ = left$( .str$, .sep - 1 )
            .str$ = mid$( .str$, .sep + 1, .strlen )
        else
            .part$ = .str$
        endif

        .length = .length+1
        .array$[.length] = .part$
    until .sep = 0
endproc
