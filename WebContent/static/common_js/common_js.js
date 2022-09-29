//contextPath
var offset=location.href.indexOf(location.host)+location.host.length;
//var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));

// ajaxCall
function ajaxCall4HtmlHead(apiURL, header, request, callback){
	$.ajax({
		url : apiURL,
		headers: header,
		type : 'post',
		crossDomain : true,
		dataType : "html",
		async : false,
		data : request,
		success : function(result) {
			callback(result);
		},
		error:function(request,status,error){
			console.log(error);
			callback('{"result":"0"}');
		}
	});
}

function ajaxCall4Html(apiURL, request, callback){
	$.ajax({
		url : apiURL,
		headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
		type : 'post',
		crossDomain : true,
		dataType : "html",
		async : false,
		data : request,
		success : function(result) {
			callback(result);
		},
		error:function(request,status,error){
			console.log(error);
			callback('{"result":"0"}');
		}
	});
}

function ajaxCall4HtmlLoading(apiURL, request, callback, bfFunc, afFunc){
	$.ajax({
		url : apiURL,
		headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
		type : 'post',
		crossDomain : true,
		dataType : "html",
		async : false,
		data : request,
		beforeSend : function() {
			bfFunc();
		},
		success : function(result) {
			callback(result);
		},
		complete : function() {
			afFunc();
		},
		error:function(request,status,error){
			console.log(error);
			callback('{"result":"0"}');
		}
	});
}

function ajaxCall4Json(apiURL, request, callback){
	$.ajax({
		url : apiURL,
		headers: {'Content-Type': 'application/json; charset=utf-8'},
		type : 'post',
		crossDomain : true,
		dataType : "json",
		async : false,
		data : JSON.stringify(request),
		success : function(result) {
			callback(result);
		},
		error:function(request,status,error){
			console.log(error);
			callback('{"result":"0"}');
		}
	});
}
		
function ajaxCall4Text(apiURL, request, callback){
	$.ajax({
		url : apiURL,
		headers: {'Content-Type': 'application/json; charset=utf-8'},
		type : 'post',
		crossDomain : true,
		dataType : "text",
		async : false,
		data : request,
		success : function(result) {
			callback(result);
		},
		error:function(request,status,error){
			console.log(error);
		}
	});
}

// 사용자정의 레이어 팝업
function call_openPop(title, description, closer){
	if (title == "") title = "VSC 알림톡 서비스";
	openPop({
  		title : title,
  		description : description,
  		btns : [ { type : 'confirm' , value : '확인' } ],
  		bodyCloser : closer
	});
}

// 숫자 문자 판단
function isNumber(s) {
  s += ''; // 문자열로 변환
  s = s.replace(/^\s*|\s*$/g, ''); // 좌우 공백 제거
  if (s == '' || isNaN(s)) return false;
  return true;
}

// progress display:block
function progress_block(){
	document.getElementById("Progress").style.display='block';
}

// progress display:none
function progress_none(){
	setTimeout(function(){ document.getElementById("Progress").style.display='none'; }, 1000);
}

/****************************************************************
 * parseDate(d) : 문자열 날짜를 Date 형으로 반환
 * examples  : 
 *
 * parseDate("2013-04-17")
 *				
 * return : Date 	 									
 ****************************************************************/
parseDate = function(d) {
	var dateParts = d.split("-");
    
    if(dateParts == null || dateParts.length <= 0) {
    	dateParts = d.split("/");
    }
    
    return new Date(dateParts[0], (dateParts[1] - 1) ,dateParts[2]);
};

/****************************************************************
 * isPast(pdate, vdate) : vdate가 pdate보다 과거 인지 체크
 * examples  : 
 *
 * if (isPast("2013-04-17", "2013-04-18")) {
 *     alert("2013-04-17 보다 이전날짜를 등록해주세요.");
 * }
 *				
 * return : Date 	 									
 ****************************************************************/
isPast = function(pdate, vdate) {
	pdate = parseDate(pdate);
	vdate = parseDate(vdate);
	
	if (pdate >= vdate) {
		return true;
	}
	
	return false;
};

/****************************************************************
 * isFuture(pdate, vdate) : vdate가 pdate보다 미래 인지 체크
 * examples  : 
 *
 * if (isFuture("2013-04-17", "2013-04-16")) {
 *     alert("2013-04-17 보다 이후날짜를 등록해주세요.");
 * }
 *				
 * return : Date 	 									
 ****************************************************************/
isFuture = function(pdate, vdate) {
	pdate = parseDate(pdate);
	vdate = parseDate(vdate);
	
	if (pdate <= vdate) {
		return true;
	}
	
	return false;
};

/****************************************************************
 * isEmpty(form.field) : 입력값이 비어있는지 체크
 * examples  : 
 *
 * if( isEmpty(form.field) ) { 
 *	 alert('입력값이 없네요.');
 * }	
 *				
 * return : 입력값에 아무것도 없으면 TRUE 	 									
 ****************************************************************/
function isEmpty(value) {
    if (value == undefined || value == null || value.replace(/ /gi,"") == "") {
        return true;
    }
    return false;
}


/****************************************************************
 * containsChars(form.field, chars) : 
 * 입력값에 특정 문자가 있는지 체크
 * 특정 문자를 허용하지 않으려 할 때 사용
 * examples  : 
 *
 * if( containsChars(form.field, "!,*&^%$#@~;") ) { 
 *	 alert('입력값에 특수문자가 포함되었네요.');
 * }	
 *	 		
 * return : 입력값에 지정한 특정문자가 있으면 TRUE 	 									
 ****************************************************************/
