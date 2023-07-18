from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/page1')
def page1():
    return render_template('page1.html')

# def hello_world():
#     return 'Hello, World!'

if __name__ == '__main__':
    app.run(debug=True)

app.static_folder = 'static'
