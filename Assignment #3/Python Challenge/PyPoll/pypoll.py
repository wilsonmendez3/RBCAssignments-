import os 
import csv
from collections import Counter

main_csv = os.path.join("Resources", "election_data.csv")

with open(main_csv, 'r') as csvfile: 
    print("ELECTION RESULTS")
    print("--------------------------")
    csvreader = csv.reader(csvfile)
    votes = []
    total_votes = 0

    next(csvreader)
    for row in csvreader:
        votes.append(row[2])
    total_votes = len(votes)
    #print(total_votes)
    vote_tally = dict(Counter(votes))
    #print(vote_tally)
     
    khan_votes = vote_tally['Khan'] 
    correy_votes = vote_tally['Correy'] 
    li_votes = vote_tally['Li']
    otooley_votes = vote_tally['O\'Tooley']
    
    runners_list = [khan_votes, correy_votes, li_votes, otooley_votes]
    winner_votes = max(runners_list)
    
    khan_perc = (khan_votes * 100) 
    khan_perc = khan_perc / total_votes
    correy_perc = (correy_votes * 100)
    correy_perc = correy_perc / total_votes 
    li_perc = li_votes * 100 
    li_perc = li_perc / total_votes
    otooley_perc = otooley_votes * 100 
    otooley_perc = otooley_perc / total_votes
    winner = ""

    for k, v in vote_tally.items():
        if v == winner_votes:
            winner = k 


    print("---------------------------------------------")
    print("Election Results")
    print("---------------------------------------------")
    print("Total Votes: " + str(total_votes))
    print("---------------------------------------------")
    print("Khan:         " + str(khan_perc) + "% " + "(" + str(khan_votes) + ") ")
    print("Correy:       " + str(correy_perc) + "% " + "(" + str(correy_votes) + ")")
    print("Li:           " + str(li_perc) + "% " + "(" + str(li_votes) + ")")
    print("O'Tooley:     " + str(otooley_perc) + "% " + "(" + str(otooley_votes) + ")")
    print("---------------------------------------------")
    print("Winner: " + winner)
    print("---------------------------------------------")

f = open("results.txt", "w")
f.write("Election Results\n")
f.write("---------------------------------------------\n")
f.write("Total Votes: ")
f.write(str(total_votes))
f.write("\n")
f.write("---------------------------------------------\n")
f.write("Khan:         ")
f.write(str(round(khan_perc, 2)))
f.write("%   (")
f.write(str(khan_votes))
f.write(")")
f.write("\n")
f.write("Correy:         ")
f.write(str(round(correy_perc, 2)))
f.write("%   (")
f.write(str(correy_votes))
f.write(")")
f.write("\n")
f.write("Li:         ")
f.write(str(round(li_perc, 2)))
f.write("%   (")
f.write(str(li_votes))
f.write(")")
f.write("\n")
f.write("O'Tooley:         ")
f.write((str(round(otooley_perc, 2))))
f.write("%   (")
f.write(str(otooley_votes))
f.write(")")