function containsChars(value, chars) {
    for (var inx = 0; inx < value.length; inx++) {
       if (chars.indexOf(value.charAt(inx)) != -1)
           return true;
    }
    return false;
}



/****************************************************************
 * containsCharsOnly(form.field, chars) : 
 * 입력값이 특정 문자만으로 되어있는지 체크
 * examples  : 
 *
 * if( containsCharsOnly(form.field, "ABO") ) { 
 *	 alert('입력값이 A or B or O 문자로만 구성되어 있네요.');
 * }	
 *			 
 * return : 입력값이 지정한 특정문자로만 되어 잇으면 TRUE 	 									
 ****************************************************************/
function containsCharsOnly(value,chars) {
    for (var inx = 0; inx < value.length; inx++) {
       if (chars.indexOf(value.charAt(inx)) == -1)
           return false;
    }
    return true;
}


/****************************************************************
 * isAlphabet(form.field) : 입력값이 알파벳으로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로 사용해도 좋다.
 * examples  : 
 *
 * if( isAlphabet(form.field) ) { 
 *	 alert('입력값이 알파벳으로만 구성되어 있네요.');
 * }	
 *			
 * return : 입력값이 알파벳으로만 이루어져 있으면 TRUE 	 									
 ****************************************************************/
function isAlphabet(value) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    return containsCharsOnly(value,chars);
}


/****************************************************************
 * isUpperCase(form.field) : 입력값이 알파벳 대문자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로 사용해도 좋다.
 * examples  : 
 *
 * if( isUpperCase(form.field) ) { 
 *	 alert('입력값이 알파벳 대문자로만 구성되어 있네요.');
 * }	
 *			
 * return : 입력값이 알파벳 대문자로만 이루어져 있으면 TRUE 	 									
 ****************************************************************/
function isUpperCase(value) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return containsCharsOnly(value, chars);
}


/****************************************************************
 * isLowerCase(form.field) : 입력값이 알파벳 소문자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로 사용해도 좋다.
 * examples  : 
 *
 * if( isLowerCase(form.field) ) { 
 *	 alert('입력값이 알파벳 소문자로만 구성되어 있네요.');
 * }	
 *	 
 * return : 입력값이 알파벳 소문자로만 이루어져 있으면 TRUE 	 									
 ****************************************************************/
function isLowerCase(value) {
    var chars = "abcdefghijklmnopqrstuvwxyz";
    return containsCharsOnly(value,chars);
}


/****************************************************************
 * isNumber(form.field) : 입력값이 숫자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 숫자 지역변수를 전역변수로 사용해도 좋다.
 * examples  : 
 *
 * if( isNumber(form.field) ) { 
 *	 alert('입력값이 숫자로만 구성되어 있네요.');
 * }	
 *	
 * return : 입력값이 숫자로만 이루어져 있으면 TRUE 	 									
 ****************************************************************/
function isNumber(value) {
    var chars = "0123456789";
    return containsCharsOnly(value,chars);
}


/****************************************************************
 * isAlphaNum(form.field) : 입력값이 알파벳과 숫자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로 사용해도 좋다.
 * examples  : 
 *
 * if( isAlphaNum(form.field) ) { 
 *	 alert('입력값이 알파벳과 숫자로만 구성되어 있네요.');
 * }	
 *	 
 * return : 입력값이 알파벳과 숫자로만 이루어져 있으면 TRUE 	 									
 ****************************************************************/
function isAlphaNum(value) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    return containsCharsOnly(value,chars);
}


/****************************************************************
 * hasHangul(form.field) : 문자열에 한글이 포함되어 있는지 여부 체크 
 * 현재 단순히 ascii코드가 255 보다 크면 한글이 존재하는 걸루 여김.
 * examples  : 
 *
 * if( hasHangul(form.field) ) { 
 *	 alert('입력값에 한글이 포함되어 있네요.');
 * }	
 *	
 * return : 입력값에 한글이 포함되어 있다면 TRUE 	 									
 ****************************************************************/
function hasHangul(value) {
	var strParam = value;
	var i;
	for(i=0; i<strParam.length; i++) {
		if(strParam.charCodeAt(i) > 255) return true;
	}	
	return false;
}


/****************************************************************
 * isNumDash(form.field) : 입력값이 숫자,대시(-)로만 되어있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로 사용해도 좋다.
 * examples  : 
 *
 * if( isNumDash(form.field) ) { 
 *	 alert('입력값이 숫자와 대시로만 구성되어 있네요.');
 * }	
 *				
 * return : 입력값이 숫자,대시(-)로만 이루어져 있으면 TRUE 	 									
 ****************************************************************/
function isNumDash(value) {
    var chars = "-0123456789";
    return containsCharsOnly(value,chars);
}


/****************************************************************
 * isNumComma(form.field) : 입력값이 숫자,콤마(,)로만 되어있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로 사용해도 좋다.
 * examples  : 
 *
 * if( isNumComma(form.field) ) { 
 *	 alert('입력값이 숫자와 콤마로만 구성되어 있네요.');
 * }	
 *	
 * return : 입력값이 숫자,콤마(,) 이루어져 있으면 TRUE 	 									
 ****************************************************************/
