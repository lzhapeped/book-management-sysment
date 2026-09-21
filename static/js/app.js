// 主前端脚本：图书馆预约管理系统
// 所有注释使用中文，便于学习
const host = "/api";
let currentUser = null;
let chart, pie1, pie2, catPie, seatPie, floorBar, topReader;
let editRd, editBk, editSt, editBr;

function isAdmin() {
    return currentUser && currentUser.role === "admin";
}

function isReader() {
    return currentUser && currentUser.role === "reader";
}

function setAppVisible(isLoggedIn) {
    document.getElementById("login").style.display = isLoggedIn ? "none" : "block";
    document.getElementById("main").style.display = isLoggedIn ? "block" : "none";
}

function updateUserInfo() {
    const info = document.getElementById("user_info");
    const switchBtn = document.getElementById("switch_account_btn");
    if (currentUser) {
        info.innerHTML = `用户：${currentUser.username}　｜　角色：${currentUser.role === 'admin' ? '管理员' : '读者'}`;
        switchBtn.style.display = "inline-block";
    } else {
        info.innerHTML = "";
        switchBtn.style.display = "none";
    }
}

function applyRoleUI() {
    const role = currentUser ? currentUser.role : "admin";
    const tabs = Array.from(document.querySelectorAll(".tab button"));
    const visibleTabs = {
        admin: ["home", "reader", "book", "seat", "borrow"],
        reader: ["home", "book", "seat", "borrow"]
    };
    const tabNames = ["home", "reader", "book", "seat", "borrow"];
    tabs.forEach((btn, index) => {
        const name = tabNames[index];
        btn.style.display = (visibleTabs[role] || visibleTabs.admin).includes(name) ? "" : "none";
    });
    document.querySelectorAll(".panel-actions, .form-row").forEach(el => {
        el.style.display = isAdmin() ? "" : "none";
    });
    const homeBtn = tabs.find(btn => btn.innerText.includes("首页"));
    if (homeBtn) showPanel("home", homeBtn);
}

function showPanel(id, btn) {
    document.querySelectorAll(".panel").forEach(p => p.style.display = "none");
    document.getElementById(id).style.display = "block";
    document.querySelectorAll(".tab button").forEach(b => b.classList.remove("active"));
    btn.classList.add("active");
    if (id === "home") refreshDash();
}

function normalizeDateString(value) {
    if (!value) return "";
    if (typeof value !== "string") return "";
    if (value.includes("T")) return value.split("T")[0];
    let parsed = new Date(value);
    if (!isNaN(parsed.getTime())) {
        let y = parsed.getFullYear();
        let m = String(parsed.getMonth() + 1).padStart(2, "0");
        let d = String(parsed.getDate()).padStart(2, "0");
        return `${y}-${m}-${d}`;
    }
    return value;
}

function normalizeDateTimeString(value) {
    if (!value) return "";
    if (typeof value !== "string") return "";
    return value.replace("T", " ").replace("Z", "").substring(0, 19);
}

async function login() {
    let u = document.getElementById("login_user").value;
    let p = document.getElementById("login_pwd").value;
    let r = await fetch(host + "/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: u, password: p }),
        credentials: "include"
    });
    let d = await r.json();
    alert(d.msg);
    if (d.msg === "登录成功") {
        currentUser = d.user;
        setAppVisible(true);
        updateUserInfo();
        applyRoleUI();
        refreshDash();
        rdList();
        bkList();
        stList();
        brList();
    }
}

async function switchAccount() {
    try {
        await fetch(host + "/logout", { method: "POST", credentials: "include" });
    } catch (e) {}
    currentUser = null;
    setAppVisible(false);
    updateUserInfo();
    document.getElementById("login_user").value = "";
    document.getElementById("login_pwd").value = "";
}

