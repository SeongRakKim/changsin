function setTreeMenuActive(el) {
	$.each($("a._isUrl"), function(index, item) {
		let nav_root = $(item).closest("li");
		if($(item).data("url") === el) {
			nav_root.find(".nav-link").removeClass("collapsed");
			nav_root.find(".collapse").addClass("show");
			$(item).addClass("active");
			return false;
		}else {
			nav_root.find(".nav-link").addClass("collapsed");
			nav_root.find(".collapse").removeClass("show");
			$(item).removeClass("active");
		}
	});
}

function eAlert(content) {
	Swal.fire({
		icon : 'error',         // Alert 제목
		text : content,  // Alert 내용
	});
}

function alert(content) {
	Swal.fire({
		icon : 'success',         // Alert 제목
		text : content,  // Alert 내용
	});
}

function run_waitMe(el, num, effect)
{
	/*
     effect list
     none,bounce,otateplane,stretch,orbit,roundBounce,win8,win8_linear,ios
     facebook,rotation,timer,pulse,progressBar,bouncePulse,img
    */

	let text = 'Please wait...';
	let fontSize = '';
	let maxSize = '';
	let textPos = '';

	switch (num) {
		case 1:
			maxSize = '';
			textPos = 'vertical';
			break;
		case 2:
			text = '';
			maxSize = 30;
			textPos = 'vertical';
			break;
		case 3:
			maxSize = 30;
			textPos = 'horizontal';
			fontSize = '18px';
			break;
		case 4:
			maxSize = 150;
			textPos = 'vertical';
			fontSize = '50px';
			break;
	}

	el.waitMe({
		effect: effect,
		text: text,
		bg: 'rgba(255,255,255,0.4)',
		color: '#000',
		maxSize: maxSize,
		waitTime: -1,
		source: 'img.svg',
		textPos: textPos,
		fontSize: fontSize,
		onClose: function(el) {}
	});
}

function ajaxErrorAlert(jqHXR) {
	eAlert("ajax 호출 실패 / 상태 : " + jqHXR.statusText);
}

function showWait(formId) {
	run_waitMe($(formId), 4, 'roundBounce');
}

function hideWait(formId) {
	$(formId).waitMe('hide');
}

function setDataOne(prefix, data) {
	$.each(data, function(key, value) {
		let type = $("[name=" + prefix + key + "]").prop("type");
		let inputType = $("input[name=" + prefix + key + "]").prop("type");

		if(inputType === "text" || inputType === "hidden") {
			if(key.indexOf("_cost") != -1 || key.indexOf("_qty") != -1 || key.indexOf("_amt") != -1) {
				$("input[name=" + prefix + key + "]").val(IsEmpty(value).comma());
			}else {
				$("input[name=" + prefix + key + "]").val(IsEmpty(value));
			}
		}else if (inputType === "checkbox" || inputType === "radio") {
			$("input[name=" + prefix + key + "]").val([IsEmpty(value)]);
		}else if (type === "textarea" || type === "select" || type === "select-one") {
			$("[name=" + prefix + key + "]").val(IsEmpty(value));
		}
	});
}

function getDatesStartToLast(startDate, lastDate) {
	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
	if(!(regex.test(startDate) && regex.test(lastDate))) return "Not Date Format";
	var result = [];
	var curDate = new Date(startDate);
	while(curDate <= new Date(lastDate)) {
		result.push(curDate.toISOString().split("T")[0]);
		curDate.setDate(curDate.getDate() + 1);
	}
	return result;
}

function IsNotNull(el) {
	if (el == null) return false;
	if (el == "NaN") return false;
	if (el == NaN) return true;
	if (new String(el).valueOf() == "undefined") return false;
	var chkStr = new String(el);
	if( chkStr.valueOf() == "undefined" ) return false;
	if (chkStr == null) return false;
	if (chkStr.toString().length == 0 ) return false;  
	return true;
}

function IsNull(el) {
	if (el == null) return true;
	if (el == "NaN") return true;
	if (el == NaN) return true;
	if (new String(el).valueOf() == "undefined") return true;
	var chkStr = new String(el);
	if( chkStr.valueOf() == "undefined" ) return true;
	if (chkStr == null) return true;
	if (chkStr.toString().length == 0 ) return true;  
	return false;
}

function IsEmpty(el) {
	if (el == null) return "";
	if (el == "NaN") return "";
	if (el == NaN) return "";
	if (new String(el).valueOf() == "undefined") return "";
	var chkStr = new String(el);
	if( chkStr.valueOf() == "undefined" ) return "";
	if (chkStr == null) return "";
	if (chkStr.toString().length == 0 ) return "";  
	return el;
}

function strCheck(str, type) {
    var REGEX = {
        EMAIL: /\S+@\S+\.\S+/,
        PWD_RULE: /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/,
        NAME_RULE: /^[가-힣a-zA-Z]+$/
    };

    if (type === "email") {
        return REGEX.EMAIL.test(str);
    } else if (type === "pwd") {
        return REGEX.PWD_RULE.test(str);
    } else if (type === "name") {
        return REGEX.NAME_RULE.test(str);
    } else {
        return false;
    }
}

/**
 * 좌측문자열채우기
 * @params
 *  - str : 원 문자열
 *  - padLen : 최대 채우고자 하는 길이
 *  - padStr : 채우고자하는 문자(char)
 */
