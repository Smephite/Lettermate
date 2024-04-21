# Lettermate
This is a simple Python script taking in a `people.csv` CSV file and a LaTex template in `latex_files/`, replacing
certain fields (name, surname) and generating a custom QR Code.  
The generated intermediate tex file is then compiled using native `pdflatex`.

## Requirements
* `pdflatex`  
* `python`
* Everything in `requirements.txt`