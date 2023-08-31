SetExcelUploadAjax();

$(".detail-exceldown").unbind("click");
$(".detail-exceldown").click(function() {
     var e = [],
        t = grid1.getColumns(),
        i = [];
    //for (T in t) t[T].hidden && i.push(t[T].name);
    for (T in t) i.push(t[T].name);
    var a = $("#MTETC5").val();
    if (null != a && "" != a && null != a && "undefined" != a) {
        var n = JSON.parse(decodeURIComponent(a));
        if (0 < n.length)
            for (var l = 0 in n)
                if (null != n[l].name && -1 < n[l].name.indexOf("MERGE")) {
                    var s = {};
                    s.name = n[l].name, s.childNames = n[l].childNames;
                    var d, r, o = !0;
                    for (d in n[l].childNames) {
                        var c = n[l].childNames[d]; - 1 < i.indexOf(c) && (o = !1)
                    }
                    o && (null != n[l].lang && "" != n[l].lang && (r = JSON.parse(decodeURIComponent(n[l].lang)), s.title = r[$("#lang").val()]), e.push(s))
                }
    }
    var m = $("#JSONHEADER").val();
    "Y" == $("#LOADYN").val() && $.isLoading({
        tpl: "<span class=\"isloading-wrapper %wrapper%\"><div class=\"loadingio-spinner-ellipsis-bus78131cg\"><div class=\"ldio-8a4hfl22cb6\"><div></div><div></div><div></div><div></div><div></div></div></div></span>"
    });
    var u = [];
    null != m && "" != m ? u = JSON.parse(m) : "Y" == $("#LOADYN").val() && setTimeout(function() {
        $.isLoading("hide")
    }, 500);
    var p = [],
        g = [];
    //for (f in t) 0 == t[f].hidden ? p.push(t[f]) : g.push(t[f].name);
    for (f in t) p.push(t[f]);
    if (0 < e.length) {
        var h = [],
            v = {},
            E = {};
        if (0 < g.length)
            for (var f = 0 in e) {
                var b = [];
                for (T in e[f].childNames) - 1 < g.indexOf(e[f].childNames[T]) || b.push(e[f].childNames[T]);
                e[f].childNames = b
            }
        for (f in e) {
            for (var T = 0 in h.push(e[f].childNames), e[f].childNames) {
                var L = "NONTITLE";
                0 == T && (L = e[f].title), v[e[f].childNames[T]] = L, E[e[f].childNames[T]] = e[f].childNames.length
            }
        }
    }
    var _ = [],
        N = [],
        D = [],
        O = [];
    for (T in e)
        for (f in _.push(e[T].title), N.push(e[T].childNames.length + ""), D.push(e[T].childNames[0]), h = e[T].childNames) O.push(h[f]);
    var I = {},
        a = $("#menucode").val();
    null != a && "" != a || (a = "download");
    m = I.MENUCODE = a;
    //hiden col not use when download excel
    const p_convert = p.filter(item => {
    return item.title != "cost_unit" && item.title != "cost_seq" && item.title != "cost_type" && item.title != "dept_cd" && item.title != "USERNAME" && item.title != "code_value" 
    && item.title != "cost_ym_ser" && item.title != "cost_type_ser" && item.title != "dept_cd_ser" && item.title != "DEPTNM" && item.title != "SIMBIZSETTYPE"
    && item.title != "createuser" && item.title != "createdate" && item.title != "updateuser" && item.title != "updatedate"
    
    && item.title != "원가회계단위" && item.title != "원가순번" && item.title != "원가구분" && item.title != "담당부서코드" && item.title != "등록자"
    && item.title != "등록일시" && item.title != "수정자" && item.title != "수정일시" && item.title != "원가년월" && item.title != "원가구분" && item.title != "담당부서코드"
    })
    
    "" != menuNmobj[a] && null != menuNmobj[a] && (m = menuNmobj[a]), I.MENUNAME = encodeURIComponent(m), I.xlsData = encodeURIComponent(JSON.stringify(grid1.getRows())), I.colData = encodeURIComponent(JSON.stringify(p_convert)), I.compData1 = encodeURIComponent(JSON.stringify(_)), I.compData2 = encodeURIComponent(JSON.stringify(N)), I.compData3 = encodeURIComponent(JSON.stringify(D)), I.compData4 = encodeURIComponent(JSON.stringify(O)), $.fileDownload("bigXlsxDownload.do", {
        httpMethod: "POST",
        data: I,
        successCallback: function(e) {
            setTimeout(function() {
                "Y" == $("#LOADYN").val() && $.isLoading("hide")
            }, 10)
        },
        failCallback: function(e, t) {
            setTimeout(function() {
                "Y" == $("#LOADYN").val() && $.isLoading("hide")
            }, 10), msg(langObj.JS0000004, null, "Y")
        }
    })
});

$(window).on("resize", function(){
   var height = $(".right-content").height() - ($(".ui-widget-header").height() + $(".editer-content1").height() + 200);
    grid1.setHeight(height);
});

let month = "";

$(`#${itmobj1["cost_ym_ser"]}`).MonthPicker({
    SelectedMonth: new Date(),
    MonthFormat: "yy-mm",
    OnAfterChooseMonth: function() { 
        month = $(this).val()
    } 
});

$("#search_btn").trigger("click");

grid1.on("check", function(event){
    if(nvl(grid1.getValue(event.rowKey, itmobj1["cost_ym"]), "") == ""){
        grid1.setValue(event.rowKey, itmobj1["cost_ym"], nvl(month, "") == "" ? moment(new Date()).format("YYYY-MM") : moment(month).format("YYYY-MM"));
    }
    grid1.setValue(event.rowKey, itmobj1["cost_ym_ser"], grid1.getValue(event.rowKey, itmobj1["cost_ym"]));
    
});

$(".editer-content2 #grid1 .tui-grid-lside-area .tui-grid-summary-area tr:first td:last").html(`<span style="font-weight:bold">합계</span>`);
