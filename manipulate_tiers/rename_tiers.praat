#############################################################################
#						rename_tiers.praat 	
#
#			             DESCRIPTION
#
#	This Praat script allows you to easily 
#   rename tiers in a TextGrid file in order 
#   to reflect its contents accurately.
#		
#
#		                   AUTHOR
#	Romain Mendez
#	romainmendz@gmail.com
#   https://github.com/romaindez
#
#
#                         COMPATIBILITY 
#   This script is compatible with Praat version 6.0 or higher
#   and may not work correctly with other versions. 
#	Make sure your software is up-do-date before trying to 
#	use this script
#
#                       HOW TO CITE
#	Mendez, R. (2023). Rename Tiers. v.1.0 
#	Praat Script. Retrieved [DATE] from https://github.com/romaindez/Praat_Scripts/blob/main/manipulate_tiers/rename_tiers.praat
#
#                            LICENSE
#
#   This script is distributed under the GNU General Public License v3.0.
#   This script is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, 
#   or any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
#	See the GNU General Public License for more details.
#	https://www.gnu.org/licenses/gpl-3.0.en.html
#
#   © Copyright 2023 - Romain Mendez [romainmendz@gmail.com]
#
############################################################################

############### FORM ###############

form Rename Tier TextGrids
	comment Choose the folder where the TextGrid files are located
	folder Directory_Import 
	comment Enter number of the tier you want to rename
	integer Tier_Number 1
	comment Enter the new tier name
    text Replace_Name_of_Tier e.g. Syllables
	comment Choose the folder where to save the TextGrid files 
	folder Directory_Export 
endform

################# VARIABLES ###############
directory_import$ = directory_Import$
directory_export$ = directory_Export$

############### MAIN SCRIPT ###############
# Create Strings as file list and get the number of files
if directory_import$ != directory_export$
Create Strings as file list... list 'directory_Import$'/*.TextGrid
numFiles = Get number of strings
# Iterate through each file in the list
for ifile to numFiles
	select Strings list
	fileName$ = Get string... ifile
	Read from file... 'directory_Import$'/'fileName$'
	# Get the user-selected tier index and new tier name from the form
	tierNumber = 'Tier_Number'
	newTierName$ = replace_Name_of_Tier$
	totalTiers =  Get number of tiers
	for n to totalTiers
	# Check if the selected tier index is within the valid range
		if (tierNumber >= 1) & (tierNumber <= totalTiers)
		# Rename the selected tier to the new tier name
		Set tier name: tierNumber, newTierName$
		# Save the modified TextGrid file with the same name in the same directory
		Save as text file... 'directory_Export$'/'fileName$'
		else
		# Show an error message if the selected tier index is invalid
        exitScript: "Error: Selected tier number is out of range! 
        Please check that the tier number you selected exists in your TextGrid!"
		endif
	endfor
else 
	exitScript: "ERROR: The import and export folders are the same. In order to avoid overwriting your files, please choose separate folders."
endif
	endfor
# Clear object list
select all
Remove
# Show a success message if everything works fine
pauseScript: "Eureka! My work here is finished!"