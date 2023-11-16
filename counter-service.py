from flask import Flask, request

app = Flask(__name__)
count = 0

@app.route('/', methods=['GET', 'POST'])
def counter():
    global count

    if request.method == 'POST':
        count += 1

    return 'Counter: {}'.format(count)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
