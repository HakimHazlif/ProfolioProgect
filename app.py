from flask import Flask, render_template, request
import pandas as pd
import itertools
import numpy as np


app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit():
    player1 = request.form['player1']
    player2 = request.form['player2']
    player3 = request.form['player3']
    player4 = request.form['player4']

    teams = [player1, player2, player3, player4]

    # الجزء الأول من الكود: إنشاء بيانات المباريات والنتائج
    player_combinations = list(itertools.permutations(teams, 2))

    table = ["Match", "Host_Player", "Result_Host_Player", "Result_Guest_Player", "Guest_Player"]
    df = pd.DataFrame(columns=table)

    df["Match"] = [f"{match[0]} vs {match[1]}" for match in player_combinations]

    df[["Host_Player", "Guest_Player"]] = pd.DataFrame(df["Match"].str.split(' vs ', expand=True))

    for index, row in df.iterrows():
        result_host_player = input(f"{row['Match']} - Goals of {row['Host_Player']} (Host): ")
        result_guest_player = input(f"{row['Match']} - Goals of {row['Guest_Player']} (Guest): ")
        df.at[index, 'Result_Host_Player'] = result_host_player
        df.at[index, 'Result_Guest_Player'] = result_guest_player
    # الجزء الثاني من الكود: بناء جدول الفرق وحساب النقاط


    columns = ["Team", "Won", "Drawn", "Lost", "For", "Against", "GD", "Points"]

    dfg = pd.DataFrame(columns= columns)

    dfg["Team"] = teams

    dfg["Won"] = 0
    dfg["Drawn"] = 0
    dfg["Lost"] = 0

    for index, row in df.iterrows():
        winner = None
        losser = None
        if row["Result_Host_Player"] > row["Result_Guest_Player"]:
            winner = row["Host_Player"]
        elif row["Result_Host_Player"] < row["Result_Guest_Player"]:
            losser = row["Host_Player"]

        if winner or losser is not None:
            dfg.loc[dfg["Team"] == winner, "Won"] += 1
            dfg.loc[dfg["Team"] == losser, "Lost"] += 1
        else:
            dfg.loc[dfg["Team"].isin([row["Host_Player"], row["Guest_Player"]]), "Drawn"] += 1


    dfg["For"] = 0
    dfg["Against"] = 0

    for index, row in df.iterrows():
        host = row["Host_Player"]
        guest = row["Guest_Player"]
        goals_host = row["Result_Host_Player"]
        goals_guest = row["Result_Guest_Player"]

        goals_host = int(goals_host) if not pd.isna(goals_host) else 0
        goals_guest = int(goals_guest) if not pd.isna(goals_guest) else 0

        dfg.loc[dfg["Team"] == host, "For"] += goals_host
        dfg.loc[dfg["Team"] == host, "Against"] += goals_guest

        dfg.loc[dfg["Team"] == guest, "For"] += goals_guest
        dfg.loc[dfg["Team"] == guest, "Against"] += goals_host

    dfg["GD"] = dfg["For"] - dfg["Against"]

    dfg["Points"] = dfg["Won"] * 3 + dfg["Drawn"]
    # ...

    # يمكنك إرجاع نتائج الفرق أو أي بيانات أخرى كمخرجات
    return render_template('result.html', result=dfg.to_html())

if __name__ == '__main__':
    app.run(debug=False)