function isNumComma(value) {
    var chars = ",0123456789";
    return containsCharsOnly(value,chars);
}


/****************************************************************
 * isNumComma(form.field) : 입력값에서 콤마를 제거한다.
 * 같은 방법으로 다양한 캐릭터에 대한 응용이 가능하다.
 * examples  : 
 *
 * var val = removeComma(form.field) : "2222,2222" -> 22222222
 *
 * return : 입력값에서 콤마(,)를 제거한 문자열. 	 									
 ****************************************************************/
function removeComma(value) {
    return value.replace(/,/gi,"");
}



/****************************************************************
 * isNumComma(form.field, format) : 
 * 입력값이 사용자가 정의한 포맷 형식인지 체크
 * 자세한 format 형식은 자바스크립트의 'regular expression(정규식)'을 참조
 * 정규식에 대한 내용은 검색엔진을 통해 찾아보면 나옴.
 * examples  : 
 *
 * if (isValidFormat(form.field, "[xyz]")) {
 *		alert('x-z 까지의 문자가 존재하네요.');
 * }
 *
 * return : 입력값이 지정한 올바른 포맷으로 되어 있으면 TRUE 	 									
 ****************************************************************/
function isValidFormat(value, format) {
    if (value.search(format) != -1) {
        return true; 
    }
    return false;
}


/****************************************************************
 * isValidEmail(form.field) : 입력값이 이메일 형식인지 체크
 * examples  : 
 *
 * if (isValidEmail(form.field)) {
 *		alert('입력값이 이메일 형식이네요.');
 * }
 *			
 * return : 입력값이 이메일 형식으로 되어있으면 TRUE 	 									
 ****************************************************************/
function isValidEmail(value) {
	/*--
	var format = /^(\S+)@(\S+)\.([A-Za-z]+)$/;
	--*/
    var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    return isValidFormat(value,format);
}



/****************************************************************
 * isValidPhone(form.field) : 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크
 * examples  : 
 *
 * if (isValidPhone(form.field)) {
 *		alert('입력값이 전화번호 형식이네요.');
 * }
 *	 
 * return : 입력값이 전화번호 형식(숫자-숫자-숫자)이면 TRUE 	 									
 ****************************************************************/
function isValidPhone(value) {
    var format = /^(\d+)-(\d+)-(\d+)$/;
    return isValidFormat(value,format);
}

/****************************************************************
 * isDate(value) : 입력값이 날짜 형식(yyyyMMdd)인지 체크
 * examples  : 
 *
 * if (isValidPhone(form.field)) {
 *		alert('입력값이 날짜 형식이네요.');
 * }
 *	 
 * return : 입력값이 날짜 형식(yyyyMMdd)이면 TRUE 	 									
 ****************************************************************/
function isDate(value) {
	var format = /^\d{4}[\-]\d{2}[\-]\d{2}$/;
	return isValidFormat(value,format);
}

/****************************************************************
 * isDate(value) : 입력값이 날짜 유효성 체크
 * examples  : 
 *
 * if (isValidDate(form.field)) {
 *		alert('입력값이 날짜 형식이네요.');
 * }
 *	 
 * return : 입력값이 날짜 형식이면 TRUE 	 									
 ****************************************************************/
function isDateFormat(value) {
	
	var bDateCheck = true;
	
    var arrDate = value.split("-");
    
    var nYear = Number(arrDate[0]);
    var nMonth = Number(arrDate[1]);
    var nDay = Number(arrDate[2]);
  
    if (nYear < 1900 || nYear > 9999)  {
    	//사용가능 하지 않은 년도 체크
        bDateCheck = false;   
    }   
  
    if (nMonth < 1 || nMonth > 12){
    	//사용가능 하지 않은 달 체크
        bDateCheck = false;   
    }   
  
    // 해당달의 마지막 일자 구하기   
    var nMaxDay = new Date(new Date(nYear, nMonth, 1) - 86400000).getDate();  
    
    if (nDay < 1 || nDay > nMaxDay){
    	//사용가능 하지 않은 날자 체크   
        bDateCheck = false;   
    }
    
    return bDateCheck;
}
/****************************************************************
 * hasCheckedRadio(form.field) : 선택된 라디오버튼이 있는지 체크
 * examples  : 
 *
 * if (hasCheckedRadio(form.field)) {
 *		alert('선택된 라디오 버튼이 있네요.');
 * }
 *	
 * return : 선택된 라디오버튼이 있으면 TRUE 	 									
 ****************************************************************/
function hasCheckedRadio(input) {
    if (input.length > 1) {
        for (var inx = 0; inx < input.length; inx++) {
            if (input[inx].checked) return true;
        }
    } else {
        if (input.checked) return true;
    }
    return false;
}


/****************************************************************
 * hasCheckedBox(form.field) : 선택된 체크박스가 있는지 체크
 * examples  : 
 *
 * if (hasCheckedBox(form.field)) {
 *		alert('선택된 체크박스가 있네요.');
 * }
 *
 * return : 선택된 체크박스가 있으면 TRUE 	 									
 ****************************************************************/
function hasCheckedBox(input) {
    return hasCheckedRadio(input);
}


/****************************************************************
 * getSelectedValue(form.field) : 선택된 선택박스의 값을 얻는다.
 * examples  : 
 *
 * var value = getSelectedValue(form.field);
 *
 * return :  선택된 선택박스의 값. 	 									
 ****************************************************************/
