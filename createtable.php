<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "new";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Receive data from Flutter app
if(isset($_POST['name']) && isset($_POST['email']) && isset($_POST['mobile'])) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $mobile = $_POST['mobile'];

    // Debug: Print received data
    echo "Received data: name=$name, email=$email, mobile=$mobile\n";

    // Prepare and bind
    $stmt = $conn->prepare("INSERT INTO reg (username, email, mobile) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $name, $email, $mobile);

    // Execute the query
    if ($stmt->execute() === TRUE) {
        echo "Data inserted successfully";
    } else {
        echo "Error inserting data: " . $conn->error;
    }
} else {
    echo "Error: Incomplete data received";
}

// Close connection
$conn->close();
?>