#############################################################################
#					 create_point_tier.praat 	
#
#			             DESCRIPTION
#
#	This Praat script allows you to easily 
#   create a new point tier in multiple TextGrid files.  
#   The script provides a user-friendly form that allows users 
#   to choose the folder where the TextGrid files are stored, 
#   the index and name of the tier they want to create, and the folder 
#   where the modified files will be saved.
#
#
#		                   AUTHOR
#	Romain Mendez
#	romainmendz@gmail.com
#   https://github.com/romaindez
#
#                       HOW TO CITE
#	Mendez, R. (2023). Insert Point Tier. v.1.0 
#	Praat Script. Retrieved [DATE] from https://github.com/romaindez/Praat_Scripts/blob/main/manipulate_tiers/insert_point_tier.praat
#
#                         COMPATIBILITY 
#   This script is compatible with Praat version 6.0 or higher
#   and may not work correctly with other versions.
#	Make sure your software is up-do-date before trying to 
#	use this script
#
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
#   https://www.gnu.org/licenses/gpl-3.0.en.html
#
#   © Copyright 2023 - Romain Mendez [romainmendz@gmail.com]
#
############################################################################

############### FORM ###############

form Create Point Tier from TextGrid
	comment TextGrid path and save path
	folder Directory_Import 
	folder Directory_Export 
	comment Enter number of the tier you want to rename
	integer Tier_Position 1 (= at top)
	comment Enter the new point tier name
    text Tier_Label e.g. Vowel

endform

################# VARIABLES ##################
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
		tierNumber = 'Tier_Position'
		tierLabel$ = tier_Label$
	#Insert the point tier
		Insert point tier: tierNumber, tierLabel$
	# Save the modified TextGrid file with the same name in the selected directory
		Save as text file... 'directory_Export$'/'fileName$'
	endfor
else 
exitScript: "ERROR: The import and export folders are the same. In order to avoid overwriting your files, please choose separate folders."
endif
# Clear object list
select all
Remove
# Show a success message if everything works fine
pauseScript: "Eureka! My work here is finished!"