function getSelectedValue(input) {
	
	if ( input == null )
		return null;

	return input.options[input.selectedIndex].value;
}


/****************************************************************
 * getSelectedValue(form.field) : 선택된 선택박스의 텍스트를 얻는다.
 * examples  : 
 *
 * var value = getSelectedText(form.field);
 *
 * return :  선택된 선택박스의 텍스트. 	 									
 ****************************************************************/
function getSelectedText(input) {
	
	if ( input == null )
		return null;

	return input.options[input.selectedIndex].text;
}


/****************************************************************
 * getIndexByValue(form.field, value)
 *  : 지정한 값과 일치하는 선택박스의 인덱스를 얻는다.
 * examples  : 
 *
 * var index = getIndexByValue(form.field, "값");
 *
 * return : 지정한 값과 일치하는 선택박스의 인덱스. 없으면 -1 리턴.	 									
 ****************************************************************/
function getIndexByValue(input, value) {

	if ( input == null )
		return;

	for ( var i = 0; i < input.options.length; i++ ) {
		if ( input.options[i].value == value )
			return i;
	}
	return -1;  // not found.
}


/****************************************************************
 * removeOptionByValue(form.field, value)
 *  : 지정한 값과 일치하는 선택박스의 인덱스를 삭제한다.
 * examples  : 
 *
 * if (removeOptionByValue(form.field, "값")) {
 *		alert('해당 인덱스가 삭제되었어요.');
 * }
 *
 * return : 해당 인덱스가 지워지면 TRUE. 	 									
 ****************************************************************/
function removeOptionByValue(input, value) {

	if ( input == null )  
		return false;

	var index = getIndexByValue( input, value );
	var srcC = 0, destC = 0;  

	if ( index == -1 ) return false; // not found

	// else value was found, shift all elemenets which are after index    

	while ( srcC < input.options.length) {
		input.options[destC] = input.options[srcC];
		if ( srcC == index ) destC--;       
		srcC++;
		destC++;
	}  

	input.options.length -= 1;     

	return true;
}


/****************************************************************
 * makeBlur(form.field)
 *  : 값이 입력안되게 하기
 * examples  : 
 *
 * <input type=text onfocus = "MakeBlur(input)">
 *
 * return : 해당없음. 	 									
 ****************************************************************/
function makeBlur(input) {
    input.blur();
}



/*-------------------------------------------------------------------------------
 * [3] 문자열 관련 함수
 *-------------------------------------------------------------------------------
 */


/****************************************************************
 * removeToken(form.field, char) : 지정한 캐릭터 제거하기.
 * examples  : 
 *
 * form.field = '1111,11'일 경우....
 * removeToken(form.field, ','); 
 *		-> 1111,11 -> 111111
 *
 * return : 입력값에서 지정한 캐릭터를 제거한 문자열.	 									
 ****************************************************************/
function removeToken(input, value) {
	val = input.value;
	str = "";
	strr = val.split(value);
	for (i=0 ; i < strr.length ; i++) {
		str += strr[i];
	}
	input.value = str;
}


/****************************************************************
 * removeTokenValue(value, char) : 지정한 캐릭터 제거하기.
 * examples  : 
 *
 * form.field = '1111,11'일 경우....
 * removeTokenValue(value, ','); 
 *		-> 1111,11 -> 111111
 *
 * return : 입력값에서 지정한 캐릭터를 제거한 문자열.	 									
 ****************************************************************/
function removeTokenValue(value, charStr) {
	val = value;
	str = "";
	strr = val.split(charStr);
	for (i=0 ; i < strr.length ; i++) {
		str += strr[i];
	}
	
	return str;
}


/****************************************************************
 * getByteLength(form.field) : 입력값의 바이트 길이를 얻는다.
 * examples  : 
 *
 * form.field = 'hi한글'일 경우....
 * getByteLength(form.field); -> 6
 *
 * return : 입력값의 바이트 길이 (한글은 2Byte)	 									
 ****************************************************************/
function getByteLength(input) {
    var byteLength = 0;
    for (var inx = 0; inx < input.value.length; inx++) {
        var oneChar = escape(input.value.charAt(inx));
        if ( oneChar.length == 1 ) {
            byteLength ++;
        } else if (oneChar.indexOf("%u") != -1) {
            byteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            byteLength += oneChar.length/3;
        }
    }
    return byteLength;
}


/****************************************************************
 * fillSpace(form.field, len, positionOfSpace)
 *	: 입력값의 앞이나 뒤에 총 바이트가 지정한 길이가 되도록 공백을 추가한다.
 * examples  : 
 *
 * form.field = 'hi한글'일 경우....
 * fillSpace(form.field, 4, 'head') -> '    hi한글'			
 * fillSpace(form.field, 4, 'tail') -> 'hi한글    '	
 *
 * return : 지정한 길이의 공백이 추가된 새로운 문자열 	 									
 ****************************************************************/
function fillSpace(input, len, positionOfSpace) {
	var str = input.value;
	var newStr = input.value;
	
	if( positionOfSpace == "head" )
		for(var i=0;i<(len-str.length);i++)
			newStr = " " + newStr ;
	else
		for(var i=0;i<(len-str.length);i++)
			newStr = newStr + " ";
			
	return newStr;
}