async function refreshDash() {
    if (!currentUser) return;
    let rd = await fetch(host + "/reader/list", { credentials: "include" }).then(r => r.json());
    let bk = await fetch(host + "/book/list", { credentials: "include" }).then(r => r.json());
    let st = await fetch(host + "/seat/list", { credentials: "include" }).then(r => r.json());
    let br = await fetch(host + "/borrow_reserve/list", { credentials: "include" }).then(r => r.json());

    let studentCnt = rd.filter(r => r[2] == "学生").length;
    let staffCnt = rd.length - studentCnt;
    let canBorrow = bk.reduce((sum, b) => sum + (Number(b[7]) || 0), 0);
    let pendingCnt = br.filter(b => b[12] == "待完成").length;

    document.getElementById("reader_cnt").innerText = rd.length;
    document.getElementById("book_cnt").innerText = bk.length;
    document.getElementById("seat_cnt").innerText = st.length;
    document.getElementById("br_cnt").innerText = br.length;
    document.getElementById("can_borrow_cnt").innerText = canBorrow;
    document.getElementById("pending_cnt").innerText = pendingCnt;

    // 数量统计柱状图
    if (chart) chart.dispose();
    chart = echarts.init(document.getElementById("chart"));
    chart.setOption({
        xAxis: { type: "category", data: ["读者", "图书", "座位", "借阅记录"] },
        yAxis: { type: "value" },
        series: [{ type: "bar", data: [rd.length, bk.length, st.length, br.length], itemStyle: { color: "#42a5f5" } }]
    });

    // 读者类型分布
    if (pie1) pie1.dispose();
    pie1 = echarts.init(document.getElementById("pie1"));
    pie1.setOption({
        series: [{
            type: "pie",
            radius: ["40%", "70%"],
            data: [{ value: studentCnt, name: "学生" }, { value: staffCnt, name: "教工" }]
        }]
    });

    // 借阅状态分布
    let stateMap = {};
    br.forEach(b => { let s = b[12] || '未知'; stateMap[s] = (stateMap[s] || 0) + 1; });
    let stateData = Object.keys(stateMap).map(k => ({ name: k, value: stateMap[k] }));
    if (pie2) pie2.dispose();
    pie2 = echarts.init(document.getElementById("pie2"));
    pie2.setOption({ series: [{ type: "pie", data: stateData }] });

    // 图书分类分布
    let catMap = {};
    bk.forEach(b => { let c = b[3] || '未知'; catMap[c] = (catMap[c] || 0) + 1; });
    let catData = Object.keys(catMap).map(k => ({ name: k, value: catMap[k] }));
    if (catPie) catPie.dispose();
    catPie = echarts.init(document.getElementById("cat_pie"));
    catPie.setOption({ series: [{ type: "pie", data: catData }] });

    // 座位状态分布
    let seatStatusMap = {};
    st.forEach(s => { let ss = s[3] || '未知'; seatStatusMap[ss] = (seatStatusMap[ss] || 0) + 1; });
    let seatStatusData = Object.keys(seatStatusMap).map(k => ({ name: k, value: seatStatusMap[k] }));
    if (seatPie) seatPie.dispose();
    seatPie = echarts.init(document.getElementById("seat_pie"));
    seatPie.setOption({ series: [{ type: "pie", data: seatStatusData }] });

    // 楼层座位数量
    let floorMap = {};
    st.forEach(s => { let f = s[1]; floorMap[f + '楼'] = (floorMap[f + '楼'] || 0) + 1; });
    if (floorBar) floorBar.dispose();
    floorBar = echarts.init(document.getElementById("floor_bar"));
    floorBar.setOption({
        xAxis: { type: 'category', data: Object.keys(floorMap) },
        yAxis: { type: 'value' },
        series: [{ type: 'bar', data: Object.values(floorMap), itemStyle: { color: '#66bb6a' } }]
    });

    // 读者借阅次数TOP5
    let readerBorrowMap = {};
    br.forEach(b => { readerBorrowMap[b[1]] = (readerBorrowMap[b[1]] || 0) + 1; });
    let readerArr = Object.keys(readerBorrowMap).map(k => ({ rid: k, count: readerBorrowMap[k] }));
    readerArr.sort((a, b) => b.count - a.count);
    let top5 = readerArr.slice(0, 5);
    if (topReader) topReader.dispose();
    topReader = echarts.init(document.getElementById("top_reader"));
    topReader.setOption({
        xAxis: { type: 'category', data: top5.map(x => x.rid) },
        yAxis: { type: 'value' },
        series: [{ type: 'bar', data: top5.map(x => x.count), itemStyle: { color: '#ff9800' } }]
    });

    // 借阅状态汇总文本
    document.getElementById("state_summary").innerHTML = Object.keys(stateMap).map(k => `${k}:${stateMap[k]}`).join("　");

    document.getElementById("analysis_text").innerHTML = `
    共管理读者 ${rd.length} 名（学生 ${studentCnt} 人、教工 ${staffCnt} 人）、图书 ${bk.length} 种、座位 ${st.length} 个。<br>
    借阅预约记录共 ${br.length} 条，其中待完成 ${pendingCnt} 条。<br>
    图书馆可借图书合计 ${canBorrow} 册，数据实时同步MySQL数据库，支持增删改查动态刷新。
    `;
}

