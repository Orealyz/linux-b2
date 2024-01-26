<html>
<body>

<?php
$host = getenv('DB_HOST');
$database = getenv('DB_DATABASE');
$username = getenv('DB_USERNAME');
$password = getenv('DB_PASSWORD');

$conn = new mysqli($host, $username, $password, $database);

$sql = 'select * from meo where name = ?';
$results = $conn->prepare($sql);
$results->bind_param('s', $_POST["name"]);
$results->execute();
$results = $results->get_result();

if ($results->num_rows === 0) {
  printf("No results for user %s", $_POST["name"]);
} else {
  foreach ($results as $row) {
      printf("User %s found ! e-mail address : %s\n", $row["name"], $row["email"]);
  }
}

?>

<br><br>
<input type="button" value="Home" onClick="document.location.href='/'" />

</body>
</html>
