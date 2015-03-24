# Draw 6 FFT boxes in series from an editor window cursor position
# It may be useful to run the sccript once, read Praat's automatic min/max
# dB values from the spectrum plots and then run this script again and
# set those options to the appropriate value(s).
#
# Kevin McGowan, kmcgowan [at] rice.edu
# please e-mail me revisions or fixes!
# 20 January 2013

cursor = Get cursor
home = 'cursor'

form Draw six FFTs starting at cursor
    comment Window Width (ms)
    real Width 0.025
    comment Maximum Frequency (Hz) to display
    integer maxHz 5000
    comment Minimum power (dB) to display (0 = auto)
    integer mindB 0
    comment Maximum power (dB) to display (0 = auto)
    integer maxdB 0
endform

size = width / 2

for i to 6
    start = cursor - size
    end = cursor + size
    Select... start end

    # name the new Sound object according to the time point where the cursor was
    milliseconds = round (cursor * 1000)
    Extract windowed selection... FFT_'milliseconds'ms Kaiser2 2 no

    # leave the Sound editor for a while to calculate and draw the spectrum
    endeditor

    # Make the Spectrum object from the new Sound
    To Spectrum (fft)

    # select and remove the temporary Sound object 
    select Sound FFT_'milliseconds'ms
    Remove

    if i = 1
        Erase all
        Select outer viewport... -0.25 3.75 -0.25 3.25
    elsif i = 2
        Select outer viewport... 3.1 7.1 -0.25 3.25
    elsif i = 3
        Select outer viewport... 6.5 10.5 -0.25 3.25
    elsif i = 4
        Select outer viewport... -0.25 3.75 2.75 6.25
    elsif i = 5
        Select outer viewport... 3.1 7.1 2.75 6.25
    elsif i = 6
        Select outer viewport... 6.5 10.5 2.75 6.25
    endif

    Draw inner box
    select Spectrum FFT_'milliseconds'ms
    Draw... 0 'maxHz' 'mindB' 'maxdB' no
    Marks right... 2 yes yes no
    Marks bottom... 4 yes yes no
    Text top... no t = 'milliseconds'ms
    Select inner viewport... 0 10.5 0 6.25

    # select and remove the temporary Spectrum object 
    select Spectrum FFT_'milliseconds'ms
    Remove

    # return to the Sound editor window and advance the cursor position
    editor
    Move cursor by... size
    cursor = Get cursor
endfor

# put cursor back where we found it
Move cursor to... 'home'
