<?php
require 'lib.php';
$role = $_SESSION['role'] ?? '';
if (!in_array($role, ['student', 'invigilator'])) { header('Location: index.php'); exit; }
$id = $_SESSION['u']['id'];
$p = $_GET['p'] ?? 'dash';

$base = "FROM exam_room_allocations era
  JOIN exam_schedules es ON es.schedule_id=era.schedule_id
  JOIN exams e ON e.exam_id=es.exam_id
  JOIN courses c ON c.course_id=e.course_id
  JOIN rooms r ON r.room_id=era.room_id";

// stat cards: [[label, value], ...]
function stats($items) {
    echo '<div class="stats">';
    foreach ($items as $x) echo '<div class="stat"><span>' . h($x[0]) . '</span><b>' . h($x[1]) . '</b></div>';
    echo '</div>';
}
// profile card: avatar + name + details grid
function profile($u, $f) {
    echo '<div class="card"><div class="phead"><div class="av">' . h(strtoupper(substr($u['name'], 0, 1))) . '</div><div><h3 style="margin:0 0 6px">' . h($u['name']) . '</h3><span class="badge" style="margin:0">' . h($u['badge']) . '</span></div></div><div class="prof">';
    foreach ($f as $l => $v) echo '<div><span>' . h($l) . '</span><b>' . h($v) . '</b></div>';
    echo '</div></div>';
}

if ($role == 'student') {
    $menu = [
        '_o' => 'Overview', 'dash' => ['📊', 'Dashboard', '?p=dash'],
        '_e' => 'Exams', 'routine' => ['🗓️', 'My Exam Routine', '?p=routine'], 'courses' => ['📚', 'My Courses', '?p=courses'],
        '_a' => 'Account', 'profile' => ['👤', 'My Profile', '?p=profile'],
    ];
    $my = "$base JOIN exam_room_students ers ON ers.allocation_id=era.allocation_id WHERE ers.student_id=?";
    $cols = "c.course_code,c.course_name,es.exam_date,es.start_time,es.end_time,r.building,r.room_number";

    if ($p == 'courses') {
        top('My Courses', $menu, 'courses');
        $d = rows("SELECT c.course_code,c.course_name,c.credit,en.semester FROM enrollments en JOIN courses c ON c.course_id=en.course_id WHERE en.student_id=? ORDER BY c.course_code ASC", [$id]);
        tbl(['Course Code', 'Course Name', 'Credit', 'Semester'], array_map(fn($x) => array_map('h', array_values($x)), $d));
    } elseif ($p == 'profile') {
        top('My Profile', $menu, 'profile');
        $s = q("SELECT * FROM students WHERE student_id=?", [$id])->fetch();
        profile($_SESSION['u'], ['Student ID' => $s['student_id'], 'Name' => $s['student_name'], 'Email' => $s['email'], 'Department' => $s['department'],
            'Intake - Section' => isec($s['intake_section']), 'Semester' => $s['semester']]);
    } elseif ($p == 'routine') {
        top('My Exam Routine', $menu, 'routine');
        $d = rows("SELECT $cols $my ORDER BY es.exam_date ASC, es.start_time ASC", [$id]);
        tbl(['Course Code', 'Course Name', 'Date', 'Time', 'Room'], array_map(fn($x) => [h($x['course_code']), h($x['course_name']), dt($x['exam_date']), tm($x['start_time']) . ' - ' . tm($x['end_time']), h($x['building'] . '-' . $x['room_number'])], $d));
    } else {
        top('Dashboard', $menu, 'dash');
        $nc = q("SELECT COUNT(*) FROM enrollments WHERE student_id=?", [$id])->fetchColumn();
        $ne = q("SELECT COUNT(*) $my", [$id])->fetchColumn();
        $nx = q("SELECT c.course_code, es.exam_date, DATEDIFF(es.exam_date, CURDATE()) days $my AND es.exam_date>=CURDATE() ORDER BY es.exam_date ASC, es.start_time ASC LIMIT 1", [$id])->fetch();
        stats([['📚 Courses', $nc], ['🗓️ Exams', $ne], ['📅 Next exam', $nx ? date('d M', strtotime($nx['exam_date'])) : '-'],
            ['📖 Next course', $nx ? $nx['course_code'] : '-'], ['⏳ Days left', $nx ? $nx['days'] : '-']]);
        echo '<h3>Upcoming exams</h3>';
        $d = rows("SELECT $cols $my AND es.exam_date>=CURDATE() ORDER BY es.exam_date ASC, es.start_time ASC", [$id]);
        tbl(['Course Code', 'Course Name', 'Date', 'Time', 'Room'], array_map(fn($x) => [h($x['course_code']), h($x['course_name']), dt($x['exam_date']), tm($x['start_time']) . ' - ' . tm($x['end_time']), h($x['building'] . '-' . $x['room_number'])], $d));
    }
} else {
    $menu = [
        '_o' => 'Overview', 'dash' => ['📊', 'Dashboard', '?p=dash'],
        '_d' => 'Duties', 'duties' => ['👁️', 'My Duties', '?p=duties'],
        '_a' => 'Account', 'profile' => ['👤', 'My Profile', '?p=profile'],
    ];
    $my = "$base JOIN invigilator_assignments ia ON ia.allocation_id=era.allocation_id WHERE ia.invigilator_code=?";
    $cols = "c.course_code,c.course_name,es.exam_date,es.start_time,es.end_time,era.intake_section,r.building,r.room_number,era.allocated_seats";
    $heads = ['Course Code', 'Course Name', 'Date', 'Time', 'Intake - Section', 'Room', 'Students'];
    $map = fn($x) => [h($x['course_code']), h($x['course_name']), dt($x['exam_date']), tm($x['start_time']) . ' - ' . tm($x['end_time']), h(isec($x['intake_section'])), h($x['building'] . '-' . $x['room_number']), h($x['allocated_seats'])];

    if ($p == 'duties') {
        top('My Invigilation Duties', $menu, 'duties');
        tbl($heads, array_map($map, rows("SELECT $cols $my ORDER BY es.exam_date ASC, es.start_time ASC", [$id])));
    } elseif ($p == 'profile') {
        top('My Profile', $menu, 'profile');
        $s = q("SELECT * FROM invigilators WHERE invigilator_code=?", [$id])->fetch();
        profile($_SESSION['u'], ['Invigilator Code' => $s['invigilator_code'], 'Name' => $s['invigilator_name'], 'Email' => $s['email'], 'Department' => $s['department']]);
    } else {
        top('Dashboard', $menu, 'dash');
        $t = q("SELECT COUNT(*) n, COUNT(DISTINCT es.exam_date) days, COALESCE(SUM(era.allocated_seats),0) st $my", [$id])->fetch();
        $nx = q("SELECT es.exam_date, DATEDIFF(es.exam_date, CURDATE()) days $my AND es.exam_date>=CURDATE() ORDER BY es.exam_date ASC, es.start_time ASC LIMIT 1", [$id])->fetch();
        stats([['🧑‍🏫 Total duties', $t['n']], ['🗓️ Exam days', $t['days']], ['🎓 Students', $t['st']],
            ['📅 Next duty', $nx ? date('d M', strtotime($nx['exam_date'])) : '-'], ['⏳ Days left', $nx ? $nx['days'] : '-']]);
        echo '<h3>Upcoming duties</h3>';
        tbl($heads, array_map($map, rows("SELECT $cols $my AND es.exam_date>=CURDATE() ORDER BY es.exam_date ASC, es.start_time ASC", [$id])));
    }
}
bottom();
