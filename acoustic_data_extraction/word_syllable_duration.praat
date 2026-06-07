############################################################################
#					word_and_syllable_duration.praat 	
#										                           		       
#						 DESCRIPTION
#
#   This script is designed to batch process several TextGrid files 
#	contained in a folder. The main purpose of this script is 
#	to automatically extract the duration of syllables and words.  
#   It matches each syllable with its corresponding word. 
#   It provides both durations and labels for word and syllable 
#   intervals. Additionally, it includes the number of syllables relative 
#   to each word. The duration of given intervals is rounded, 
#   expressed in seconds and it contains two decimals.
#   The script allows users to save data in a tabular format 
#   document, either to a .csv or .txt file.
#   
#                       IMPORTANT NOTES 
#   The script assumes that there is only one tier for words and
#   one tier for syllables. Make sure that the tiers are in the correct 
#   order when specifying their numbers in the form. 
#						
#							AUTHOR
#	Romain Mendez
#	romainmendz@gmail.com
#  	https://github.com/romaindez
#
#                       HOW TO CITE
#	Mendez, R. (2026). Word and Syllable Duration. v.1.1 (optimized)
#	Praat Script. Retrieved [DD MM YYYY] from https://github.com/romaindez/Praat_Scripts/blob/main/acoustic_data_extraction/word_syllable_duration.praat
#
#                     	 COMPATIBILITY 
#   This script is compatible with Praat version 6.0 or higher
#   Tested and optimized for Praat 6.4.67+
#	Make sure your software is up-to-date before trying to 
#	use this script
#
#                      VERSION HISTORY & LICENSE
#
#   1.1 - 2026 - Fixed encoding, improved code structure
#   1.0 - 05-08-2023 - Initial release	
#   This script is distributed under the GNU General Public License v3.0.
#   This script is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#  	the Free Software Foundation, either version 3 of the License, 
#   or any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
#	See the GNU General Public License for more details.
#	https://www.gnu.org/licenses/gpl-3.0.en.html
#
#	© Copyright 2023 - Romain Mendez [romainmendz@gmail.com]
#
############################################################################

############### FORM ###############

#Indicate where the files are and fill the labels info
form Duration_To_File
    comment Select your operating system
    choice Operating_System 1
        option MacOS / Linux
        option Windows
    comment TextGrid path and save path
    folder Import_Files 
    folder Export_Files 
    choice File_format 1 
        option csv
        option txt
    comment Name of the file
    text Name_Of_Saved_File Word_Syllable_duration
    comment Number of the tiers containing the words and the syllables
    positive Words_Tier_Number 1
    positive Syllable_Tier_Number 2 
    endform
    
    ################# VARIABLES ##################
    
    operatingSystem$ = operating_System$
    if operatingSystem$ == "Windows"
    dirImp$ = import_Files$ + "\"
    dirExp$ = export_Files$ + "\"
    else
        dirImp$ = import_Files$ + "/"
        dirExp$ = export_Files$ + "/"
    endif
    dirTextGrids$ = dirImp$ + "*.TextGrid"
    nameOfFile$ = name_Of_Saved_File$
    wordsTierNumber = words_Tier_Number
    syllableTierNumber = syllable_Tier_Number 
    file_format$ = file_format$
    
    ################# MAIN SCRIPT ##################
    # Create the file. If there is already a file with that name, it will warn the user that the file will be overwritten.
    if file_format$ == "txt"
        saveFile$ = dirExp$ + nameOfFile$ + ".txt"
    else 
        saveFile$ = dirExp$ + nameOfFile$ + ".csv"
    endif
    if fileReadable(saveFile$)
        pauseScript: "That file already exists! Are you sure you want to overwrite it?"
        deleteFile: saveFile$
    endif
    
    # Create a file with headers
    appendFile: saveFile$, "Filename", tab$, "Word", tab$, "Word Duration (s)", tab$, "Syllable Position", tab$, "Syllable", tab$, "Syllable Duration (s)", newline$
    # Create a list of TextGrid files
    textGridFileList = Create Strings as file list: "textGridFileList", dirTextGrids$
    # Get the number of TextGrid files in the specified folder
    numberOfFiles = Get number of strings
    ### MAIN LOOP ###
    # Loop through each TextGrid file
    for ifile to numberOfFiles
        # Select the current TextGrid file from the list
        selectObject: textGridFileList
        file$ = Get string: ifile
        base$ = file$ - ".TextGrid"
        fil$ = dirImp$ + file$
        # Read the content of the current TextGrid file
        Read from file: dirImp$ + file$
        # Select the TextGrid object based on the base file name
        select TextGrid 'base$'
        # Get the number of intervals in the Syllable and Words tiers
        numIntervalsSyllable = Get number of intervals: syllableTierNumber
        numIntervalsWords = Get number of intervals: wordsTierNumber
        # Loop through each word interval in the TextGrid
        for i to numIntervalsWords
            onsetWord = Get starting point: wordsTierNumber, i
            offsetWord = Get end point: wordsTierNumber, i
            labWords$ = Get label of interval: wordsTierNumber, i
            countSyllabes = 1
            totalSyllabes = 0
            rawDurationWord = offsetWord - onsetWord
            # Loop through each syllable in the TextGrid
            for n to numIntervalsSyllable
                onsetSyllables = Get starting point: syllableTierNumber, n
                offsetSyllables = Get end point: syllableTierNumber, n
                # Check if the syllable is part of the current word
                if  onsetSyllables >= onsetWord and offsetSyllables <= offsetWord
                    labelSyllable$ = Get label of interval: syllableTierNumber, n
                    rawDurationSyllable = offsetSyllables - onsetSyllables
                    # Count the total number of syllables for the current word
                    totalSyllabes = totalSyllabes + 1
                    # Print information to the file
                    appendFile: saveFile$, base$, tab$, labWords$, tab$ , fixed$(rawDurationWord,2), tab$, fixed$(totalSyllabes,0), tab$, labelSyllable$, tab$, fixed$(rawDurationSyllable,2), newline$
                endif
            # End loop through syllable intervals
            endfor
        # End loop through word intervals
        endfor
    ### END OF MAIN LOOP ### 
    endfor
    # Clear object list
    select all
    Remove
    # Message if everything works fine
    pauseScript: "Eureka! My work here is finished!"
    