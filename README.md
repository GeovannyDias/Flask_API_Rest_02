# API Rest - Flask (Python)
API REST con Python, Flask y MySQL (GET, POST, PUT, DELETE)

## Course

```
virtualenv -p python3 env
.\env\Scripts\activate
pip list
python -m pip install --upgrade pip

pip install flask flask_mysqldb

Make Directory:
md src


JSON = JavaScript Object Notation

pip freeze > requirements.txt

```

## Extension VSC

```
Thunder Client → Rest API Client for VS Code, GUI based Http Client
Python → Microsoft
Code Runner
vscode-icons

Others:
Prettier - Code formatter
GitLens — Git supercharged
Polacode → 📸 Polaroid for your code
ESLint → Integrates ESLint JavaScript into VS Code.
indent-rainbow → Makes indentation easier to read
SVG → SVG Coding, Minify, Pretty, Preview All-In-One

Bookmarks → Mark lines and jump to them
Linter → An extension for VSCode that provides linting for multiple languages in on package.

 

```

## Cors

```
flask cors

pip install -U flask-cors

from flask_cors import CORS

app=Flask(__name__)
cors = CORS(app, resources={r"/*":{"origins":"*"}})

```



