<?php
// ডেটাবেজের কাজ, সেশন এবং পেজের সাধারণ ডিজাইন/ফাংশন ব্যবহার করার জন্য lib.php যুক্ত করা হয়েছে।
require 'lib.php';
// ব্যবহারকারী Admin হিসেবে লগইন করেছে কি না যাচাই করা হচ্ছে।
need('admin');
// Form-এর Dropdown-এ দেখানোর জন্য Semester ও Department-এর নাম।
$SEM = []; foreach (['1st','2nd','3rd','4th','5th','6th','7th','8th','9th','10th','11th','12th'] as $s) $SEM[] = "$s Semester";
$DEP = ['CSE', 'EEE', 'BBA', 'English'];

// Foreign Key Dropdown-এর জন্য প্রয়োজনীয় SQL Query রাখা হয়েছে।
$FK = [
 'course'  => "SELECT course_id id, course_code label FROM courses",
 'student' => "SELECT student_id id, CONCAT(student_id,' - ',student_name) label FROM students",
 'exam'    => "SELECT e.exam_id id, CONCAT(c.course_code,' - ',e.exam_type,' (',e.semester,')') label FROM exams e JOIN courses c ON c.course_id=e.course_id",
 'sched'   => "SELECT es.schedule_id id, CONCAT(c.course_code,' | ',DATE_FORMAT(es.exam_date,'%d %b %Y'),' ',TIME_FORMAT(es.start_time,'%h:%i %p')) label FROM exam_schedules es JOIN exams e ON e.exam_id=es.exam_id JOIN courses c ON c.course_id=e.course_id",
 'room'    => "SELECT room_id id, CONCAT(building,'-',room_number,' (cap ',capacity,')') label FROM rooms",
 'inv'     => "SELECT invigilator_code id, CONCAT(invigilator_code,' - ',invigilator_name) label FROM invigilators",
 'alloc'   => "SELECT a.allocation_id id, CONCAT(c.course_code,' | ',a.intake_section,' | ',r.building,'-',r.room_number) label FROM exam_room_allocations a JOIN exam_schedules es ON es.schedule_id=a.schedule_id JOIN exams e ON e.exam_id=es.exam_id JOIN courses c ON c.course_id=e.course_id JOIN rooms r ON r.room_id=a.room_id",
 'sec'     => "SELECT DISTINCT intake_section id, intake_section label FROM students",
];
function fk($n) { global $FK; return array_column(rows($FK[$n] . ' ORDER BY label ASC'), 'label', 'id'); }

// Dropdown-এর জন্য Database থেকে ID ও Label নিয়ে Option তৈরি করা হয়।
$M = [
 'students'     => ['Students', '🎓', 'students', 'student_id', 0, [
    'student_id' => ['Student ID', 'number'], 'student_name' => ['Name', 'text'], 'email' => ['Email', 'auto'],
    'department' => ['Department', 'sel', $DEP], 'intake_section' => ['Intake - Section', 'text', 'e.g. 55-1'], 'semester' => ['Semester', 'sel', $SEM]]],
 'courses'      => ['Courses', '📚', 'courses', 'course_id', 1, [
    'course_code' => ['Course Code', 'text'], 'course_name' => ['Course Name', 'text'], 'credit' => ['Credit', 'number'], 'department' => ['Department', 'sel', $DEP]]],
 'enrollments'  => ['Enrollments', '📝', 'enrollments', 'enrollment_id', 1, [
    'student_id' => ['Student', 'fk', 'student'], 'course_id' => ['Course', 'fk', 'course'], 'semester' => ['Semester', 'sel', $SEM]]],
 'rooms'        => ['Rooms', '🏫', 'rooms', 'room_id', 1, [
    'building' => ['Building', 'text'], 'room_number' => ['Room Number', 'text'], 'capacity' => ['Capacity', 'number']]],
 'invigilators' => ['Invigilators', '👩‍🏫', 'invigilators', 'invigilator_id', 1, [
    'invigilator_code' => ['Invigilator Code', 'text'], 'invigilator_name' => ['Name', 'text'], 'email' => ['Email', 'auto'], 'department' => ['Department', 'sel', $DEP]]],
 'exams'        => ['Exams', '📄', 'exams', 'exam_id', 1, [
    'course_id' => ['Course', 'fk', 'course'], 'exam_type' => ['Exam Type', 'sel', ['Final Exam', 'Mid Exam', 'Makeup Exam']], 'academic_year' => ['Academic Year', 'text'], 'semester' => ['Semester', 'sel', $SEM]]],
 'schedules'    => ['Exam Schedules', '🗓️', 'exam_schedules', 'schedule_id', 1, [
    'exam_id' => ['Exam', 'fk', 'exam'], 'exam_date' => ['Exam Date', 'date'], 'start_time' => ['Start Time', 'time'], 'end_time' => ['End Time', 'time']]],
 'duties'       => ['Invigilator Duty', '👁️', 'invigilator_assignments', 'assignment_id', 1, [
    'allocation_id' => ['Room Allocation', 'fk', 'alloc'], 'invigilator_code' => ['Invigilator', 'fk', 'inv']]],
];
// URL থেকে কোন Admin Page দেখাতে হবে তা নির্ধারণ করা হয়।
$t = $_GET['t'] ?? 'dash';
// Menu-এর জন্য Icon, Name এবং Link তৈরি করা হয়।
$mi = fn($k) => [$M[$k][1], $M[$k][0], "?t=$k"];
// Admin Panel-এর Sidebar Menu তৈরি করা হয়েছে।
$menu = [
 '_o' => 'Overview', 'dash' => ['📊', 'Dashboard', '?t=dash'],
 '_p' => 'People', 'students' => $mi('students'), 'invigilators' => $mi('invigilators'),
 '_a' => 'Academic', 'courses' => $mi('courses'), 'rooms' => $mi('rooms'), 'enrollments' => $mi('enrollments'),
 '_e' => 'Exam Setup', 'exams' => $mi('exams'), 'schedules' => $mi('schedules'), 'alloc' => ['🚪', 'Room Allocation', '?t=alloc'], 'duties' => $mi('duties'),
 '_r' => 'Reports', 'routine' => ['📋', 'Exam Routine', '?t=routine'], 'conflicts' => ['⚠️', 'Conflicts', '?t=conflicts'],
 'roomreport' => ['🪑', 'Room Allocation Report', '?t=roomreport'], 'coursereport' => ['📖', 'Student Course Report', '?t=coursereport'],
];