/****************************************************************
 * replaceString(form.field, old, new) 
 *  : 입력값의 모든 문자열중에서 old를 new로 대체함.
 * examples  : 
 *
 * form.field = 'hahohi'일 경우....
 * replaceString(form.field, 'ho','한글') -> 'ha한글hi'			
 *
 * return : 대체된 새로운 문자열	 									
 ****************************************************************/
function replaceString(input, strOld, strNew) {
	
	var str = input.value;
	var index = 0;
	var oldLen = strOld.length;
	var newLen = strNew.length;
	var strPre = "";

	if( strOld == null || strOld == "") return str;

	while (true) {
		if ((index = str.indexOf(strOld)) != -1) {
			strPre= strPre + str.substring(0, index) + strNew;
			str = str.substring(index + oldLen);
		}
		else
			break;
	}
	return strPre + str;
}


/****************************************************************
 * formatString(strParam, strFormat, cMark) 
 *  : 지정한 문자열을 지정한 포맷으로 변환한다. 
 * examples  : 
 * 
 * formatString("20010305", "4-2-2", '/') -> 2001/03/05
 * formatString("7011011101417", "6-7", '-') -> 701101-1101417
 *
 * return : 포맷된 새로운 문자열	 									
 ****************************************************************/
function formatString(strParam, strFormat, cMark) {
	var formatArray, strData, nLength, nCurPos;
	nLength = nCurPos = 0;
	strData = "";
	
	if(strParam != "" && strParam != null) {
		formatArray = strFormat.split("-");
		for(i=0; i < formatArray.length; i++) {
			nLength = parseInt(formatArray[i]);
			strData += strParam.substr(nCurPos, nLength);
			if(i < (formatArray.length-1)) strData += cMark;
			nCurPos += nLength;
		}
	}
	return strData;
}


/****************************************************************
 * numFormat(form.field) 
 *  : 입력값을 금액표시로 전환
 * examples  : 
 * 
 * form.field = '99999'일 경우....
 * numFormat(form.field) -> 99,999
 * 
 * form.field = '-12345.001'일 경우....
 * numFormat(form.field) -> -123,45.001
 *
 * return : 대체된 새로운 금액 문자열	 									
 ****************************************************************/
function numFormat(obj) {

    var str  = String(obj.value);
    var len  = str.length;
    var tmp  = "";
    var tm2  = "";
    
	/* 소수점 두개 이상 에러 표시 */
    count = 0;

    for( j=0 ; j < len ; j++) {
		if( obj.value.charAt(j) == '.') count++;
    }

    if (count > 1) {
		var text = "소수점이 둘 이상 포함되었습니다."; 
	    alert(text);
	    obj.focus();
    } 

    if (str.charAt(0) == '-') {
	    tmp = '-' ;
	    str = str.substring(1,len);
    }

    if (str.indexOf('-',0) != -1) {
	    obj.focus();
	    return;
    }

    if ((sit=str.indexOf('.',0)) != -1) {
	    tm2 = str.substring(sit,len);
	    str = str.substring(0,sit);
    }

    var i    = 0;  

    while (str.charAt(i) == '0') i++;
	    
	str = str.substring(i,len);
	len = str.length;

	if(len < 3) {
		obj.value = str;
		return;
	}
	else {
		var sit = len % 3;
		if (sit > 0) {
			tmp = tmp + str.substring(0,sit) + ',';
			len = len - sit;
		}

		while (len > 3) {
			tmp = tmp + str.substring(sit,sit+3) + ',';
			len = len - 3;
			sit = sit + 3;
		}

		tmp = tmp + str.substring(sit,sit+3) + tm2;
		obj.value = tmp;
    }
}

/****************************************************************
 * fnGetPercentage(intParam1, intParam2) 
 *  : 지정한 수치의 percentage를 구한다. 
 * examples  : 
 * 
 * fnGetPercentage(100, 50) -> 50
 *
 * return : 비율(percentage)	 									
 ****************************************************************/
function fnGetPercentage(intParam1, intParam2) {
	var percentage = roundXL((intParam2 / intParam1) * 100, 2);
	
	return percentage;
}


/*-------------------------------------------------------------------------------
 * [4] 쿠키 관련 함수
 *-------------------------------------------------------------------------------
 */


/****************************************************************
 * setCookie(name, value, expiredays) 
 *  : 지정한 값으로 쿠키를 설정한다.	
 * examples  : 
 * 
 * setCookie( "is_end", "done" , 1); -> 쿠키보관일 : 하루
 *
 * return : 해당 없음.	 									
 ****************************************************************/
function setCookie(name, value, expiredays){
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}


/****************************************************************
 * getCookie(name) 
 *  : 지정한 값에 따른 쿠키를 얻는다.	
 * examples  : 
 * 
 * if (getCookie( "is_end" ) == "done") {
 *		alert('쿠키가 만료되었습니다.');
 * }
 *
 * examples  : 
 * return : 쿠키정보 문자열.	 									
 ****************************************************************/
function getCookie(uName) {
	var flag = document.cookie.indexOf(uName+'=');
	if (flag != -1) { 
		flag += uName.length + 1;
		end = document.cookie.indexOf(';', flag) ;

		if (end == -1) end = document.cookie.length;
		return unescape(document.cookie.substring(flag, end));
	}
}

function checkNumber() {
	var key = String.fromCharCode(event.keyCode);
	var re = new RegExp('[0-9]');

	if(!re.test(key)) {
		event.returnValue = false;
	}
}

