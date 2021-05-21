<?php

$tz = 'Europe/Zurich';

$timestamp = time();

$dt = new DateTime("now", new DateTimeZone($tz)); //first argument "must" be a string
$dt->setTimestamp($timestamp); //adjust the object to correct timestamp

$time = $dt->format('H:i');

$date = $dt->format('d.m.Y');
?>
<div class="clock_time">
<?php echo $time; ?>
</div>
<div class="clock_date">
<?php echo $date; ?>
</div>