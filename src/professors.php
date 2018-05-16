<html>
<head>
<title>
Professors
</title> 
</head>

<body>
	<h1>
	<b>Professors</b>
	</h1> 
	<br> 
		
	<form name = "input" action = "" method = "post" > 
		<b>Social Security Number (SSN):</b><br> 
		<input type = "text" name = "SSN"> 
		<input type = "submit" id = "btn" value = "submit"/><br>
		<br>
		<b>or</b> <br>
		<br>
		
	<form name = "input" action = "" method = "post"> 
		<b>Course Number:</b><br> 
		<input type = "text" name = "coursenumber">
		<input type = "submit" id = "btn" value = "Submit" />
		<br>
		<br>
<?php

$link = mysql_connect('ecsmysql', 'username', 'password');

if (!$link) {
	die('Could not connect: ' . mysql_error());
	}

echo 'Connected successfully<p>';

mysql_select_db("username",$link);


$prof_ssn = $_post["SSN"];
$courseNum = $_post["coursenumber"];


if($prof_ssn != ""){
	$SQL = "SELECT Course.Title, classroom, meetingDays,classTime, endTime 
	FROM Professor, Section, Course
	WHERE Ssn = '$prof_ssn' AND Ssn = pSsn AND cNum = cNumber";
	
	echo "<p>";
	echo $SQL;
	echo "<p>";
	

	$result = mysql_query($SQL, $link); 
	
	
	
	for($i = 0; $i <mysql_numrows($result); $i++){
	
	echo "Title: ", mysql_result($result,$i,"title"),"<br>";
	echo "Classrooms: ", mysql_result($result,$i,"classroom"),"<br>";
	echo "Meeting Days: ", mysql_result($result,$i,"meetingDays"),"<br>"; 
	echo "Class Time: ", mysql_result($result, $i, "classTime"),"<br>";
	echo "End Time: ", mysql_results($result, $i, "endTime"), "<br>";
	
	}
}


if($courseNum != ""){
	
	$SQL = "SELECT grade, COUNT(cwid) AS numOfStudents
	FROM enrollRecord 
	WHERE courseNumber = '$courseNum' 
	GROUP BY grade";

	echo "<p>";
	echo $SQL;	
	echo "<p>";
	
	$result = mysql_result($SQL, $link);
	
	for($i = 0; $i < mysql_numrows($result); $i++){
	
	echo "Grade", mysql_result($result,$i,"grade"),"<br>";
	echo "Number of students with this grade: ", mysql_result($result,$i,"numOfStudents"),"<br>"; 

	
	}
}
mysql_close($link);
?>

</body>
</html>