/**
 * @type   : method
 * @access : public
 * @desc   : 체크박스 전체선택/선택해제
 * @sig    : targetCheckBox, destCheckBox
 * @param  : targetCheckBox - 전체선택/해제 할 checkbox OBJ
 * @param  : destCheckBox - 기준 checkbox OBJ
 */
function checkboxAllCheck(targetCheckBox, destCheckBox) {
	if (targetCheckBox) {
		if (targetCheckBox.length) {
    		for (var i=0; i<targetCheckBox.length; i++) {
    			targetCheckBox[i].checked = destCheckBox.checked;
    		}
		}
		else {
			targetCheckBox.checked = destCheckBox.checked;
		}
	}
}

/**
 * @type   : method
 * @access : public
 * @desc   : 체크박스 전체선택/선택해제(disabled 는 체크 제외)
 * @sig    : targetCheckBox, destCheckBox
 * @param  : targetCheckBox - 전체선택/해제 할 checkbox OBJ
 * @param  : destCheckBox - 기준 checkbox OBJ
 */
function checkboxAllNoDisabledCheck(targetCheckBox, destCheckBox) {
	if (targetCheckBox) {
		if (targetCheckBox.length) {
    		for (var i=0; i<targetCheckBox.length; i++) {
    			if(targetCheckBox.eq(i).attr("disabled")!= "disabled"){
    				targetCheckBox[i].checked = destCheckBox.checked;
    			}
    		}
		}
		else {
			targetCheckBox.checked = destCheckBox.checked;
		}
	}
}

/**
 * @type   : method
 * @access : public
 * @desc   : 체크박스가 선택된것이 있는지 여부를 파악한다.
 * @sig    : checkbox
 * @param  : checkbox - 선택여부를 파악할 checkbox object
 * @return : boolean (선택한 대상이 있으면 true, 없으면 false)
 */
function checkboxChecked(checkbox) {
	if (checkbox) {
		if (checkbox.length) {
    		for (var i=0; i<checkbox.length; i++) {
    			if (checkbox[i].checked) {
    				return true;
    			}
    		}
		}
		else {
			if (checkbox.checked) {
				return true;
			}
		}
	}
	return false;
}

/**
 * @type   : method
 * @access : public
 * @desc   : 체크박스가 하나만 선택되도록 한다.
 * @sig    : checkbox, thisObj
 * @param  : checkbox - 선택여부를 파악할 checkbox object
 * @param  : thisObj - 현재 선택한 checkbox object
 * @return : boolean (선택한 대상이 있으면 true, 없으면 false)
 */
function checkboxOnlyOneChecked(checkbox, thisObj) {
	if (thisObj.checked == false) {
		return true;
	}
	if (checkbox) {
		if (checkbox.length) {
    		for (var i=0; i<checkbox.length; i++) {
    			checkbox[i].checked = false;
    		}
    		thisObj.checked = true;
    		return true;
		}
		else {
			if (checkbox.checked) {
				return true;
			}
		}
	}
	return false;
}

/****************************************************************
 * 지정한 일 수 만큼의 기간을  
 * 
 * examples  : 
 * 
 * setCookie( "is_end", "done" , 1);
 *
 * return : 해당 없음.	 									
 ****************************************************************/
/*********************** 기간 자동 처리 부분 ************************/
//월의 끝 일자 얻기
function getEndDate(datestr){
	
	//널인지?	
	if(isEmpty(datestr)){
		return null;
	} 
	
	//숫자인지?
	if(!isNum(datestr)){
		return null;
	}
	 
	//길이가 8자리?
	if(datestr.length != 6){
		return null;
	}
	
	var yy = Number(datestr.substring(0,4));
	var mm = Number(datestr.substring(4,6));
	
	//윤년 검증
	var boundDay = "";

	if(mm != 2){
		var mon=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
		boundDay = mon[mm-1];
	}
	else{
		if (yy%4 == 0 && yy%100 != 0 || yy%400 == 0){
			boundDay = 29;
		}
		else{
			boundDay = 28;
		}
	}
	
	return boundDay;		
}

// Left 빈자리 만큼 padStr 을 붙인다.
function lpad(src, len, padStr){
	var retStr = "";
	var padCnt = Number(len) - String(src).length;
	for(var i=0;i<padCnt;i++) retStr += String(padStr);
	return retStr+src;
}

// Right 빈자리 만큼 padStr 을 붙인다.
function rpad(src, len, padStr){
	var retStr = "";
	var padCnt = Number(len) - String(src).length;
	for(var i=0;i<padCnt;i++) retStr += String(padStr);
	return src+retStr;
}

// 숫자검증
function isNum(str){	
	
	if(isEmpty(str)) return false;
	
	for(var idx=0;idx < str.length;idx++){
		if(str.charAt(idx) < '0' || str.charAt(idx) > '9'){
			return false;
		}
	}
	return true;
}
	
//오늘날짜
function getToDay()
{

	var date = new Date();

	var year  = date.getFullYear();
	var month = date.getMonth() + 1;
	var day   = date.getDate();

	if (("" + month).length == 1) { month = "0" + month; }
	if (("" + day).length   == 1) { day   = "0" + day;   }
		
	return ("" + year + month + day);

}

/****************************************************************
 * isEmptyExist() 
 *  : 공백체크.	
 *
 * return : 해당 없음.	 									
 ****************************************************************/
function isEmptyExist(input) {
	
	var pattern = /\s/g;
	
	if(input.value.match(pattern)){
		return true;
	}
	return false;
}

