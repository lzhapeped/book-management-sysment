"""应用工厂与蓝图注册。

该模块提供 `create_app()`，用于创建 Flask 应用并注册蓝图。
本项目为图书馆预约管理系统，包含图书、读者、座位、借阅预约等模块。
"""
from flask import Flask, render_template
from flask_cors import CORS
import importlib

from .core.utils import CustomJSONEncoder


def create_app():
    """创建并配置 Flask 应用实例。"""
    app = Flask(__name__, template_folder='../templates', static_folder='../static')
    app.secret_key = "library_admin_2026"
    CORS(app, supports_credentials=True)

    # JSON encoder and settings
    app.json_provider_class = CustomJSONEncoder
    app.config['JSON_AS_ASCII'] = False

    # Register built-in blueprints from the organized blueprints package.
    for mod_name, attr in (('auth', 'auth_bp'), ('reader', 'reader_bp'),
                           ('book', 'book_bp'), ('seat', 'seat_bp'),
                           ('borrow_reserve', 'borrow_reserve_bp')):
        try:
            mod = importlib.import_module(f"myapp.blueprints.{mod_name}")
            if hasattr(mod, attr):
                app.register_blueprint(getattr(mod, attr))
        except Exception:
            pass

    @app.route('/')
    def index():
        return render_template('index.html')

    return app