function lpad(str, padLen, padStr) {
    if (padStr.length > padLen) {
        console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
        return str;
    }
    str += ""; // 문자로
    padStr += ""; // 문자로
    while (str.length < padLen)
        str = padStr + str;
    str = str.length >= padLen ? str.substring(0, padLen) : str;
    return str;
}

function bomPad(bomQty, padLen, padStr, padType) {
	var str = null;
	if(ChkIsNotNull(bomQty)) {
		var arr = bomQty.toString().split(".");
		var frontVal = arr[0].replace(/,/g, "");
		var backVal = padType == "r" ? rpad(arr[1], padLen, padStr) : lpad(arr[1], padLen, padStr);
		str = ChkIsNull(arr[1]) ? frontVal : frontVal + "." + backVal;
	}

	return str;
}

/**
 * 우측문자열채우기
 * @params
 *  - str : 원 문자열
 *  - padLen : 최대 채우고자 하는 길이
 *  - padStr : 채우고자하는 문자(char)
 */
function rpad(str, padLen, padStr) {
    if (padStr.length > padLen) {
        console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
        return str + "";
    }
    str += ""; // 문자로
    padStr += ""; // 문자로
    while (str.length < padLen)
        str += padStr;
    str = str.length >= padLen ? str.substring(0, padLen) : str;
    return str;
}

function ComSubmit(opt_formId) {
	this.formId = ChkIsNull(opt_formId) ? "searchForm" : opt_formId;
	this.url = "";
	this.method = "get";
	
	if(this.formId == "commonForm"){
		$("#commonForm").empty();
	}
	 
	this.setUrl = function setUrl(url){
		this.url = ChkIsNull(url) ? "/" : url;
	};
	
	this.setMethod = function setMethod(method){
		this.method = ChkIsNull(method) ? "get" : method;
	};
	
	this.setTarget = function setTarget(target){
		this.target = ChkIsNull(target) ? "" : target;
	};
	 
	this.addParam = function addParam(key, value){
		$("#" + this.formId).append($("<input type='hidden' name='" + key + "' id='" + key + "' value='" + value + "' />"));
	};
	 
	this.submit = function submit(){
		var frm = $("#" + this.formId)[0];
		frm.action = this.url;
		frm.method = this.method;
		frm.submit();
	};
}

//parsley validation 초기화
function initParsley() {
	var parsleyConfig = {
		trigger: false,
		errorsWrapper: '',
		errorTemplate: ''
	};

	$.each(arguments, function(index, value) {
		$("#" + value).parsley(parsleyConfig);
	});

	// validation 에러를 alert()으로 표시하게 처리
	window.Parsley.on("field:error", function(field) {
		var errorMessageStr = "";

		$.each(field.getErrorsMessages(), function(index, value) {
			if (errorMessageStr !== "") {
				errorMessageStr += "\n";
			}
			errorMessageStr += field.element.title + "은(는) " + value;
		});

		alert(errorMessageStr);
	});
}

function parsleyIsValidate(formId) {
	var parsleyConfig = {errorsWrapper: '',errorTemplate: ''};
	return $("form#" + formId).parsley(parsleyConfig).validate();
}

function layerOpen( el ){
	var temp = $("#" + el);
	var bg = temp.prev().hasClass("bg");    // dimmed 레이어를 감지하기 위한 boolean 변수

	if(bg)	$(".layer-wrapper").fadeIn();   // "bg" 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다.
	else	temp.fadeIn();

	// 화면의 중앙에 레이어를 띄운다.
	if (temp.outerHeight() < $(document).height()) temp.css("margin-top", "-" + temp.outerHeight()/2 + "px");
	else temp.css("top", "0px");
	if (temp.outerWidth() < $(document).width()) temp.css("margin-left", "-" + temp.outerWidth()/2 + "px");
	else temp.css("left", "0px");

	$("#_cancel").click( function(event){
		$(".layer-wrapper").fadeOut();
		event.preventDefault();
	});

	$("#_close").click( function(event){ 
		$(".layer-wrapper").fadeOut();
		event.preventDefault();
	});
	
	$(".bg").click( function(event){
		$(".layer-wrapper").fadeOut();
		event.preventDefault();
	});
}

function PopInfo () {
	if(ChkIsNull(arguments[0])) return false;
	
	var url = "/common/popup/" + arguments[0].name;
	$.ajax({
		type: "get"
		,url: url
		,data: {
			cust_cd: arguments[0].cust_cd
			,gubn: arguments[0].gubn
			,file: arguments[0].file
			,param1: arguments[0].param1
			,param2: arguments[0].param2
		}
		,cache: false
		,dataType: "html"
		,success: function(msg){
			$("#dialog").html(msg);
			if(msg.indexOf("pop-title") != -1) {
				layerOpen("pop-layer");
			}
		}
		,error: function(xhr, status, message) {
			ajaxError(xhr, status, message);
		}
	});
}

// 이미지 관련 =============================
// 업로드한 실제 파일명
function getOriginalName(fileName) {
	var file = getFileLink(fileName);
	var idx = file.indexOf("_") + 1;
	return file.substr(idx);
}

