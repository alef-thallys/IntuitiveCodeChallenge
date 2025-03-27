from flask import Flask, request, jsonify
from flask_cors import CORS
from sqlalchemy import create_engine, text

app = Flask(__name__)
CORS(app) 

DB_USER = "root"
DB_PASSWORD = "87249293a"
DB_HOST = "127.0.0.1"
DB_PORT = "3306" 
DB_NAME = "intuitiveChallenge"

DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

engine = create_engine(DATABASE_URL)

@app.route('/buscar', methods=['GET'])
def buscar_operadoras():
    query = request.args.get('q', '').lower()

    if not query:
        return jsonify({"error": "Parâmetro de busca não informado"}), 400

    try:
        with engine.connect() as conn:
            sql = text("""
                SELECT * FROM operadoras_ativas 
                WHERE LOWER(razao_social) LIKE :query 
                OR LOWER(registro_ans) LIKE :query
            """)
            result = conn.execute(sql, {"query": f"%{query}%"})
            
            columns = result.keys()  
            operadoras = [dict(zip(columns, row)) for row in result.fetchall()] 

        return jsonify(operadoras)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
