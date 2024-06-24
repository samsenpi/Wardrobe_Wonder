




function validateUname() {
    var uname = document.getElementById('username').value;

    if (uname == "") {
        document.getElementById('uname_err').innerHTML = "Please Enter username";
        return false;
    }
    else {

        document.getElementById('uname_err').innerHTML = " ";
        return true;
    }

}

function validateEmail() {
    var email = document.getElementById('email').value;
    var at = email.indexOf('@');
    var dot = email.indexOf('.', at + 1);
    var len = email.length;

    if (!((at > -1) && (dot > -1) && len >dot + 1)) {
        document.getElementById('email_err').innerHTML = "Please Enter a valid email";
        return false;
    }
    document.getElementById('email_err').innerHTML = "";
    return true;
}


function validatePasswd() {
    var pswd = document.getElementById('password').value;

    if (pswd=="") {
        document.getElementById('pswd_err').innerHTML = "Password is empty";
        return false;
    }
    document.getElementById('pswd_err').innerHTML = "";
    return true;
}

function checkPassword() {
    var pswd = document.getElementById('password').value;
    var conf_pswd = document.getElementById('confirm-password').value;

    if (pswd != conf_pswd) {
        document.getElementById('conpswd_err').innerHTML = "Password & confirm password didn't match";
        return false;
    }
    document.getElementById('conpswd_err').innerHTML = "";
    return true;
}


function validate() {
    if (validateUname() && validateEmail() && checkPassword()) {
        return true;
    }
    return false;
}