// 저장된 원본 파일명(날짜경로 포함, 유니크값 포함, 인코딩됨)
function getFileLink(fileName) {
	var front = fileName.substr(0, 12);
	var end = fileName.substr(14);
	return front + end;
}

function checkImageType(fileName) {
	if(ChkIsNull(fileName)) return null;
	
	var pattern = /jpg$|jpeg$|png$|gif$|tif$|tiff$/i;
	return fileName.match(pattern);
}

function checkFileType(fileName) {
	if(ChkIsNull(fileName)) return null;
	
	if (checkImageType(fileName)) {
		return checkImageType(fileName);
	}
	
	var pattern = /pdf$|hwp$|ppt$|pptx$|xls$|xlsx$|doc$|docx$/i;
	return fileName.match(pattern);
}

function checkExcelType(fileName) {
	if(ChkIsNull(fileName)) return null;
	
	var pattern = /xlsx$/i;
	return fileName.match(pattern);
}

// ** 중요: 폴더, DB에 한글 파일명으로 저장됨, parameter로 넘겨줄 때는 인코딩
function setImageDisplay(gubn, cust_cd, fileName, isThumb) {
	if(ChkIsNotNull(fileName)) {
		if(checkImageType(fileName)) {
			if(isThumb) {
				return "/common/fileDisplay?gubn=" + gubn + "&cust_cd=" + cust_cd + "&fileName=" + encodeURIComponent(fileName);
			}
			else {
				return "/common/fileDisplay?gubn=" + gubn + "&cust_cd=" + cust_cd + "&fileName=" + encodeURIComponent(getFileLink(fileName));
			}
		}
		else {
			alert("이미지 파일만 사용해 주시기 바랍니다.");
			return "/resources/images/no-image.png";
		}
	}
	else {
		return "/resources/images/no-image.png";
	}
}

function setProfileDisplay(gubn, cust_cd, fileName, isThumb) {
	if(ChkIsNotNull(fileName)) {
		if(checkImageType(fileName)) {
			if(isThumb) {
				return "/common/fileDisplay?gubn=" + gubn + "&cust_cd=" + cust_cd + "&fileName=" + encodeURIComponent(fileName);
			}
			else {
				return "/common/fileDisplay?gubn=" + gubn + "&cust_cd=" + cust_cd + "&fileName=" + encodeURIComponent(getFileLink(fileName));
			}
		}
		else {
			alert("이미지 파일만 사용해 주시기 바랍니다.");
			return "/resources/images/profile.png";
		}
	}
	else {
		return "/resources/images/profile.png";
	}
}

function setFileEvent(gubn, cust_cd, fileName) {
	if(checkImageType(fileName)) {
		PopInfo({name:"gallery", gubn:gubn, cust_cd:cust_cd, file:fileName});
	}
	else {
		if(!confirm("해당 파일을 다운로드 하시겠습니까?")) return false;
		self.location = "/common/fileDisplay?gubn=" + gubn + "&cust_cd=" + cust_cd + "&fileName=" + encodeURIComponent(fileName);
	}
}

function setDownload(gubn, cust_cd, fileName) {
	if(!confirm("해당 파일을 다운로드 하시겠습니까?")) return false;
	
	if(checkImageType(fileName)) {
		self.location = "/common/fileDownload?gubn=" + gubn + "&cust_cd=" + cust_cd + "&fileName=" + encodeURIComponent(getFileLink(fileName));
	}
	else {
		self.location = "/common/fileDownload?gubn=" + gubn + "&cust_cd=" + cust_cd + "&fileName=" + encodeURIComponent(fileName);
	}
}

//** 중요: 파일명이 틀리거나 파일이 삭제되거나 서버가 다운될 때 이미지 에러 무한루프 막아줌
function setImageError(tag) {
	$(tag).error(function () {
		$(tag).unbind("error");
		$(tag).prop("src", "/resources/images/profile.png");
	});
}
// ==================================

// 이메일 형식 체크 
function emailCheck(email) {
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; 
	if(exptext.test(email) == false) { 
		// 이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우 
		alert("이메일형식이 올바르지 않습니다."); 
		return false; 
	}
	return true; 
} 

// 특수문자 여부 체크
function checkSpecial(str) { 
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi; 
	if (special_pattern.test(str) == true) { 
		return true; 
	} 
	else { 
		return false; 
	} 
}

