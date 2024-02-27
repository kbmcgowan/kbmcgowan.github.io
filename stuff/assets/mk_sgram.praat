# select a WAV file to generate, label, and save a 300 dpi spectrgram image.
# Kevin B. McGowan <clunis@umich.edu>

sound = selected ("Sound")
name$ = selected$ ("Sound")

# set 8000 Hz as the upper bound for a publishable spectrogram
sgram = To Spectrogram: 0.005, 8000, 0.002, 20, "Gaussian"

# paint the spectrogram with full garnish
Erase all
Select outer viewport: 0, 10, 0, 4.5
Paint: 0, 0, 0, 0, 100, "yes", 55, 6, 0, "no"

# add normal labels to axes
Draw inner box
Marks left every: 1, 8000, "yes", "yes", "no"
Text left: "no", "Frequency (Hz)"
Marks bottom: 2, "yes", "yes", "no"
Text bottom: "no", "Time (s)"

removeObject( sgram )
selectObject( sound )

fileName$ = chooseWriteFile$: "Save as a 300 dpi PNG file", name$ + ".png"
if fileName$ <> ""
	Save as 300-dpi PNG file: fileName$
endif
