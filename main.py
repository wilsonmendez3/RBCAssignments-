import os 
import csv
from collections import Counter


main_csv = os.path.join("Resources", "budget_data.csv")


with open(main_csv, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")
    TotalMonths = list(csvreader)
    row_count = len(TotalMonths)
    rows = csv.DictReader(csvfile)
    print("Financial Analysis")
    print("--------------------------")
    print("Total Months: " + str(row_count))




