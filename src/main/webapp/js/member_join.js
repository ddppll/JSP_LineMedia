// 아이디 검사
function idCheck(){
    let mid = document.getElementById("mid").value;
    
    if(mid.length < 4 || mid.length > 16){
        document.getElementById("iddemo").innerHTML="아이디는 4자 이상 16자 이하로 입력하세요"
    }
    else{
        let alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        for(let i=0; i<mid.length; i++) {
            if(alpha.indexOf(mid.charAt(i)) == -1) {
                document.getElementById("iddemo").innerHTML = "아이디는 영문자와 숫자만 가능합니다.";
            return false;
        }
        }
            
        document.getElementById("iddemo").innerHTML = " ";
        
    }
}
// 비밀번호 검사
function pwdCheck(){
    let pwd = document.getElementById("pwd").value;
    let regpwd = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+])(?!.*[^a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/gm;
    
    if(mid.length < 8 || mid.length > 16){
        document.getElementById("pwddemo").innerHTML="비밀번호는 8자 이상 16자 이하로 입력하세요"
    }
    else{
        if(!regpwd.test(pwd)){
            document.getElementById("pwddemo").innerHTML = "영어/숫자/특수문자를 포함한 8~16자로 입력하세요"
        }
        else{
            document.getElementById("pwddemo").innerHTML = " ";
        }
    }
}

// 비밀번호 확인 일치 검사
function pwdConfirmCheck(){
    let pwd = document.getElementById("pwd").value;
    let pwdConfirm = document.getElementById("pwdConfirm").value;
    if(!(pwdConfirm == pwd)){
        document.getElementById("pwdConfirmDemo").innerHTML = "비밀번호가 일치하지 않습니다."
    }
    else{
        document.getElementById("pwdConfirmDemo").innerHTML = " ";
    }
}

// 닉네임 검사
function nameCheck(){
    let name = document.getElementById("name").value;
    let regname = /^[0-9|가-힣|a-z|A-Z|]+$/gm;
    if(name.length<2 || name.length>8){
        document.getElementById("namedemo").innerHTML = "이름은 2자 이상 8자 이하로 입력하세요."
    }
    else{
        if(!regname.test(name)){
            document.getElementById("namedemo").innerHTML = "이름은 영어/한글/숫자로만 입력하세요"
        }
        else{
            document.getElementById("namedemo").innerHTML = " ";
        }
    }
}

//휴대 전화 검사
function cellphoneCheck2(){
    let phone2 = document.getElementById("cellphone2").value;
    let regphone2 = /^[0-9]{3,4}$/gm;
    
        if(!regphone2.test(phone2)){
            document.getElementById("cellphonedemo").innerHTML = "다시 입력하세요";
        }
        else{
            document.getElementById("cellphonedemo").innerHTML = " ";
        }
    
}
//휴대 전화 검사2
function cellphoneCheck3(){
    let phone2 = document.getElementById("cellphone3").value;
    let regphone2 = /^[0-9]{4}$/gm;
    
        if(!regphone2.test(phone2)){
            document.getElementById("cellphonedemo").innerHTML = "다시 입력하세요";
        }
        else{
            document.getElementById("cellphonedemo").innerHTML = " ";
        }

//이메일 검사
function emailCheck(){
    let email = document.getElementById("email").value;
    let regemail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if(!regemail.test(email)){
        document.getElementById("emaildemo").innerHTML = "이메일 형식으로 입력하세요";
    }
    else{
        document.getElementById("emaildemo").innerHTML = " ";
    }
}
}