import sqlite3
import os
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

DATABASE = "database/landing_page.db"


def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn


@app.route('/', methods=['GET', 'POST'])
def index():
    conn = get_db_connection()

    if request.method == 'POST':
        nombre = request.form.get('nombre')
        email = request.form.get('email')
        mensaje = request.form.get('mensaje')

        conn.execute(
            "INSERT INTO mensajes_contacto (nombre, email, mensaje) VALUES (?, ?, ?)",
            (nombre, email, mensaje)
        )
        conn.commit()
        conn.close()
        return redirect(url_for('mensajes'))

    configuracion = conn.execute(
        "SELECT * FROM configuracion_sitio LIMIT 1"
    ).fetchone()

    hero = conn.execute(
        "SELECT * FROM hero LIMIT 1"
    ).fetchone()

    estadisticas = conn.execute(
        "SELECT * FROM estadisticas ORDER BY orden ASC"
    ).fetchall()

    cursos_db = conn.execute(
        "SELECT * FROM cursos WHERE estado = 1 ORDER BY orden ASC"
    ).fetchall()

    nosotros = conn.execute(
        "SELECT * FROM nosotros LIMIT 1"
    ).fetchone()

    valores = conn.execute(
        "SELECT * FROM valores ORDER BY orden ASC"
    ).fetchall()

    cursos = []
    for curso in cursos_db:
        caracteristicas = conn.execute(
            "SELECT * FROM curso_caracteristicas WHERE curso_id = ? ORDER BY orden ASC",
            (curso["id"],)
        ).fetchall()

        cursos.append({
            "id": curso["id"],
            "titulo": curso["titulo"],
            "descripcion": curso["descripcion"],
            "imagen": curso["imagen"],
            "caracteristicas": caracteristicas
        })

    conn.close()

    return render_template(
        "index.html",
        configuracion=configuracion,
        hero=hero,
        estadisticas=estadisticas,
        cursos=cursos,
        nosotros=nosotros,
        valores=valores
    )


@app.route('/mensajes')
def mensajes():
    conn = get_db_connection()

    configuracion = conn.execute(
        "SELECT * FROM configuracion_sitio LIMIT 1"
    ).fetchone()

    mensajes = conn.execute(
        "SELECT * FROM mensajes_contacto ORDER BY id DESC"
    ).fetchall()

    conn.close()

    return render_template(
        "mensajes.html",
        configuracion=configuracion,
        mensajes=mensajes
    )


@app.route('/eliminar/<int:id>', methods=['POST'])
def eliminar(id):
    conn = get_db_connection()
    conn.execute("DELETE FROM mensajes_contacto WHERE id = ?", (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('mensajes'))


if __name__ == '__main__':
    ##app.run(debug=True)
    port = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=port, debug=False)