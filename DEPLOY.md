# SudoCG 社区部署指南

## 项目结构

```
sudocg/
├── src/                # 前端 React 代码
├── server/             # 后端 Node.js 代码
│   ├── index.js        # Express 服务器
│   ├── package.json    # 后端依赖
│   └── data/           # 加密数据存储目录（自动创建）
├── dist/               # 前端构建输出（npm run build 后生成）
└── package.json        # 前端依赖
```

## 本地开发

### 1. 安装依赖

```bash
# 安装前端依赖
npm install

# 安装后端依赖
cd server
npm install
cd ..
```

### 2. 启动开发服务器

**终端 1 - 启动前端开发服务器：**
```bash
npm run dev
```

**终端 2 - 启动后端 API 服务器：**
```bash
cd server
npm start
```

前端运行在 `http://localhost:5173`
后端运行在 `http://localhost:3001`

## 生产部署

### 1. 构建前端

```bash
npm run build
```

这将生成 `dist/` 目录。

### 2. 启动生产服务器

```bash
cd server
npm start
```

服务器将同时提供 API 和静态文件服务，访问 `http://localhost:3001` 即可。

### 3. 使用 PM2 保持运行（推荐）

```bash
# 安装 PM2
npm install -g pm2

# 启动服务器
cd server
pm2 start index.js --name sudocg

# 查看日志
pm2 logs sudocg

# 设置开机自启
pm2 startup
pm2 save
```

## 环境变量

可以通过环境变量配置：

```bash
# 端口号（默认 3001）
PORT=3001

# 加密密钥（生产环境务必修改！）
ENCRYPTION_KEY=your-secure-secret-key-here
```

## 数据存储

所有数据以 **AES-256-CBC 加密** 的形式存储在 `server/data/` 目录下：

- `users.enc` - 用户数据
- `categories.enc` - 板块数据
- `threads.enc` - 帖子数据
- `posts.enc` - 回复数据
- `notifications.enc` - 通知数据
- `messages.enc` - 私信数据
- `codes.enc` - 兑换码数据
- `stats.enc` - 站点统计
- `moderation.enc` - 审核规则

## 默认管理员账号

首次启动时会自动创建：

- **账号**: `admin`
- **密码**: `admin123`

**⚠️ 请在部署后立即修改管理员密码！**

## Nginx 反向代理配置（可选）

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

## 备份数据

只需备份 `server/data/` 目录即可：

```bash
cp -r server/data /path/to/backup/
```

## 注意事项

1. **生产环境必须修改 `ENCRYPTION_KEY`**，否则数据安全无法保障
2. 建议使用 HTTPS（可通过 Nginx + Let's Encrypt 实现）
3. 定期备份 `server/data/` 目录
4. 图片上传会转为 Base64 存储，建议限制图片大小（当前限制 512KB）