// 전화번호 형식 체크
function isPhone(phoneNum) { 
	var regExp = /(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/; 
	var myArray; 
	
	if(regExp.test(phoneNum)) { 
		myArray = regExp.exec(phoneNum); 
		return true; 
	} 
	else { 
		regExp = /(02)([0-9]{3,4})([0-9]{4})$/; 
		if(regExp.test(phoneNum)) { 
			myArray = regExp.exec(phoneNum); 
			return true; 
		}
		else { 
			regExp = /(0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/; 
			if(regExp.test(phoneNum)) { 
				myArray = regExp.exec(phoneNum); 
				return true; 
			}
			else {
				return false; 
			}
		} 
	}
}

// 전화번호 포맷으로 변환
function formatPhone(phoneNum) { 
	phoneNum = phoneNum.replace(/[^0-9]/g, '');
	
	if(isPhone(phoneNum)) { 
		var rtnNum; 
		var regExp = /(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/; 
		var myArray; 
		
		if(regExp.test(phoneNum)) { 
			myArray = regExp.exec(phoneNum); 
			rtnNum = myArray[1]+'-' + myArray[2]+'-'+myArray[3]; 
			return rtnNum; 
		} 
		else { 
			regExp = /(02)([0-9]{3,4})([0-9]{4})$/; 
			if(regExp.test(phoneNum)) { 
				myArray = regExp.exec(phoneNum); 
				rtnNum = myArray[1]+'-'+myArray[2]+'-'+myArray[3]; 
				return rtnNum; 
			} 
			else { 
				regExp = /(0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/; 
				if(regExp.test(phoneNum)) { 
					myArray = regExp.exec(phoneNum); 
					rtnNum = myArray[1]+'-'+myArray[2]+'-'+myArray[3]; 
					return rtnNum; 
				} 
				else { 
					return phoneNum;
				}
			} 
		} 
	} 
	else { 
		return phoneNum; 
	} 
}

// 사업자등록번호 형식 체크
function isIdNum(idNum) { 
	var regExp = /([1-9]{1}[0-9]{2})([0-9]{2})([0-9]{5})$/; 
	var myArray; 
	
	if(regExp.test(idNum)) { 
		myArray = regExp.exec(idNum); 
		return true; 
	} 
	else { 
		return false; 
	}
}

// 사업자등록번호 포맷으로 변환
function formatIdNum(idNum) { 
	idNum = idNum.replace(/[^0-9]/g, '');
	if(idNum.length > 10) return idNum;
	
	if(isIdNum(idNum)) { 
		var rtnNum; 
		var regExp = /([1-9]{1}[0-9]{2})([0-9]{2})([0-9]{5})$/; 
		var myArray; 
		
		if(regExp.test(idNum)) { 
			myArray = regExp.exec(idNum); 
			rtnNum = myArray[1]+'-' + myArray[2]+'-'+myArray[3]; 
			return rtnNum; 
		} 
		else { 
			return idNum;
		} 
	} 
	else { 
		return idNum; 
	} 
}

// ID 포맷
function formatID(str) { 
	str = str.replace(/[^a-zA-Z0-9_-]/g, '');
	return str;
}

function formatCode(str) { 
	str = str.replace(/[^a-zA-Z0-9\-]/g, '');
	return str;
}

function formatProc(str) { 
	str = str.replace(/[^a-zA-Z]/g, '').toUpperCase();
	return str;
}

function formatUppercase(str) { 
	str = str.replace(/[^a-zA-Z0-9\/\ \_\-\.\,\&\(\)]/g, '').toUpperCase();
	return str;
}

function formatUppercaseKo(str) { 
	str = str.replace(/[^a-zA-Z0-9ㄱ-ㅎ가-힣\/\ \_\-\.\,\&\(\)]/g, '').toUpperCase();
	return str;
}

$.datepicker.regional['ko'] = {
	closeText: '닫기',
	prevText: '이전달',
	nextText: '다음달',
	currentText: '오늘',
	monthNames: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
	monthNamesShort: [ '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12' ],
	dayNames: [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesShort: [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesMin: [ '일', '월', '화', '수', '목', '금', '토' ],
	weekHeader: 'Wk',
	dateFormat: 'yy-mm-dd',
	firstDay: 0,
	isRTL: false,
	showMonthAfterYear: true,
	yearSuffix: ''
};

$.datepicker.setDefaults($.datepicker.regional['ko']);

function initStartEndDatepicker(startDateElementId, endDateElementId) {
	var startDatepicker = $("#" + startDateElementId);
	var endDatepicker = $("#" + endDateElementId);

	var startDatePickerOptions = {
		'changeMonth': true,
		'changeYear': true,
		'maxDate': endDatepicker.val(),
		'onClose': function(datepicker) {
			endDatepicker.datepicker('option', 'minDate', datepicker);
		}
	};

	var endDatePickerOptions = {
		'changeMonth': true,
		'changeYear': true,
		'minDate': startDatepicker.val(),
		'onClose': function(datepicker) {
			startDatepicker.datepicker('option', 'maxDate', datepicker);
		}
	};

	startDatepicker.datepicker(startDatePickerOptions);
	endDatepicker.datepicker(endDatePickerOptions);
}

function initDatepickerByClass() {
	var options = {
		'changeMonth': true,
		'changeYear': true,
		dateFormat: 'yy-mm-dd'
	};

	$.each(arguments, function(index, value) {
		$(document).find("." + value).removeClass("hasDatepicker").datepicker(options);
	});
}

// 해당월 첫날
function getFirstDate(yymm) {
	return moment(yymm).format("YYYY-MM-DD");
}

//해당월 마지막날
function getLastDate(yymm) {
	var sdate = moment(yymm).format("YYYY-MM-DD");
	return moment(sdate).endOf("month").format("YYYY-MM-DD");
}

//검색일 셋팅
function setDate(val) {
	var today = new Date();

	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();

	if (month < 10) {
		month = "0" + month;
	}
	
	if (day < 10) {
		day = "0" + day;
	}
	
	if(document.searchForm.endDate) {
		document.searchForm.endDate.value = year + '-' + month + '-' + day;
	}
	if(document.searchForm.endFrontDate) {
		document.searchForm.endFrontDate.value = '';	
	}	
	
	if (val == "01") {
	} 
	else if (val == "07") {
		today.setDate(today.getDate() - parseInt(val));
		
		year = today.getFullYear();
		month = today.getMonth() + 1;
		day = today.getDate();

		if (month < 10) {
			month = "0" + month;
		}
		
		if (day < 10) {
			day = "0" + day;
		}
	} 
	else {
		today.setMonth(today.getMonth() - parseInt(val));
		
		year = today.getFullYear();
		month = today.getMonth() + 1;
		day = today.getDate();

		if (month < 10) {
			month = "0" + month;
		}
		if (day < 10) {
			day = "0" + day;
		}
	}
	
	if(document.searchForm.startDate) {
		document.searchForm.startDate.value = year + '-' + month + '-' + day;
	}
	if(document.searchForm.startFrontDate) {
		document.searchForm.startFrontDate.value = '';
	}
}

function setFrontDate(val) {
	var today = new Date();

	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();

	if (month < 10) {
		month = "0" + month;
	}
	if (day < 10) {
		day = "0" + day;
	}
	
	if(document.searchForm.startDate) {
		document.searchForm.startDate.value = '';	
	}
	document.searchForm.startFrontDate.value = year + '-' + month + '-' + day;
	
	if (val == "01") {
	} 
	else if (val == "10") {
		today.setDate(today.getDate() + parseInt(val));
		
		year = today.getFullYear();
		month = today.getMonth() + 1;
		day = today.getDate();

		if (month < 10) {
			month = "0" + month;
		}
		
		if (day < 10) {
			day = "0" + day;
		}
	} 
	else {
		today.setMonth(today.getMonth() + parseInt(val));
		
		year = today.getFullYear();
		month = today.getMonth() + 1;
		day = today.getDate();

		if (month < 10) {
			month = "0" + month;
		}
		if (day < 10) {
			day = "0" + day;
		}
	}
	
	if(document.searchForm.endDate) {
		document.searchForm.endDate.value = '';	
	}
	document.searchForm.endFrontDate.value = year + '-' + month + '-' + day;
}

function setCurDate(gubn) {
	if(document.searchForm.curDate) {
		var curDate = document.searchForm.curDate.value
		var curdt = new Date(curDate);
		
		if (gubn == "back") {
			curdt.setDate(curdt.getDate() - 1);
		}
		else if (gubn == "next") {
			curdt.setDate(curdt.getDate() + 1);
		}
		
		year = curdt.getFullYear();
		month = curdt.getMonth() + 1;
		day = curdt.getDate();
		
		if (month < 10) {
			month = "0" + month;
		}
		
		if (day < 10) {
			day = "0" + day;
		}
		
		document.searchForm.curDate.value = year + '-' + month + '-' + day;
	}
}

function clearForm(form) {
	var elements = form.elements;
	form.reset();

	for (i = 0; i < elements.length; i++) {
		var tag_name = elements[i].tagName.toLowerCase();
		var field_type = elements[i].type.toLowerCase();

		if(tag_name == "input") {
			switch (field_type) {
			case "text":
			case "password":
			/*case "hidden":*/
				elements[i].value = "";
				break;
			case "radio":
			case "checkbox":
				if (elements[i].value == "") {
					elements[i].checked = true;
				}
				else {
					elements[i].checked = false;
				}
				break;
			}

			setDate("07");
		}
		// else if(tag_name == "select") {
		// 	if(elements[i].classList.contains("selectpicker") == false
		// 			&& elements[i].name != "fact_cd") {
		// 		elements[i].value = "";
		// 	}
		// }
		else if(tag_name == "textarea") {
			elements[i].innerHTML = "";
		}
	}
}

function setDisableForm(form, flag) {
	var elements = form.elements;
	form.reset();

	for (i = 0; i < elements.length; i++) {
		var tag_name = elements[i].tagName.toLowerCase();
		var field_type = elements[i].type.toLowerCase();

		if(tag_name == "input") {
			switch (field_type) {
			case "text":
			case "password":
			case "radio":
			case "checkbox":
				elements[i].disabled  = flag;
				break;
			}
		}
		else if(tag_name == "select" || tag_name == "textarea") {
			elements[i].disabled  = flag;
		}
	}
}

function markFileSize(file_size) {
	var byteSize = Math.round(file_size / 1024 * 100) * .01;
	var suffix = 'KB';

	if (byteSize > 1000) {
		byteSize = Math.round(byteSize * .001 * 100) * .01;
		suffix = 'MB';
	}

	var sizeParts = byteSize.toString().split('.');

	if (sizeParts.length > 1) {
		byteSize = sizeParts[0] + '.' + sizeParts[1].substr(0, 2);
	} else {
		byteSize = sizeParts[0];
	}

	return byteSize + suffix;
}

function limitFileUpload(originSize, limitSize) {
	var convertSize = markFileSize(originSize);
	var sizeMark = convertSize.substr(convertSize.length-2);
	var fileSize = convertSize.substring(0, (convertSize.length-2));
	
	var convertLimit = (limitSize * 1024) * .001;
	
	if(sizeMark == "MB" && fileSize > convertLimit) {
		return true;
	}
	return false;
}

String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.left = function(len) {
	if (this.length == 0 || this.length < len) return this;
	return this.substring(0, len);
}

String.prototype.right = function(len) {
	if (this.length == 0 || this.length < len) return this;
	return this.substring(this.length - len, this.length);
}

String.prototype.mid = function(pos, len) {
	if (this.length == 0 || this.length < pos) return "";
	if (this.length < (pos + len)) len = this.length - pos;
	return this.substring(pos, pos + len);
}

String.prototype.comma = function(gubn) {
	var num = this.toString().split(".");
	num[0] = num[0].replace(/[^0-9]/g, "");
	if(num[1]) {
		num[1] = num[1].replace(/[^0-9]/g, "");
	}
	
	if (this.toString().trim().left(1) != "-") {
		if(num[0].length == 0 || isNaN(num[0])) return "";
	}
	
	var positive = num[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	if (this.toString().trim().left(1) == "-") {
		positive = "-" + positive;
	}
	
	if(gubn) {
		gubn = gubn.replace(/[^0-9]/g, "");

		if(typeof num[1] == "undefined") {
			return positive;
		}
		else if(num[1] == "") {
			positive = positive + ".";
		}
		else {
			positive = positive + "." + (num[1] + "000").substring(0, (num[1].length < gubn ? num[1].length : gubn));
		}
	}
	
	return positive;
}

Number.prototype.comma = String.prototype.comma;

//정수 지정자리 반올림 (값, 자릿수) - 엑셀의 ROUND
function Round(n, pos) {
	n = n.toFixed(0);
	var digits = Math.pow(10, pos);
	var sign = 1;
	if (n < 0) {
		sign = -1;
	}

	// 음수이면 양수처리후 반올림 한 후 다시 음수처리
	n = n * sign;
	var num = Math.round(n / digits) * digits;
	num = num * sign;
	return num;
}

// 정수 지정자리 올림 (값, 자릿수) - 엑셀의 ROUNDUP
function Ceiling(n, pos) {
	// Ceiling(450.0000006) -> 451이 되므로 toFixed로 소수점 버림
	n = n.toFixed(0);
	var digits = Math.pow(10, pos);
	var num = Math.ceil(n / digits) * digits;
	return num;
}

// 정수 지정자리 버림 (값, 자릿수) - 엑셀의 ROUNDDOWN
function Floor(n, pos) {
	n = n.toFixed(0);
	var digits = Math.pow(10, pos);
	var num = Math.floor(n / digits) * digits;
	return num;
}

//소수점 지정자리 반올림 (값, 자릿수)
function RoundP(n, pos) {
	var digits = Math.pow(10, pos);
	var sign = 1;
	if (n < 0) {
		sign = -1;
	}

	// 음수이면 양수처리후 반올림 한 후 다시 음수처리
	n = n * sign;
	var num = Math.round(n * digits) / digits;
	num = num * sign;
	return num.toFixed(pos);
}

// 소수점 지정자리 버림 (값, 자릿수)
function FloorP(n, pos) {
	var digits = Math.pow(10, pos);
	var sign = 1;
	if (n < 0) {
		sign = -1;
	}

	// 음수이면 양수처리후 반올림 한 후 다시 음수처리
	n = n * sign;
	var num = Math.floor(n * digits) / digits;
	num = num * sign;
	return num.toFixed(pos);
}

// 자릿수에 맞춰 0 붙이기
function pad(n, width) {
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join("0") + n;
}

// 바늘 시계용 
function updateClock(){
    var now = moment(),
        second = now.seconds() * 6,
        minute = now.minutes() * 6 + second / 60,
        hour = ((now.hours() % 12) / 12) * 360 + 90 + minute / 12;

    $("#tHour").css("transform", "rotate(" + hour + "deg)");
    $("#tMinute").css("transform", "rotate(" + minute + "deg)");
    $("#tSecond").css("transform", "rotate(" + second + "deg)");
}

// Ajax 에러 시 alert 표시
function ajaxError(xhr, status, message) {
	if (message != "abort") {
		if (xhr.status == 200) {
			var contentType = xhr.getResponseHeader("Content-Type");
			if(ChkIsNotNull(contentType)) {
				if(contentType.toLowerCase().indexOf("text/html") != -1) {
					window.location.reload();
				}
			}
			else {
				alert("데이터 수신 오류" + (xhr ? "\r상태: " + xhr.statusText : "") + "\r" + status + "\r" + message);
			}
		}
		else {
			alert("데이터 수신 오류" + (xhr ? "\r상태: " + xhr.statusText : "") + "\r" + status + "\r" + message);
		}
	}
}

function fnMoveFocus(event) {
	var curIndex = 0;
	var preIndex = 0;
	var nextIndex = 0;
	
	if($(document).find(".rudder").length == 0) return false;
	
	$.each($(document).find(".rudder"), function(index, item) {
		if(item == event.target) {
			curIndex = index;
		}
	});
	
	// 왼쪽, 오른쪽은 제외 : input 내 커서 이동을 위해.. 중요!!
	
	// 위로 
	if (event.keyCode == 38) {
		preIndex = curIndex - 1;
		
		if(event.target == document) {
			$($(document).find(".rudder")[0]).select();
		}
		else {
			if(preIndex > -1) {
				$($(document).find(".rudder")[preIndex]).select();
			}
			else {
				$($(document).find(".rudder")[$(document).find(".rudder").length - 1]).select();
			}
		}
	}
	// 아래로
	else if (event.keyCode == 40) {
		nextIndex = curIndex + 1;
		
		if(event.target == document) {
			$($(document).find(".rudder")[0]).select();
		}
		else {
			if($(document).find(".rudder").length > nextIndex) {
				$($(document).find(".rudder")[nextIndex]).select();
			}
			else {
				$($(document).find(".rudder")[0]).select();
			}
		}
	}
	// 엔터
	else if (event.keyCode == 13) {
		var form = $(event.target).closest("form").prop("name");
		if(ChkIsNotNull(form)) {
			$("#" + form).find(".enter-data:visible").trigger("click");
		}
		else {
			goCheck();
		}
	}
}

function getPDF(pdf_ort, pdf_id, pdf_name) {
	var html_width = $("#" + pdf_id).width();
	var html_height = $("#" + pdf_id).height();
	var margin_top_left = 50;
	var img_width = html_width;
	var img_height = html_height;
	
	var pdf_width = 0;
	var pdf_height = 0;
	
	if(pdf_ort == "p") {
		pdf_width = html_width + (margin_top_left * 2);
		pdf_height = Math.ceil(pdf_width * 1.41428) + (margin_top_left * 2);
	}
	else if(pdf_ort == "l") {
		pdf_width = html_width + (margin_top_left * 2);
		pdf_height = (pdf_width * 0.70707) + (margin_top_left * 2);
	}
	else {
		return false;
	}
	
	var pdf_pages = Math.ceil(html_height/pdf_height)-1;

	html2canvas($("#" + pdf_id),
		{onrendered: function(canvas) {
			canvas.getContext("2d");
			
			var imgData = canvas.toDataURL("image/jpeg", 1.0);
			var pdf = new jsPDF(pdf_ort, "pt",  [pdf_width, pdf_height]);
		    pdf.addImage(imgData, 'JPG', margin_top_left, margin_top_left, img_width, img_height);
			
			for (var i = 1; i <= pdf_pages; i++) { 
				pdf.addPage(pdf_width, pdf_height);
				pdf.addImage(imgData, 'JPG', margin_top_left, -(pdf_height * i) + (margin_top_left * 4), img_width, img_height);
			}
			
		    pdf.save(pdf_name + ".pdf");
		}
    });
};

//param1은 시작일, param2는 종료일이다.
// 날짜 사이 값 배열 리턴
function getDateRangeData(param1, param2){  
	var res_day = [];
	var ss_day = new Date(param1);
	var ee_day = new Date(param2);
	while(ss_day.getTime() <= ee_day.getTime()){
		var _mon_ = (ss_day.getMonth()+1);
		_mon_ = _mon_ < 10 ? '0'+_mon_ : _mon_;
		var _day_ = ss_day.getDate();
		_day_ = _day_ < 10 ? '0'+_day_ : _day_;
		res_day.push(ss_day.getFullYear() + '-' + _mon_ + '-' +  _day_);
		ss_day.setDate(ss_day.getDate() + 1);
	}
	return res_day;
}

function getDateRangeData2(param1, param2){
	var res_day = [];
	var ss_day = new Date(param1);
	var ee_day = new Date(param2);
	var week = ['일', '월', '화', '수', '목', '금', '토'];
	while(ss_day.getTime() <= ee_day.getTime()){
		var _mon_ = (ss_day.getMonth()+1);
		_mon_ = _mon_ < 10 ? '0'+_mon_ : _mon_;
		var _day_ = ss_day.getDate();
		_day_ = _day_ < 10 ? '0'+_day_ : _day_;
		res_day.push(ss_day.getFullYear() + '-' + _mon_ + '-' +  _day_ + '(' + week[new Date(ss_day.getFullYear() + '-' + _mon_ + '-' +  _day_).getDay()] + ')');
		ss_day.setDate(ss_day.getDate() + 1);
	}
	return res_day;
}

// Map  형식 사용
Map = function() {
	this.map = new Object();
};
Map.prototype = {
	put : function(key, value){
		this.map[key] = value;
	},
	get : function(key){
		return this.map[key];
	},
	containsKey : function(key){
		return key in this.map;
	},
	containsValue : function(value){
		for(var prop in this.map){
			if(this.map[prop] == value) return true;
		}
		return false;
	},
	isEmpty : function(key){
		return (this.size() == 0);
	},
	clear : function(){
		for(var prop in this.map){
			delete this.map[prop];
		}
	},
	remove : function(key){
		delete this.map[key];
	},
	keys : function(){
		var keys = new Array();
		for(var prop in this.map){
			keys.push(prop);
		}
		return keys;
	},
	values : function(){
		var values = new Array();
		for(var prop in this.map){
			values.push(this.map[prop]);
		}
		return values;
	},
	size : function(){
		var count = 0;
		for (var prop in this.map) {
			count++;
		}
		return count;
	}
};

// ArrayList 형식 사용
ArrayList=function(/* array? */arr) {
	// summary
	// Returns a new object of type dojox.collections.ArrayList
	var items=[];
	if(arr) items=items.concat(arr);
	this.count=items.length;
	this.add=function(/* object */obj){
		// summary
		// Add an element to the collection.
		items.push(obj);
		this.count=items.length;
	};
	this.addRange=function(/* array */a){
		// summary
		// Add a range of objects to the ArrayList
		if(a.getIterator){
			var e=a.getIterator();
			while(!e.atEnd()){
				this.add(e.get());
			}
			this.count=items.length;
		}else{
			for(var i=0; i<a.length; i++){
				items.push(a[i]);
			}
			this.count=items.length;
		}
	};
	this.clear=function(){
		// summary
		// Clear all elements out of the collection, and reset the count.
		items.splice(0, items.length);
		this.count=0;
	};
	this.clone=function(){
		// summary
		// Clone the array list
		return new dojox.collections.ArrayList(items); // dojox.collections.ArrayList
	};
	this.contains=function(/* object */obj){
		// summary
		// Check to see if the passed object is a member in the ArrayList
		for(var i=0; i < items.length; i++){
			if(items[i] == obj) {
				return true; // bool
			}
		}
		return false; // bool
	};
	this.forEach=function(/* function */ fn, /* object? */ scope){
		// summary
		// functional iterator, following the mozilla spec.
		dojo.forEach(items, fn, scope);
	};
	this.get = function(index) {
		return items[index];
	};
	this.size = function() {
		return items.length;
	};
	this.getIterator=function(){
		// summary
		// Get an Iterator for this object
		return new dojox.collections.Iterator(items); // dojox.collections.Iterator
	};
	this.indexOf=function(/* object */obj){
		// summary
		// Return the numeric index of the passed object; will return -1 if not found.
		for(var i=0; i < items.length; i++){
			if(items[i] == obj) {
				return i; // int
			}
		}
		return -1; // int
	};
	this.insert=function(/* int */ i, /* object */ obj){
		// summary
		// Insert the passed object at index i
		items.splice(i,0,obj);
		this.count=items.length;
	};
	this.item=function(/* int */ i){
		// summary
		// return the element at index i
		return items[i]; // object
	};
	this.remove=function(/* object */obj){
		// summary
		// Look for the passed object, and if found, remove it from the internal array.
		var i=this.indexOf(obj);
		if(i >=0) {
			items.splice(i,1);
		}
		this.count=items.length;
	};
	this.removeAt=function(/* int */ i){
		// summary
		// return an array with function applied to all elements
		items.splice(i,1);
		this.count=items.length;
	};
	this.reverse=function(){
		// summary
		// Reverse the internal array
		items.reverse();
	};
	this.sort=function(/* function? */ fn){
		// summary
		// sort the internal array
		if(fn){
			items.sort(fn);
		}else{
			items.sort();
		}
	};
	this.setByIndex=function(/* int */ i, /* object */ obj){
		// summary
		// Set an element in the array by the passed index.
		items[i]=obj;
		this.count=items.length;
	};
	this.toArray=function(){
		// summary
		// Return a new array with all of the items of the internal array concatenated.
		return [].concat(items);
	}
	this.toString=function(/* string */ delim){
		// summary
		// implementation of toString, follows [].toString();
		return items.join((delim||","));
	};
};

// 특정일 기준 일주일 날자 표현
function setWeekDate(selectDate)
{
	var year  = selectDate.substring(0,4); //선택된 년도
	var month = selectDate.substring(4,6); //선택된 월
	var day   = selectDate.substring(6,8); //선택된 일자
	var week  = new Array("", "월", "화", "수", "목", "금", "토", "일");  // 아래 코드에서는 사용하지 않음

	// 보통 0~6 까지가 일~토로 표현된다 하지만 월요일부터 표현하기 위해 0번째를 공백처리
	var currentDay = new Date(year, month-1, day);
	var theDayOfWeek = currentDay.getDay();        // 요일을 숫자로 구해옴

	// 선택한 날이 일요일 일때 전주의 날짜를 담음
	if(theDayOfWeek == 0)
	{
		var currentDay = new Date(year, month-1, day-7);
	}

	var theYear = currentDay.getFullYear();
	var theMonth = currentDay.getMonth();
	var theDate  = currentDay.getDate();

	var thisWeek = [];
	for(var i=1; i<8; i++)
	{
		var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek));
		var yyyy = resultDay.getFullYear();
		var mm = Number(resultDay.getMonth()) + 1;
		var dd = resultDay.getDate();
		var dd_nm = resultDay.getDay();

		mm = String(mm).length === 1 ? '0' + mm : mm;
		dd = String(dd).length === 1 ? '0' + dd : dd;

		//월요일부터 화, 수 ~ 일요일까지 날짜를 담음
		thisWeek[i] = yyyy + '-' + mm + '-' + dd;
	}
	return thisWeek;
}

function getToday()
{
	var dt = new Date();
	var Year = dt.getFullYear();
	var Month = "" + (dt.getMonth()+1);
	var Day = "" + dt.getDate();

	if(Month.length < 2) Month = "0" + Month;
	if(Day.length < 2) Day = "0" + Day;

	return Year.toString() + "-" + Month + "-" + Day;
}

$.fn.radioSelect2 = function(val) {
    this.each(function() {
        var $this = $(this);
        var $label = $this.parent();
        $this.attr('checked', false);
        if($label.hasClass("active")) {
            $label.removeClass("active");
        }
        if($this.val() == val) {
            setTimeout(function(){
                $this.prop('checked', "checked");
            },10);
            $label.addClass("active");
        }
    });
    return this;
};