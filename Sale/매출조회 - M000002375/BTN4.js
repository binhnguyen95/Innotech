var save_flag = true;
var msg_error = "";

var checks = grid1.getCheckedRows();
if (checks.length === 0) {
    save_flag = false;
    msg_error = "품목을 추가하십시오!";
}
if(!save_flag){
    msg(msg_error, null, "N");
    JSRETURN = false;
}

//check progress status
for (let i = 0; i < checks.length; i++) {
    if (checks[i][itmobj1["progress_status"]] != "interface") {
        save_flag = false;
        msg_error = "인터페이스 상태만 전표취소 가능합니다!";
        break;
    }
}
if(!save_flag){
    msg(msg_error, null, "N");
    JSRETURN = false;
}