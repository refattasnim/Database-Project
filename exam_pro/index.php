<?php
require 'lib.php';
$a = $_GET['a'] ?? 'login';
$RL = roles();
$err = ''; $ok = ''; $step = 1; $qtext = '';
$post = $_SERVER['REQUEST_METHOD'] == 'POST';
$role = $_POST['role'] ?? '';
$id = trim($_POST['id'] ?? '');
$R = $RL[$role] ?? null;
$row = ($post && $R && $id !== '') ? q("SELECT * FROM {$R[1]} WHERE {$R[2]}=?", [$id])->fetch() : null;
$lg = $row ? q("SELECT * FROM {$R[3]} WHERE {$R[4]}=?", [$row[$R[4]]])->fetch() : null;

if ($post && $R) {
    if ($a == 'login') {
        if (!$row) $err = 'ID not found. Please create your account first, or ask the admin to add your ID.';
        elseif (!$lg) $err = 'No account created for this ID yet. Please create your account first.';
        elseif (!password_verify($_POST['pw'] ?? '', $lg['password_hash'])) $err = 'Invalid ID or password.';
        else {
            session_regenerate_id(true);
            $_SESSION['role'] = $role;
            $_SESSION['u'] = ['id' => $row[$R[4]], 'name' => $row[$R[6]],
                'badge' => $role == 'student' ? isec($row['intake_section']) : $R[0]];
            header('Location: ' . ($role == 'admin' ? 'admin.php' : 'portal.php')); exit;
        }
    } elseif ($a == 'register') {
        $pw = $_POST['pw'] ?? '';
        if (!$row) $err = 'This ID is not registered in the system. Please contact the admin.';
        elseif ($lg) $err = 'An account already exists for this ID. Please login.';
        elseif (strlen($pw) < 6) $err = 'Password must be at least 6 characters.';
        elseif ($pw !== ($_POST['pw2'] ?? '')) $err = 'Passwords do not match.';
        elseif (trim($_POST['ans'] ?? '') === '' || empty($_POST['qid'])) $err = 'Please choose a security question and answer it.';
        else {
            q("INSERT INTO {$R[3]} ({$R[4]},password_hash,security_question_id,security_answer_hash) VALUES (?,?,?,?)",
                [$row[$R[4]], password_hash($pw, PASSWORD_DEFAULT), $_POST['qid'], password_hash(strtolower(trim($_POST['ans'])), PASSWORD_DEFAULT)]);
            flash('ok', 'Account created. You can login now.');
            header('Location: index.php'); exit;
        }
    } elseif ($a == 'forgot') {
        if (!$lg) $err = 'No account found for this ID. Please create an account first.';
        else {
            $step = 2;
            $qtext = q("SELECT question_text FROM security_questions WHERE question_id=?", [$lg['security_question_id']])->fetchColumn();
            if (isset($_POST['ans'])) {
                $np = $_POST['np'] ?? '';
                if ($lg['reset_locked_until'] && strtotime($lg['reset_locked_until']) > time()) $err = 'Too many wrong answers. Try again after ' . date('h:i A', strtotime($lg['reset_locked_until'])) . '.';
                elseif (strlen($np) < 6) $err = 'New password must be at least 6 characters.';
                elseif (!password_verify(strtolower(trim($_POST['ans'])), $lg['security_answer_hash'])) {
                    $n = $lg['reset_attempts'] + 1;
                    q("UPDATE {$R[3]} SET reset_attempts=?, reset_locked_until=? WHERE {$R[4]}=?", [$n >= 5 ? 0 : $n, $n >= 5 ? date('Y-m-d H:i:s', time() + 900) : null, $row[$R[4]]]);
                    $err = $n >= 5 ? 'Too many wrong answers. Locked for 15 minutes.' : 'Wrong answer. Attempts used: ' . $n . ' of 5.';
                } else {
                    q("UPDATE {$R[3]} SET password_hash=?, reset_attempts=0, reset_locked_until=NULL WHERE {$R[4]}=?", [password_hash($np, PASSWORD_DEFAULT), $row[$R[4]]]);
                    flash('ok', 'Password reset successful. Please login.');
                    header('Location: index.php'); exit;
                }
            }
        }
    }
}
$m = $_SESSION['msg'] ?? null; unset($_SESSION['msg']);
$titles = ['login' => 'Welcome back', 'register' => 'Create your account', 'forgot' => 'Reset your password'];
$subs = ['login' => 'Login to see your exam schedule.', 'register' => 'Use the ID your admin added for you.', 'forgot' => 'Answer your security question to set a new password.'];
?>
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Exam System</title><link rel="stylesheet" href="style.css"></head><body class="login">

