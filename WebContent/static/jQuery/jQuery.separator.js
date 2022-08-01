/*
 * Form Separator Remover 1.0 Beta, jQuery plugin
 *
 * Copyright(c) 2012, Seok ChangHo
 * http://www.courage.pe.kr
 *
 */
(function($) {
    var methods = {
    	separatorRemoveForm: function() {
    		this.find(':input[class*=separator]').each( function() {
                var field = $(this);
                methods._separatorField(field, 'remove');
            });
    	},
    	separatorAddForm: function() {
    		this.find('input[class*=separator]').each( function() {
                var field = $(this);
                methods._separatorField(field, 'add');
            });
    	},
        _separatorField: function(field, option) {

            if (!field.attr("id")) {
                $.error("jQuerySeparator: an ID attribute is required for this field: " + field.attr("name") + " class:" +
                field.attr("class"));
            }
            
            var classStr = field.attr('class').split(/\s/);
            var rulesParsing = "";
            
            for (var i = 0; i < classStr.length; i++) {
            	if (classStr[i].indexOf("separator") == 0) {
            		rulesParsing = classStr[i];
            		break;
            	}
            }
            
            if (rulesParsing == null || rulesParsing == "") {
            	return false;
            }
            
            var getRules = /separator\[(.*)\]/.exec(rulesParsing);
            var rule = getRules[1];
            
            if (rule === null) {
                return false;
            }
            
            switch (rule) {
                case "date":
                	if(option == 'remove') {
                		methods._separatorRemove(field);
                	} else {
                		methods._separatorDate(field);
                	}
                    break;
                case "yyyyMM":
                	if(option == 'remove') {
                		methods._separatorRemove(field);
                	} else {
                		methods._separatorYyyyMM(field);
                	}
                    break;
                case "number":
                	if(option == 'remove') {
                		methods._separatorRemove(field);
                	} else {
                		methods._separatorNumber(field);
                	}
                    break;
                case "ssn":
                	if(option == 'remove') {
                		methods._separatorRemove(field);
                	} else {
                		methods._separatorSSN(field);
                	}
                    break;
                case "post":
                	if(option == 'remove') {
                		methods._separatorRemove(field);
                	} else {
                		methods._separatorPost(field);
                	}
                    break;
                case "corporateNumber":
                	if(option == 'remove') {
                		methods._separatorRemove(field);
                	} else {
                		methods._separatorCorporateNumber(field);
                	}
                    break;
                default:
                	$.error("jQuerySeparator rule not found");
            }

        },
        _separatorRemove: function(field) {

            switch (field.prop("type")) {
                case "text":
                case "hidden":
                	if(field.val()) {
                		field.val(field.val().replace(/-/gi,""));
                		field.val(field.val().replace(/\./gi,""));
                		field.val(field.val().replace(/\,/gi,""));
                		field.val(field.val().replace(/\//gi,""));
                	}
                	break;
            }
        },
        _separatorDate: function(field) {
        	if(methods._isRegex(field, /^\d{8}$/)) {
        		methods._formatString(field, '4-2-2', '-');
        	}
        },
        _separatorYyyyMM: function(field) {
        	if(methods._isRegex(field, /^\d{6}$/)) {
        		methods._formatString(field, '4-2', '-');
        	}
        },
        _separatorNumber: function(field) {
        	if(methods._isRegex(field, /^[\-\+]?(([0-9]+)([\.]([0-9]+))?|([\.]([0-9]+))?)$/)) {
        		methods._formatNumber(field);
        	}
        },
        _separatorSSN: function(field) {
        	if(methods._isRegex(field, /^\d{13}$/)) {
        		methods._formatString(field, '6-7', '-');
        	}
        },
        _separatorPost: function(field) {
        	if(methods._isRegex(field, /^\d{6}$/)) {
        		methods._formatString(field, '3-3', '-');
        	}
        },
        _separatorCorporateNumber: function(field) {
        	if(methods._isRegex(field, /^\d{10}$/)) {
        		methods._formatString(field, '3-2-5', '-');
        	}
        },
        _isRegex: function(field, regex) {
            var pattern = new RegExp(regex);

            if (pattern.test(field.attr('value'))) {
            	return true;
            } else {
            	return false;
            }
        },
        _formatString: function(field, strFormat, cMark) {
        	var formatArray, strData, nLength, nCurPos;
        	nLength = nCurPos = 0;
        	strData = "";
        	
        	if(field.val()) {
        		formatArray = strFormat.split("-");
        		
        		for(i=0; i < formatArray.length; i++) {
        			nLength = parseInt(formatArray[i]);
        			strData += field.val().substr(nCurPos, nLength);
        			if(i < (formatArray.length-1)) strData += cMark;
        			nCurPos += nLength;
        		}
        	}
        	
        	field.val(strData);
        },
        _formatNumber: function(field) {
			var str = String(field.val());
			var len = str.length;
			var tmp = "";
			var tm2 = "";

			/* 소수점 두개 이상 에러 표시 */
			count = 0;

			if (str.charAt(0) == '-') {
				tmp = '-';
				str = str.substring(1, len);
			}

			if ((sit = str.indexOf('.', 0)) != -1) {
				tm2 = str.substring(sit, len);
				str = str.substring(0, sit);
			}

			var i = 0;

			while (str.charAt(i) == '0')
				i++;

			str = str.substring(i, len);
			len = str.length;

			if (len < 3) {
				field.val(str);
			} else {
				var sit = len % 3;
				if (sit > 0) {
					tmp = tmp + str.substring(0, sit) + ',';
					len = len - sit;
				}

				while (len > 3) {
					tmp = tmp + str.substring(sit, sit + 3) + ',';
					len = len - 3;
					sit = sit + 3;
				}

				tmp = tmp + str.substring(sit, sit + 3) + tm2;
				field.val(tmp);
			}
        }
    };

    
    $.fn.separator = function(method) {
        var form = $(this);
        
        if(!form[0]) {
		  return form;  // stop here if the form do not exist
        }
        
        if (typeof(method) === 'string' && method.charAt(0) != '_' && methods[method]) {
        	methods[method].apply(form);
        }
        
        return form;
    };
})(jQuery);
