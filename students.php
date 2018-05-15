<html> 
<head>
<title>
Students
</title>
</head>

<body> 
	<h1>
	<b>Students</b>
	</h1>
	<br>

	<form name = "input" action = "" method = "post">
		<b>Campus Wide ID (CWID):</b><br> 
		<input type = "text" name = "CWID"> 
		<input type = "submit" id = "btn" value = "Submit"/><br>
		<br>
		<b>or</b><br>
		<br>

	<form name = "input" action = "" method = "post">
		<b>Course Number:</b><br>
		<input type = "text" name = "coursenumber">
		<input type = "submit" id = "btn" value = "Submit" />
		<br>


<?php
$link = mysql_connect('ecsmysql', 'username', 'password');

if (!$link) {
	die('Could not connect: ' . mysql_error());
	}

echo 'Connected successfully<p>';

mysql_select_db("username",$link);


$cwid = $_post["CWID"];
$courseNum = $_post["coursenumber"];


if($pcourseNum != ""){
	$SQL = "SELECT classroom, meetingDays,classTime, endTime, COUNT(cwid) AS numOfStudents, secNumber
	FROM Section, Course, enrollRecord 
	WHERE cNum = cNumber = "$courseNum" AND cNum = cNumber AND cNum = courseNo
	GROUP BY courseNo";
	
	echo "<p>";
	echo $SQL;
	echo "<p>";
	
	$result = mysql_query($SQL, $link); 
	
	for($i = 0; $i <mysql_numrows($result); $i++){
	
	echo "Section: ", mysql_result($result,$i,"secNumber"),"<br>";
	echo "Classrooms: ", mysql_result($result,$i,"classroom"),"<br>";
	echo "Meeting Days: ", mysql_result($result,$i,"meetingDays"),"<br>"; 
	echo "Class Time: ", mysql_result($result, $i, "classTime"),"<br>";
	echo "End Time: ", mysql_results($result, $i, "endTime"), "<br>";
	echo "Number od stutents enrolled: ", mysql_results($result,$i,"numOfStudents"),"<br>";
	}
}


if($cwid != ""){
	
	$SQL = "SELECT courseNo, grade
	FROM student, enroll_record 
	WHERE Cwid = '$cwid'AND Cwid = cwid";

	echo "<p>";
	echo $SQL;
	echo "<p>"; 	
	
	$result = mysql_result($SQL, $link);
	
	for($i = 0; $i < mysql_numrows($result); $i++){
	
	echo "Course Number: ", mysql_result($result,$i,"courseNo"),"<br>";
	echo "Grade: ", mysql_result($result,$i,"grade"),"<br>"; 

?>

</body>
</html>
