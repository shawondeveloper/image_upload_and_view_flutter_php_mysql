<?php 

	$db = mysqli_connect('localhost','root','','userdata');
	if (!$db) {
		echo "Database connection faild";
	}

	$person = $db->query("SELECT * FROM person");
	$list = array();

	while ($rowdata= $person->fetch_assoc()) {
		$list[] = $rowdata;
	}

	echo json_encode($list);