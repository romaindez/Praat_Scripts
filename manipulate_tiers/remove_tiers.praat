#############################################################################
#					   remove_tiers.praat 	
#
#			             DESCRIPTION
#
#	This Praat script allows you to easily 
#   remove tiers in a TextGrid file.  
#   The script provides a user-friendly form that allows users 
#   to input the directory where the TextGrid files are stored, 
#   the index of the tier they want to remove, and the directory 
#   where the modified files should be saved.
#
#
#                       IMPORTANT NOTE 
#   It is essential to be aware that if a TextGrid file 
#   contains only one tier, the script will execute without errors; 
#   however, Praat will not allow the removal of that single tier. 
#   This limitation exists because a TextGrid file must have at least 
#   one tier to be considered valid in Praat. 
#
#   If you attempt to remove the last tier, Praat will retain it, 
#   and the file will remain unaltered. In such cases, users may 
#   consider creating a new tier or modifying the existing 
#   tier's content rather than attempting to remove it.
# 		
#
#		                   AUTHOR
#	Romain Mendez
#	romainmendz@gmail.com
#   https://github.com/romaindez
#
#                       HOW TO CITE
#	Mendez, R. (2023). Remove Tiers. v.1.0 
#	Praat Script. Retrieved [DATE] from (LINK TO GITHUB REPOSITORY)
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
#   See the GNU General Public License for more details.
#    https://www.gnu.org/licenses/gpl-3.0.en.html
#
#   © Copyright 2023 - Romain Mendez [romainmendz@gmail.com]
#
############################################################################

############### FORM ###############

#Indicate where the files are and fill the labels info
form Remove Tier Textgrids
    comment TextGrid path and save path
    folder Import_Directory 
    folder Export_Directory 
    comment Enter number of the tier you want to remove
    positive Tier_Number 1
 endform


################# VARIABLES ###############
directory_import$ = import_Directory$
directory_export$ = export_Directory$

############### MAIN SCRIPT ###############
# Create Strings as file list and get the number of files
if directory_import$ != directory_export$
 Create Strings as file list... list 'Import_Directory$'/*.TextGrid
 num = Get number of strings
 # Loop through each file in the list
 for ifile to num
     select Strings list
     fileName$ = Get string... ifile
     Read from file... 'Import_Directory$'/'fileName$'
     # Get the selected tier number from the form
     tierNum = 'Tier_Number'
     totalTiers =  Get number of tiers
     # Loop through each tier in the TextGrid file
     for n to totalTiers
         # Check if the selected tier index is within the valid range
         if (tierNum >= 1) & (tierNum <= totalTiers)
         # Remove the tier with the specified index (tierNum)
         nocheck Remove tier: 'tierNum'
         # Save the modified TextGrid file to the Export_Directory
         Save as text file... 'Export_Directory$'/'fileName$'
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
 # Clear object list to avoid clutter
 select all
 Remove
 # Message displayed if everything works fine 
 pauseScript: "Eureka! My work here is finished!"