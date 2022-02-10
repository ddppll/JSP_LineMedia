

//네비바 고정 설정
$(document).ready(function(){
    $(window).scroll(function(){
        var scroll = $(window).scrollTop();
        if (scroll > 1) {
            $(".navbar").css("background","#000000");
            $(".navbar").css("opacity","0.8");
            $(".nav-link").css("color","white");
            $(".fas").css("color","unset");
            
            
        }
        else{
            $(".navbar").css("background", "unset");
            $(".navbar").css("color","white");
            $(".nav-link").css("color","white");  
            $(".fas").css("color","white"); 
        }
    })
})

//로그인창
var newWindow;
function loginWindow(){
    var url = "login.html";
    var winX = 500;
    var winY = 350;
    var x =(window.screen.width/2) - (winX/2);
    var y =(window.screen.height/2) - (winY/2);
    windowName = "loginWindow";
    // var opt = "width=600px,height=300px,left=300px,top=200px";
    newWindow = window.open(url, windowName, "width="+winX+",height="+winY+",left="+x+",top="+y);
    
    
    
}