/****************************************************************
 * fncBrowserCheck() 
 *  : 브라우저 체크	
 *
 * return : IE7 이상일 경우 true	 									
 ****************************************************************/
function fncBrowserCheck() {
	var browser = navigator.appName;
	var b_version=navigator.appVersion;
	var version=parseFloat(b_version);

	if (browser != "Microsoft Internet Explorer") {
		alert('Microsoft Internet Explorer 에서 지원하는 기능 입니다.');
		return false;
	} else {
		return true;
	}
}

/****************************************************************
 * isNullField(form.field) : 개체가 NULL인지 체크
 * examples  : 
 *
 * if( isNullField(form.field) ) { 
 *	 alert('해당개체가 없네요.');
 * }	
 *			
 * return : 개체가 Null or 개체가 없으면 TRUE 	 									
 ****************************************************************/
function isNullField(input) {
    if (input == null || input == "") {
        return true;
    }
    return false;
}


String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");
};

/****************************************************************
 * setCommaMoneyAll(form)
 *  : form내의 text 박스의 형식을 comma구분의 숫자형식으로 변환
 * examples  :
 *
 * setCommaMoneyAll(form) -> '123,456'
 *
 * return :
 ****************************************************************/
function setCommaMoneyAll(form){
    var all_len = form.length;
    for(var i =0; i< all_len; i++){
        if(form[i].type == "text"){
             if(isNumComma(form[i])) {
                form[i].value = getCommaMoney(form[i].value);
            }
        }
    }
}

/****************************************************************
 * getCommaMoneyRemoveAll(form)
 *  : form내의 text 박스의 형식을 comma구분의 숫자형식을 comma를 제외한 숫자로 변환
 * examples  :
 *
 * getCommaMoneyRemoveAll(form) -> '123456'
 *
 * return :
 ****************************************************************/
function getCommaMoneyRemoveAll(form){
    var all_len = form.length;
    for(var i =0; i< all_len; i++){
        if(form[i].type == "text"){
             if(isNumComma(form[i])) {
                form[i].value = form[i].value.replace(/,/gi, '');
            }
        }
    }
}

/****************************************************************
 * getCommaMoneyRemove(number)
 *  : number의 형식을 콤마구분 문자형식으로 변경
 * examples  :
 *
 * getCommaMoneyRemove(number) -> '123456'
 *
 * return :
 ****************************************************************/
function getCommaMoneyRemove(number){
	number = number.replace(/,/gi, '');
	
	return number;
}

/****************************************************************
 * getCommaMoney(number)
 *  : number의 형식을 콤마구분 숫자형식으로 변경
 * examples  :
 *
 * getCommaMoney(123456) -> '123,456'
 *
 * return : String
 ****************************************************************/
function getCommaMoney(number) {
	var money = '';
	var y = -1
	var chars = '0123456789';
	number = String(number);

	if(number.length <= 3) {
		return number;
	}

	for (var x=number.length; x>=0; x--) {
    	var moyo = number.charAt(x);
        if (moyo != ",") { /* 컴마가 없는 경우에만 숫자를 붙인다 */
            if (y%3 == 0 && y != 0) {/* 세자리 마다 컴마를 붙인다. */
            	if(chars.indexOf(moyo) != -1) {
            		money = moyo + "," + money;
            	} else {
            		money = moyo + money;
            	}
            }else {
                money = moyo + money;
            }
           	y++;
        }
    }

	return money;
}

/****************************************************************
 * roundXL(n, digits)
 *  : n의 실수에서 disits번째 소수점 자리수 반올림 값을 반환한다.
 * examples  :
 *
 * roundXL(10.125, 3) -> 10.13
 *
 * return : float
 ****************************************************************/
function roundXL(n, digits) {
	if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림
	
	digits = Math.pow(10, digits); // 정수부 반올림
	var t = Math.round(n * digits) / digits;
	
	return parseFloat(t.toFixed(0));
}

/****************************************************************
 * monthDiff(d1, d2)
 *  : d1, d2 월 간격차이를 반환한다.
 * examples  :
 *
 * monthDiff('20110101', '20110201') -> 1
 *
 * return : int
 ****************************************************************/
function monthDiff(d1, d2) {
	var months = 0;
	
	if(d1.length == 8 || d2.length == 8) {
		var date1 = new Date(Number(d1.substring(0, 4)), Number(d1.substring(4, 6)), Number(d1.substring(6, 8)));
		var date2 = new Date(Number(d2.substring(0, 4)), Number(d2.substring(4, 6)), Number(d2.substring(6, 8)));
		
		months = (date2.getFullYear() - date1.getFullYear()) * 12;
		months -= date1.getMonth();
		months += date2.getMonth();
	}
	
	return months;
}

/****************************************************************
 * moneyToHan(money)
 *  : money의 한글명을 반환한다.
 * examples  :
 *
 * moneyToHan('1000000') -> 일백만
 *
 * return : string
 ****************************************************************/