<nav class="topbar"><div class="mark">E</div><div class="wm">ExamPro</div></nav>

<div class="stage">
<div class="split">

  <div class="lform">
    <h2><?= h($titles[$a] ?? $titles['login']) ?></h2>
    <p class="lsub"><?= h($subs[$a] ?? $subs['login']) ?></p>
    <?php if ($m): ?><div class="alert <?= $m[0] ?>"><?= h($m[1]) ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert err"><?= h($err) ?></div><?php endif; ?>
    <form method="post">
      <label>Login as
        <select name="role" id="role" onchange="ph()" required <?= $step == 2 ? 'style="pointer-events:none"' : '' ?>>
  <option value="" data-p="Enter ID / code / username" disabled <?= $role == '' ? 'selected' : '' ?>>Select</option>
  <?php foreach ($RL as $k => $v): ?><option value="<?= $k ?>" data-p="Enter <?= h(strtolower($v[5])) ?>" <?= $k == $role ? 'selected' : '' ?>><?= $v[0] ?></option><?php endforeach; ?>
        </select></label>
      <label>ID / Code / Username
        <input name="id" id="idf" value="<?= h($id) ?>" placeholder="Enter student id" required></label>
      <?php if ($a == 'login'): ?>
        <label>Password<input type="password" name="pw" placeholder="Enter password" required></label>
        <button class="btn">Login</button>
        <div class="links"><a href="?a=register">Create account</a><a href="?a=forgot">Forgot password?</a></div>
      <?php elseif ($a == 'register'): ?>
        <label>Password<input type="password" name="pw" placeholder="At least 6 characters" required></label>
        <label>Confirm password<input type="password" name="pw2" placeholder="Re-enter password" required></label>
        <label>Security question
          <select name="qid" required><option value="">Select a security question</option>
          <?php foreach (rows("SELECT * FROM security_questions ORDER BY question_id ASC") as $s): ?>
            <option value="<?= $s['question_id'] ?>"><?= h($s['question_text']) ?></option><?php endforeach; ?>
          </select></label>
        <label>Your answer<input name="ans" placeholder="Enter your answer" required></label>
        <button class="btn">Create account</button>
        <div class="links"><a href="index.php">Back to login</a></div>
      <?php else: ?>
        <?php if ($step == 2): ?>
          <label>Security question<input value="<?= h($qtext) ?>" disabled></label>
          <label>Your answer<input name="ans" placeholder="Enter your answer" required></label>
          <label>New password<input type="password" name="np" placeholder="At least 6 characters" required></label>
          <button class="btn">Reset password</button>
        <?php else: ?>
          <button class="btn">Show my security question</button>
        <?php endif; ?>
        <div class="links"><a href="index.php">Back to login</a></div>
      <?php endif; ?>
    </form>
  </div>

  <div class="lpanel">
    <div class="ptxt">
      <small>NO MORE NOTICE BOARDS</small>
      <h2>Know before you go.</h2>
      <p>Check your schedule, time & room.</p>
    </div>
  </div>

</div>
<footer class="lfoot">© <?= date('Y') ?> Exam Management System</footer>
</div>

<script>function ph(){var s=document.getElementById("role");document.getElementById("idf").placeholder=s.options[s.selectedIndex].getAttribute("data-p")}ph()</script></body></html>
