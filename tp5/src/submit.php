<html>
<body>

Hellooooooooooooo <?php echo $_POST["name"]; ?> 🐈
<br>
Your email address is: <?php echo $_POST["email"]; ?>
<br>
Everything has been sent to the database! (maybe it will work, or maybe it will explode because you didn't configure the database :( )

<?php
$host = getenv('DB_HOST');
$database = getenv('DB_DATABASE');
$username = getenv('DB_USERNAME');
$password = getenv('DB_PASSWORD');

$conn = new mysqli($host, $username, $password, $database);

$sql = 'INSERT INTO meo (name, email) VALUES (?, ?)';
$stmt = $conn->prepare($sql);
$stmt->bind_param('ss', $_POST["name"], $_POST["email"]);
$stmt->execute();

?>
<br><br>
<input type="button" value="Home" onClick="document.location.href='/'" />
</body>
</html>
