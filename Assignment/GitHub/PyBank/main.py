import os
import csv
from collections import Counter

main_csv = os.path.join("Resources", "budget_data.csv")

with open(main_csv, 'r') as csvfile:
    print("Financial Analysis")
    print("--------------------------")
    csvreader = csv.reader(csvfile)
    total = 0
    profits_losses = []
    average_change = 0
    budget_dict = {}
    greatestincrease = 0
    greatestdecrease = 0
    greatestincrease_month = ""
    greatestdecrease_month = ""

    next(csvreader)
    for row in csvreader:
        total = total + int(row[1])
        profits_losses.append(int(row[1]))
        budget_dict[row[0]] = int(row[1])
 
    average_change = (profits_losses[-1] - profits_losses[0])/(len(profits_losses) - 1)
    greatestincrease = max(profits_losses)
    greatestdecrease = min(profits_losses)

    for key, value in budget_dict.items():
        if value == greatestincrease:
            greatestincrease_month = key
        if value == greatestdecrease:
            greatestdecrease_month = key

    print("Total Months : " + str(len(profits_losses)))
    print("Total: " + str(total))
    print("Average Change: " + str(average_change))
    print("Greatest increase of profits: " + greatestincrease_month + " : " + str(greatestincrease))
    print("Greatest decrease of profits: " + greatestdecrease_month + " : " + str(greatestdecrease))


f = open("results.txt", "w")
f.write("Financial Analysis\n")
f.write("-----------------------------------------------------\n")
f.write("Total months: ")
f.write(str(len(profits_losses)))
f.write("\n")
f.write("Total: $")
f.write(str(total))
f.write("\n")
f.write("Average Change: $")
f.write(str(str(average_change)))
f.write("\n")
f.write("Greatest increase in profits: ")
f.write(str(greatestincrease_month))
f.write("  ($")
f.write(str(greatestincrease))
f.write(")")
f.write("\n")
f.write("Greatest decrease in profits: ")
f.write(str(greatestdecrease_month))
f.write("  ($")
f.write(str(greatestdecrease))
f.write(")")
f.write("\n")
f.write("----------------------------------------------------\n")