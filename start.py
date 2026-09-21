"""项目运行脚本。

用法：

```bash
python start.py
```

该脚本通过 `create_app()` 创建应用并启动 Flask 开发服务器。
"""
from myapp import create_app

app = create_app()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
