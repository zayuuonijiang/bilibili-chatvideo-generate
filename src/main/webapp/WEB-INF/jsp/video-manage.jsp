<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: "Segoe UI", "PingFang SC", "Microsoft YaHei", sans-serif;
            min-height: 100vh;
            color: #e6edf3;
            background:
                linear-gradient(135deg, rgba(5,10,25,0.9), rgba(10,20,50,0.9)),
                url('${pageContext.request.contextPath}/static/bg-placeholder.jpg') center/cover no-repeat fixed;
        }
        .app-layout { display:flex; min-height:100vh; backdrop-filter: blur(6px); }
        .sidebar {
            width:230px; padding:1.5rem 1.25rem;
            background: linear-gradient(190deg, rgba(15,23,42,0.78), rgba(15,23,42,0.55));
            border-right: 1px solid rgba(148,163,184,0.35);
            display:flex; flex-direction:column; gap:1.5rem;
            position: sticky; top: 0; align-self:flex-start; height:100vh; overflow-y:auto;
            backdrop-filter: blur(14px);
        }
        .sidebar-header { display:flex; align-items:center; gap:0.75rem; }
        .sidebar-logo { width:32px; height:32px; border-radius:999px; background: radial-gradient(circle at 30% 30%, #38bdf8, #6366f1); }
        .sidebar-title { font-size:1rem; font-weight:700; color:#fff; }
        .nav-section-title { font-size:0.75rem; color:#e5e7eb; letter-spacing:0.08em; margin-bottom:0.25rem; }
        .nav-group { display:flex; flex-direction:column; gap:0.3rem; }
        .nav-link {
            display:flex; align-items:center; gap:0.5rem; padding:0.5rem 0.75rem;
            border-radius:999px; color:#fff; font-weight:600; text-decoration:none; font-size:0.88rem;
            transition: all 0.2s;
        }
        .nav-link:hover { background: linear-gradient(90deg, rgba(56,189,248,0.12), rgba(129,140,248,0.12)); transform: translateX(2px); }
        .nav-link-active { background: linear-gradient(90deg, rgba(56,189,248,0.25), rgba(129,140,248,0.25)); }
        .nav-footer { margin-top:auto; font-size:0.75rem; color:#64748b; }

        .main { flex:1; padding:1.75rem 2rem; display:flex; flex-direction:column; }
        .main-header { margin-bottom:1.25rem; }
        .main-title { font-size:1.4rem; font-weight:700; color:#fff; }
        .main-subtitle { margin-top:0.35rem; color:#9ca3af; font-size:0.9rem; }

        .row { display:flex; flex-wrap:wrap; gap:1rem; align-items:stretch; }
        .col { flex:1 1 420px; display:flex; }
        .card {
            background: rgba(15,23,42,0.82);
            border-radius:16px; border:1px solid rgba(148,163,184,0.35);
            box-shadow: 0 24px 80px rgba(15,23,42,0.9);
            padding:1.5rem 1.6rem; display:flex; flex-direction:column; flex:1;
            min-height:760px;
        }
        .card h2 { font-size:1.02rem; color:#fff; margin-bottom:0.75rem; }
        .sub { color:#9ca3af; font-size:0.9rem; margin-bottom:0.9rem; }
        label { display:block; margin-bottom:0.35rem; color:#9ca3af; font-size:0.9rem; }
        input[type="text"] {
            width:100%; padding:0.5rem 0.75rem; margin-bottom:0.9rem; border-radius:8px;
            border:1px solid rgba(148,163,184,0.55); background: rgba(15,23,42,0.92); color:#e5e7eb;
        }
        .list-actions { display:flex; gap:0.5rem; flex-wrap:wrap; margin-bottom:0.3rem; }
        .btn {
            padding:0.45rem 0.9rem; background:#fff; color:#111827; border:1px solid rgba(209,213,219,0.9);
            border-radius:999px; font-size:0.84rem; font-weight:600; cursor:pointer; margin:0;
        }
        .btn-danger { background:#fef2f2; color:#991b1b; border-color:#fecaca; }
        .msg { margin-top:0.5rem; font-size:0.85rem; display:none; }
        .msg.err { color:#fca5a5; }
        .msg.ok { color:#4ade80; }

        .table-wrap { margin-top:0.75rem; border:1px solid rgba(148,163,184,0.35); border-radius:10px; overflow:auto; flex:1; min-height:0; }
        table { width:100%; border-collapse:collapse; min-width:760px; }
        th, td { padding:0.55rem 0.65rem; border-bottom:1px solid rgba(148,163,184,0.2); text-align:left; color:#e5e7eb; font-size:0.86rem; }
        th { position:sticky; top:0; background: rgba(30,41,59,0.95); color:#cbd5e1; z-index:2; }
        .mono { font-family: Consolas, "Courier New", monospace; }
        .title-cell { max-width:420px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
        .op-actions { display:flex; gap:0.35rem; white-space:nowrap; }

        .preview-wrap { margin-top:0.75rem; border:1px solid rgba(148,163,184,0.35); border-radius:10px; padding:0.5rem; background: rgba(15,23,42,0.92); }
        .preview-title { font-size:0.85rem; color:#9ca3af; margin-bottom:0.45rem; }
        #previewVideo { width:100%; max-height:300px; background:#000; border-radius:8px; }

        @media (max-width: 900px) {
            .app-layout { flex-direction:column; }
            .sidebar { width:100%; flex-direction:row; align-items:center; justify-content:space-between; padding:0.75rem 1rem; }
            .nav-group { flex-direction:row; flex-wrap:wrap; }
            .main { padding:1.25rem 1.25rem 1.75rem; }
            .card { min-height:auto; }
        }
    </style>
</head>
<body>
<div class="app-layout">
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo"></div>
            <div class="sidebar-title">B 站 · 跑酷对话视频</div>
        </div>
        <div>
            <div class="nav-section-title">导航</div>
            <div class="nav-group">
                <a href="${pageContext.request.contextPath}/" class="nav-link"><span>首页</span></a>
                <a href="${pageContext.request.contextPath}/bashboard" class="nav-link"><span>跑酷生成仪表盘</span></a>
                <a href="${pageContext.request.contextPath}/zhihu" class="nav-link"><span>QA 文本管理</span></a>
                <a href="${pageContext.request.contextPath}/video-manage" class="nav-link nav-link-active"><span>视频管理</span></a>
                <a href="${pageContext.request.contextPath}/test" class="nav-link"><span>接口与合成测试</span></a>
            </div>
        </div>
        <div class="nav-footer"><div>管理目录：Result</div></div>
    </aside>

    <main class="main">
        <div class="main-header">
            <div class="main-title">视频管理页面</div>
            <div class="main-subtitle">统一管理 Result 目录下以 _sub 结尾的 .mp4 文件，支持查询、删除、点击预览。</div>
        </div>

        <div class="row">
            <div class="col" style="flex: 7 1 0;">
                <div class="card">
                    <h2>列表与检索</h2>
                    <p class="sub">仅显示文件名以 _sub.mp4 结尾的视频文件，支持标题模糊搜索。</p>
                    <label>关键词（index / title 模糊搜索）</label>
                    <input type="text" id="keywordInput" placeholder="例如：12 或 吃饭吃什么" />
                    <div class="list-actions">
                        <button type="button" class="btn" id="searchBtn">搜索</button>
                        <button type="button" class="btn" id="resetBtn">重置</button>
                        <button type="button" class="btn" id="refreshBtn">刷新列表</button>
                    </div>
                    <div id="listMsg" class="msg"></div>

                    <div class="table-wrap">
                        <table>
                            <thead>
                            <tr>
                                <th style="width:70px;">Index</th>
                                <th>Title</th>
                                <th style="width:240px;">FileName</th>
                                <th style="width:160px;">操作</th>
                            </tr>
                            </thead>
                            <tbody id="videoTableBody"></tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col" style="flex: 5 1 0;">
                <div class="card">
                    <h2>预览面板</h2>
                    <p class="sub">点击左侧“预览”按钮即可播放；删除后列表自动刷新。</p>
                    <div class="preview-wrap">
                        <div class="preview-title" id="previewTitle">当前预览：未选择视频</div>
                        <video id="previewVideo" controls></video>
                    </div>
                    <div id="previewMsg" class="msg"></div>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
(function () {
    var keywordInput = document.getElementById('keywordInput');
    var searchBtn = document.getElementById('searchBtn');
    var resetBtn = document.getElementById('resetBtn');
    var refreshBtn = document.getElementById('refreshBtn');
    var listMsg = document.getElementById('listMsg');
    var previewMsg = document.getElementById('previewMsg');
    var videoTableBody = document.getElementById('videoTableBody');
    var previewVideo = document.getElementById('previewVideo');
    var previewTitle = document.getElementById('previewTitle');

    function showMsg(el, text, isErr) {
        el.textContent = text;
        el.className = 'msg ' + (isErr ? 'err' : 'ok');
        el.style.display = 'block';
    }
    function hideMsg(el) { el.style.display = 'none'; }
    function escapeHtml(str) {
        if (str == null) return '';
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function renderTable(items) {
        videoTableBody.innerHTML = '';
        if (!items || !items.length) {
            videoTableBody.innerHTML = '<tr><td colspan="4" style="color:#9ca3af;">暂无符合条件的视频文件。</td></tr>';
            return;
        }
        items.forEach(function (item) {
            var tr = document.createElement('tr');
            var fileName = item.fileName || '';
            var title = item.title || '';
            tr.innerHTML = '' +
                '<td class="mono">' + escapeHtml(item.index || '') + '</td>' +
                '<td class="title-cell" title="' + escapeHtml(title) + '">' + escapeHtml(title) + '</td>' +
                '<td class="mono" title="' + escapeHtml(fileName) + '">' + escapeHtml(fileName) + '</td>' +
                '<td><div class="op-actions">' +
                '<button type="button" class="btn" data-action="preview">预览</button>' +
                '<button type="button" class="btn btn-danger" data-action="delete">删除</button>' +
                '</div></td>';

            tr.querySelector('button[data-action="preview"]').addEventListener('click', function () {
                previewTitle.textContent = '当前预览：' + fileName;
                previewVideo.src = '${pageContext.request.contextPath}/api/video/manage/preview?fileName=' + encodeURIComponent(fileName);
                previewVideo.load();
                hideMsg(previewMsg);
            });
            tr.querySelector('button[data-action="delete"]').addEventListener('click', function () {
                doDelete(fileName);
            });
            videoTableBody.appendChild(tr);
        });
    }

    function fetchList() {
        hideMsg(listMsg);
        var keyword = (keywordInput.value || '').trim();
        var url = '${pageContext.request.contextPath}/api/video/manage/list';
        if (keyword) {
            url += '?keyword=' + encodeURIComponent(keyword);
        }
        fetch(url, { method: 'GET' })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (res.code === 200 && res.data) {
                    renderTable(res.data);
                    showMsg(listMsg, '已加载 ' + res.data.length + ' 条视频记录。', false);
                } else {
                    renderTable([]);
                    showMsg(listMsg, res.message || '加载失败。', true);
                }
            })
            .catch(function (err) {
                renderTable([]);
                showMsg(listMsg, '请求失败：' + (err.message || err), true);
            });
    }

    function doDelete(fileName) {
        if (!fileName) {
            showMsg(previewMsg, '删除失败：文件名为空。', true);
            return;
        }
        if (!window.confirm('确认删除文件：' + fileName + ' ?')) {
            return;
        }
        hideMsg(previewMsg);
        var body = new URLSearchParams();
        body.append('fileName', fileName);
        fetch('${pageContext.request.contextPath}/api/video/manage/delete', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: body.toString()
        })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (res.code === 200) {
                    showMsg(previewMsg, '删除成功：' + fileName, false);
                    if (previewVideo.src && previewVideo.src.indexOf(encodeURIComponent(fileName)) >= 0) {
                        previewVideo.removeAttribute('src');
                        previewVideo.load();
                        previewTitle.textContent = '当前预览：未选择视频';
                    }
                    fetchList();
                } else {
                    showMsg(previewMsg, res.message || '删除失败。', true);
                }
            })
            .catch(function (err) {
                showMsg(previewMsg, '请求失败：' + (err.message || err), true);
            });
    }

    searchBtn.addEventListener('click', fetchList);
    refreshBtn.addEventListener('click', fetchList);
    resetBtn.addEventListener('click', function () {
        keywordInput.value = '';
        fetchList();
    });
    keywordInput.addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            fetchList();
        }
    });

    fetchList();
})();
</script>
</body>·
</html>