function moneyToHan(money){
	
	arrayNum=new Array("","일","이","삼","사","오","육","칠","팔","구");
	arrayUnit=new Array("","십","백","천","만 ","십만 ","백만 ","천만 ","억 ","십억 ","백억 ","천억 ","조 ","십조 ","백조");
	arrayStr= new Array();
	
	var str = getCommaMoneyRemove(money);
	
	len = str.length;
	hanStr = "";
	
	for(var i=0;i<len;i++) {
		arrayStr[i] = str.substr(i,1);
	}
	
	code = len;
	
	for(var i=0;i<len;i++) {
		code--;
		tmpUnit = "";
		if(arrayNum[arrayStr[i]] != ""){
			tmpUnit = arrayUnit[code];
			
			if(code>4) {
				if(( Math.floor(code/4) == Math.floor((code-1)/4)
				     && arrayNum[arrayStr[i+1]] != "") || 
				   ( Math.floor(code/4) == Math.floor((code-2)/4) 
				     && arrayNum[arrayStr[i+2]] != "")) {
					tmpUnit=arrayUnit[code].substr(0,1);
				} 
			}
		}
		
		hanStr +=  arrayNum[arrayStr[i]]+tmpUnit;
    }
	
	return hanStr;
}

/****************************************************************
 * getDateFormat(value) : 입력된 날자값(yyyyMMdd)을 yyyy-MM-dd 으로 변환
 * examples  : 
 *
 * moneyToHan('99991231') -> 9999-12-31
 *	 
 * return : 입력값이 날짜 형식(yyyyMMdd)을 yyyy-MM-dd으로 변환된 값	 									
 ****************************************************************/
function getDateFormat(dateStr) {
	return dateStr.substring(0, 4) + "-" + dateStr.substring(4, 6) + "-" + dateStr.substring(6, 8);
}

/****************************************************************
 * getDashRemove(value)
 *  : value 형식을 대쉬구분 문자형식으로 변경
 * examples  :
 *
 * getDashRemove(9999-12-31) -> '99991231'
 *
 * return : 입력값이 날짜 형식(yyyy-MM-dd)을 yyyyMMdd으로 변환된 값
 ****************************************************************/
function getDashRemove(value){
	return value.replace(/-/gi, '');
}

/****************************************************************
 * gfGetUrl()
 *
 * return : URL 문자열 반환
 ****************************************************************/
function gfGetUrl() {
	var url = "";
	var ip = htmldocument.location.host;
	var port = htmldocument.location.port;

	if (port != "") {
		ip = "http://" + ip.substring(0, ip.indexOf(":"));
	} else {
		ip = "http://" + ip;
	}

	if (port != "") {
		url = ip + ":" + port;
	} else {
		url = ip;
		port = "80";
	}

	return url;
}

// 7,1 : 인쇄미리보기, 6,-1 인쇄바로하기, 8,1 페이지 설정
function PrintOption(type1,type2){
	var NS = 1;
	if( document.all) NS = 0;
	
    if (NS) {
            window.print();
    } else {
            var active = '<OBJECT ID="active1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
            document.body.insertAdjacentHTML('beforeEnd', active);
            active1.ExecWB(type1,type2); 
            active1.outerHTML ="";
    }
}

String.prototype.escapeHtml = function() {
	return this.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/\"/g, "&quot;");
};

var Browser = {
	a : navigator.userAgent.toLowerCase()
};

Browser = {
	ie : /* @cc_on true || @ */false,
	ie6 : Browser.a.indexOf('msie 6') != -1,
	ie7 : Browser.a.indexOf('msie 7') != -1,
	ie8 : Browser.a.indexOf('msie 8') != -1,
	ie9 : Browser.a.indexOf('msie 9') != -1,
	ie10 : Browser.a.indexOf('msie 10') != -1,
	opera : !!window.opera,
	safari : Browser.a.indexOf('safari') != -1,
	safari3 : Browser.a.indexOf('applewebkit/5') != -1,
	mac : Browser.a.indexOf('mac') != -1,
	chrome : Browser.a.indexOf('chrome') != -1,
	firefox : Browser.a.indexOf('firefox') != -1
};

function whatKindOfBrowser() {
	if (Browser.chrome) {
		return "chrome";
	} else if (Browser.ie6) {
		return "ie6";
	} else if (Browser.ie7) {
		return "ie7";
	} else if (Browser.ie8) {
		return "ie8";
	} else if (Browser.ie9) {
		return "ie9";
	} else if (Browser.ie10) {
		return "ie10";
	} else if (Browser.opera) {
		return "opera";
	} else if (Browser.safari) {
		return "safari";
	} else if (Browser.safari3) {
		return "safari3";
	} else if (Browser.mac) {
		return "mac";
	} else if (Browser.firefox) {
		return "firefox";
	} else {
		return false;
	}
}
/****************************************************************
 * byteCheck(el) : 입력값의 바이트 길이를 얻는다.
 * return : 입력값의 바이트 길이 (한글은 2Byte)	 									
 ****************************************************************/
function byteCheck(el){
    var codeByte = 0;
    for (var idx = 0; idx < el.val().length; idx++) {
        var oneChar = escape(el.val().charAt(idx));
        if ( oneChar.length == 1 ) {
            codeByte ++;
        } else if (oneChar.indexOf("%u") != -1) {
            codeByte += 2;
        } else if (oneChar.indexOf("%") != -1) {
            codeByte ++;
        }
    }
    return codeByte;
};

function convertSystemSourcetoHtml(str){
	 str = str.replace(/</g,"&lt;");
	 str = str.replace(/>/g,"&gt;");
	 str = str.replace(/\"/g,"&quot;");
	 str = str.replace(/\'/g,"&#39;");
	 str = str.replace(/\n/g,"<br />");
	 return str;
};

Number.prototype.format = function(n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};