// ===================== 读者管理 (reader表) =====================
async function rdList() {
    let d = await fetch(host + "/reader/list", { credentials: "include" }).then(r => r.json());
    renderRdTable(d);
}
async function rdSearch() {
    let kw = document.getElementById("rd_search_input").value.trim();
    let all = await fetch(host + "/reader/list", { credentials: "include" }).then(r => r.json());
    let res = all.filter(r =>
        r[0].includes(kw) || r[1].includes(kw) || (r[2] && r[2].includes(kw)) ||
        (r[3] && r[3].includes(kw))
    );
    renderRdTable(res);
}
function renderRdTable(data) {
    let h = `<table cellpadding="8" cellspacing="0" border="1" style="width:100%;border-collapse:collapse"><thead><tr><th>编号</th><th>姓名</th><th>类型</th><th>专业</th><th>手机号</th><th>邮箱</th><th>注册日期</th><th>状态</th></tr></thead><tbody>`;
    data.forEach(i => {
        let rd = normalizeDateString(i[6]);
        h += `<tr onclick="rdFill('${i[0]}','${i[1]}','${i[2]}','${i[3] || ''}','${i[4] || ''}','${i[5] || ''}','${i[7] || ''}')" style="cursor:pointer">`;
        h += `<td>${i[0]}</td><td>${i[1]}</td><td>${i[2]}</td><td>${i[3] || ''}</td><td>${i[4] || ''}</td><td>${i[5] || ''}</td><td>${rd}</td><td>${i[7] || ''}</td></tr>`;
    });
    h += `</tbody></table>`;
    document.getElementById("rd_table").innerHTML = h;
}
function rdFill(a, b, c, d, e, f, g) {
    editRd = a;
    document.getElementById("rd_rid").value = a;
    document.getElementById("rd_rname").value = b;
    document.getElementById("rd_rtype").value = c;
    document.getElementById("rd_rmajor").value = d;
    document.getElementById("rd_rphone").value = e;
    document.getElementById("rd_remail").value = f;
    document.getElementById("rd_rstatus").value = g;
}
async function rdAdd() {
    if (!isAdmin()) return alert("无权限：仅管理员可新增读者");
    let d = {
        rid: document.getElementById("rd_rid").value,
        rname: document.getElementById("rd_rname").value,
        rtype: document.getElementById("rd_rtype").value,
        rmajor: document.getElementById("rd_rmajor").value,
        rphone: document.getElementById("rd_rphone").value,
        remail: document.getElementById("rd_remail").value,
        rstatus: document.getElementById("rd_rstatus").value || "正常"
    };
    if (!d.rid || !d.rname) return alert("编号和姓名不能为空");
    let res = await (await fetch(host + "/reader/add", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    rdList();
    refreshDash();
}
async function rdUpdate() {
    if (!isAdmin()) return alert("无权限：仅管理员可修改读者");
    if (!editRd) return alert("请先点击表格选择要修改的读者");
    let d = {
        rid: editRd,
        rname: document.getElementById("rd_rname").value,
        rtype: document.getElementById("rd_rtype").value,
        rmajor: document.getElementById("rd_rmajor").value,
        rphone: document.getElementById("rd_rphone").value,
        remail: document.getElementById("rd_remail").value,
        rstatus: document.getElementById("rd_rstatus").value || "正常"
    };
    let res = await (await fetch(host + "/reader/update", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    rdList();
    refreshDash();
}
async function rdDel() {
    if (!isAdmin()) return alert("无权限：仅管理员可删除读者");
    if (!editRd) return alert("请先点击表格选择要删除的读者");
    if (!confirm("确认删除该读者吗？")) return;
    let res = await (await fetch(host + "/reader/delete", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ rid: editRd }), credentials: "include" })).json();
    alert(res.msg);
    editRd = null;
    ["rd_rid","rd_rname","rd_rtype","rd_rmajor","rd_rphone","rd_remail","rd_rstatus"].forEach(id => document.getElementById(id).value = "");
    rdList();
    refreshDash();
}

// ===================== 图书管理 (book表) =====================
async function bkList() {
    let d = await fetch(host + "/book/list", { credentials: "include" }).then(r => r.json());
    renderBkTable(d);
}
async function bkSearch() {
    let kw = document.getElementById("bk_search_input").value.trim();
    let all = await fetch(host + "/book/list", { credentials: "include" }).then(r => r.json());
    let res = all.filter(b =>
        b[0].includes(kw) || b[1].includes(kw) || (b[2] && b[2].includes(kw))
    );
    renderBkTable(res);
}
function renderBkTable(data) {
    let h = `<table cellpadding="8" cellspacing="0" border="1" style="width:100%;border-collapse:collapse"><thead><tr><th>ISBN</th><th>书名</th><th>作者</th><th>分类</th><th>出版社</th><th>出版日期</th><th>馆藏</th><th>可借</th><th>书架</th><th>定价</th></tr></thead><tbody>`;
    data.forEach(i => {
        let pd = normalizeDateString(i[5]);
        h += `<tr onclick="bkFill('${i[0]}','${i[1]}','${i[2]}','${i[3]}','${i[4] || ''}','${pd}','${i[6]}','${i[7]}','${i[8]}','${i[9]}')" style="cursor:pointer">`;
        h += `<td>${i[0]}</td><td>${i[1]}</td><td>${i[2]}</td><td>${i[3]}</td><td>${i[4] || ''}</td><td>${pd}</td><td>${i[6]}</td><td>${i[7]}</td><td>${i[8]}</td><td>${i[9]}</td></tr>`;
    });
    h += `</tbody></table>`;
    document.getElementById("bk_table").innerHTML = h;
}
function bkFill(a, b, c, d, e, f, g, h, i, j) {
    editBk = a;
    document.getElementById("bk_bid").value = a;
    document.getElementById("bk_bname").value = b;
    document.getElementById("bk_bauthor").value = c;
    document.getElementById("bk_bcategory").value = d;
    document.getElementById("bk_bpress").value = e;
    document.getElementById("bk_bpub_date").value = f;
    document.getElementById("bk_btotal").value = g;
    document.getElementById("bk_bcan_borrow").value = h;
    document.getElementById("bk_bshelf").value = i;
    document.getElementById("bk_bprice").value = j;
}
async function bkAdd() {
    if (!isAdmin()) return alert("无权限：仅管理员可新增图书");
    let d = {
        bid: document.getElementById("bk_bid").value,
        bname: document.getElementById("bk_bname").value,
        bauthor: document.getElementById("bk_bauthor").value,
        bcategory: document.getElementById("bk_bcategory").value,
        bpress: document.getElementById("bk_bpress").value,
        bpub_date: document.getElementById("bk_bpub_date").value,
        btotal: document.getElementById("bk_btotal").value,
        bcan_borrow: document.getElementById("bk_bcan_borrow").value,
        bshelf: document.getElementById("bk_bshelf").value,
        bprice: document.getElementById("bk_bprice").value
    };
    if (!d.bid || !d.bname) return alert("ISBN和书名不能为空");
    let res = await (await fetch(host + "/book/add", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    bkList();
    refreshDash();
}
async function bkUpdate() {
    if (!isAdmin()) return alert("无权限：仅管理员可修改图书");
    if (!editBk) return alert("请先点击表格选择要修改的图书");
    let d = {
        bid: editBk,
        bname: document.getElementById("bk_bname").value,
        bauthor: document.getElementById("bk_bauthor").value,
        bcategory: document.getElementById("bk_bcategory").value,
        bpress: document.getElementById("bk_bpress").value,
        bpub_date: document.getElementById("bk_bpub_date").value,
        btotal: document.getElementById("bk_btotal").value,
        bcan_borrow: document.getElementById("bk_bcan_borrow").value,
        bshelf: document.getElementById("bk_bshelf").value,
        bprice: document.getElementById("bk_bprice").value
    };
    let res = await (await fetch(host + "/book/update", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    bkList();
    refreshDash();
}
async function bkDel() {
    if (!isAdmin()) return alert("无权限：仅管理员可删除图书");
    if (!editBk) return alert("请先点击表格选择要删除的图书");
    if (!confirm("确认删除该图书吗？")) return;
    let res = await (await fetch(host + "/book/delete", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ bid: editBk }), credentials: "include" })).json();
    alert(res.msg);
    editBk = null;
    ["bk_bid","bk_bname","bk_bauthor","bk_bcategory","bk_bpress","bk_bpub_date","bk_btotal","bk_bcan_borrow","bk_bshelf","bk_bprice"].forEach(id => document.getElementById(id).value = "");
    bkList();
    refreshDash();
}

// ===================== 座位管理 (seat表) =====================
async function stList() {
    let d = await fetch(host + "/seat/list", { credentials: "include" }).then(r => r.json());
    renderStTable(d);
}
async function stSearch() {
    let kw = document.getElementById("st_search_input").value.trim();
    let all = await fetch(host + "/seat/list", { credentials: "include" }).then(r => r.json());
    let res = all.filter(s =>
        s[0].includes(kw) || String(s[1]).includes(kw) || (s[2] && s[2].includes(kw))
    );
    renderStTable(res);
}
function renderStTable(data) {
    let h = `<table cellpadding="8" cellspacing="0" border="1" style="width:100%;border-collapse:collapse"><thead><tr><th>座位编号</th><th>楼层</th><th>自习室</th><th>状态</th></tr></thead><tbody>`;
    data.forEach(i => {
        h += `<tr onclick="stFill('${i[0]}','${i[1]}','${i[2]}','${i[3]}')" style="cursor:pointer">`;
        h += `<td>${i[0]}</td><td>${i[1]}</td><td>${i[2]}</td><td>${i[3]}</td></tr>`;
    });
    h += `</tbody></table>`;
    document.getElementById("st_table").innerHTML = h;
}
function stFill(a, b, c, d) {
    editSt = a;
    document.getElementById("st_sid").value = a;
    document.getElementById("st_sfloor").value = b;
    document.getElementById("st_sroom").value = c;
    document.getElementById("st_sstatus").value = d;
}
async function stAdd() {
    if (!isAdmin()) return alert("无权限：仅管理员可新增座位");
    let d = {
        sid: document.getElementById("st_sid").value,
        sfloor: document.getElementById("st_sfloor").value,
        sroom: document.getElementById("st_sroom").value,
        sstatus: document.getElementById("st_sstatus").value || "空闲"
    };
    if (!d.sid || !d.sfloor || !d.sroom) return alert("座位编号、楼层、自习室不能为空");
    let res = await (await fetch(host + "/seat/add", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    stList();
    refreshDash();
}
async function stUpdate() {
    if (!isAdmin()) return alert("无权限：仅管理员可修改座位");
    if (!editSt) return alert("请先点击表格选择要修改的座位");
    let d = {
        sid: editSt,
        sfloor: document.getElementById("st_sfloor").value,
        sroom: document.getElementById("st_sroom").value,
        sstatus: document.getElementById("st_sstatus").value
    };
    let res = await (await fetch(host + "/seat/update", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    stList();
    refreshDash();
}
async function stDel() {
    if (!isAdmin()) return alert("无权限：仅管理员可删除座位");
    if (!editSt) return alert("请先点击表格选择要删除的座位");
    if (!confirm("确认删除该座位吗？")) return;
    let res = await (await fetch(host + "/seat/delete", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ sid: editSt }), credentials: "include" })).json();
    alert(res.msg);
    editSt = null;
    ["st_sid","st_sfloor","st_sroom","st_sstatus"].forEach(id => document.getElementById(id).value = "");
    stList();
    refreshDash();
}

// ===================== 借阅管理 (borrow_reserve表) =====================
async function brList() {
    let d = await fetch(host + "/borrow_reserve/list", { credentials: "include" }).then(r => r.json());
    renderBrTable(d);
}
async function brSearch() {
    let kw = document.getElementById("br_search_input").value.trim();
    let all = await fetch(host + "/borrow_reserve/list", { credentials: "include" }).then(r => r.json());
    let res = all.filter(b =>
        b[1].includes(kw) || (b[4] && b[4].includes(kw))
    );
    renderBrTable(res);
}
function renderBrTable(data) {
    let h = `<table cellpadding="8" cellspacing="0" border="1" style="width:100%;border-collapse:collapse"><thead><tr><th>记录号</th><th>读者编号</th><th>图书ISBN</th><th>座位号</th><th>类型</th><th>操作时间</th><th>截止时间</th><th>实际结束</th><th>续借</th><th>逾期天</th><th>罚款</th><th>缴费状态</th><th>借阅状态</th></tr></thead><tbody>`;
    data.forEach(i => {
        let ot = i[5] ? normalizeDateTimeString(String(i[5])) : '';
        let dl = i[6] ? normalizeDateTimeString(String(i[6])) : '';
        let re = i[7] ? normalizeDateTimeString(String(i[7])) : '';
        let bid = i[2] || '';
        let sid = i[3] || '';
        h += `<tr onclick="brFill('${i[0]}','${i[1]}','${bid}','${sid}','${i[4]}','${i[11]}','${i[12]}','${re}')" style="cursor:pointer">`;
        h += `<td>${i[0]}</td><td>${i[1]}</td><td>${bid}</td><td>${sid}</td><td>${i[4]}</td><td>${ot}</td><td>${dl}</td><td>${re}</td><td>${i[8]}</td><td>${i[9]}</td><td>${i[10]}</td><td>${i[11]}</td><td>${i[12]}</td></tr>`;
    });
    h += `</tbody></table>`;
    document.getElementById("br_table").innerHTML = h;
}
function brFill(a, b, c, d, e, f, g, h) {
    editBr = a;
    document.getElementById("br_rid").value = b;
    document.getElementById("br_bid").value = c;
    document.getElementById("br_sid").value = d;
    document.getElementById("br_type").value = e;
    document.getElementById("br_pay_state").value = f;
    document.getElementById("br_state").value = g;
    document.getElementById("br_real_end").value = h ? h.replace(" ", "T") : "";
}
async function brAdd() {
    let d = {
        rid: document.getElementById("br_rid").value,
        bid: document.getElementById("br_bid").value,
        sid: document.getElementById("br_sid").value,
        br_type: document.getElementById("br_type").value
    };
    if (!d.rid || !d.br_type) return alert("读者编号和借阅类型不能为空");
    let res = await (await fetch(host + "/borrow_reserve/add", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    brList();
    refreshDash();
}
async function brUpdate() {
    if (!editBr) return alert("请先点击表格选择要修改的记录");
    let d = {
        br_id: editBr,
        br_state: document.getElementById("br_state").value,
        pay_state: document.getElementById("br_pay_state").value,
        real_end: document.getElementById("br_real_end").value
    };
    let res = await (await fetch(host + "/borrow_reserve/update", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(d), credentials: "include" })).json();
    alert(res.msg);
    brList();
    refreshDash();
}
async function brDel() {
    if (!isAdmin()) return alert("无权限：仅管理员可删除借阅记录");
    if (!editBr) return alert("请先点击表格选择要删除的记录");
    if (!confirm("确认删除该借阅记录吗？")) return;
    let res = await (await fetch(host + "/borrow_reserve/delete", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ br_id: editBr }), credentials: "include" })).json();
    alert(res.msg);
    editBr = null;
    ["br_rid","br_bid","br_sid","br_type","br_state","br_pay_state","br_real_end"].forEach(id => document.getElementById(id).value = "");
    brList();
    refreshDash();
}

// 导出到全局以便 HTML 中按钮调用
window.showPanel = showPanel;
window.login = login;
window.switchAccount = switchAccount;
window.refreshDash = refreshDash;
window.rdList = rdList; window.rdSearch = rdSearch; window.rdAdd = rdAdd; window.rdUpdate = rdUpdate; window.rdDel = rdDel;
window.bkList = bkList; window.bkSearch = bkSearch; window.bkAdd = bkAdd; window.bkUpdate = bkUpdate; window.bkDel = bkDel;
window.stList = stList; window.stSearch = stSearch; window.stAdd = stAdd; window.stUpdate = stUpdate; window.stDel = stDel;
window.brList = brList; window.brSearch = brSearch; window.brAdd = brAdd; window.brUpdate = brUpdate; window.brDel = brDel;