// Automatic Room Allocation Function
// Student-দের জন্য Room-এর Seat স্বয়ংক্রিয়ভাবে বরাদ্দ করা হয়।
function autoAlloc($sid, $sec, $room) {
    global $pdo;
    // নির্বাচিত Exam Schedule-এর Course ও Semester বের করা হচ্ছে।
    $x = q("SELECT e.course_id,e.semester FROM exam_schedules es JOIN exams e ON e.exam_id=es.exam_id WHERE es.schedule_id=?", [$sid])->fetch();
    // এই Course ও Semester-এর নির্বাচিত Section-এর Student বের করা হচ্ছে।
    // যাদের এই Exam-এর জন্য Room দেওয়া হয়নি, শুধু তাদের নেওয়া হচ্ছে।
    $ids = array_column(rows("SELECT s.student_id FROM students s JOIN enrollments en ON en.student_id=s.student_id AND en.course_id=? AND en.semester=?
        WHERE s.intake_section=? AND s.student_id NOT IN (SELECT ers.student_id FROM exam_room_students ers JOIN exam_room_allocations a ON a.allocation_id=ers.allocation_id WHERE a.schedule_id=?)
        ORDER BY s.student_id ASC", [$x['course_id'], $x['semester'], $sec, $sid]), 'student_id');
    // কোনো Student না পাওয়া গেলে Function এখানেই শেষ হবে।
    if (!$ids) return 'No unassigned students found for this section and exam.';
    // প্রতিটি Room-এ কতটি Seat খালি আছে তা বের করা হচ্ছে।
    // Admin-এর পছন্দের Room-কে আগে রাখা হচ্ছে।
    $rooms = rows("SELECT r.room_id, r.capacity-COALESCE((SELECT SUM(allocated_seats) FROM exam_room_allocations WHERE room_id=r.room_id AND schedule_id=?),0) free
        FROM rooms r ORDER BY r.room_id=? DESC, r.capacity DESC, r.room_id ASC", [$sid, $room]);
    // একটির পর একটি Room-এ Student বসানো হচ্ছে।
    foreach ($rooms as $r) {
        if (!$ids) break;
        // Room-এর খালি Seat এবং বাকি Student-এর মধ্যে ছোট সংখ্যাটি নেওয়া হচ্ছে।
        $n = min($r['free'], count($ids));
        if ($n <= 0) continue;
        try {
            // Room Allocation-এর তথ্য Database-এ Save করা হচ্ছে।
            q("INSERT INTO exam_room_allocations (schedule_id,room_id,intake_section,allocated_seats) VALUES (?,?,?,?)", [$sid, $r['room_id'], $sec, $n]);
            // নতুন Allocation-এর ID নেওয়া হচ্ছে।
            $a = $pdo->lastInsertId();
            // বরাদ্দ করা Room-এর সঙ্গে Student-দের যুক্ত করা হচ্ছে।
            foreach (array_splice($ids, 0, $n) as $i) q("INSERT INTO exam_room_students (allocation_id,student_id) VALUES (?,?)", [$a, $i]);
        } catch (PDOException $e) { 
        // একই সময়ে Room-এ অন্য Exam থাকলে পরবর্তী Room চেষ্টা করা হবে।    
        if (strpos($e->getMessage(), '45000') === false) throw $e; }
    }
    // সব Student-এর Room না হলে কতজন বাকি আছে তা জানানো হয়।
    return $ids ? count($ids) . ' student(s) are still unassigned: not enough free rooms at this time.' : '';
}

// ---------- POST actions ----------
// Form Submit হলে Database-এর তথ্য পরিবর্তনের কাজ এখানে করা হয়।
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $act = $_POST['act'] ?? '';
    try {
        // Room Allocation Form Submit হলে Automatic Allocation চালানো হয়।
        if ($act == 'alloc') {
            $r = autoAlloc((int)$_POST['sid'], $_POST['sec'], (int)$_POST['room']);
            flash($r ? 'err' : 'ok', $r ?: 'Room allocated and students assigned automatically.');
        } 
        // Admin কোনো Room Allocation Delete করলে এই অংশ কাজ করে।
        elseif ($act == 'delalloc') {
            q("DELETE FROM exam_room_allocations WHERE allocation_id=?", [$_POST['id']]); flash('ok', 'Allocation deleted.');
        } 
        // Students, Courses, Rooms ইত্যাদি Module-এর CRUD কাজ।
        elseif (isset($M[$t])) {
            [, , $tb, $pk, $auto, $cols] = $M[$t];
            // Delete Action
            if ($act == 'del') { q("DELETE FROM $tb WHERE $pk=?", [$_POST['id']]); flash('ok', 'Deleted successfully.'); }
            else {
                // Form থেকে আসা তথ্য সংগ্রহ করা হচ্ছে।
                $v = []; foreach ($cols as $c => $d) if ($d[1] != 'auto') $v[$c] = trim($_POST[$c] ?? '');
                // Invigilator Code বড় হাতের অক্ষরে রাখা হচ্ছে।
                if ($t == 'invigilators') $v['invigilator_code'] = strtoupper($v['invigilator_code']);
                // Student-এর Intake-Section 55-1-এর মতো হতে হবে।
                if ($t == 'students' && !preg_match('/^\d{2}-\d{1,2}$/', $v['intake_section'])) {
                    flash('err', 'Intake - Section must be like 55-1 (intake number, then section). Intake alone is not allowed.');
                    header('Location: ?t=' . $t); exit;
                }
                // Edit করার সময় কোন Record পরিবর্তন হবে তার ID নেওয়া হচ্ছে।
                $sid_ = ($_POST['_id'] ?? '') !== '' ? $_POST['_id'] : ($v['student_id'] ?? '');
                // Edit Action
                if (($_POST['_id'] ?? '') !== '') {
                    $set = []; $p = [];
                    // Student-এর Email স্বয়ংক্রিয়ভাবে তৈরি করা হচ্ছে।
                    if ($t == 'students') $v['email'] = $sid_ . '@bubt.edu.bd';
                    // Invigilator-এর Email স্বয়ংক্রিয়ভাবে তৈরি করা হচ্ছে।
                    if ($t == 'invigilators') $v['email'] = strtolower($v['invigilator_code']) . '@bubt.edu.bd';
                    foreach ($v as $c => $x) { if ($c == $pk) continue; $set[] = "$c=?"; $p[] = $x; }
                    $p[] = $_POST['_id'];
                    // SQL UPDATE Query দিয়ে তথ্য পরিবর্তন করা হচ্ছে।
                    q("UPDATE $tb SET " . implode(',', $set) . " WHERE $pk=?", $p); flash('ok', 'Updated successfully.');
                } else {
                // নতুন Record Insert করার জন্য Column ও Value তৈরি করা হচ্ছে।    
                if ($t == 'students') $v['email'] = $sid_ . '@bubt.edu.bd';
                    if ($t == 'invigilators') $v['email'] = strtolower($v['invigilator_code']) . '@bubt.edu.bd';
                    // SQL INSERT Query দিয়ে নতুন তথ্য Save করা হচ্ছে।
                    q("INSERT INTO $tb (" . implode(',', array_keys($v)) . ") VALUES (" . implode(',', array_fill(0, count($v), '?')) . ")", array_values($v)); flash('ok', 'Saved successfully.');
                }
            }
        }
    } catch (PDOException $e) 
    // Database-এ কোনো Error হলে Error Message দেখানো হয়।
    { flash('err', err($e)); }
    // কাজ শেষ হলে একই Page-এ Redirect করা হয়।
    header('Location: ?t=' . $t); exit;
}
// Form-এর Input Field তৈরি করার Function।
function field($c, $d, $v) {
    $l = $d[0]; $ty = $d[1];
    // Foreign Key Dropdown তৈরি করা হচ্ছে।
    if ($ty == 'sel' || $ty == 'fk') {
        $o = $ty == 'fk' ? fk($d[2]) : array_combine($d[2], $d[2]);
        $s = '<label>' . h($l) . '<select name="' . h($c) . '" required><option value="">Select ' . h($l) . '</option>';
        foreach ($o as $k => $x) $s .= '<option value="' . h($k) . '"' . ((string)$k === (string)$v ? ' selected' : '') . '>' . h($x) . '</option>';
        return $s . '</select></label>';
    }
    // Number Input-এর জন্য Minimum ও Step নির্ধারণ করা হচ্ছে।
    $ex = $ty == 'number' ? ' step="any" min="0"' : '';
    // Invigilator Code বড় হাতের অক্ষরে দেখানো হয়।
    if ($c == 'invigilator_code') $ex .= ' style="text-transform:uppercase"';
    // Intake-Section-এর Format যাচাই করা হয়।
    if ($c == 'intake_section') $ex .= ' pattern="\d{2}-\d{1,2}" title="Format: 55-1 (intake, then section)"';
    return '<label>' . h($l) . '<input type="' . $ty . '" name="' . h($c) . '" value="' . h($v) . '" placeholder="Enter ' . h(strtolower($l)) . (($ty == 'text' && isset($d[2])) ? ' (' . h($d[2]) . ')' : '') . '" required' . $ex . '></label>';
}

// Dashboard-এর তথ্য Bar Chart আকারে দেখানোর Function।
function bars($title, $d) {
    $max = max($d ?: [1]) ?: 1;
    echo '<div class="card"><h3>' . h($title) . '</h3>';
    foreach ($d as $l => $v) echo '<div class="bar"><span>' . h($l) . '</span><div><i style="width:' . round($v / $max * 100) . '%"></i></div><b>' . $v . '</b></div>';
    if (!$d) echo '<p class="empty">No data yet</p>';
    echo '</div>';
}
// Semester অনুযায়ী তথ্য Donut Chart আকারে দেখানোর Function।
function donut($title, $d) {
    $tot = array_sum($d) ?: 1; $cols = ['#4a2370', '#7a4d9e', '#b08fd0', '#2e1445', '#a53a62', '#d8c9e6']; $a = 0; $g = []; $lg = ''; $i = 0;
    foreach ($d as $l => $v) { $s = $a / $tot * 100; $a += $v; $c = $cols[$i++ % 6]; $g[] = "$c $s% " . ($a / $tot * 100) . '%'; $lg .= '<div class="lg"><u style="background:' . $c . '"></u>' . h($l) . ' <b>' . $v . '</b></div>'; }
    echo '<div class="card"><h3>' . h($title) . '</h3><div class="dn"><div class="ring" style="background:conic-gradient(' . implode(',', $g ?: ['#e6dff0 0% 100%']) . ')"></div><div>' . $lg . '</div></div></div>';
}

// Conflict Check-এর Function।
// Exam Schedule-এ বিভিন্ন ধরনের সমস্যা খুঁজে বের করা হয়।
function conflict_checks() {
    $r = fn($a, $b) => tm($a) . ' - ' . tm($b);
    $pair = fn($x) => [h($x['lbl']), dt($x['d']), h($x['a']), $r($x['s1'], $x['f1']), h($x['b']), $r($x['s2'], $x['f2'])];
    $ph = ['Date', 'Course 1', 'Time 1', 'Course 2', 'Time 2'];
    return [
     // একই Student-এর দুইটি Exam একই সময়ে পড়ছে কি না।
     ['Student exam clashes', 'A student has two exams at overlapping times on the same day.', array_merge(['Student'], $ph),
      "SELECT CONCAT(s.student_id,' - ',s.student_name) lbl, es1.exam_date d, c1.course_code a, es1.start_time s1, es1.end_time f1, c2.course_code b, es2.start_time s2, es2.end_time f2
       FROM enrollments en1 JOIN enrollments en2 ON en1.student_id=en2.student_id AND en1.course_id<en2.course_id AND en1.semester=en2.semester
       JOIN students s ON s.student_id=en1.student_id
       JOIN exams e1 ON e1.course_id=en1.course_id JOIN exams e2 ON e2.course_id=en2.course_id
       JOIN exam_schedules es1 ON es1.exam_id=e1.exam_id JOIN exam_schedules es2 ON es2.exam_id=e2.exam_id
       JOIN courses c1 ON c1.course_id=e1.course_id JOIN courses c2 ON c2.course_id=e2.course_id
       WHERE es1.schedule_id<>es2.schedule_id AND es1.exam_date=es2.exam_date AND e1.academic_year=e2.academic_year AND e1.semester=e2.semester
       AND es1.start_time<es2.end_time AND es1.end_time>es2.start_time ORDER BY s.student_id ASC", $pair],
     // একই Room-এ একই সময়ে দুইটি Exam রাখা হয়েছে কি না।
     ['Room double booking', 'The same room is used by two exams at overlapping times.', array_merge(['Room'], $ph),
      "SELECT DISTINCT CONCAT(r.building,'-',r.room_number) lbl, es1.exam_date d, c1.course_code a, es1.start_time s1, es1.end_time f1, c2.course_code b, es2.start_time s2, es2.end_time f2
       FROM exam_room_allocations a1 JOIN exam_room_allocations a2 ON a2.room_id=a1.room_id AND a2.schedule_id>a1.schedule_id
       JOIN rooms r ON r.room_id=a1.room_id
       JOIN exam_schedules es1 ON es1.schedule_id=a1.schedule_id JOIN exam_schedules es2 ON es2.schedule_id=a2.schedule_id
       JOIN exams e1 ON e1.exam_id=es1.exam_id JOIN courses c1 ON c1.course_id=e1.course_id
       JOIN exams e2 ON e2.exam_id=es2.exam_id JOIN courses c2 ON c2.course_id=e2.course_id
       WHERE es1.exam_date=es2.exam_date AND es1.start_time<es2.end_time AND es1.end_time>es2.start_time ORDER BY d ASC", $pair],
     // Room-এর Capacity এবং বরাদ্দ করা Seat-এর মধ্যে গরমিল আছে কি না।
     ['Room capacity / Seat mismatch', 'Assigned students are more than the room capacity, or different from the allocated seats.', ['Course', 'Intake - Section', 'Room', 'Capacity', 'Allocated', 'Assigned'],
      "SELECT c.course_code, era.intake_section, CONCAT(r.building,'-',r.room_number) room, r.capacity, era.allocated_seats seats, COUNT(ers.student_id) assigned
       FROM exam_room_allocations era JOIN exam_schedules es ON es.schedule_id=era.schedule_id JOIN exams e ON e.exam_id=es.exam_id
       JOIN courses c ON c.course_id=e.course_id JOIN rooms r ON r.room_id=era.room_id
       LEFT JOIN exam_room_students ers ON ers.allocation_id=era.allocation_id
       GROUP BY era.allocation_id, c.course_code, era.intake_section, r.building, r.room_number, r.capacity, era.allocated_seats
       HAVING assigned > r.capacity OR assigned <> era.allocated_seats",
      fn($x) => [h($x['course_code']), h(isec($x['intake_section'])), h($x['room']), h($x['capacity']), h($x['seats']), h($x['assigned'])]],
     // একই Exam-এর জন্য কোনো Student একাধিক Room-এ আছে কি না।
      ['Student in multiple rooms', 'A student is assigned to more than one room for the same exam.', ['Course', 'Student', 'Rooms'],
      "SELECT c.course_code, CONCAT(s.student_id,' - ',s.student_name) lbl, COUNT(DISTINCT era.room_id) n
       FROM exam_room_students ers JOIN exam_room_allocations era ON era.allocation_id=ers.allocation_id
       JOIN exam_schedules es ON es.schedule_id=era.schedule_id JOIN exams e ON e.exam_id=es.exam_id
       JOIN courses c ON c.course_id=e.course_id JOIN students s ON s.student_id=ers.student_id
       GROUP BY es.schedule_id, c.course_code, s.student_id, s.student_name HAVING COUNT(DISTINCT era.room_id)>1",
      fn($x) => [h($x['course_code']), h($x['lbl']), h($x['n'])]],
     // কোনো Invigilator-এর দুইটি Duty একই সময়ে পড়ছে কি না।
      ['Invigilator duty clashes', 'An invigilator has two duties at overlapping times on the same day.', array_merge(['Invigilator'], $ph),
      "SELECT CONCAT(ia1.invigilator_code,' - ',i.invigilator_name) lbl, es1.exam_date d, c1.course_code a, es1.start_time s1, es1.end_time f1, c2.course_code b, es2.start_time s2, es2.end_time f2
       FROM invigilator_assignments ia1 JOIN invigilator_assignments ia2 ON ia2.invigilator_code=ia1.invigilator_code AND ia2.assignment_id>ia1.assignment_id
       JOIN invigilators i ON i.invigilator_code=ia1.invigilator_code
       JOIN exam_room_allocations a1 ON a1.allocation_id=ia1.allocation_id JOIN exam_room_allocations a2 ON a2.allocation_id=ia2.allocation_id
       JOIN exam_schedules es1 ON es1.schedule_id=a1.schedule_id JOIN exam_schedules es2 ON es2.schedule_id=a2.schedule_id
       JOIN exams e1 ON e1.exam_id=es1.exam_id JOIN courses c1 ON c1.course_id=e1.course_id
       JOIN exams e2 ON e2.exam_id=es2.exam_id JOIN courses c2 ON c2.course_id=e2.course_id
       WHERE es1.exam_date=es2.exam_date AND es1.start_time<es2.end_time AND es1.end_time>es2.start_time ORDER BY d ASC", $pair],
    ];
}

// Admin Panel-এর Header ও Sidebar দেখানো হচ্ছে।
top($t == 'dash' ? 'Admin Dashboard' : ($M[$t][0] ?? ($t == 'alloc' ? 'Room Allocation' : ($t == 'conflicts' ? 'Conflict Check' : ($t == 'roomreport' ? 'Room Allocation Report' : ($t == 'coursereport' ? 'Student Course Report' : 'Exam Routine'))))), $menu, $t);
// Dashboard Section
// এখানে মোট Record, Conflict Status এবং বিভিন্ন Chart দেখানো হয়।
if ($t == 'dash') {
    // সব ধরনের Conflict Check করে মোট Conflict গণনা করা হচ্ছে।
    $nc = 0; foreach (conflict_checks() as $c) $nc += count(rows($c[3]));
     // Conflict পাওয়া গেলে Warning, না পাওয়া গেলে Success Message দেখানো হয়।
    echo '<a href="?t=conflicts" style="text-decoration:none"><div class="alert ' . ($nc ? 'err' : 'ok') . '">' . ($nc ? "⚠️ $nc conflict(s) found. Click to view." : '✅ No conflicts found in the exam schedule.') . '</div></a>';
    echo '<div class="stats">';
     // Database-এর বিভিন্ন Table-এ মোট কত Record আছে তা দেখানো হয়।
    foreach (['students' => ['🎓', 'Students'], 'courses' => ['📚', 'Courses'], 'rooms' => ['🏫', 'Rooms'], 'invigilators' => ['👩‍🏫', 'Invigilators'], 'exams' => ['🗂️', 'Exams'], 'exam_room_allocations' => ['🪑', 'Allocations']] as $tb => $i)
        echo '<div class="stat"><span>' . $i[0] . ' ' . $i[1] . '</span><b>' . q("SELECT COUNT(*) FROM $tb")->fetchColumn() . '</b></div>';
    echo '</div><div class="grid2">';
    // Intake-Section অনুযায়ী Student-এর সংখ্যা Bar Chart-এ দেখানো হয়।
    bars('Students per Intake - Section', array_column(rows("SELECT intake_section l, COUNT(*) v FROM students GROUP BY intake_section ORDER BY intake_section ASC"), 'v', 'l'));
    // Semester অনুযায়ী Student-এর সংখ্যা Donut Chart-এ দেখানো হয়।
    donut('Students by Semester', array_column(rows("SELECT semester l, COUNT(*) v FROM students GROUP BY semester ORDER BY semester ASC"), 'v', 'l'));
    // প্রতিদিন কতটি Exam আছে তা Chart-এ দেখানো হয়।
    bars('Exams per Day', array_column(array_map(fn($x) => ['l' => dt($x['d']), 'v' => $x['v']], rows("SELECT exam_date d, COUNT(*) v FROM exam_schedules GROUP BY exam_date ORDER BY exam_date ASC")), 'v', 'l'));
    // প্রতিটি Room-এ মোট কতটি Seat বরাদ্দ করা হয়েছে তা দেখানো হয়।
    bars('Seats Allocated per Room', array_column(rows("SELECT CONCAT(r.building,'-',r.room_number) l, COALESCE(SUM(a.allocated_seats),0) v FROM rooms r LEFT JOIN exam_room_allocations a ON a.room_id=r.room_id GROUP BY r.room_id ORDER BY r.room_id ASC"), 'v', 'l'));
    // প্রতিটি Invigilator-এর মোট Duty দেখানো হয়।
    bars('Duties per Invigilator', array_column(rows("SELECT i.invigilator_code l, COUNT(ia.assignment_id) v FROM invigilators i LEFT JOIN invigilator_assignments ia ON ia.invigilator_code=i.invigilator_code GROUP BY i.invigilator_code ORDER BY i.invigilator_code ASC"), 'v', 'l'));
    echo '</div><h3>Upcoming exams</h3>';
    // Dashboard-এর পর Upcoming Exam Routine দেখানোর জন্য Page পরিবর্তন করা হয়।
    $t = 'routine';
}
// এখানে সব Exam-এর Routine দেখানো হয়।
// Department অনুযায়ী Routine Filter করার সুবিধাও রয়েছে।
if ($t == 'routine') {
    // URL থেকে নির্বাচিত Department নেওয়া হচ্ছে।
    $dept = $_GET['dept'] ?? '';
    // Routine Page সরাসরি ওপেন হলে Department Filter দেখানো হয়।
    if (($_GET['t'] ?? '') == 'routine') {
        echo '<form method="get" class="card form" style="max-width:320px"><input type="hidden" name="t" value="routine"><label>Department<select name="dept" onchange="this.form.submit()"><option value="">All Departments</option>';
        // Department-এর Dropdown তৈরি করা হচ্ছে।
        foreach ($DEP as $x) echo '<option' . ($x == $dept ? ' selected' : '') . '>' . h($x) . '</option>';
        echo '</select></label></form>';
    }
    // complete_exam_routine View থেকে সম্পূর্ণ Exam Routine নেওয়া হচ্ছে।
    // Department নির্বাচন করা থাকলে শুধু সেই Department-এর Exam দেখানো হবে।
    $d = rows("SELECT r.*, c.department FROM complete_exam_routine r JOIN courses c ON c.course_code=r.course_code" . ($dept !== '' ? " WHERE c.department=?" : "") . " ORDER BY r.exam_date ASC, r.start_time ASC, r.course_code ASC, r.intake_section ASC", $dept !== '' ? [$dept] : []);
    // Routine-এর তথ্য Table আকারে দেখানো হচ্ছে।
    tbl(['Course', 'Department', 'Date', 'Time', 'Intake - Section', 'Room', 'Students', 'Invigilators'],
        array_map(fn($x) => [h($x['course_code'] . ' - ' . $x['course_name']), h($x['department']), dt($x['exam_date']), tm($x['start_time']) . ' - ' . tm($x['end_time']), h(isec($x['intake_section'])), h($x['building'] . '-' . $x['room_number']), h($x['total_students']), 
        // একাধিক Invigilator থাকলে আলাদা আলাদা করে দেখানো হচ্ছে।
        implode('', array_map(fn($n) => '<div class="iv">' . h($n) . '</div>', explode(', ', (string)$x['invigilators'])))], $d));
}
// CONFLICT REPORT:
// Exam Schedule, Room এবং Invigilator-এর মধ্যে কোনো Conflict আছে কি না দেখায়। 
elseif ($t == 'conflicts') {
    // সব Conflict Check চালিয়ে পাওয়া Result এখানে রাখা হচ্ছে।
    $res = []; $tot = 0;
    foreach (conflict_checks() as $c) { $d = rows($c[3]); $tot += count($d); $res[] = [$c, $d]; }
    // মোট Conflict থাকলে Warning, না থাকলে Success Message দেখানো হয়।
    echo '<div class="alert ' . ($tot ? 'err' : 'ok') . '">' . ($tot ? "⚠️ $tot conflict(s) found. Please fix them below." : '✅ All checks passed. No conflicts found.') . '</div>';
    // প্রতিটি Conflict আলাদা Section-এ দেখানো হচ্ছে।
    foreach ($res as [$c, $d]) {
    // Conflict-এর নাম এবং কতটি সমস্যা পাওয়া গেছে তা দেখানো হয়।    
    echo '<h3>' . ($d ? '❌ ' : '✅ ') . h($c[0]) . ' <span class="badge">' . count($d) . '</span></h3><p style="margin:-6px 0 12px;color:#7a6b8a;font-size:14px">' . h($c[1]) . '</p>';
        if ($d) tbl($c[2], array_map($c[4], $d), true); else echo '<div class="alert ok">No conflicts.</div>';
    }
} 
// ROOM ALLOCATION:
// এখানে Exam-এর জন্য Room বরাদ্দ করা হয়।
elseif ($t == 'alloc') {
// Admin Schedule, Intake-Section এবং Preferred Room নির্বাচন করবেন।
// একটি Room-এ সব Student না ধরলে অন্য Free Room-এ বাকি Student যাবে।    
    echo '<div class="card"><h3>Allocate a room</h3><p style="margin-top:-8px;color:#7a6b8a;font-size:14px">If the section is bigger than the room, the remaining students are placed in other free rooms automatically.</p><form method="post" class="form"><input type="hidden" name="act" value="alloc">';
    // Exam Schedule, Section এবং Preferred Room-এর Dropdown তৈরি করা হচ্ছে।
    echo field('sid', ['Exam Schedule', 'fk', 'sched'], '') . field('sec', ['Intake - Section', 'fk', 'sec'], '') . field('room', ['Preferred Room', 'fk', 'room'], '');
    echo '<button class="btn">Allocate rooms</button></form></div>';
    // Database থেকে আগে করা সব Room Allocation-এর তথ্য নেওয়া হচ্ছে।
    $d = rows("SELECT a.allocation_id,c.course_code,es.exam_date,es.start_time,es.end_time,a.intake_section,r.building,r.room_number,a.allocated_seats
        FROM exam_room_allocations a JOIN exam_schedules es ON es.schedule_id=a.schedule_id JOIN exams e ON e.exam_id=es.exam_id JOIN courses c ON c.course_id=e.course_id JOIN rooms r ON r.room_id=a.room_id
        ORDER BY a.allocation_id ASC");
    // Allocation-এর তথ্য Table-এ দেখানো হচ্ছে।
    // এখান থেকে Admin চাইলে Allocation Delete করতে পারবেন।
    tbl(['ID', 'Course', 'Date', 'Time', 'Intake - Section', 'Room', 'Seats', 'Action'],
        array_map(fn($x) => [$x['allocation_id'], h($x['course_code']), dt($x['exam_date']), tm($x['start_time']) . ' - ' . tm($x['end_time']), h(isec($x['intake_section'])), h($x['building'] . '-' . $x['room_number']), $x['allocated_seats'],
            '<form method="post" class="inl" onsubmit="return confirm(\'Delete this allocation?\')"><input type="hidden" name="act" value="delalloc"><input type="hidden" name="id" value="' . $x['allocation_id'] . '"><button class="btn sm red">Delete</button></form>'], $d), true);
} 
// ROOM ALLOCATION REPORT:
// Room-এর Capacity, Allocated Seat এবং Assigned Student তুলনা করে।
elseif ($t == 'roomreport') {
    // room_allocation_report View থেকে Report-এর তথ্য নেওয়া হচ্ছে।
    $d = rows("SELECT * FROM room_allocation_report ORDER BY exam_date ASC, start_time ASC, course_code ASC, intake_section ASC");
    // প্রতিটি Room-এর Capacity ও Student Assignment দেখানো হচ্ছে।
    tbl(['Course', 'Date', 'Time', 'Intake - Section', 'Room', 'Capacity', 'Allocated', 'Students', 'Status'],
        array_map(fn($x) => [h($x['course_code'] . ' - ' . $x['course_name']), dt($x['exam_date']), tm($x['start_time']) . ' - ' . tm($x['end_time']), h(isec($x['intake_section'])), h($x['building'] . '-' . $x['room_number']), h($x['capacity']), h($x['allocated_seats']), h($x['total_students']),
            ($x['total_students'] > $x['capacity'] || $x['total_students'] != $x['allocated_seats']) ? '<span class="badge" style="margin:0">⚠️ Mismatch</span>' : '✅ OK'], $d), true);
} 
// STUDENT COURSE REPORT:
// কোন Course-এ কোন Student Enroll করেছে তা দেখায়।
elseif ($t == 'coursereport') {
    $cc = $_GET['course'] ?? ''; $sm = $_GET['sem'] ?? '';
    echo '<form method="get" class="card form" style="max-width:640px"><input type="hidden" name="t" value="coursereport"><label>Course<select name="course" onchange="this.form.submit()"><option value="">All Courses</option>';
    foreach (rows("SELECT course_code, course_name FROM courses ORDER BY course_code ASC") as $x)
        echo '<option value="' . h($x['course_code']) . '"' . ($x['course_code'] == $cc ? ' selected' : '') . '>' . h($x['course_code'] . ' - ' . $x['course_name']) . '</option>';
    echo '</select></label><label>Semester<select name="sem" onchange="this.form.submit()"><option value="">All Semesters</option>';
    foreach ($SEM as $x) echo '<option' . ($x == $sm ? ' selected' : '') . '>' . h($x) . '</option>';
    echo '</select></label></form>';
    $w = []; $p = [];
    if ($cc !== '') { $w[] = 'course_code=?'; $p[] = $cc; }
    if ($sm !== '') { $w[] = 'semester=?'; $p[] = $sm; }
    $d = rows("SELECT * FROM student_course_report" . ($w ? ' WHERE ' . implode(' AND ', $w) : '') . " ORDER BY course_code ASC, student_id ASC", $p);
    $g = []; foreach ($d as $x) $g[$x['course_code'] . ' - ' . $x['course_name']][] = $x;
    $heads = ['Student ID', 'Name', 'Department', 'Intake - Section', 'Semester'];
    echo '<div class="stats"><div class="stat"><span>📖 Courses</span><b>' . count($g) . '</b></div><div class="stat"><span>🎓 Total students</span><b>' . count(array_unique(array_column($d, 'student_id'))) . '</b></div></div>';
    foreach ($g as $title => $list) {
        echo '<h3>' . h($title) . ' <span class="badge">' . count($list) . ' student(s)</span></h3>';
        tbl($heads, array_map(fn($x) => [h($x['student_id']), h($x['student_name']), h($x['department']), h(isec($x['intake_section'])), h($x['semester'])], $list), true);
    }
    if (!$g) tbl($heads, []);
} 
// GENERAL CRUD SECTION:
// Students, Courses, Rooms, Exams ইত্যাদির Add/Edit/Delete কাজ এখানে হয়।
elseif (isset($M[$t])) {
    // নির্বাচিত Module-এর Configuration নেওয়া হচ্ছে।
    [$title, , $tb, $pk, $auto, $cols] = $M[$t];
    // Edit Button চাপলে Database থেকে সংশ্লিষ্ট Record নেওয়া হচ্ছে।
    $edit = isset($_GET['e']) ? q("SELECT * FROM $tb WHERE $pk=?", [$_GET['e']])->fetch() : null;
    // Add অথবা Edit Form তৈরি করা হচ্ছে।
    echo '<div class="card"><h3>' . ($edit ? 'Edit' : 'Add') . ' ' . h($title) . '</h3><form method="post" class="form">';
    // Edit করার সময় কোন Record পরিবর্তন হবে তার ID Hidden Field-এ রাখা হয়।
    if ($edit) echo '<input type="hidden" name="_id" value="' . h($edit[$pk]) . '">';
    // Configuration অনুযায়ী Form-এর Input Field তৈরি করা হচ্ছে।
    foreach ($cols as $c => $d) {
        if ($d[1] == 'auto') continue;
        // Edit করার সময় Primary Key পরিবর্তন করা যাবে না।
        if ($edit && $c == $pk) { echo '<label>' . h($d[0]) . '<input value="' . h($edit[$c]) . '" disabled></label>'; continue; }
        // Field Function ব্যবহার করে Input তৈরি করা হচ্ছে
        echo field($c, $d, $edit[$c] ?? '');
    }
    if ($t == 'students') echo '<p style="grid-column:1/-1;margin:0;color:#7a6b8a;font-size:13px">Email is generated automatically: student id@bubt.edu.bd</p>';
    if ($t == 'invigilators') echo '<p style="grid-column:1/-1;margin:0;color:#7a6b8a;font-size:13px">Email is generated automatically: invigilator code@bubt.edu.bd</p>';
    // Add-এর সময় Save এবং Edit-এর সময় Save Changes Button দেখানো হয়।
    echo '<div><button class="btn">' . ($edit ? 'Save changes' : 'Save') . '</button> ' . ($edit ? '<a class="btn light" href="?t=' . $t . '">Cancel</a>' : '') . '</div></form></div>';
    // Table-এ কোন কোন Column দেখানো হবে তা নির্ধারণ করা হচ্ছে।
    $show = $auto ? [$pk => ['ID', 'id']] + $cols : $cols;
    // Foreign Key-এর ID-এর পরিবর্তে সংশ্লিষ্ট নাম দেখানোর জন্য Map তৈরি করা হয়।
    $maps = []; foreach ($cols as $c => $d) if ($d[1] == 'fk') $maps[$c] = fk($d[2]);
    // Database থেকে Module-এর সব Record নেওয়া হচ্ছে।
    $data = rows("SELECT * FROM $tb ORDER BY $pk ASC");
    $out = [];
    // প্রতিটি Record-এর তথ্য Table-এর Row হিসেবে তৈরি করা হচ্ছে।
    foreach ($data as $r) {
        $line = [];
        foreach ($show as $c => $d) {
            $val = $r[$c];
            if ($d[1] == 'fk') $val = $maps[$c][$val] ?? $val;
            $line[] = $d[1] == 'time' ? tm($val) : ($d[1] == 'date' ? dt($val) : h($val));
        }
        // প্রতিটি Record-এর পাশে Edit ও Delete Button যোগ করা হচ্ছে।
        $line[] = '<a class="btn sm light" href="?t=' . $t . '&e=' . urlencode($r[$pk]) . '">Edit</a> <form method="post" class="inl" onsubmit="return confirm(\'Delete this record?\')"><input type="hidden" name="act" value="del"><input type="hidden" name="id" value="' . h($r[$pk]) . '"><button class="btn sm red">Delete</button></form>';
        $out[] = $line;
    }
    // সব Record Table আকারে দেখানো হচ্ছে।
    tbl(array_merge(array_column($show, 0), ['Action']), $out, true);
}
// Admin Page-এর Footer দেখিয়ে HTML Page সম্পন্ন করা হচ্ছে।
bottom();