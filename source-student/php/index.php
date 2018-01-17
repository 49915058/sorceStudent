<?php
$http_method = $_SERVER['REQUEST_METHOD'];
echo "got the method $http_method";
?>

<br/>

Got the following parameters<br/>
<?php
    if ( $http_method == "GET"){
        foreach( $_GET as $key => $value){
            echo "Key=".$key.",Value=".$value."<br/>";
        }
        $JSON = json_encode($_GET);
        echo "JSON=$JSON";
    }elseif ( $http_method == "POST" ){
        foreach( $_POST as $key => $value){
            echo "Key=".$key.",Value=".$value."<br/>";
        }
    }
?>



