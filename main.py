import os
import shutil
import pandas as pd
import qrcode
import qrcode.image.svg
URL = "https://www.example.com/patient/%s"


# Define Paths
OUT_PATH = os.path.join(os.getcwd(), "output")
TMP_PATH = os.path.join(os.getcwd(), "tmp")

# Define Template
TEX_TEMPLATE = open("latex_files/template.tex", "r").read()

# Make Sure Paths Exist
os.makedirs(OUT_PATH, exist_ok=True)
os.makedirs(TMP_PATH, exist_ok=True)

# Copy all latex files to be able to compile
for f in os.listdir("latex_files"):
    if f == "template.tex":
        continue
    shutil.copyfile(os.path.join("latex_files", f), os.path.join(TMP_PATH, f))


# Generate QR Code and Compile PDF for a single patient
def generate_pdf(row):
    (name, surname, patient_id) = (row["name"], row["surname"], row["patient_id"])

    # Generate QR Code
    img = qrcode.make(URL % patient_id)
    img.save(f"{TMP_PATH}/{patient_id}.png")

    # Replace Placeholders in Template
    content = TEX_TEMPLATE
    content = content.replace("==PATIENT_ID==", str(patient_id))
    content = content.replace("==NAME==", name)
    content = content.replace("==SURNAME==", surname)
    content = content.replace("==ADDRESS==", "Hier könnte Ihre Adresse stehen")
    content = content.replace("==QR_CODE==", f"{TMP_PATH}/{patient_id}.png")

    # Write to tex File
    tex_name = os.path.join(TMP_PATH, f"{patient_id}.tex")
    open(tex_name, "w").write(content)

    # Compile PDF
    os.system(f"cd {TMP_PATH} && pdflatex -shell-escape {tex_name}")

    # Move PDF to Output Folder
    shutil.move(f"{TMP_PATH}/{patient_id}.pdf", f"{OUT_PATH}/{patient_id}.pdf")


def main():
    # Read Data
    df = pd.read_csv("people.csv")
    df.reset_index()

    # Iterate over all rows and generate PDFs
    for _, row in df.iterrows():
        generate_pdf(row)


if __name__ == "__main__":
    main()
