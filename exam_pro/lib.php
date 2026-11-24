<?php
session_start();
date_default_timezone_set('Asia/Dhaka'); // all date()/time() use Bangladesh time
// ---- DB settings (XAMPP default) ----
$pdo = new PDO('mysql:host=127.0.0.1;dbname=database_project;charset=utf8mb4', 'root', '', [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

function h($s) { return htmlspecialchars((string)$s, ENT_QUOTES); }
function q($sql, $p = []) { global $pdo; $s = $pdo->prepare($sql); $s->execute($p); return $s; }
function rows($sql, $p = []) { return q($sql, $p)->fetchAll(); }
function tm($t) { return $t ? date('h:i A', strtotime($t)) : ''; }
function dt($d) { return $d ? date('d M Y', strtotime($d)) : ''; }
function isec($s) { $x = explode('-', $s) + [1 => '']; return "Intake {$x[0]} - Section {$x[1]}"; }
function flash($t, $m) { $_SESSION['msg'] = [$t, $m]; }
function need($role) { if (($_SESSION['role'] ?? '') != $role) { header('Location: index.php'); exit; } }

// Show the trigger's own message (e.g. "Room is already booked!") to the user
function err($e) {
    $m = $e->getMessage();
    if (preg_match('/1644 (.*)$/s', $m, $x)) return trim($x[1]);
    if (stripos($m, 'Duplicate') !== false) return 'This record already exists.';
    if (stripos($m, 'foreign key') !== false) return 'Linked data is missing or still in use, so this action is not allowed.';
    return 'Database error: ' . $m;
}

// role => [label, main table, id column, login table, login key, id label, name column]
function roles() {
    return [
        'student'     => ['Student', 'students', 'student_id', 'student_logins', 'student_id', 'Student ID', 'student_name'],
        'invigilator' => ['Invigilator', 'invigilators', 'invigilator_code', 'invigilator_logins', 'invigilator_code', 'Invigilator Code', 'invigilator_name'],
        'admin'       => ['Admin', 'admins', 'username', 'admin_logins', 'admin_id', 'Admin Username', 'full_name'],
    ];
}

// Common page layout (same for admin / student / invigilator)
function top($title, $menu, $act) {
    $u = $_SESSION['u'];
    $m = $_SESSION['msg'] ?? null; unset($_SESSION['msg']);
    echo '<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>' . h($title) . ' - Exam System</title><link rel="stylesheet" href="style.css"></head><body>';
    echo '<aside class="sb"><div class="brand">Exam<span>Pro</span></div>';
    foreach ($menu as $k => $it) {
        if (is_string($it)) { echo '<div class="grp">' . h($it) . '</div>'; continue; } // section heading
        echo '<a href="' . $it[2] . '" class="' . ($k == $act ? 'on' : '') . '"><span>' . $it[0] . '</span>' . h($it[1]) . '</a>';
    }
    echo '<a href="logout.php" class="out"><span>🔒</span>Logout</a></aside><main>';
    echo '<div class="phd"><div><div class="pb">Exam<span>Pro</span></div><h1>' . h($title) . '</h1></div><div class="pm">Generated on ' . date('d M Y, h:i A') . '<br>By ' . h($u['name']) . ' (' . h($u['badge']) . ')</div></div>';
    echo '<header><h1>' . h($title) . '</h1><div><b>' . h($u['name']) . '</b> <span class="badge">' . h($u['badge']) . '</span></div></header><section>';
    if ($m) echo '<div class="alert ' . $m[0] . '">' . h($m[1]) . '</div>';
}

function bottom() {
    echo '</section><footer>© ' . date('Y') . ' Exam Management System</footer></main>';
    echo '<script>function f(i){var t=i.value.toLowerCase();i.closest(".card").querySelectorAll("tbody tr").forEach(function(r){r.style.display=r.innerText.toLowerCase().indexOf(t)>-1?"":"none"})}</script></body></html>';
}

// Table with search bar + Download PDF (browser "Save as PDF")
function tbl($heads, $rows, $np = false) {
    echo '<div class="card"><div class="tools"><input class="srch" placeholder="🔍 Search..." oninput="f(this)"><button class="btn" onclick="window.print()">⬇ Download PDF</button></div><div class="wrap"><table class="' . ($np ? 'np' : '') . '"><thead><tr>';
    foreach ($heads as $x) echo '<th>' . h($x) . '</th>';
    echo '</tr></thead><tbody>';
    foreach ($rows as $r) { echo '<tr>'; foreach ($r as $c) echo '<td' . (strpos($c, '<') === false && mb_strlen(html_entity_decode($c)) <= 22 ? ' class="n"' : '') . '>' . $c . '</td>'; echo '</tr>'; }
    if (!$rows) echo '<tr><td colspan="' . count($heads) . '" class="empty">No data found</td></tr>';
    echo '</tbody></table></div></div>';
}
