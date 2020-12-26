<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
// value는 input 태그의 아이디
// item은 div의 전체마다의 (chatarea정도로 생각하면 될듯)
// name은 찾을꺼 클래스의 이름
      function filter(){

        var value, name, item, i;

        value = document.getElementById("value").value.toUpperCase();
        item = document.getElementsByClassName("item");

        for(i=0;i<item.length;i++){
          name = item[i].getElementsByClassName("name");
          if(name[0].innerHTML.toUpperCase().indexOf(value) > -1){
            item[i].style.display = "flex";
          }else{
            item[i].style.display = "none";
          }
        }
      }
</script>

<style>
body{
  margin: 0;
  padding: 0;
  font-family: "Montserrat";
}
.searchbox{
  width: 90%;
  margin: 10px auto;
}
.header{
  background: #ECDFBF;
  overflow: hidden;
  padding: 20px;
  text-align: center;
}
.header h1{
  text-transform: uppercase;
  color: white;
  margin: 0;
  margin-bottom: 8px;
}
#value{
  border: none;
  background: #E0D3B6;
  padding: 6px;
  font-size: 18px;
  width: 80%;
  border-radius: 6px;
  color: white;
}
#value:focus{
  outline: none;
}
.container{
  background: #FFFFF5;
  padding: 1%;
}
.item{
  margin: 3% 0px;
  display: flex;
  align-items: center;
}
.icon{
  width: 25px;
  height: 25px;
  background: #E0D3B6;
  color: white;
  font-size: 15px;
  text-align: center;
  line-height: 25px;
  border-radius: 50%;
  margin-right: 8px;
}
.name{ 
  font-size: 17px;
  font-weight: 470;
  color: #333;
}
</style>
<body>

   <div class="searchbox">
      <div class="header">
        <h1>Search</h1>
        <input onkeyup="filter()" type="text" id="value" placeholder="Type to Search">
      </div>

      <div class="container">

        <div class="item">
          <span class="icon">A</span>
          <span class="name">Apple</span>
        </div>

        <div class="item">
          <span class="icon">O</span>
          <span class="name">Orange</span>
        </div>

        <div class="item">
          <span class="icon">M</span>
          <span class="name">Mandarin</span>
        </div>

        <div class="item">
          <span class="icon">S</span>
          <span class="name">Strawberry</span>
        </div>

        <div class="item">
          <span class="icon">W</span>
          <span class="name">Watermelon</span>
        </div>

        <div class="item">
          <span class="icon">G</span>
          <span class="name">Grape</span>
        </div>

        <div class="item">
          <span class="icon">P</span>
          <span class="name">Pear</span>
        </div>

        <div class="item">
          <span class="icon">C</span>
          <span class="name">Cherry</span>
        </div>
      </div>
    </div>
</body>
</html>