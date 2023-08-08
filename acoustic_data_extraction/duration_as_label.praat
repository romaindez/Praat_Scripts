############################################################################
#					duration_as_label.praat 	
#										                           		       
#						DESCRIPTION
#
# 	This script allows you to extract the duration of given intervals 
#	in a tier and then replace the label of the interval with the value 	
#	corresponding to said duration. The duration of given intervals is 
#	rounded and written as "(0.01)" corresponding to the CHAT format 
#	following MacWhinney, B. (2000). The CHILDES Project: Tools for 
#	Analyzing Talk. 3rd Edition. Mahwah, NJ: Lawrence Erlbaum Associates.
#						
#							AUTHOR
#	Romain Mendez
#	romainmendz@gmail.com
#  	https://github.com/romaindez
#
#							HOW TO CITE
#	Mendez, R. (2023). Duration as Label. 
#	v.1.0 Praat Script. Retrieved [DATE] from (LINK TO GITHUB REPOSITORY)
#
#                     	 COMPATIBILITY 
#   This script is compatible with Praat version 6.0 or higher
#   and may not work correctly with other versions.
#
#
#                       	LICENSE
#
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
form Duration As Label
	comment Where are the TextGrids to be modified?
	folder Import_Files 
	comment Where do you want to save the modified TextGrids?
	folder Export_Files 
	comment Information about the tier to be modified
	positive Tier_Number 1
	text Interval_Label silence (do not use " " unless the label contains them)
endform
 
################# VARIABLES ##################
 
dirImp$ = import_Files$
dirExp$ = export_Files$
dirTextGrids$ = dirImp$ + "*.TextGrid"
tierNumber = tier_Number
intervalLabel$ = interval_Label$
 
################# MAIN SCRIPT #####################
# Create a file list and get the number of files
if dirImp$ != dirExp$
	Create Strings as file list... list 'dirImp$'/*.TextGrid
 
	# Get the number of files in the list 
	numFiles = Get number of strings
	# Show a message in case there are no files
	if numFiles == 0
		exitScript: "There are no TextGrid files in the specified folder. Exiting"
	endif
	# Loop per file
	for ifile to numFiles
		select Strings list
		fileName$ = Get string: ifile
		base$ = fileName$ - ".TextGrid"
		
		# Read TextGrid
		Read from file... 'dirImp$'/'fileName$'
		
		# Select the current TextGrid
		select TextGrid 'base$'
		
		# Extract the number of intervals of each tier
		nbIntervalSilent = Get number of intervals: tierNumber  
		# Get the label of the intervals 
		for i to nbIntervalSilent
			existingLabel$ = Get label of interval: tierNumber, i
			# Only choose the label that matches the one indicated in the form
			if existingLabel$ = intervalLabel$
				newLabel$ = existingLabel$
				# Loop per silence in order to get the duration of each silence  
				onsetSilent = Get starting point: tierNumber, i
				offsetSilent = Get end point: tierNumber, i
				# Calculate the raw duration of each silence (in ms)
				durTierSilence = offsetSilent - onsetSilent
				# Rounding 2 decimal
				durTierSilenceStrings$ = fixed$ (durTierSilence, 2)
				# Modification to string CHAT format
				durSilence$ = durTierSilenceStrings$
				# Replace the label of the interval with its duration 
				Replace interval text... 'tierNumber' i i 'newLabel$' 'durSilence$' Literals
			endif
		endfor
	else 
		exitScript: "ERROR: The import and export folders are the same. In order to avoid overwriting your files, please choose separate folders."
	endif
	# Save the modified TextGrid
	Save as text file... 'dirExp$'/'fileName$'
endfor
# Clear object list
select all
Remove
# Message if everything works fine 
pauseScript: "Eureka! My work here is finished!"
