# Praat Scripts

Praat is a widely used software package and programming language designed for the analysis, synthesis, and manipulation of speech and phonetics (Boersma & Weenink, 2023). [Boersma, Paul & Weenink, David (2023). Praat: doing phonetics by computer [Computer program]. Version 6.3.14, retrieved 5 August 2023 from http://www.praat.org/]

This repository contains several open-source Praat scripts divided in two folders. They are designed to automate some of the most common tasks in speech research. They are intended to be used by researchers and students who are familiar with Praat and have some basic knowledge of scripting. Each script has a header with instructions on how to use it as well as a description of the task it performs. Please read the header carefully before using the script.

The scripts are written in Praat's own programming language. For more information please visit: https://www.fon.hum.uva.nl/praat/manual/Scripting.html.
They are distributed under the GNU General Public License v3.0 (see [License information](#license-information)).

# How to Use

## Compatibility

These scripts are compatible with `Praat` version 6.0 and higher and may not work correctly with older versions. Make sure your software is up-do-date before trying to use any of the scripts provided.

## How to cite

You can cite this repository as follows:
Mendez, R. (2023). Praat Scripts. Retrieved [DD MM YYYY] from (LINK TO GITHUB REPOSITORY).

If you wish to cite a specific script, please check the header of said script for the correct citation.

## Setup

Place the scripts files in a convenient location on your computer.

## Preparing the TextGrid/Audio Files

1. Make sure the TextGrid or audio files you want to process are in a single folder.
2. In order to avoid overwriting, make sure to create a separate folder to save your modified TextGrid or audio files.
3. **IMPORTANT**: Create a backup of your files before running these scripts, as the changes made will be irreversible.

## Running the Script

1. Open `Praat` (version 6.3.xx or compatible).
2. From the `Praat` menu, go to `Praat > Open Praat script...` and select the script you placed in step 1 of the [Setup](#Setup).
3. The script will open, and you'll usually see a form with several options.
4. After entering the required information, click the `Run` button to execute the script.

## Results

- These scripts will process all the TextGrid or audio files in the specified import folder.
- The modified TextGrid or audio files will be saved in the specified export folder (We strongly recommend you to set separate import and export folders).

## Completion

Once the script finishes executing, you will see a message indicating if the process ran without errors.

## Troubleshooting and Contributions

- If an error occurs, please read it carefully, ensure that you have provided correct inputs. Make sure your TextGrid and audio files are properly named and formatted and that you have carefully followed the instructions provided here and on the header of each script.
- If you encounter any issues or have questions, please feel free to create a pull request or raise an issue in the repository. You can also reach out for assistance at [romainmendz@gmail.com](mailto:romainmendz@gmail.com).
- Contributions to the scripts are welcome!

# Important Note

Some of these scripts modify TextGrid or audio files directly. Use them with caution. It is recommended to work with a copy of your original files to avoid accidental data loss. I do not take any responsibility for any loss of data or damage to your files. Use these scripts at your own risk.

# License information

These scripts are distributed under the GNU General Public License v3.0.
These scripts are free software: you can redistribute them and/or modify
them under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License,
or any later version.

These scripts are distributed in the hope that they will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.
https://www.gnu.org/licenses/gpl-3.0.en.html
