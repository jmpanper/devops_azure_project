from flask import Flask, render_template, request, jsonify
import os
from slotmachine import game

# Configura Flask para buscar plantillas en la carpeta 'html'
app = Flask(__name__, template_folder='html', static_folder='html/styles')

# Página de inicio
@app.route('/')
def index():
    return render_template('index.html')

# Endpoint para jugar
@app.route('/play', methods=['POST'])
def play():
    bet = int(request.form['bet'])
    lines = int(request.form['lines'])
    balance = int(request.form['balance'])

    result, balance = game(bet, lines, balance)

    return jsonify(result=result, balance=balance)

if __name__ == '__main__':
    app.run(debug=True)
