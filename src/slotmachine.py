import random

MAX_LINES = 3
MIN_BET = 1
MAX_BET = 100
ROWS = 3
COLS = 3

symbolCount = {"A":2, "B":4, "C":6, "D":8}
symbolValue = {"A":5, "B":4, "C":3, "D":2}

def checkWinnings(columns, lines, bet, values):
    winnings = 0
    winningLines = []
    for line in range(lines):
        symbol = columns[0][line]
        for column in columns:
            symbolChecking = column[line]
            if symbol != symbolChecking:
                break
        else:
            winnings += values[symbol] * bet
            winningLines.append(line + 1)
    return winnings, winningLines

def slotMachineSpin(rows, cols, symbols):
    all_symbols = []
    for symbol, symbolCount in symbols.items():
        for _ in range(symbolCount):
            all_symbols.append(symbol)
    my_columns = []
    for _ in range(cols):
        my_col = []
        current_symbols = all_symbols[:]
        for _ in range(rows):
            value = random.choice(current_symbols)
            current_symbols.remove(value)
            my_col.append(value)
        my_columns.append(my_col)
    return my_columns

def print_slot_machine(columns):
    result = ""
    for row in range(len(columns[0])):
        for i, column in enumerate(columns):
            if i != len(columns) - 1:
                result += column[row] + " | "
            else:
                result += column[row]
        result += "\n"
    return result

def game(bet, lines, balance):
    totalBet = bet * lines
    if totalBet > balance:
        return "No tienes suficiente saldo", balance

    slots = slotMachineSpin(ROWS, COLS, symbolCount)
    result = print_slot_machine(slots)
    winnings, winningLines = checkWinnings(slots, lines, bet, symbolValue)

    # Guardar los resultados en el archivo
    with open("resultados.txt", "a") as file:
        file.write(f"Jugada: {winnings}$ en las líneas {', '.join(map(str, winningLines))}\n")

    balance += winnings - totalBet
    return result, balance
