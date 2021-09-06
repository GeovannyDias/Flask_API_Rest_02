from flask import Flask, jsonify, request
from flask_cors import CORS
from config import config  # Fichero config
from flask_mysqldb import MySQL

# __name__ Este parámetro sirve para saber si estamos ejecutando este archivo como principal
app = Flask(__name__)

CORS(app, resources={r"/*":{"origins":"*"}})

conn = MySQL(app)

@app.route('/')
def get_start():
    return 'Running Server...'

# GET ALL DATA
@app.route('/courses', methods=['GET'])
def get_courses():
    try:
        cursor = conn.connection.cursor()
        sql = 'select * from cursos'
        cursor.execute(sql)
        data = cursor.fetchall()
        # print(data)
        data_courses = []
        for d in data:
            course = {'id': d[0], 'name': d[1], 'credit': d[2]}
            data_courses.append(course)
        return jsonify({'courses': data_courses, 'message': 'Get Courses Successfuly', 'code': 'OK'}), 200
    except Exception as ex:
        return jsonify({'message': 'Error al intentar obtener datos', 'code': 'FAIL_CONTENT'}), 500


# GET ONE DATA TO PARAM
@app.route('/course/<id>', methods=['GET'])
def get_course(id):
    try:
        cursor = conn.connection.cursor()
        # sql = "select * from cursos where id = id"
        # se pasa el parametro mediente format()
        sql = "select * from cursos where id = {0}".format(id)
        cursor.execute(sql)
        data = cursor.fetchone()
        if data != None:
            course = {'id': data[0], 'name': data[1], 'credit': data[2]}
            return jsonify({'course': course, 'message': 'Get Course Successfuly', 'code': 'OK'}), 200
        else:
            return jsonify({'message': 'Course Not Found', 'code': 'OK'}), 200
    except Exception as ex:
        return jsonify({'message': 'Error al intentar obtener dato', 'code': 'FAIL_CONTENT'}), 500


# POST DATA
@app.route('/course', methods=['POST'])
def post_course():
    try:
        print(request.json)
        cursor = conn.connection.cursor()
        sql = """INSERT INTO cursos (name, credit)
        VALUES('{0}', {1})""".format(request.json['name'], request.json['credit'])
        cursor.execute(sql)
        conn.connection.commit()  # Confirma la accion de insercción
        return jsonify({'message': 'Post Course Successfuly', 'code': 'OK'}), 200
    except Exception as ex:
        return jsonify({'message': 'Error al intentar insertar datos', 'code': 'FAIL_CONTENT'}), 500


# UPDATE DATA
@app.route('/course/<id>', methods=['PUT'])
def update_course(id):
    try:
        # Validar si el registro con el ID existe (Pendiente)
        cursor = conn.connection.cursor()
        sql = """UPDATE cursos SET name = '{0}', credit = {1}
        WHERE id = {2}""".format(request.json['name'], request.json['credit'], id)
        cursor.execute(sql)
        conn.connection.commit()  # Confirma la accion de insercción
        return jsonify({'message': 'Update Course Successfuly', 'code': 'OK'}), 200
    except Exception as ex:
        return jsonify({'message': 'Error al intentar actualizar datos', 'code': 'FAIL_CONTENT'}), 500


# DELETE DATA
@ app.route('/course/<id>', methods=['DELETE'])
def delete_course(id):
    try:
        # Validar si el registro con el ID existe (Pendiente)
        cursor = conn.connection.cursor()
        sql = "DELETE FROM cursos WHERE id = {0}".format(id)
        cursor.execute(sql)
        conn.connection.commit()  # Confirma la accion de insercción
        return jsonify({'message': 'Delete Course Successfuly', 'code': 'OK'}), 200
    except Exception as ex:
        return jsonify({'message': 'Error al intentar eliminar datos', 'code': 'FAIL_CONTENT'}), 500


# ERROR 404
def page_not_found(error):
    return '<h2>La página que intentas buscar no Existe!</h2>', 404


# RUN APP
if __name__ == '__main__':
    app.config.from_object(config['development'])
    app.register_error_handler(404, page_not_found)
    app.run()
