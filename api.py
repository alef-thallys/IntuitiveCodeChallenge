from flask import Flask, request, jsonify
from flask_cors import CORS
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os

app = Flask(__name__)
load_dotenv()
CORS(app) 

db_config = {
    "DB_USER": os.getenv("DB_USER"),
    "DB_PASSWORD": os.getenv("DB_PASSWORD"),
    "DB_HOST": os.getenv("DB_HOST"),
    "DB_PORT": os.getenv("DB_PORT"),
    "DB_NAME": os.getenv("DB_NAME"),
}

DATABASE_URL = f"mysql+pymysql://{db_config['DB_USER']}:{db_config['DB_PASSWORD']}@{db_config['DB_HOST']}:{db_config['DB_PORT']}/{db_config['DB_NAME']}"
engine = create_engine(DATABASE_URL)

@app.route('/buscar', methods=['GET'])
def buscar_operadoras():
    print("Received request to /buscar endpoint.")
    query = request.args.get('q', '').lower()

    if not query:
        print("No search parameter provided.")
        return jsonify({"error": "Parâmetro de busca não informado"}), 400

    try:
        print(f"Searching for operadoras with query: {query}")
        with engine.connect() as conn:
            sql = text("""
                SELECT * FROM operadoras_ativas 
                WHERE LOWER(razao_social) LIKE :query 
                OR LOWER(registro_ans) LIKE :query
            """)
            result = conn.execute(sql, {"query": f"%{query}%"})
            
            columns = result.keys()
            operadoras = [dict(zip(columns, row)) for row in result.fetchall()]

        print(f"Found {len(operadoras)} results for query: {query}")
        return jsonify(operadoras)

    except Exception as e:
        print(f"Error while processing /buscar request: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    print("Starting API server...")
    app.run(debug=True, host='0.0.0.0', port=5000)
    print("API server is running on http://0.0.0.0:5000")
